# Omega sensitivity


To quantify to what degree missing observations affect our results, we run leave-one-covariate out (LOCO) factor analyses for each valid datasets. For each benchmarks in the dataset, we run factor analysis with the dataset left out, and store the difference in $\omega_h$ as a measure of sensitivity. Table 1 shows the correlations between benchmark frequency (normalized within the dataset) and the deltas. Signed averages of $r$ shows negligible correlation at $r=0.054$, but this may simply be because signed correlations cancel out to 0. Average of unsigned, absolute $r$ yielded a larger but still modest correlation of $r=0.184$.

**Table 1**. Correlations between benchmark observation and their $\Delta\omega_h$. $k$ = number of factors extracted.

| Method                        | Dataset            | $k$ |         $r$ |         $N$ |
| ----------------------------- | ------------------ | --: | ----------: | ----------: |
| fill-mean                     | C_all_standard     |   2 |     +0.0701 |          78 |
| fill-mean                     | C_all_standard     |  14 |     +0.1316 |          78 |
| knn                           | C_all_standard     |   2 |     +0.0268 |          78 |
| knn                           | C_all_standard     |   7 |     +0.3205 |          78 |
| knn                           | S_all_standard     |   2 |     +0.1765 |         124 |
| knn                           | S_all_standard     |  11 |     +0.2069 |         124 |
| missforest                    | C_all_aggressive   |   2 |     +0.0173 |         102 |
| missforest                    | C_all_aggressive   |   4 |     +0.2315 |         102 |
| missforest                    | C_all_standard     |   2 |     +0.0318 |          78 |
| missforest                    | C_all_standard     |   4 |     +0.0100 |          78 |
| missforest                    | S_all_standard     |   2 |     −0.3363 |         124 |
| missforest                    | S_all_standard     |   4 |     −0.2933 |         124 |
| onesidedmc                    | C_all_aggressive   |   2 |     −0.4256 |         102 |
| onesidedmc                    | C_all_standard     |   2 |     +0.3207 |          78 |
| onesidedmc                    | S_all_standard     |   2 |     +0.3462 |         124 |
| softimpute                    | C_all_aggressive   |   2 |     −0.0747 |         102 |
| softimpute                    | C_all_aggressive   |   5 |     +0.1804 |         102 |
| softimpute                    | C_all_standard     |   2 |     +0.4196 |          78 |
| softimpute                    | C_all_standard     |   9 |     +0.3245 |          78 |
| softimpute                    | R_all_aggressive   |   2 |     +0.1227 |         310 |
| softimpute                    | R_all_aggressive   |  20 |     −0.0677 |         310 |
| softimpute                    | R_all_standard     |   2 |     +0.0164 |         298 |
| softimpute                    | R_all_standard     |  20 |     −0.1719 |         298 |
| softimpute                    | S_all_aggressive   |   2 |     −0.2156 |         293 |
| softimpute                    | S_all_aggressive   |  20 |     −0.0837 |         293 |
| softimpute                    | S_all_standard     |   2 |     +0.2324 |         124 |
| softimpute                    | S_all_standard     |   5 |     +0.0361 |         124 |
| softimpute                    | raw_all_aggressive |   2 |     −0.2083 |         380 |
| softimpute                    | raw_all_aggressive |  10 |     −0.3003 |         380 |
| softimpute                    | raw_all_standard   |   2 |     +0.2880 |         404 |
| softimpute                    | raw_all_standard   |  10 |     +0.0528 |         404 |
| softimpute_corr               | C_all_standard     |   2 |     −0.0565 |          78 |
| softimpute_corr               | C_all_standard     |   4 |     +0.0917 |          78 |
| softimpute_corr               | S_all_standard     |   2 |     −0.1664 |         124 |
| softimpute_corr               | S_all_standard     |   5 |     +0.2068 |         124 |
| fill-zeros                    | C_all_standard     |   2 |     +0.2965 |          78 |
| fill-zeros                    | C_all_standard     |  14 |     +0.2493 |          78 |
| **Average $r$**               |                    |     | **+0.0542** | 37 (groups) |
| **Average $\lvert r \lvert$** |                    |     |  **0.1840** |             |
