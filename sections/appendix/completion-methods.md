# Completion methods

Every method on the R side shares one interface. It takes the sparse matrix in, and returns the completed matrix, the swept-parameter grid, and the held-out RMSE and $R^2$ at each parameter value. None of them factor. This is what allows the factoring stage to be identical across methods.

## Cell-level methods

| Method | Description | Package | Swept parameter | Grid |
|---|---|---|---|---|
| SoftImpute \citep{mazumder2010} | Nuclear-norm-penalised low-rank completion by iterative soft-thresholded SVD, assuming a low-rank signal plus noise. Primary cell-level method. | softImpute | rank | 1…10 (capped at $\min(n,p)-1$), and at each rank a 30-point geometric $\lambda$ grid from $\lambda_0$ down to $\lambda_0/100$, ALS with warm starts |
| k-NN | Each missing cell filled from the $k$ most similar models, an assumption-light baseline with no low-rank, linearity, or normality assumption. | VIM | $k$ | 1…10 (capped below $n$), Gower distance over benchmarks, weighted-mean aggregation |
| missForest \citep{stekhoven2012} | Iterative random-forest imputation, nonparametric, able to capture nonlinear dependence the low-rank methods cannot represent. | missForest | number of trees | {50, 100, 200, 400}, at most 10 iterations |
| MICE \citep{vanbuuren2011} | Multiple imputation by chained equations, producing $m$ completed datasets that are averaged before factoring. | mice | $m$ | {5, 10, 20}, predictive mean matching, 5 iterations |

SoftImpute selects $\lambda$ within a rank by cell-weighted held-out RMSE (an internal minimisation only) and *reports* the column-balanced score. The completed matrix returned is a refit on the full data at the selected $(\text{rank}, \lambda)$, while the reported score comes from the masked-train fit's predictions. The two must not be conflated, or the metric leaks.

MICE requires two departures from its defaults on this matrix, which is wide and highly collinear: per-column ridge regularisation ($10^{-3}$) so the normal equations are solvable, and the collinearity guard disabled so that collinear columns are imputed rather than silently skipped and left undefined. Any cell MICE still cannot fill is backfilled with the column mean, so the completed matrix is never silently incomplete. Factoring receives the mean of the $m$ completions.

**Deferred.** Regularised EM-PCA is implemented but not validated, since its built-in dimensionality cross-validation is prohibitively slow at this matrix size. It is excluded from all reported results.

## OneSidedMC

Implemented in Julia \citep{cao2023}. The premise is that when observations are too sparse to complete cells, the **right singular vectors** (the benchmark-space factors) may still be recoverable. The estimator targets $\Theta = \frac{1}{n}Z^\top Z$ over the $n$ models. Each product $z_{ij}z_{ij'}$ of two observed standardised scores in one row is an estimate of $\Theta_{jj'}$, and we fit $\hat\Theta = \hat V\hat V^\top$, with $\hat V \in \mathbb{R}^{p \times r}$, to all such products by squared loss using Adam. Off-diagonal and diagonal terms are each averaged over their total count across rows.

Adaptations required for this data:

- **Ragged observations.** Real rows have a variable number of observed benchmarks, so we store observations as a ragged list of column-and-value pairs per row rather than in the paper's fixed-$k$ rectangular layout. The estimator consumes observed cells only, and never a dense matrix plus a mask. Rows with more observations contribute more pairs, so heavily evaluated models carry more weight in $\hat\Theta$.
- **Rank selection.** OSMC has no built-in rank selector, so we choose $r$ by a held-out sweep over $r = 1\ldots10$.
- **Cell-level metric.** Its native error is defined on pairwise products, which is not comparable to the other methods, so each held-out cell is additionally predicted from the recovered covariance by the conditional-Gaussian (best linear) predictor $\hat z_j = V_j^\top V_S^{+} z_S$, solved in the $r$-dimensional factor space rather than by inverting the rank-deficient $|S| \times |S|$ covariance block, which is numerically unstable on richly-observed rows. The native pairwise metric is retained as a disabled branch.
- **Leakage control.** The holdout split is taken *before* column moments are computed, so standardisation is fit on training cells only. Column-stratified holdout matches the R implementation, with the additional row constraint that a cell is held out only if its row retains at least 2 training cells, which the predictor needs in order to condition on.

The output handed to factoring is a synthesised surrogate (`\hyperref[correlation-matrix-completion-and-surrogate-synthesis]{Appendix~\ref*{correlation-matrix-completion-and-surrogate-synthesis}}`{=latex}) rather than an imputation of the real cells.

## Correlation-matrix completion and surrogate synthesis

Shared machinery for SoftImpute-corr, OptSpace, USVT, CVXR, and GGM:

1. Split the holdout, then standardise columns by **training-cell** moments.
2. Compute the observed pairwise-complete correlation matrix. Entries for pairs never co-observed are undefined, and these are exactly the completion target. No minimum co-observation threshold is applied here, because the floor is already enforced upstream by the densifier and the degenerate-column guard.
3. Complete the correlation matrix with the method's estimator.
4. Symmetrise, then project to the nearest valid correlation matrix (the nearest positive-definite projection of \citet{higham2002}, with unit diagonal and a final eigenvalue projection), guaranteeing positive definiteness rather than near-definiteness, so that every principal submatrix $R_{SS}$ is invertible.
5. Predict each held-out cell from the row's surviving observed cells by the conditional-Gaussian predictor $\hat z_j = R_{jS} R_{SS}^{-1} z_S$ (an empty conditioning set degenerates to the z-mean, 0), and score with the shared metric (`\hyperref[held-out-metric]{Appendix~\ref*{held-out-metric}}`{=latex}).
6. Refit on the **full** correlation matrix and synthesise an $n \times p$ surrogate $X = ZW^\top$ with $Z \in \mathbb{R}^{n \times p}$ with i.i.d. $N(0,1)$ entries and $W = Q\Lambda^{1/2}$ from the eigendecomposition, then un-standardise to the original column scale by the observed-cell moments, so that $\operatorname{cov}(X) = R$ by construction.

Estimators:

| Estimator | Description | Implementation | Configuration |
|-------|--------------|-------------------|----------|
| SoftImpute-corr \citep{mazumder2010} | Applies SoftImpute's low-rank completion to the observed pairwise correlation matrix rather than the data matrix, whose missing entries are exactly the benchmark pairs never co-observed. | softImpute | sweeps rank 1…10 with the same nested $\lambda$ grid as the cell-level methods above |
| OptSpace \citep{keshavan2010} | Manifold-optimisation low-rank completion of the correlation matrix, with automatic rank estimation. | filling | automatic rank estimation, at most 50 iterations to a tolerance of $10^{-6}$, no sweep |
| USVT \citep{chatterjee2015} | Universal singular value thresholding: completes the correlation matrix by hard-thresholding its singular values. | filling | fixed singular-value threshold $\eta = 0.01$, no sweep |
| CVXR (maximum-determinant SDP) | Structured completion targeting positive-definiteness directly: maximises $\log\det\Sigma$ subject to $\Sigma \succeq 0$ and each observed correlation lying within a per-pair Fisher-*z* confidence band scaled to that pair's co-observation count. | CVXR with the SCS solver | maximise $\log\det\Sigma$ s.t. $\Sigma \succeq 0$, diagonal matched exactly, each observed off-diagonal constrained to $\tanh(z_{ij} \pm c\,/\sqrt{\max(n_{ij}-3,\,1)})$ with $c = 2$, pairs with no computable correlation left unconstrained, no sweep |
| GGM (Gaussian graphical model) | MLE completion over the observed-pair graph, treating it as the conditional-independence structure. | ggm | graphical-model MLE with the observed-pair graph as the conditional-independence structure, handling non-chordal patterns, no sweep |

Only SoftImpute-corr sweeps a hyperparameter. The other four take a single fixed configuration, so their reported "sweep" is a single point.

The per-pair confidence band in CVXR exists because a single flat tolerance cannot serve both a correlation estimated from $n = 10$ and one from $n = 200$, so the band widens automatically as $n_{ij}$ falls. Solver infeasibility is a genuine finding. It tells us the observed pairwise correlations are not jointly PSD-consistent even at their sampling uncertainty, and the remedy in that case is a wider band. The Gaussian graphical model has no fallback either, and if its fit fails to converge, the method fails.

Note that neither estimator applies a minimum co-observation threshold. Every pair with a computable correlation enters as a constraint, including pairs resting on very few shared models. For CVXR this is partly self-correcting through the $n$-scaled band. For GGM it makes the conditional-independence graph denser than a trust-filtered version would be.<!-- Trailing "See Appendix known-limitations-and-deviations" removed: that appendix is now Limitations and no longer restates this, since the paragraph above says it in full. -->

## No-imputation (raw) variants

Applied to the undensified matrix, factoring a pairwise-complete correlation matrix with two treatments of the undefined entries:

| Variant | Undefined-entry treatment |
|---|---|
| Mean | Fill with the mean observed off-diagonal correlation |
| Zeros | Fill with 0 (absent co-observation implies assumed no association) |

The two encode opposite priors about an unobserved pair ("behaves like a typical pair" against "is unrelated"), so the gap between them bounds how much the undefined entries alone can move the solution.

Both are smoothed afterwards as a numerical safety net. Effective sample size is taken as the raw row count $n$, **not** the harmonic mean of pairwise complete-case counts: with sparse data a single zero-overlap pair sends the harmonic mean to zero and collapses the whole estimate.
