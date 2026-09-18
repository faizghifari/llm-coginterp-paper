# Densification algorithm

Target density $\tau = 0.10$. Let $\mathbf{M}$ be the boolean observation mask.

**C (column-primary peel).** While density $< \tau$: drop the benchmark with the fewest observations among currently-kept rows, then drop any model left with zero observations.

**R (row-primary peel).** While density $< \tau$: drop the model with the fewest observations among currently-kept columns, then drop any benchmark left with zero observations.

**S (symmetric peel).** While density $< \tau$: compute each kept column's and each kept row's *fill rate* (observations ÷ current opposite-axis size) and drop whichever single marginal has the lowest rate; then clear emptied rows and columns on both axes.

**Minimum-observation floor.** After peeling, iterate to a fixed point: drop any kept row or column with fewer than `MIN_OBS` observations *within the currently kept submatrix*. The loop is required because dropping a sparse row can starve a column and vice versa.

**Degenerate-column guard.** Finally drop any column with fewer than 2 observed values or zero variance among its observed values, matching exactly what the downstream estimators would drop at runtime. This parity is deliberate: it keeps the reported matrix shape equal to the shape actually factored.

The tables analysed in this paper were generated with `MIN_OBS = 2`, verified against the shipped matrices — the minimum per-axis observation count is 2 on the R-densified matrices, whose peel is the binding one. See `\hyperref[known-limitations-and-deviations]{Appendix~\ref*{known-limitations-and-deviations}}`{=latex} regarding the current value of that constant in the analysis repository.
