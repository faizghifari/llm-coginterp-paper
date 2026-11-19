# Imputation evaluation

## Sequential imputation

Imputation descends a ladder of target densities from 50% down to 10%. The densest slice is imputed directly from its observations. Each sparser step trains on the union of its slice's observed cells and the previous step's completed matrix, with observed cells taking precedence. Because the densification is deterministic until it reaches the target, higher-density (smaller subset) slices are guaranteed to be fully nested by a lower-density (bigger subset) slice.

## Per-step protocol

At each step, we mask ~20% of the observed cells as an evaluation set. The mask is column-stratified, so each benchmark is masked at least once and keeps at least two training observations. Columns are standardized using training-cell moments only.

Two restrictions keep the evaluation honest. First, a per-step mask marks which cells are real observations: cells carried in from the previous step's completions train but are never held out or graded. Second, held-out cells are drawn only from benchmarks that the step introduces (absent from all denser slices); an introduced benchmark's cells were never observed, trained on, or completed at any denser step, so each benchmark is graded exactly once across the chain, and no step's training set contains a cell that a later step grades. All held-out grading within a step — the hyperparameter sweep included — draws holdouts only from the introduced columns' real observed cells.

Within each benchmark $j$ introduced at the step, sample $n_{\text{hold}} = \max\big(1,\ \min(\lfloor 0.2\, n_{\text{obs}(j)} \rfloor,\; n_{\text{obs}(j)} - 2)\big)$ observed cells for $n_{\text{obs}(j)} > 2$, so at least 2 training observations remain in every column. Every introduced column with more than 2 observations contributes at least one held-out cell.

Let $\text{MSE}_j$ and $\text{base}_j$ be the mean squared error and mean baseline within column $j$. Then

$$\text{RMSE} = \frac{1}{p}\sum_j \sqrt{\text{MSE}_j}, \qquad R^2 = 1 - \frac{\frac{1}{p}\sum_j \text{MSE}_j}{\frac{1}{p}\sum_j \text{base}_j}$$

$R^2$ selects the hyperparameters within each method at each step (rank, number of trees, etc.).

## Weighted R²

The reported evaluation metric is the weighted $R^2$. Let $R^2_d$ be the held-out $R^2$ of ladder step $d$ and $c_d$ the number of benchmarks it introduces; then

$$\mathrm{wr2} = \frac{\sum_d c_d R^2_d}{\sum_d c_d}$$

Because each benchmark is introduced at exactly one step and graded only there, $\mathrm{wr2}$ is the exact benchmark-balanced mean held-out $R^2$ of the final matrix, decomposed by introduction step. Factor analysis proceeds only on imputations whose $\mathrm{wr2} \geq 0.4$.
