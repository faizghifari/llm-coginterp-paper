# Factor analysis details

## Estimator

`psych::fa` \citep{revelle2024} with `fm = "minres"` (minimum residual) and `rotate = "promax"` when $nf > 1$, else no rotation. Where the default (SMC communality start) errors on a singular correlation matrix, the fit is retried with `SMC = FALSE` (unity diagonal); only hard errors trigger the fallback — `psych`'s benign warnings still return a usable fit.

## Factor count

Horn's \citep{horn1965} parallel analysis in its PC flavour: the observed eigenvalues of the correlation matrix are compared position-by-position against the 95th percentile of eigenvalues from 100 random $n \times p$ standard-normal matrices' correlation matrices, and

$$nf = \#\{i : \lambda_i^{\text{obs}} > \lambda_i^{\text{cut}}\},\quad nf \geq 2.$$

Because the random baseline depends only on $(n, p, \text{iterations}, \text{quantile})$, it is computed once per shape and cached as JSON keyed by that tuple. The cache is **shape-keyed and never global**: two datasets share cutoffs only if their shapes are identical.

The count is then capped: at 20 (tractability — beyond that the bifactor fits become prohibitively slow), and at $\min(p-1,\, n-1,\, \operatorname{rank}(R) - 1)$, since the completed and surrogate matrices are frequently rank-deficient or have $p \gg n$ and `fa` would otherwise error. If the fit still fails, the count is decremented until it succeeds; the count actually used is what is recorded.

## Bifactor decomposition

`psych::omega` \citep{revelle2009} with `fm = "minres"`, `flip = FALSE`, Schmid–Leiman \citep{schmidleiman1957} transformation. Recorded per cell: the full SL loading matrix (general factor plus domain factors, per benchmark), $\omega_h$, its asymptotic variant, $\omega_{total}$, and the per-group $\omega_{hs}$ vector. Also recorded from the first-order solution: cumulative variance explained, per-factor proportions, and the inter-factor correlation matrix $\Phi$ with its mean off-diagonal.

Two runs per cell: `pa` (at the parallel-analysis count) and `forced2f` (at exactly 2 factors). This is an exploratory Schmid–Leiman solution — cross-loadings are not constrained to zero — and is not equivalent to a confirmatory bifactor CFA.

## Gating

For imputed matrices, factoring proceeds only if the imputation's held-out $R^2 \geq 0.4$, read from the results store. The raw (no-imputation) variants are exempt, since they have no imputation step to gate on.

## Leave-one-covariate-out

For each benchmark $i$: delete row and column $i$ from the correlation matrix, refit the EFA and the bifactor at the same factor count, and record $\Delta\omega_h^{(i)} = \omega_h^{\text{full}} - \omega_h^{(-i)}$. Run at both the parallel-analysis count and the forced 2-factor count, parallelised across benchmarks. The resulting $\Delta\omega_h$ vector is then correlated against each benchmark's observation frequency in the corresponding *sparse* (pre-imputation) matrix.

## Cross-method congruence

Pairwise factor congruence \citep{lorenzoseva2006} between solutions is the absolute cosine similarity between loading vectors, computed after sorting factors by sum of squared loadings and taken sign-invariantly. Solutions are compared only within the same dataset, the same solution type, and the same shape — and therefore only when two methods happen to agree on the factor count, which on this data is rare enough to be a reportable limitation in itself.
