# Imputation evaluation

Within each benchmark $j$, sample $n_{\text{hold}} = \max\big(1,\ \min(\lfloor 0.2\, n_{\text{obs}(j)} \rfloor,\; n_{\text{obs}(j)} - 2)\big)$ observed cells for $n_{\text{obs}(j)} > 2$, so at least 2 training observations remain in every column. Every column with more than 2 observations contributes at least one held-out cell, so no benchmark is unrepresented in the evaluation set.

At each stage of the imputation, we masked ~20% of the observed cells as an evaluation set. To prevent high-observation benchmarks from inflating the score, we use a column-stratified mask, such that each benchmark is masked at least once and leaving at least two training observations in every column. Columns are standardised using training-cell moments only. 


Let $\text{MSE}_j$ and $\text{base}_j$ be the mean squared error and mean baseline within column $j$. Then

$$\text{RMSE} = \frac{1}{p}\sum_j \sqrt{\text{MSE}_j}, \qquad R^2 = 1 - \frac{\frac{1}{p}\sum_j \text{MSE}_j}{\frac{1}{p}\sum_j \text{base}_j}$$

To filter out likely untrustworthy imputations, we do skip running factor analysis on results  where the held-out $R^2 < 0.2$ . In addition to gating factor analysis, $R^2$ is also used for hyperparameter selection within each method (number of ranks, number of trees, etc.). 


%%## Rules that keep methods comparable

- Standardise columns, never rows.
- The baseline sees only training cells.
- The reported score must come from a fit that never saw the held-out cells. A full-data refit at the selected hyperparameter is used only to produce the matrix handed downstream.
- Methods whose native error is not cell-level must still derive a cell-level score (`\hyperref[onesidedmc]{Appendix~\ref*{onesidedmc}}`{=latex}, `\hyperref[correlation-matrix-completion-and-surrogate-synthesis]{Appendix~\ref*{correlation-matrix-completion-and-surrogate-synthesis}}`{=latex}). The native metric may be retained, but it is never the headline.


# Gating

Through thorough consideration we have decided that an imputation is considered untrustworthy only when $R^2 < 0.2$. While this may seem a quite low number, we believe this threshold is justifiable for several reasons.

First,
%%