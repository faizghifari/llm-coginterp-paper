# Densification algorithm

Target density $\tau = 0.10$. Let $\mathbf{M}$ be the boolean observation mask.

**C (column-primary peel).** While density $< \tau$: drop the benchmark with the fewest observations among currently-kept rows, then drop any model left with zero observations.

**R (row-primary peel).** While density $< \tau$: drop the model with the fewest observations among currently-kept columns, then drop any benchmark left with zero observations.

**S (symmetric peel).** While density $< \tau$: compute each kept column's and each kept row's *fill rate* (observations ÷ current opposite-axis size) and drop whichever single marginal has the lowest rate, then clear emptied rows and columns on both axes.

**Minimum-observation floor.** After peeling, iterate to a fixed point, dropping any kept row or column with fewer observations than the floor *within the currently kept submatrix*. The loop is required because dropping a sparse row can starve a column and vice versa.

**Degenerate-column guard.** Finally drop any column with fewer than 2 observed values or zero variance among its observed values, matching exactly what the downstream estimators would drop at runtime. This parity is deliberate: it keeps the reported matrix shape equal to the shape actually factored.

The tables analysed in this paper were generated with the floor set to 3 observations.<!-- The constant name MIN_OBS was removed here and above in pass 5. -->

<!-- This sentence used to read: "The tables analysed in this paper were
generated with MIN_OBS = 2, verified against the shipped matrices -- the minimum
per-axis observation count is 2 on the R-densified matrices, whose peel is the
binding one. See Appendix known-limitations-and-deviations regarding the current
value of that constant in the analysis repository."

Both halves were wrong. The floor is 3 (scripts/densify.py), and Table 2 of the
Methodology reproduces exactly at 3 and only at 3 on the current corpus
(1618 models / 456 benchmarks / 13,251 rows), verified by re-running
collapse_results.py and densify.py --peek on 2026-09-19. The shipped matrices in
data/text_only/combinations_* still carry min_obs=2 because they predate the
corpus update and have not been regenerated; they are not what Table 2 reports.
The pointer to the Known limitations appendix went to a section describing a
2-vs-3 discrepancy that no longer exists, and that section has been deleted. -->

