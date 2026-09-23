# Held-out metric

## Split

Column-stratified: within each benchmark $j$, sample $n_{\text{hold}} = \max\big(1,\ \min(\lfloor 0.2\, n_{\text{obs}(j)} \rfloor,\; n_{\text{obs}(j)} - 2)\big)$ observed cells for $n_{\text{obs}(j)} > 2$, so at least 2 training observations remain in every column. Every column with more than 2 observations contributes **at least one** held-out cell, so no benchmark is unrepresented in the evaluation set.

## Scoring

Let $z$ be the true standardised held-out value and $\hat z$ the prediction, with standardisation fit on training cells only. The baseline predicts each column's training mean, which is 0 in z-space, so the per-cell baseline error is $z^2$.

*Cell-weighted*:

$$\text{RMSE} = \sqrt{\overline{(\hat z - z)^2}}, \qquad R^2 = 1 - \frac{\sum (\hat z - z)^2}{\sum z^2}$$

*Column-balanced* (default): let $\text{MSE}_j$ and $\text{base}_j$ be the mean squared error and mean baseline within column $j$. Then

$$\text{RMSE} = \frac{1}{p}\sum_j \sqrt{\text{MSE}_j}, \qquad R^2 = 1 - \frac{\frac{1}{p}\sum_j \text{MSE}_j}{\frac{1}{p}\sum_j \text{base}_j}$$

Two properties are deliberate. The column-balanced RMSE is an **average of per-column RMSEs**, not a global RMSE, so it is not directly comparable to a pooled figure. And $R^2$ is a **single pooled ratio** of balanced quantities, not a mean of per-column $R^2$: a thin column with a small baseline yields $R^2$ in the range $-10$ to $-50$, and a handful of those destroys an average. Model selection uses $R^2$, which is invariant to the RMSE aggregation choice.

## Rules that keep methods comparable

- Standardise columns, never rows.
- The baseline sees only training cells.
- The reported score must come from a fit that never saw the held-out cells. A full-data refit at the selected hyperparameter is used only to produce the matrix handed downstream.
- Methods whose native error is not cell-level must still derive a cell-level score (`\hyperref[onesidedmc]{Appendix~\ref*{onesidedmc}}`{=latex}, `\hyperref[correlation-matrix-completion-and-surrogate-synthesis]{Appendix~\ref*{correlation-matrix-completion-and-surrogate-synthesis}}`{=latex}). The native metric may be retained, but it is never the headline.


# Gating

Through thorough consideration we have decided that an imputation is considered untrustworthy only when $R^2 < 0.2$. While this may seem a quite low number, we believe this threshold is justifiable for several reasons.

First, 