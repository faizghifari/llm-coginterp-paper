# Factor analysis details

## Estimator

We fit the exploratory factor analysis with the minimum-residual estimator \citep{revelle2024}, applying a promax rotation whenever more than one factor is extracted and no rotation otherwise. Where the default squared-multiple-correlation start for the communalities errors on a singular correlation matrix, we retry the fit from a unity diagonal. Only hard errors trigger that fallback, since benign warnings still return a usable fit.

## Factor count

Horn's \citep{horn1965} parallel analysis in its PC flavour: the observed eigenvalues of the correlation matrix are compared position-by-position against the 95th percentile of eigenvalues from 100 random $n \times p$ standard-normal matrices' correlation matrices, and

$$nf = \#\{i : \lambda_i^{\text{obs}} > \lambda_i^{\text{cut}}\},\quad nf \geq 2.$$

Because the random baseline depends only on the matrix shape, the iteration count and the quantile, we compute it once per shape and cache it. The cache is **shape-keyed and never global**, so two datasets share cutoffs only when their shapes are identical.

The count is then capped at 20, beyond which the bifactor fits become prohibitively slow, and at $\min(p-1,\, n-1,\, \operatorname{rank}(R) - 1)$, since the completed and surrogate matrices are frequently rank-deficient or have $p \gg n$ and the estimator would otherwise error. If the fit still fails, we decrement the count until it succeeds, and record the count actually used.

## Bifactor decomposition

The bifactor step also uses the minimum-residual estimator \citep{revelle2009}, with the Schmid-Leiman \citep{schmidleiman1957} transformation and without sign flipping. We record per cell the full Schmid-Leiman loading matrix (the general factor plus the domain factors, per benchmark), $\omega_h$ and its asymptotic variant, $\omega_{total}$, and the per-group $\omega_{hs}$ vector. From the first-order solution we also record cumulative variance explained, per-factor proportions, and the inter-factor correlation matrix $\Phi$ with its mean off-diagonal.

We run each cell twice, once at the parallel-analysis count and once at exactly 2 factors. This is an exploratory Schmid-Leiman solution, in which cross-loadings are not constrained to zero, and it is not equivalent to a confirmatory bifactor CFA.

## Gating

For imputed matrices, factoring proceeds only if the imputation's held-out $R^2 \geq 0.3$.<!-- Was 0.4, which contradicted the Methodology. The gate is 0.3 (src/run/factor.R), which is also what the Methodology and the accepted-imputations table in Results state. "read from the results store" dropped in pass 5. --> The raw (no-imputation) variants are exempt, since they have no imputation step to gate on.

## Leave-one-covariate-out

For each benchmark $i$: delete row and column $i$ from the correlation matrix, refit the EFA and the bifactor at the same factor count, and record $\Delta\omega_h^{(i)} = \omega_h^{\text{full}} - \omega_h^{(-i)}$. Run at both the parallel-analysis count and the forced 2-factor count, parallelised across benchmarks. The resulting $\Delta\omega_h$ vector is then correlated against each benchmark's observation frequency in the corresponding *sparse* (pre-imputation) matrix.

## Cross-method congruence

Pairwise factor congruence \citep{lorenzoseva2006} between solutions is the absolute cosine similarity between loading vectors, computed after sorting factors by sum of squared loadings and taken sign-invariantly. We compare solutions only within the same dataset, the same solution type, and the same shape, and therefore only when two methods happen to agree on the factor count. On this data that agreement is rare enough to be a reportable limitation in itself.
