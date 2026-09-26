# Imputation methods

Every method on the R side shares one interface. It takes the sparse matrix in, and returns the completed matrix, the swept-parameter grid, and the held-out RMSE and $R^2$ at each parameter value. None of them factor. This is what allows the factoring stage to be identical across methods. `\hyperref[tab:imputation-cell-methods]{Table~\ref*{tab:imputation-cell-methods}}`{=latex} shows the lists of full-dataset missing data estimators, while `\hyperref[tab:imputation-corr-methods]{Table~\ref*{tab:imputation-corr-methods}}`{=latex} shows the list for the correlation-level imputers.

```{=latex}
\begin{longtable}{@{}p{0.15\textwidth}p{0.30\textwidth}p{0.12\textwidth}p{0.26\textwidth}@{}}
\caption{Estimators of the missing dataset entries.}\label{tab:imputation-cell-methods}\\
\toprule
Method & Description & Package & Configuration \\
\midrule
\endhead
\bottomrule
\endlastfoot
SoftImpute \citep{mazumder2010} & Nuclear-norm-penalised low-rank completion by iterative soft-thresholded SVD, assuming a low-rank signal plus noise. Primary cell-level method. & softImpute & sweeps rank: 1\ldots10 (capped at $\min(n,p)-1$), and at each rank a 30-point geometric $\lambda$ grid from $\lambda_0$ down to $\lambda_0/100$, ALS with warm starts \\
k-NN & Each missing cell filled from the $k$ most similar models, an assumption-light baseline with no low-rank, linearity, or normality assumption. & VIM & sweeps $k$: 1\ldots10 (capped below $n$), Gower distance over benchmarks, weighted-mean aggregation \\
missForest \citep{stekhoven2012} & Iterative random-forest imputation, nonparametric, able to capture nonlinear dependence the low-rank methods cannot represent. & missForest & sweeps number of trees: \{50, 100, 200, 400\}, at most 10 iterations \\
\end{longtable}
```

```{=latex}
\begin{longtable}{@{}p{0.16\textwidth}p{0.29\textwidth}p{0.13\textwidth}p{0.15\textwidth}@{}}
\caption{Estimators of the missing correlation entries.}\label{tab:imputation-corr-methods}\\
\toprule
Estimator & Description & Package & Configuration \\
\midrule
\endhead
\bottomrule
\endlastfoot
One-sided matrix completion \citep{cao2023} & Recovers the right-singular vectors of a reduced matrix of a large, super-sparse dataset. Originally demonstrated to work with simply 2 observations per row. & Custom Julia code & Sweeps rank 1...10, selecting the rank with the best $R^2$. \\
SoftImpute \citep{mazumder2010} & Applies SoftImpute's low-rank completion to the observed pairwise correlation matrix rather than the data matrix, whose missing entries are exactly the benchmark pairs never co-observed. & softImpute & sweeps rank 1\ldots10 with the same nested $\lambda$ grid as the cell-level methods above \\
USVT \citep{chatterjee2015} & Universal singular value thresholding: completes the correlation matrix by hard-thresholding its singular values. & filling & fixed singular-value threshold $\eta = 0.01$, no sweep \\
\end{longtable}
```

## One-sided matrix completion 

We use a custom implementation of OSMC \citep{cao2023} written in Julia. The premise is that when observations are too sparse to complete cells, the right singular vectors (the benchmark-space factors) may still be recoverable. The estimator targets $\Theta = \frac{1}{n}Z^\top Z$ over the $n$ models. Each product $z_{ij}z_{ij'}$ of two observed standardised scores in one row is an estimate of $\Theta_{jj'}$, and we fit $\hat\Theta = \hat V\hat V^\top$, with $\hat V \in \mathbb{R}^{p \times r}$, to all such products by squared loss using Adam. Off-diagonal and diagonal terms are each averaged over their total count across rows.

Its native error is defined on pairwise products, which is not comparable to the other methods, so each held-out cell is additionally predicted from the recovered covariance by the conditional-Gaussian (best linear) predictor $\hat z_j = V_j^\top V_S^{+} z_S$, solved in the $r$-dimensional factor space rather than by inverting the rank-deficient $|S| \times |S|$ covariance block, which is numerically unstable on richly-observed rows. Additionally, for the hold-out column stratification, the masking also ensures each row has at least 2 observations.

%%
- **Ragged observations.** Real rows have a variable number of observed benchmarks, so we store observations as a ragged list of column-and-value pairs per row rather than in the original paper's fixed-$k$ rectangular layout. The estimator consumes observed cells only, and never a dense matrix plus a mask. Rows with more observations contribute more pairs, so heavily evaluated models carry more weight in $\hat\Theta$.
- **Cell-level metric.** Its native error is defined on pairwise products, which is not comparable to the other methods, so each held-out cell is additionally predicted from the recovered covariance by the conditional-Gaussian (best linear) predictor $\hat z_j = V_j^\top V_S^{+} z_S$, solved in the $r$-dimensional factor space rather than by inverting the rank-deficient $|S| \times |S|$ covariance block, which is numerically unstable on richly-observed rows.
- **Holdout handling.** In addition to the column stratification, the hold-out masking also ensures each row has at least 2 observations.

The output handed to factoring is a synthesised surrogate rather than an imputation of the real cells.
%%

%%Only SoftImpute-corr sweeps a hyperparameter. The other three take a single fixed configuration, so their reported "sweep" is a single point.

The per-pair confidence band in CVXR exists because a single flat tolerance cannot serve both a correlation estimated from $n = 10$ and one from $n = 200$, so the band widens automatically as $n_{ij}$ falls. Solver infeasibility is a genuine finding. It tells us the observed pairwise correlations are not jointly PSD-consistent even at their sampling uncertainty, and the remedy in that case is a wider band. The Gaussian graphical model has no fallback either, and if its fit fails to converge, the method fails.

Note that neither estimator applies a minimum co-observation threshold. Every pair with a computable correlation enters as a constraint, including pairs resting on very few shared models. For CVXR this is partly self-correcting through the $n$-scaled band. For GGM it makes the conditional-independence graph denser than a trust-filtered version would be.<!-- Trailing "See Appendix known-limitations-and-deviations" removed: that appendix is now Limitations and no longer restates this, since the paragraph above says it in full. -->%%

%%## No-imputation (raw) variants

Applied to the undensified matrix, factoring a pairwise-complete correlation matrix with two treatments of the undefined entries:

| Variant | Undefined-entry treatment |
|---|---|
| Mean | Fill with the mean observed off-diagonal correlation |
| Zeros | Fill with 0 (absent co-observation implies assumed no association) |

The two encode opposite priors about an unobserved pair ("behaves like a typical pair" against "is unrelated"), so the gap between them bounds how much the undefined entries alone can move the solution.

Both are smoothed afterwards as a numerical safety net. Effective sample size is taken as the raw row count $n$, **not** the harmonic mean of pairwise complete-case counts: with sparse data a single zero-overlap pair sends the harmonic mean to zero and collapses the whole estimate.
%%