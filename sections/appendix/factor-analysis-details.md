# Factor analysis details

## Estimator

We fit the exploratory factor analysis with the minimum-residual estimator, applying a promax rotation whenever more than one factor is extracted and no rotation otherwise. Where the default squared-multiple-correlation start for the communalities errors on a singular correlation matrix, we retry the fit from a unity diagonal. Only hard errors trigger that fallback, since benign warnings still return a usable fit. The factor analysis used the R package `psych` \citep{revelle2024}.

## Factor count

We use Horn's parallel analysis \citep{horn1965} in its PC flavor. The observed eigenvalues of the correlation matrix are compared position-by-position against the 95th percentile of eigenvalues from 100 random $n \times p$ standard-normal matrices' correlation matrices, and
$$n_f = \#\{i : \lambda_i^{\text{obs}} > \lambda_i^{\text{cut}}\},\quad n_f \geq 2.$$
The count is then capped at 20, beyond which the bifactor fits become prohibitively slow, and at $\min(p-1,\, n-1,\, \operatorname{rank}(R) - 1)$, since the completed and surrogate matrices are frequently rank-deficient or have $p \gg n$ and the estimator would otherwise error. If the fit still fails, we decrement the count until it succeeds, and record the count actually used.

## Bifactor decomposition

The bifactor step uses the Schmid-Leiman \citep{schmidleiman1957,reise2010,reise2012} transformation for EFA without sign flipping. We record per cell the full Schmid-Leiman loading matrix (the general factor plus the domain factors, per benchmark) and $\omega_h$. From the first-order solution we also record cumulative variance explained, per-factor proportions, and the inter-factor correlation matrix $\Phi$ with its mean off-diagonal.