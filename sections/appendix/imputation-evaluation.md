# Imputation evaluation

## Metrics

Within each benchmark $j$, sample $n_{\text{hold}} = \max\big(1,\ \min(\lfloor 0.2\, n_{\text{obs}(j)} \rfloor,\; n_{\text{obs}(j)} - 2)\big)$ observed cells for $n_{\text{obs}(j)} > 2$, so at least 2 training observations remain in every column. Every column with more than 2 observations contributes at least one held-out cell, so no benchmark is unrepresented in the evaluation set.

At each stage of the imputation, we masked ~20% of the observed cells as an evaluation set. To prevent high-observation benchmarks from inflating the score, we use a column-stratified mask, such that each benchmark is masked at least once and leaving at least two training observations in every column. Columns are standardised using training-cell moments only. 


Let $\text{MSE}_j$ and $\text{base}_j$ be the mean squared error and mean baseline within column $j$. Then

$$\text{RMSE} = \frac{1}{p}\sum_j \sqrt{\text{MSE}_j}, \qquad R^2 = 1 - \frac{\frac{1}{p}\sum_j \text{MSE}_j}{\frac{1}{p}\sum_j \text{base}_j}$$

To filter out likely untrustworthy imputations, we skip running factor analysis on results  where the held-out $R^2 < 0.2$ . Additionally, $R^2$ is also used for hyperparameter selection within each method (number of ranks, number of trees, etc.). 

## Correlation-level imputers

Since correlation-level imputers cannot recover individual cells, we held out a fraction of observed cells, then predict each held-out cell from the row's remaining observed cells using the conditional-Gaussian (best linear) predictor $\hat{z}_j = \Theta_{jS}\,\Theta_{SS}^{+}\,z_S$, where $S$ indexes the surviving cells of that row and $\Theta$ is the imputed (or fitted) covariance structure. The best guess for a missing cell is a weighted combination of the row's other cells, with weights fixed by the recovered correlations. The list of correlation-level imputers are presented in table 2 below.