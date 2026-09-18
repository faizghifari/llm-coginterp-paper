# I Held-out metric {-}

## I.1 Split {-}

Column-stratified: within each benchmark $j$, sample $n_{\text{hold}} = \min(\lfloor 0.2\, n_{\text{obs}(j)} \rfloor,\; n_{\text{obs}(j)} - 2)$ observed cells, so at least 2 training observations remain in every column. Every column with more than 2 observations contributes **at least one** held-out cell, so no benchmark is unrepresented in the evaluation set.

## I.2 Scoring {-}

Let $z$ be the true standardised held-out value and $\hat z$ the prediction, with standardisation fit on training cells only. The baseline predicts each column's training mean, which is 0 in z-space, so the per-cell baseline error is $z^2$.

*Cell-weighted*:

$$\text{RMSE} = \sqrt{\overline{(\hat z - z)^2}}, \qquad R^2 = 1 - \frac{\sum (\hat z - z)^2}{\sum z^2}$$

*Column-balanced* (default): let $\text{MSE}_j$ and $\text{base}_j$ be the mean squared error and mean baseline within column $j$. Then

$$\text{RMSE} = \frac{1}{p}\sum_j \sqrt{\text{MSE}_j}, \qquad R^2 = 1 - \frac{\frac{1}{p}\sum_j \text{MSE}_j}{\frac{1}{p}\sum_j \text{base}_j}$$

Two properties are deliberate. The column-balanced RMSE is an **average of per-column RMSEs**, not a global RMSE, so it is not directly comparable to a pooled figure. And $R^2$ is a **single pooled ratio** of balanced quantities, not a mean of per-column $R^2$: a thin column with a small baseline yields $R^2$ in the range $-10$ to $-50$, and a handful of those destroys an average. Model selection uses $R^2$, which is invariant to the RMSE aggregation choice.

## I.3 Rules that keep methods comparable {-}

- Standardise columns, never rows.
- The baseline sees only training cells.
- The reported score must come from a fit that never saw the held-out cells; a full-data refit at the selected hyperparameter is used only to produce the matrix handed downstream.
- Methods whose native error is not cell-level must still derive a cell-level score ([[H-completion-methods#H.2 OneSidedMC|Appendix H.2]], [[H-completion-methods#H.3 Correlation-matrix completion and surrogate synthesis|Appendix H.3]]); the native metric may be retained but is never the headline.
