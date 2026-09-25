# Benchmark $g$-rankings

## Frequency-ranking correlations

A pressing concern with regards to our findings on the top $g$ benchmarks in table 5 of the main content, is to what degree a benchmark's $g$-factor loading is correlated with their non-missing frequency. This is important to know, as our datasets can possess higher or lower correlations introduced as artifacts by our imputation methods.

Naively, as shown in table 1 below, benchmark frequency *is* correlated with $g$ loadings. Unsigned averages suggest this correlation is ignorable ($r = 0.3432$), but the range of the correlations are quite dispersed, and some dataset-imputation combination can be as high as ~0.5. Thus, identifying benchmarks which proxy a supposed latent $g$ factor well requires adjusting the statistics with respect to their frequency.

**Table 1**. Correlations between benchmark frequency and their $g$ loadings. $k$ = number of factors extracted.

| Method                       | Dataset            | $k$ |         $r$ |         $N$ |
| ---------------------------- | ------------------ | --: | ----------: | ----------: |
| fill-mean                    | C_all_standard     |   2 |     +0.4192 |          78 |
| fill-mean                    | C_all_standard     |  14 |     +0.4192 |          78 |
| knn                          | C_all_standard     |   2 |     +0.4065 |          78 |
| knn                          | C_all_standard     |   7 |     +0.4065 |          78 |
| knn                          | S_all_standard     |   2 |     +0.2335 |         124 |
| knn                          | S_all_standard     |  11 |     +0.2335 |         124 |
| missforest                   | C_all_aggressive   |   2 |     +0.3251 |         102 |
| missforest                   | C_all_aggressive   |   4 |     +0.3251 |         102 |
| missforest                   | C_all_standard     |   2 |     +0.2203 |          78 |
| missforest                   | C_all_standard     |   4 |     +0.2203 |          78 |
| missforest                   | S_all_standard     |   2 |     −0.2462 |         124 |
| missforest                   | S_all_standard     |   4 |     −0.2462 |         124 |
| onesidedmc                   | C_all_aggressive   |   2 |     −0.4090 |         102 |
| onesidedmc                   | C_all_standard     |   2 |     +0.4786 |          78 |
| onesidedmc                   | S_all_standard     |   2 |     +0.3609 |         124 |
| softimpute                   | C_all_aggressive   |   2 |     +0.5763 |         102 |
| softimpute                   | C_all_aggressive   |   5 |     +0.5763 |         102 |
| softimpute                   | C_all_standard     |   2 |     +0.5513 |          78 |
| softimpute                   | C_all_standard     |   9 |     +0.5513 |          78 |
| softimpute                   | R_all_aggressive   |   2 |     −0.3041 |         310 |
| softimpute                   | R_all_aggressive   |  20 |     −0.3041 |         310 |
| softimpute                   | R_all_standard     |   2 |     −0.2140 |         298 |
| softimpute                   | R_all_standard     |  20 |     −0.2140 |         298 |
| softimpute                   | S_all_aggressive   |   2 |     −0.3161 |         293 |
| softimpute                   | S_all_aggressive   |  20 |     −0.3161 |         293 |
| softimpute                   | S_all_standard     |   2 |     +0.1885 |         124 |
| softimpute                   | S_all_standard     |   5 |     +0.1885 |         124 |
| softimpute                   | raw_all_aggressive |   2 |     −0.2404 |         380 |
| softimpute                   | raw_all_aggressive |  10 |     −0.2404 |         380 |
| softimpute                   | raw_all_standard   |   2 |     +0.1815 |         404 |
| softimpute                   | raw_all_standard   |  10 |     +0.1815 |         404 |
| softimpute_corr              | C_all_standard     |   2 |     +0.3788 |          78 |
| softimpute_corr              | C_all_standard     |   4 |     +0.3788 |          78 |
| softimpute_corr              | S_all_standard     |   2 |     +0.3890 |         124 |
| softimpute_corr              | S_all_standard     |   5 |     +0.3890 |         124 |
| fill-zeros                   | C_all_standard     |   2 |     +0.5343 |          78 |
| fill-zeros                   | C_all_standard     |  14 |     +0.5343 |          78 |
| **Average**                  |                    |     | **+0.1783** | 37 (groups) |
| **Average $\lvert r\lvert$** |                    |     |  **0.3432** |             |

## Frequency adjustment


Let $C$ denote a factor cell: a method and dataset combination for which factor loadings are available. Within each cell $C$, benchmarks are ranked by absolute loading $|g_i|$ ($i$ indexes benchmarks). The rank $r_i$ is normalized within the cell,

$$a_i = \frac{r_i - 1}{n - 1}, \qquad r_i \in \{1, \dots, n\},$$

so $a_i = 0$ at the top of the cell and $a_i = 1$ at the bottom. This makes cells with different numbers of benchmarks $n$ comparable. Each benchmark's raw score is the mean of its $a_i$ over the cells in which it appears. Benchmarks appearing in fewer than two cells are excluded.

For a dataset with $m$ models, the frequency of benchmark $i$ is the proportion of models with an observed score,

$$f_i = \frac{\#\{\text{models with non-missing score for } i\}}{m}.$$

Columns with fewer than two observations or zero variance are excluded before computing $f_i$. Where several datasets contribute, the benchmark's frequency is the mean of its per-dataset $f_i$.

As shown in table 2 above, within most cells, frequently measured benchmarks obtain higher $|g_i|$ and lower (better) $a_i$. A benchmark may therefore rank highly partly because it is measured often rather than because it is a strong indicator of $g$.

The adjustment is applied within each cell rather than to the pooled averages. Within cell $C$, the normalized ranks are regressed on the cell's own frequencies by ordinary least squares,

$$a_i = \alpha + \beta f_i + \varepsilon_i, \qquad
\hat{\varepsilon}_i = (a_i - \bar{a}) - \hat{\beta}\,(f_i - \bar{f}),$$

and the residual $\hat{\varepsilon}_i$ replaces $a_i$. By construction the residuals are uncorrelated with $f_i$ within the cell, so $\hat{\beta}$ removes exactly the linear component of the within-cell rank–frequency association. A cell with fewer than three frequency–rank pairs, or with zero frequency variance, cannot be fitted; its benchmarks receive centered raw ranks $(a_i - \bar{a})$, and such cells are counted and reported.

The adjusted score of benchmark $i$ is the mean of its residuals over the cells in which it appears; rankings are reported on this scale, with the raw average rank retained for comparison.

## Diagnostics

We present 2 diagnostics that justify the method of adjustment. Table 2 below shows, within each cell, the Pearson correlation $r(f_i, a_i)$ is reported, with the mean $r$, the mean $|r|$, and the counts of negative and positive cells. Negative $r$ indicates that more frequently measured benchmarks load higher on $g$.

**Table 2**. Correlations between benchmark frequency and their $g$ rankings. Mean $r = -0.173$, mean $\lvert r \rvert = 0.273$; 13 negative and 7 positive cells.

| method | dataset | $N$ | $r$ |
|---|---|---|---|
| default | C_all_standard | 78 | −0.429 |
| knn | C_all_standard | 78 | −0.429 |
| knn | S_all_standard | 124 | +0.020 |
| missforest | C_all_aggressive | 102 | −0.342 |
| missforest | C_all_standard | 78 | −0.106 |
| missforest | S_all_standard | 124 | +0.261 |
| onesidedmc | C_all_aggressive | 102 | +0.383 |
| onesidedmc | C_all_standard | 78 | −0.242 |
| onesidedmc | S_all_standard | 124 | −0.271 |
| softimpute | C_all_aggressive | 102 | −0.470 |
| softimpute | C_all_standard | 78 | −0.497 |
| softimpute | R_all_aggressive | 310 | +0.006 |
| softimpute | R_all_standard | 298 | +0.222 |
| softimpute | S_all_aggressive | 293 | +0.094 |
| softimpute | S_all_standard | 124 | −0.162 |
| softimpute | raw_all_aggressive | 380 | +0.012 |
| softimpute | raw_all_standard | 404 | −0.091 |
| softimpute_corr | C_all_standard | 78 | −0.425 |
| softimpute_corr | S_all_standard | 124 | −0.431 |
| fill-zeros | C_all_standard | 78 | −0.572 |

Second, table 3 reports the the pooled correlation between mean frequency and mean rank is before and after the adjustment, stratified by the number of cells $k$ in which a benchmark appears. The within-cell association does not survive pooling with a consistent sign: cells disagree in direction, so the pooled raw correlation is small even though the within-cell correlations are not.

**Table 3**. Pooled correlation between mean frequency and mean rank.

| $N$ cells | $N$ benchmarks | $r$ raw | $r$ adjusted |
| --------- | -------------- | ------- | ------------ |
| 2         | 54             | −0.023  | −0.021       |
| 3         | 26             | −0.024  | −0.049       |
| 4         | 24             | −0.214  | −0.232       |
| 5         | 141            | +0.061  | +0.046       |
| 8         | 10             | +0.040  | +0.038       |
| 10        | 33             | +0.518  | +0.516       |
| 13        | 13             | −0.538  | −0.539       |
| 20        | 78             | −0.382  | +0.073       |
| Pooled    | 380            | −0.128  | −0.039       |

%%The adjustment is therefore evaluated per stratum rather than by the pooled correlation alone. Because the stratum-level diagnostic correlates against the *mean* frequency across a benchmark's datasets while the adjustment orthogonalizes against each *cell's* frequency, a residual stratum-level correlation is expected and does not indicate a failure of the adjustment.%%

For this reason, we report the cellwise-frequency-adjusted average normalized rank as the primary ordering of benchmarks (table 5 in the main content): it removes the linear component of the within-cell rank–frequency association, which reaches $|r| \approx 0.3$ in the average cell, before averaging across cells. The raw average normalized rank is retained alongside it for comparison, as the two orderings agree closely. The adjustment mainly matters for benchmarks measured across many cells, where the within-cell association is strongest and where the adjusted ranking reorders the raw ranking.

## Full $g$ rankings

Table 4 below shows benchmarks sorted by their rank order, similar to table 5 in the main content, but now including the entirety of 380 benchmarks useda cross our analyses.

**Table 4**. All used 380 benchmarks, sorted by their average normalized rank-order (ANR) of their $g$ factor loadings, residualized (RANR) against their frequency. The normalized rank-order ranges from 0 to 1. 0 = ranked first, 1 = ranked last. $N$ cells = number of EFA solutions with that benchmark. CI and Best/Worst refers to ANR.

| No  | Benchmark                        | RANR      | ANR      | 95% CI               | Best  | Worst | $N$ cells |
| --: | -------------------------------- | --------- | -------- | -------------------- | ----: | ----: | --------: |
| 1   | bhasa                                                    | -0.346 | 0.141 | [-0.005, 0.287] | 0.024 | 0.318 | 5         |
| 2   | mtrag                                                    | -0.341 | 0.147 | [-0.051, 0.346] | 0.021 | 0.394 | 5         |
| 3   | creativityprism                                          | -0.339 | 0.156 | [-0.019, 0.332] | 0.026 | 0.367 | 5         |
| 4   | eqbench                                                  | -0.332 | 0.156 | [-0.060, 0.372] | 0.017 | 0.451 | 5         |
| 5   | mceval                                                   | -0.331 | 0.156 | [0.024, 0.288]  | 0.051 | 0.333 | 5         |
| 6   | pwc_svamp                                                | -0.329 | 0.169 | [-0.033, 0.371] | 0.058 | 0.298 | 4         |
| 7   | pwc_drop_test                                            | -0.328 | 0.162 | [-0.139, 0.462] | 0.008 | 0.431 | 4         |
| 8   | ProphetArena                                             | -0.315 | 0.183 | [-0.036, 0.401] | 0.092 | 0.385 | 4         |
| 9   | dialogbench                                              | -0.295 | 0.210 | [-1.351, 1.770] | 0.087 | 0.332 | 2         |
| 10  | pwc_piqa                                                 | -0.282 | 0.253 | [0.162, 0.345]  | 0.003 | 0.822 | 20        |
| 11  | pwc_timequestions                                        | -0.275 | 0.230 | [0.173, 0.288]  | 0.226 | 0.235 | 2         |
| 12  | tablebench_data_analysis                                 | -0.272 | 0.223 | [-0.185, 0.631] | 0.000 | 0.787 | 5         |
| 13  | pwc_multinli                                             | -0.271 | 0.233 | [-0.459, 0.925] | 0.179 | 0.288 | 2         |
| 14  | lawbench                                                 | -0.264 | 0.222 | [-0.288, 0.731] | 0.057 | 0.452 | 3         |
| 15  | pwc_arc_challenge                                        | -0.260 | 0.277 | [0.149, 0.405]  | 0.000 | 0.808 | 20        |
| 16  | tablebench_fact_checking                                 | -0.260 | 0.235 | [-0.165, 0.635] | 0.020 | 0.784 | 5         |
| 17  | sea_helm                                                 | -0.257 | 0.235 | [-0.069, 0.539] | 0.045 | 0.603 | 5         |
| 18  | pinocchio                                                | -0.256 | 0.249 | [-0.564, 1.062] | 0.185 | 0.313 | 2         |
| 19  | tombench                                                 | -0.255 | 0.234 | [0.056, 0.413]  | 0.062 | 0.446 | 5         |
| 20  | indicgenbench                                            | -0.252 | 0.253 | [-0.347, 0.853] | 0.206 | 0.300 | 2         |
| 21  | dischargeme                                              | -0.250 | 0.245 | [0.093, 0.396]  | 0.087 | 0.402 | 5         |
| 22  | pwc_gem_xsum                                             | -0.246 | 0.259 | [-0.508, 1.026] | 0.199 | 0.319 | 2         |
| 23  | milu                                                     | -0.241 | 0.248 | [0.092, 0.404]  | 0.044 | 0.350 | 5         |
| 24  | dialectbench                                             | -0.238 | 0.267 | [-0.357, 0.892] | 0.218 | 0.317 | 2         |
| 25  | mena_bench                                               | -0.232 | 0.256 | [-0.163, 0.675] | 0.082 | 0.859 | 5         |
| 26  | ReasonBENCH                                              | -0.232 | 0.266 | [0.044, 0.489]  | 0.075 | 0.380 | 4         |
| 27  | sea_exam                                                 | -0.230 | 0.261 | [-0.007, 0.530] | 0.055 | 0.559 | 5         |
| 28  | evalplus                                                 | -0.230 | 0.269 | [0.020, 0.517]  | 0.102 | 0.479 | 4         |
| 29  | sportsmetrics                                            | -0.226 | 0.272 | [-0.132, 0.676] | 0.124 | 0.653 | 4         |
| 30  | kalahi                                                   | -0.224 | 0.264 | [0.146, 0.382]  | 0.148 | 0.362 | 5         |
| 31  | batayan                                                  | -0.222 | 0.268 | [0.053, 0.482]  | 0.071 | 0.456 | 5         |
| 32  | bharatbench                                              | -0.221 | 0.268 | [-0.141, 0.676] | 0.111 | 0.856 | 5         |
| 33  | tablebench_numerical_reasoning                           | -0.217 | 0.278 | [-0.146, 0.702] | 0.021 | 0.851 | 5         |
| 34  | pwc_pecc                                                 | -0.216 | 0.273 | [0.056, 0.490]  | 0.079 | 0.516 | 5         |
| 35  | race_based_med                                           | -0.213 | 0.281 | [0.042, 0.520]  | 0.108 | 0.579 | 5         |
| 36  | shc_conf_med                                             | -0.211 | 0.283 | [-0.036, 0.602] | 0.098 | 0.722 | 5         |
| 37  | helm                                                     | -0.209 | 0.282 | [-0.066, 0.630] | 0.048 | 0.764 | 5         |
| 38  | financial_scenarios                                      | -0.204 | 0.304 | [0.121, 0.488]  | 0.057 | 0.764 | 10        |
| 39  | kaggle_olamysiak_eclektic                                | -0.203 | 0.310 | [0.121, 0.498]  | 0.006 | 0.821 | 13        |
| 40  | aci_bench                                                | -0.200 | 0.294 | [0.109, 0.480]  | 0.106 | 0.465 | 5         |
| 41  | turl_col_type                                            | -0.193 | 0.301 | [-0.167, 0.769] | 0.061 | 0.958 | 5         |
| 42  | financebench                                             | -0.192 | 0.317 | [0.174, 0.460]  | 0.061 | 0.707 | 10        |
| 43  | cmmlu                                                    | -0.191 | 0.294 | [-0.276, 0.864] | 0.104 | 0.549 | 3         |
| 44  | pwc_race                                                 | -0.191 | 0.299 | [-0.149, 0.747] | 0.032 | 0.886 | 5         |
| 45  | pwc_turbulence                                           | -0.191 | 0.294 | [0.149, 0.439]  | 0.246 | 0.359 | 3         |
| 46  | pwc_big_bench_reasoning_about_colored_objects            | -0.191 | 0.299 | [-0.196, 0.793] | 0.010 | 0.929 | 5         |
| 47  | fin_qa                                                   | -0.190 | 0.319 | [0.130, 0.508]  | 0.029 | 0.756 | 10        |
| 48  | banking77                                                | -0.187 | 0.322 | [0.104, 0.540]  | 0.013 | 0.886 | 10        |
| 49  | wikitq                                                   | -0.184 | 0.311 | [-0.126, 0.748] | 0.007 | 0.794 | 5         |
| 50  | cac                                                      | -0.183 | 0.305 | [-0.156, 0.765] | 0.099 | 0.965 | 5         |
| 51  | pwc_big_bench_winowhy                                    | -0.181 | 0.322 | [-0.870, 1.514] | 0.042 | 0.876 | 3         |
| 52  | pwc_big_bench_disambiguation_qa                          | -0.180 | 0.310 | [-0.178, 0.798] | 0.013 | 0.902 | 5         |
| 53  | synthetic_reasoning                                      | -0.179 | 0.343 | [0.250, 0.435]  | 0.065 | 0.748 | 20        |
| 54  | afrobench                                                | -0.175 | 0.315 | [0.074, 0.555]  | 0.000 | 0.534 | 5         |
| 55  | mt_bench                                                 | -0.173 | 0.316 | [-0.037, 0.669] | 0.120 | 0.798 | 5         |
| 56  | followbench                                              | -0.170 | 0.319 | [0.065, 0.574]  | 0.185 | 0.551 | 4         |
| 57  | gsm                                                      | -0.169 | 0.319 | [0.162, 0.476]  | 0.000 | 0.936 | 20        |
| 58  | pwc_arc_easy                                             | -0.169 | 0.341 | [0.184, 0.499]  | 0.041 | 0.970 | 13        |
| 59  | xifbench                                                 | -0.169 | 0.320 | [-0.089, 0.728] | 0.034 | 0.849 | 5         |
| 60  | openbookqa                                               | -0.168 | 0.330 | [0.180, 0.480]  | 0.013 | 0.931 | 20        |
| 61  | pwc_big_bench_date_understanding                         | -0.166 | 0.323 | [-0.156, 0.803] | 0.003 | 0.919 | 5         |
| 62  | belebele                                                 | -0.165 | 0.323 | [-0.120, 0.765] | 0.041 | 0.946 | 5         |
| 63  | americasnli                                              | -0.162 | 0.343 | [-2.033, 2.719] | 0.156 | 0.530 | 2         |
| 64  | natural_qa_closedbook                                    | -0.162 | 0.327 | [0.208, 0.445]  | 0.052 | 0.909 | 20        |
| 65  | medcalc_bench                                            | -0.160 | 0.335 | [-0.029, 0.698] | 0.074 | 0.834 | 5         |
| 66  | starr_patient_instructions                               | -0.159 | 0.335 | [0.017, 0.653]  | 0.175 | 0.769 | 5         |
| 67  | pubmedqa                                                 | -0.156 | 0.348 | [0.134, 0.562]  | 0.050 | 0.812 | 8         |
| 68  | pwc_tiq                                                  | -0.155 | 0.350 | [-1.070, 1.770] | 0.238 | 0.462 | 2         |
| 69  | pwc_big_bench_penguins_in_a_table                        | -0.155 | 0.334 | [-0.220, 0.888] | 0.010 | 0.933 | 5         |
| 70  | pwc_big_bench_strategyqa                                 | -0.155 | 0.348 | [-0.969, 1.665] | 0.039 | 0.960 | 3         |
| 71  | akata_games_2023                                         | -0.154 | 0.334 | [-0.360, 1.028] | 0.017 | 0.975 | 4         |
| 72  | thaiexam                                                 | -0.154 | 0.374 | [0.263, 0.486]  | 0.016 | 0.980 | 20        |
| 73  | emobench                                                 | -0.154 | 0.334 | [0.125, 0.544]  | 0.159 | 0.586 | 5         |
| 74  | synthetic_reasoning_natural                              | -0.153 | 0.369 | [0.274, 0.464]  | 0.143 | 0.724 | 20        |
| 75  | pwc_big_bench_sports_understanding                       | -0.150 | 0.338 | [-0.216, 0.892] | 0.000 | 0.898 | 5         |
| 76  | pwc_record                                               | -0.149 | 0.361 | [0.116, 0.606]  | 0.140 | 0.881 | 7         |
| 77  | pwc_big_bench_causal_judgment                            | -0.148 | 0.341 | [-0.167, 0.850] | 0.003 | 0.836 | 5         |
| 78  | pwc_multirc                                              | -0.147 | 0.357 | [0.208, 0.507]  | 0.069 | 0.594 | 8         |
| 79  | pwc_ncbi_disease                                         | -0.146 | 0.359 | [-1.081, 1.799] | 0.246 | 0.472 | 2         |
| 80  | pwc_rucos                                                | -0.146 | 0.353 | [0.105, 0.600]  | 0.237 | 0.411 | 3         |
| 81  | agentif                                                  | -0.146 | 0.346 | [0.041, 0.652]  | 0.074 | 0.732 | 5         |
| 82  | medqa                                                    | -0.144 | 0.362 | [0.214, 0.511]  | 0.000 | 0.992 | 20        |
| 83  | thai_exam_a_level                                        | -0.144 | 0.384 | [0.277, 0.491]  | 0.008 | 0.772 | 20        |
| 84  | flores_200                                               | -0.142 | 0.363 | [-1.672, 2.399] | 0.203 | 0.524 | 2         |
| 85  | litbench                                                 | -0.140 | 0.352 | [-0.082, 0.786] | 0.024 | 0.933 | 5         |
| 86  | pwc_parus                                                | -0.139 | 0.360 | [-0.430, 1.151] | 0.146 | 0.726 | 3         |
| 87  | shc_ptbm_med                                             | -0.137 | 0.357 | [0.045, 0.669]  | 0.094 | 0.680 | 5         |
| 88  | bigcodebench                                             | -0.131 | 0.379 | [0.220, 0.538]  | 0.059 | 0.846 | 13        |
| 89  | thai_exam_tpat1                                          | -0.131 | 0.397 | [0.296, 0.498]  | 0.013 | 0.676 | 20        |
| 90  | mgsm                                                     | -0.126 | 0.370 | [-0.070, 0.810] | 0.108 | 0.993 | 5         |
| 91  | nusamt                                                   | -0.122 | 0.383 | [-0.855, 1.621] | 0.285 | 0.480 | 2         |
| 92  | math_chain_of_thought                                    | -0.120 | 0.367 | [0.230, 0.505]  | 0.037 | 0.935 | 20        |
| 93  | legalbench                                               | -0.117 | 0.392 | [0.243, 0.542]  | 0.045 | 0.963 | 20        |
| 94  | pwc_big_bench_temporal_sequences                         | -0.113 | 0.376 | [-0.190, 0.942] | 0.005 | 0.980 | 5         |
| 95  | neuro_eval                                               | -0.113 | 0.386 | [0.205, 0.566]  | 0.303 | 0.553 | 4         |
| 96  | thaih6                                                   | -0.109 | 0.380 | [-0.021, 0.780] | 0.154 | 0.921 | 5         |
| 97  | ewok_spatial_relations                                   | -0.108 | 0.387 | [0.015, 0.758]  | 0.010 | 0.839 | 5         |
| 98  | tab_fact                                                 | -0.107 | 0.388 | [0.024, 0.751]  | 0.161 | 0.861 | 5         |
| 99  | mtsamples_replicate                                      | -0.106 | 0.388 | [0.100, 0.677]  | 0.198 | 0.680 | 5         |
| 100 | pwc_cc3m_tagmask                                         | -0.096 | 0.409 | [-4.122, 4.939] | 0.052 | 0.765 | 2         |
| 101 | quac                                                     | -0.095 | 0.429 | [0.304, 0.553]  | 0.020 | 0.878 | 20        |
| 102 | kaggle_andrewmingwang_scicode_subproblem_standard        | -0.095 | 0.435 | [0.298, 0.572]  | 0.000 | 0.935 | 20        |
| 103 | wmt_14                                                   | -0.092 | 0.417 | [0.260, 0.575]  | 0.000 | 0.971 | 20        |
| 104 | thai_exam_tgat                                           | -0.092 | 0.436 | [0.323, 0.549]  | 0.003 | 0.901 | 20        |
| 105 | swiss_legal_bench                                        | -0.092 | 0.414 | [-3.097, 3.924] | 0.137 | 0.690 | 2         |
| 106 | pwc_webapp1k_react                                       | -0.091 | 0.398 | [0.083, 0.712]  | 0.146 | 0.825 | 5         |
| 107 | ewok_social_interactions                                 | -0.090 | 0.404 | [0.047, 0.762]  | 0.088 | 0.866 | 5         |
| 108 | ChipBench                                                | -0.090 | 0.416 | [-3.354, 4.185] | 0.119 | 0.712 | 2         |
| 109 | kaggle_yulongt_facts_parametric                          | -0.090 | 0.419 | [0.191, 0.646]  | 0.024 | 0.951 | 10        |
| 110 | ewok_physical_interactions                               | -0.088 | 0.406 | [-0.020, 0.832] | 0.047 | 0.970 | 5         |
| 111 | pwc_copa                                                 | -0.088 | 0.410 | [0.242, 0.579]  | 0.129 | 0.683 | 8         |
| 112 | shc_bmt_med                                              | -0.088 | 0.406 | [0.149, 0.663]  | 0.084 | 0.625 | 5         |
| 113 | gtbench                                                  | -0.088 | 0.403 | [0.241, 0.565]  | 0.301 | 0.579 | 5         |
| 114 | multiloko                                                | -0.087 | 0.439 | [0.326, 0.552]  | 0.065 | 0.909 | 20        |
| 115 | mimic_rrs                                                | -0.087 | 0.407 | [0.142, 0.672]  | 0.129 | 0.704 | 5         |
| 116 | kaggle_aminmohamedmohami_browsecomp                      | -0.084 | 0.446 | [0.297, 0.595]  | 0.016 | 0.961 | 20        |
| 117 | include                                                  | -0.084 | 0.405 | [-0.002, 0.813] | 0.094 | 0.696 | 4         |
| 118 | pwc_commitmentbank                                       | -0.083 | 0.406 | [0.184, 0.629]  | 0.195 | 0.605 | 5         |
| 119 | mbpp                                                     | -0.082 | 0.457 | [0.337, 0.577]  | 0.030 | 0.905 | 20        |
| 120 | aime25                                                   | -0.080 | 0.449 | [0.277, 0.622]  | 0.008 | 0.987 | 20        |
| 121 | kaggle_sjmikler_livecodebench                            | -0.079 | 0.449 | [0.299, 0.600]  | 0.029 | 1.000 | 20        |
| 122 | filbench                                                 | -0.077 | 0.412 | [0.125, 0.699]  | 0.067 | 0.715 | 5         |
| 123 | shc_ent_med                                              | -0.077 | 0.417 | [0.002, 0.833]  | 0.127 | 0.912 | 5         |
| 124 | mmlu_prox                                                | -0.073 | 0.455 | [0.321, 0.589]  | 0.036 | 0.948 | 20        |
| 125 | mmlu_pro                                                 | -0.073 | 0.280 | [0.139, 0.421]  | 0.000 | 0.927 | 20        |
| 126 | shc_sequoia_med                                          | -0.071 | 0.423 | [-0.029, 0.875] | 0.107 | 0.943 | 5         |
| 127 | kaggle_andrewmingwang_scicode_main_with_background       | -0.070 | 0.442 | [0.273, 0.611]  | 0.089 | 0.984 | 13        |
| 128 | ilakkanam                                                | -0.070 | 0.420 | [0.139, 0.700]  | 0.099 | 0.638 | 5         |
| 129 | mmlu                                                     | -0.069 | 0.340 | [0.194, 0.486]  | 0.000 | 1.000 | 20        |
| 130 | madinah_qa                                               | -0.069 | 0.460 | [0.332, 0.588]  | 0.026 | 0.976 | 20        |
| 131 | burmesesan                                               | -0.067 | 0.421 | [-0.037, 0.880] | 0.089 | 0.970 | 5         |
| 132 | raft                                                     | -0.065 | 0.459 | [0.327, 0.591]  | 0.010 | 0.902 | 20        |
| 133 | humorbench                                               | -0.063 | 0.431 | [0.157, 0.706]  | 0.057 | 0.637 | 5         |
| 134 | global_piqa                                              | -0.063 | 0.440 | [-0.055, 0.935] | 0.401 | 0.479 | 2         |
| 135 | arabicmmlu                                               | -0.062 | 0.467 | [0.343, 0.592]  | 0.079 | 0.973 | 20        |
| 136 | medbullets                                               | -0.061 | 0.433 | [0.112, 0.754]  | 0.162 | 0.809 | 5         |
| 137 | sotopia                                                  | -0.057 | 0.433 | [-0.034, 0.899] | 0.072 | 0.790 | 4         |
| 138 | arc                                                      | -0.056 | 0.356 | [0.230, 0.481]  | 0.049 | 1.000 | 20        |
| 139 | gpqa_diamond                                             | -0.054 | 0.475 | [0.355, 0.595]  | 0.016 | 0.992 | 20        |
| 140 | wikifact                                                 | -0.052 | 0.471 | [0.365, 0.577]  | 0.000 | 0.851 | 20        |
| 141 | ewok_physical_relations                                  | -0.050 | 0.445 | [0.076, 0.813]  | 0.040 | 0.871 | 5         |
| 142 | pwc_commonsenseqa                                        | -0.049 | 0.456 | [0.106, 0.805]  | 0.067 | 0.990 | 8         |
| 143 | mmedbench                                                | -0.048 | 0.442 | [-0.101, 0.985] | 0.116 | 0.771 | 4         |
| 144 | freshqa                                                  | -0.048 | 0.440 | [0.026, 0.854]  | 0.027 | 0.931 | 5         |
| 145 | criticbench                                              | -0.047 | 0.443 | [0.148, 0.739]  | 0.107 | 0.717 | 5         |
| 146 | facts_search                                             | -0.044 | 0.463 | [0.270, 0.656]  | 0.000 | 0.813 | 10        |
| 147 | cogbench                                                 | -0.042 | 0.470 | [0.290, 0.650]  | 0.081 | 0.884 | 13        |
| 148 | swe_bench                                                | -0.042 | 0.466 | [0.290, 0.643]  | 0.081 | 0.780 | 10        |
| 149 | arabic_exams                                             | -0.042 | 0.487 | [0.359, 0.615]  | 0.065 | 0.980 | 20        |
| 150 | medmcqa                                                  | -0.041 | 0.453 | [0.188, 0.718]  | 0.177 | 0.729 | 5         |
| 151 | pwc_wnli                                                 | -0.041 | 0.464 | [-2.057, 2.985] | 0.266 | 0.662 | 2         |
| 152 | alrage                                                   | -0.040 | 0.489 | [0.361, 0.617]  | 0.041 | 0.846 | 20        |
| 153 | truthfulqa                                               | -0.038 | 0.366 | [0.258, 0.475]  | 0.016 | 0.789 | 20        |
| 154 | pwc_mawps                                                | -0.036 | 0.453 | [0.095, 0.810]  | 0.137 | 0.785 | 5         |
| 155 | sportqa                                                  | -0.035 | 0.453 | [0.261, 0.645]  | 0.276 | 0.541 | 4         |
| 156 | arena_hard_auto                                          | -0.034 | 0.497 | [0.362, 0.632]  | 0.078 | 0.922 | 20        |
| 157 | vietnamese_glue                                          | -0.033 | 0.457 | [-0.098, 1.013] | 0.015 | 0.818 | 4         |
| 158 | numeric_nlg                                              | -0.031 | 0.463 | [0.027, 0.899]  | 0.077 | 0.985 | 5         |
| 159 | n2c2_ct_matching                                         | -0.031 | 0.463 | [0.242, 0.684]  | 0.217 | 0.690 | 5         |
| 160 | pwc_big_bench_formal_fallacies_syllogisms_negation       | -0.031 | 0.459 | [0.079, 0.839]  | 0.058 | 0.818 | 5         |
| 161 | pwc_big_bench_logic_grid_puzzle                          | -0.031 | 0.472 | [0.074, 0.871]  | 0.377 | 0.658 | 3         |
| 162 | ewok_material_dynamics                                   | -0.030 | 0.464 | [0.145, 0.783]  | 0.074 | 0.779 | 5         |
| 163 | multichallenge                                           | -0.030 | 0.460 | [0.212, 0.709]  | 0.285 | 0.774 | 5         |
| 164 | ewok                                                     | -0.028 | 0.466 | [0.088, 0.844]  | 0.054 | 0.906 | 5         |
| 165 | bbh                                                      | -0.028 | 0.323 | [0.182, 0.464]  | 0.000 | 0.959 | 20        |
| 166 | ewok_agent_properties                                    | -0.028 | 0.467 | [0.028, 0.905]  | 0.007 | 0.995 | 5         |
| 167 | pwc_danetqa                                              | -0.026 | 0.472 | [-0.052, 0.997] | 0.241 | 0.654 | 3         |
| 168 | msmarco_regular                                          | -0.026 | 0.484 | [0.332, 0.636]  | 0.244 | 0.919 | 10        |
| 169 | simpleqa                                                 | -0.026 | 0.486 | [0.383, 0.590]  | 0.171 | 0.692 | 13        |
| 170 | alghafa                                                  | -0.022 | 0.507 | [0.377, 0.637]  | 0.039 | 1.000 | 20        |
| 171 | kaggle_andrewmingwang_scicode_subproblem_with_background | -0.022 | 0.508 | [0.368, 0.648]  | 0.049 | 0.935 | 20        |
| 172 | pwc_frontiermath                                         | -0.019 | 0.470 | [0.091, 0.850]  | 0.069 | 0.849 | 5         |
| 173 | FlashInfer-Bench                                         | -0.018 | 0.480 | [-0.038, 0.998] | 0.062 | 0.847 | 4         |
| 174 | math500                                                  | -0.017 | 0.516 | [0.352, 0.679]  | 0.013 | 1.000 | 20        |
| 175 | indoculture                                              | -0.017 | 0.473 | [-0.210, 1.155] | 0.037 | 0.897 | 4         |
| 176 | mtsamples_procedures                                     | -0.016 | 0.479 | [0.158, 0.799]  | 0.272 | 0.926 | 5         |
| 177 | gpqa                                                     | -0.015 | 0.338 | [0.219, 0.456]  | 0.040 | 0.919 | 20        |
| 178 | indicqa                                                  | -0.014 | 0.496 | [0.322, 0.670]  | 0.104 | 0.854 | 10        |
| 179 | pwc_codecontests                                         | -0.013 | 0.492 | [-5.322, 6.306] | 0.035 | 0.950 | 2         |
| 180 | benchmax                                                 | -0.011 | 0.476 | [0.393, 0.559]  | 0.384 | 0.558 | 5         |
| 181 | msmarco_trec                                             | -0.010 | 0.500 | [0.368, 0.631]  | 0.236 | 0.854 | 10        |
| 182 | pwc_gigaword                                             | -0.010 | 0.495 | [-2.480, 3.471] | 0.261 | 0.730 | 2         |
| 183 | cruxeval                                                 | -0.010 | 0.496 | [0.280, 0.712]  | 0.192 | 0.970 | 8         |
| 184 | livebench                                                | -0.008 | 0.484 | [0.103, 0.864]  | 0.040 | 0.751 | 5         |
| 185 | kmmlu                                                    | -0.006 | 0.482 | [0.063, 0.901]  | 0.114 | 0.877 | 5         |
| 186 | summarization_xsum                                       | -0.006 | 0.525 | [0.435, 0.616]  | 0.130 | 0.801 | 20        |
| 187 | winogrande                                               | -0.006 | 0.392 | [0.274, 0.510]  | 0.117 | 0.950 | 20        |
| 188 | bfcl                                                     | -0.005 | 0.527 | [0.390, 0.663]  | 0.106 | 0.926 | 20        |
| 189 | DeceptionBench                                           | -0.002 | 0.504 | [-1.136, 2.143] | 0.375 | 0.633 | 2         |
| 190 | culturescope                                             | -0.001 | 0.502 | [-0.372, 1.375] | 0.151 | 0.855 | 3         |
| 191 | pwc_obqa                                                 | -0.001 | 0.487 | [0.239, 0.735]  | 0.169 | 0.650 | 5         |
| 192 | chatbot_arena                                            | +0.001 | 0.499 | [0.356, 0.641]  | 0.057 | 0.992 | 20        |
| 193 | flores_en_id                                             | +0.002 | 0.511 | [0.338, 0.685]  | 0.051 | 0.792 | 10        |
| 194 | natural_qa_openbook_longans                              | +0.003 | 0.493 | [0.390, 0.596]  | 0.099 | 0.798 | 20        |
| 195 | ewok_social_properties                                   | +0.005 | 0.500 | [0.199, 0.800]  | 0.125 | 0.797 | 5         |
| 196 | artificial_analysis_intelligence                         | +0.006 | 0.542 | [0.440, 0.644]  | 0.179 | 1.000 | 20        |
| 197 | pwc_lambada                                              | +0.007 | 0.500 | [0.176, 0.823]  | 0.243 | 0.868 | 5         |
| 198 | ewok_quantitative_properties                             | +0.009 | 0.503 | [0.179, 0.828]  | 0.091 | 0.799 | 5         |
| 199 | sorry_bench                                              | +0.012 | 0.502 | [0.158, 0.846]  | 0.322 | 0.963 | 5         |
| 200 | ewok_physical_dynamics                                   | +0.014 | 0.508 | [0.233, 0.782]  | 0.172 | 0.767 | 5         |
| 201 | pwc_strategyqa                                           | +0.017 | 0.522 | [-5.303, 6.346] | 0.063 | 0.980 | 2         |
| 202 | gsm8k                                                    | +0.017 | 0.413 | [0.263, 0.563]  | 0.000 | 1.000 | 20        |
| 203 | kaggle_vijitsingh1_mgsm_english                          | +0.017 | 0.546 | [0.436, 0.656]  | 0.136 | 0.911 | 20        |
| 204 | bbq                                                      | +0.020 | 0.531 | [0.390, 0.671]  | 0.000 | 0.976 | 20        |
| 205 | Vericoding                                               | +0.021 | 0.526 | [0.305, 0.748]  | 0.509 | 0.544 | 2         |
| 206 | boolq                                                    | +0.022 | 0.545 | [0.441, 0.649]  | 0.040 | 0.919 | 20        |
| 207 | pwc_anli_test                                            | +0.023 | 0.511 | [0.221, 0.802]  | 0.247 | 0.819 | 5         |
| 208 | ewok_social_relations                                    | +0.025 | 0.519 | [0.145, 0.894]  | 0.064 | 0.911 | 5         |
| 209 | moralbench                                               | +0.027 | 0.512 | [-0.424, 1.448] | 0.132 | 0.886 | 3         |
| 210 | ehr_sql                                                  | +0.027 | 0.521 | [0.145, 0.897]  | 0.204 | 0.865 | 5         |
| 211 | medec                                                    | +0.031 | 0.525 | [0.140, 0.911]  | 0.133 | 0.845 | 5         |
| 212 | babi_qa                                                  | +0.033 | 0.554 | [0.442, 0.667]  | 0.050 | 0.921 | 20        |
| 213 | vectara                                                  | +0.034 | 0.522 | [0.412, 0.631]  | 0.435 | 0.660 | 5         |
| 214 | ewok_material_properties                                 | +0.035 | 0.529 | [0.124, 0.934]  | 0.030 | 0.940 | 5         |
| 215 | pwc_webapp1k_duo_react                                   | +0.036 | 0.524 | [0.305, 0.743]  | 0.293 | 0.723 | 5         |
| 216 | kaggle_andrewmingwang_scicode_main_standard              | +0.036 | 0.550 | [0.361, 0.738]  | 0.008 | 0.911 | 13        |
| 217 | kaggle_andrewmingwang_dsqa                               | +0.036 | 0.526 | [0.309, 0.743]  | 0.364 | 0.722 | 5         |
| 218 | scigen                                                   | +0.037 | 0.531 | [0.137, 0.925]  | 0.118 | 0.955 | 5         |
| 219 | pwc_terra                                                | +0.037 | 0.536 | [-0.367, 1.438] | 0.236 | 0.939 | 3         |
| 220 | math_regular                                             | +0.038 | 0.575 | [0.463, 0.687]  | 0.077 | 1.000 | 20        |
| 221 | culemo                                                   | +0.038 | 0.544 | [0.510, 0.577]  | 0.541 | 0.546 | 2         |
| 222 | eifbench                                                 | +0.042 | 0.534 | [0.418, 0.649]  | 0.462 | 0.665 | 5         |
| 223 | pwc_aime24                                               | +0.044 | 0.532 | [0.260, 0.804]  | 0.290 | 0.683 | 4         |
| 224 | aratrust                                                 | +0.047 | 0.576 | [0.441, 0.710]  | 0.052 | 0.974 | 20        |
| 225 | livecodebench                                            | +0.049 | 0.540 | [0.194, 0.887]  | 0.178 | 0.914 | 5         |
| 226 | pwc_storycloze                                           | +0.050 | 0.550 | [0.309, 0.791]  | 0.198 | 0.980 | 8         |
| 227 | pwc_siqa                                                 | +0.052 | 0.539 | [-0.130, 1.208] | 0.025 | 0.887 | 4         |
| 228 | hellaswag                                                | +0.052 | 0.463 | [0.340, 0.586]  | 0.126 | 0.983 | 20        |
| 229 | indicsentiment                                           | +0.052 | 0.562 | [0.345, 0.780]  | 0.065 | 0.951 | 10        |
| 230 | entity_data_imputation                                   | +0.055 | 0.578 | [0.449, 0.707]  | 0.030 | 0.990 | 20        |
| 231 | pwc_apps                                                 | +0.060 | 0.565 | [-2.515, 3.645] | 0.323 | 0.807 | 2         |
| 232 | lindsea_pragmatics_presuppositions_id                    | +0.061 | 0.571 | [0.373, 0.770]  | 0.049 | 0.896 | 10        |
| 233 | LemmaBench                                               | +0.063 | 0.566 | [0.390, 0.743]  | 0.494 | 0.636 | 3         |
| 234 | mental_health                                            | +0.063 | 0.558 | [0.225, 0.890]  | 0.252 | 0.846 | 5         |
| 235 | aime_2025                                                | +0.065 | 0.559 | [0.174, 0.943]  | 0.189 | 0.893 | 5         |
| 236 | culturalbench                                            | +0.065 | 0.554 | [0.295, 0.813]  | 0.393 | 0.882 | 5         |
| 237 | pwc_peerqa                                               | +0.066 | 0.554 | [0.322, 0.786]  | 0.330 | 0.816 | 5         |
| 238 | pwc_rwsd                                                 | +0.068 | 0.567 | [-0.369, 1.503] | 0.315 | 1.000 | 3         |
| 239 | kaggle_aminmohamedmohami_indic_gen_bench                 | +0.068 | 0.562 | [0.353, 0.772]  | 0.421 | 0.844 | 5         |
| 240 | StatEval                                                 | +0.071 | 0.577 | [-2.021, 3.174] | 0.372 | 0.781 | 2         |
| 241 | pwc_carb                                                 | +0.073 | 0.558 | [-0.468, 1.584] | 0.135 | 0.960 | 3         |
| 242 | facts_grounding                                          | +0.076 | 0.608 | [0.481, 0.736]  | 0.223 | 0.987 | 20        |
| 243 | pwc_lidirus                                              | +0.077 | 0.576 | [-0.247, 1.398] | 0.248 | 0.910 | 3         |
| 244 | flores_id_en                                             | +0.077 | 0.587 | [0.365, 0.809]  | 0.111 | 0.984 | 10        |
| 245 | naturalquestions                                         | +0.079 | 0.568 | [0.166, 0.970]  | 0.032 | 0.836 | 5         |
| 246 | nusax                                                    | +0.080 | 0.589 | [0.451, 0.728]  | 0.229 | 0.911 | 10        |
| 247 | bold                                                     | +0.082 | 0.614 | [0.494, 0.734]  | 0.143 | 0.984 | 20        |
| 248 | harmbench                                                | +0.082 | 0.593 | [0.474, 0.712]  | 0.244 | 1.000 | 20        |
| 249 | entity_matching                                          | +0.082 | 0.605 | [0.461, 0.750]  | 0.069 | 0.961 | 20        |
| 250 | wisesight                                                | +0.083 | 0.597 | [0.458, 0.736]  | 0.135 | 0.921 | 13        |
| 251 | pwc_oie2016                                              | +0.085 | 0.571 | [-0.494, 1.635] | 0.140 | 0.997 | 3         |
| 252 | irokobench                                               | +0.086 | 0.578 | [0.130, 1.026]  | 0.144 | 0.953 | 5         |
| 253 | pwc_newsqa                                               | +0.092 | 0.584 | [0.177, 0.991]  | 0.079 | 0.949 | 5         |
| 254 | xstest                                                   | +0.095 | 0.606 | [0.481, 0.731]  | 0.179 | 0.987 | 20        |
| 255 | kaggle_andrewmingwang_simpleqa_verified                  | +0.097 | 0.629 | [0.520, 0.738]  | 0.268 | 1.000 | 20        |
| 256 | summarization_cnndm                                      | +0.098 | 0.630 | [0.515, 0.745]  | 0.188 | 0.987 | 20        |
| 257 | shc_privacy_med                                          | +0.100 | 0.594 | [0.365, 0.823]  | 0.343 | 0.760 | 5         |
| 258 | xnli                                                     | +0.101 | 0.615 | [0.496, 0.734]  | 0.249 | 0.871 | 13        |
| 259 | civil_comments                                           | +0.101 | 0.624 | [0.518, 0.731]  | 0.277 | 0.909 | 20        |
| 260 | narrative_qa                                             | +0.102 | 0.591 | [0.482, 0.700]  | 0.059 | 0.870 | 20        |
| 261 | LegalEval-Q                                              | +0.104 | 0.608 | [0.063, 1.153]  | 0.355 | 0.749 | 3         |
| 262 | musr                                                     | +0.105 | 0.458 | [0.331, 0.584]  | 0.109 | 0.971 | 20        |
| 263 | mimiciv_billing_code                                     | +0.105 | 0.600 | [0.259, 0.940]  | 0.196 | 0.862 | 5         |
| 264 | flores_en_vi                                             | +0.105 | 0.615 | [0.411, 0.820]  | 0.128 | 0.953 | 10        |
| 265 | simple_safety_tests                                      | +0.106 | 0.616 | [0.488, 0.744]  | 0.033 | 1.000 | 20        |
| 266 | disinformation_wedging                                   | +0.106 | 0.638 | [0.506, 0.770]  | 0.129 | 1.000 | 20        |
| 267 | flores_th_en                                             | +0.107 | 0.617 | [0.424, 0.809]  | 0.163 | 0.943 | 10        |
| 268 | math                                                     | +0.107 | 0.454 | [0.305, 0.603]  | 0.024 | 0.987 | 20        |
| 269 | flores_vi_en                                             | +0.107 | 0.617 | [0.404, 0.830]  | 0.084 | 0.976 | 10        |
| 270 | shc_proxy_med                                            | +0.109 | 0.603 | [0.222, 0.984]  | 0.117 | 0.939 | 5         |
| 271 | real_toxicity_prompts                                    | +0.109 | 0.641 | [0.513, 0.769]  | 0.065 | 0.950 | 20        |
| 272 | shc_gip_med                                              | +0.111 | 0.605 | [0.226, 0.984]  | 0.154 | 0.877 | 5         |
| 273 | shc_sei_med                                              | +0.112 | 0.606 | [0.365, 0.847]  | 0.316 | 0.860 | 5         |
| 274 | worldvaluesbench                                         | +0.112 | 0.602 | [0.227, 0.977]  | 0.082 | 0.829 | 5         |
| 275 | pwc_rcb                                                  | +0.113 | 0.612 | [0.196, 1.028]  | 0.454 | 0.788 | 3         |
| 276 | pwc_penn_treebank_word_level                             | +0.113 | 0.618 | [-1.204, 2.441] | 0.475 | 0.762 | 2         |
| 277 | RealMath                                                 | +0.114 | 0.602 | [0.178, 1.026]  | 0.065 | 0.879 | 5         |
| 278 | aime                                                     | +0.115 | 0.619 | [0.600, 0.638]  | 0.617 | 0.620 | 2         |
| 279 | kaggle_sripalthilakraj_global_mmlu_lite_english          | +0.115 | 0.627 | [0.463, 0.791]  | 0.057 | 0.960 | 13        |
| 280 | pwc_samsum                                               | +0.118 | 0.623 | [-3.893, 5.140] | 0.268 | 0.979 | 2         |
| 281 | maliciousinstruct                                        | +0.118 | 0.607 | [0.225, 0.989]  | 0.136 | 0.990 | 5         |
| 282 | lindsea_syntax_minimal_pairs_id                          | +0.119 | 0.629 | [0.433, 0.824]  | 0.269 | 0.978 | 10        |
| 283 | mega                                                     | +0.121 | 0.610 | [-0.073, 1.293] | 0.139 | 0.992 | 4         |
| 284 | indommlu                                                 | +0.121 | 0.613 | [0.134, 1.092]  | 0.134 | 0.962 | 5         |
| 285 | xcopa                                                    | +0.128 | 0.642 | [0.483, 0.801]  | 0.187 | 1.000 | 13        |
| 286 | ifeval                                                   | +0.129 | 0.482 | [0.360, 0.605]  | 0.030 | 0.984 | 20        |
| 287 | indonli                                                  | +0.131 | 0.641 | [0.515, 0.767]  | 0.447 | 0.942 | 10        |
| 288 | flores_en_ta                                             | +0.131 | 0.641 | [0.499, 0.783]  | 0.350 | 0.974 | 10        |
| 289 | lsat_qa                                                  | +0.133 | 0.655 | [0.542, 0.767]  | 0.221 | 0.948 | 20        |
| 290 | twitter_aae                                              | +0.133 | 0.643 | [0.466, 0.819]  | 0.261 | 0.967 | 10        |
| 291 | kaggle_andrewmingwang_facts                              | +0.133 | 0.641 | [0.401, 0.880]  | 0.081 | 1.000 | 10        |
| 292 | kaggle_andrewmingwang_asset_ops_bench                    | +0.134 | 0.643 | [0.383, 0.904]  | 0.033 | 0.992 | 10        |
| 293 | medal                                                    | +0.135 | 0.640 | [-3.237, 4.518] | 0.335 | 0.945 | 2         |
| 294 | kaggle_jonlipovetz_game_arena                            | +0.136 | 0.626 | [0.349, 0.903]  | 0.310 | 0.815 | 5         |
| 295 | pwc_asdiv_a                                              | +0.140 | 0.645 | [-2.125, 3.415] | 0.427 | 0.863 | 2         |
| 296 | anthropic_red_team                                       | +0.142 | 0.652 | [0.538, 0.767]  | 0.041 | 0.951 | 20        |
| 297 | uitvsfc                                                  | +0.142 | 0.652 | [0.501, 0.803]  | 0.268 | 0.862 | 10        |
| 298 | the_pile                                                 | +0.142 | 0.674 | [0.568, 0.780]  | 0.333 | 1.000 | 20        |
| 299 | disinformation_reiteration                               | +0.143 | 0.675 | [0.545, 0.805]  | 0.000 | 0.948 | 20        |
| 300 | ttcw                                                     | +0.144 | 0.649 | [-1.535, 2.833] | 0.478 | 0.821 | 2         |
| 301 | legal_support                                            | +0.145 | 0.667 | [0.548, 0.785]  | 0.114 | 0.909 | 20        |
| 302 | tydiqa                                                   | +0.145 | 0.655 | [0.432, 0.878]  | 0.203 | 0.997 | 10        |
| 303 | pwc_muserc                                               | +0.147 | 0.646 | [0.460, 0.832]  | 0.565 | 0.712 | 3         |
| 304 | mexa                                                     | +0.147 | 0.635 | [0.276, 0.994]  | 0.191 | 0.949 | 5         |
| 305 | opencompass                                              | +0.147 | 0.653 | [0.496, 0.810]  | 0.640 | 0.665 | 2         |
| 306 | SuperGPQA                                                | +0.151 | 0.640 | [0.251, 1.029]  | 0.131 | 0.918 | 5         |
| 307 | oogiri                                                   | +0.152 | 0.641 | [0.148, 1.133]  | 0.205 | 0.932 | 4         |
| 308 | mimic_bhc                                                | +0.154 | 0.648 | [0.361, 0.936]  | 0.308 | 0.956 | 5         |
| 309 | lindsea_pragmatics_scalar_implicatures_id                | +0.154 | 0.664 | [0.494, 0.834]  | 0.106 | 0.922 | 10        |
| 310 | humaneval                                                | +0.156 | 0.661 | [0.398, 0.924]  | 0.256 | 0.993 | 8         |
| 311 | medhallu                                                 | +0.160 | 0.655 | [0.336, 0.973]  | 0.233 | 0.900 | 5         |
| 312 | flores_ta_en                                             | +0.161 | 0.671 | [0.487, 0.855]  | 0.242 | 0.984 | 10        |
| 313 | med_dialog                                               | +0.162 | 0.656 | [0.393, 0.918]  | 0.356 | 0.859 | 5         |
| 314 | pwc_wikitext_2                                           | +0.163 | 0.668 | [-2.208, 3.545] | 0.442 | 0.894 | 2         |
| 315 | fever                                                    | +0.164 | 0.650 | [0.257, 1.043]  | 0.468 | 0.754 | 3         |
| 316 | flores_en_th                                             | +0.167 | 0.677 | [0.536, 0.818]  | 0.317 | 0.901 | 10        |
| 317 | pwc_wikitext_103                                         | +0.168 | 0.672 | [0.349, 0.995]  | 0.646 | 0.697 | 2         |
| 318 | pwc_safim                                                | +0.170 | 0.667 | [0.003, 1.330]  | 0.050 | 0.951 | 4         |
| 319 | pwc_abstractive_text_summarization_from_il_post          | +0.173 | 0.678 | [-1.634, 2.990] | 0.496 | 0.860 | 2         |
| 320 | vihsd                                                    | +0.175 | 0.689 | [0.560, 0.818]  | 0.220 | 0.990 | 13        |
| 321 | blimp                                                    | +0.176 | 0.686 | [0.590, 0.782]  | 0.536 | 0.967 | 10        |
| 322 | thaitoxicitytweets                                       | +0.177 | 0.687 | [0.508, 0.867]  | 0.114 | 0.987 | 10        |
| 323 | mlhsd                                                    | +0.179 | 0.689 | [0.536, 0.843]  | 0.228 | 0.942 | 10        |
| 324 | xquad                                                    | +0.179 | 0.693 | [0.576, 0.810]  | 0.407 | 0.926 | 13        |
| 325 | kaggle_nanliao7_itbench                                  | +0.179 | 0.673 | [0.325, 1.020]  | 0.186 | 0.875 | 5         |
| 326 | pwc_text8                                                | +0.180 | 0.685 | [-2.054, 3.424] | 0.470 | 0.901 | 2         |
| 327 | humanitys_last_exam                                      | +0.181 | 0.672 | [0.162, 1.182]  | 0.047 | 0.966 | 5         |
| 328 | copyright_text                                           | +0.187 | 0.719 | [0.616, 0.822]  | 0.228 | 0.982 | 20        |
| 329 | kaggle_jonlipovetz_chess_suite                           | +0.188 | 0.678 | [0.267, 1.090]  | 0.270 | 0.993 | 5         |
| 330 | qtsumm                                                   | +0.190 | 0.684 | [0.366, 1.003]  | 0.401 | 0.966 | 5         |
| 331 | llmchess                                                 | +0.194 | 0.689 | [0.512, 0.867]  | 0.439 | 0.792 | 5         |
| 332 | pwc_sst_5_fine_grained_classification                    | +0.196 | 0.699 | [0.104, 1.295]  | 0.501 | 0.966 | 3         |
| 333 | vmlu                                                     | +0.201 | 0.707 | [0.434, 0.980]  | 0.017 | 0.970 | 8         |
| 334 | pwc_openwebtext                                          | +0.201 | 0.705 | [-2.692, 4.102] | 0.438 | 0.973 | 2         |
| 335 | kaggle_nanliao7_enterprise_ops                           | +0.204 | 0.697 | [0.354, 1.040]  | 0.216 | 0.918 | 5         |
| 336 | triangulating                                            | +0.209 | 0.706 | [0.080, 1.333]  | 0.127 | 0.958 | 4         |
| 337 | NormAd                                                   | +0.209 | 0.714 | [0.554, 0.875]  | 0.702 | 0.727 | 2         |
| 338 | StrongREJECT                                             | +0.215 | 0.720 | [-0.422, 1.862] | 0.630 | 0.810 | 2         |
| 339 | imdb                                                     | +0.217 | 0.740 | [0.630, 0.850]  | 0.089 | 0.974 | 20        |
| 340 | pwc_bioasq                                               | +0.219 | 0.722 | [0.055, 1.389]  | 0.417 | 0.923 | 3         |
| 341 | medi_qa                                                  | +0.222 | 0.717 | [0.342, 1.091]  | 0.212 | 0.961 | 5         |
| 342 | pwc_asqp                                                 | +0.229 | 0.734 | [-0.247, 1.715] | 0.657 | 0.811 | 2         |
| 343 | shc_cdi_med                                              | +0.230 | 0.724 | [0.422, 1.026]  | 0.391 | 0.989 | 5         |
| 344 | abceval                                                  | +0.231 | 0.720 | [0.238, 1.202]  | 0.273 | 0.913 | 4         |
| 345 | alpacaeval                                               | +0.231 | 0.718 | [0.629, 0.808]  | 0.620 | 0.793 | 5         |
| 346 | pwc_tasd                                                 | +0.231 | 0.737 | [-0.243, 1.717] | 0.660 | 0.814 | 2         |
| 347 | triviaqa                                                 | +0.233 | 0.738 | [0.526, 0.949]  | 0.356 | 0.990 | 8         |
| 348 | sibench                                                  | +0.235 | 0.723 | [0.432, 1.013]  | 0.464 | 0.994 | 5         |
| 349 | complexbench                                             | +0.236 | 0.724 | [0.569, 0.878]  | 0.562 | 0.887 | 5         |
| 350 | wildbench                                                | +0.239 | 0.747 | [0.571, 0.923]  | 0.437 | 0.986 | 8         |
| 351 | xcr_bench                                                | +0.239 | 0.728 | [0.286, 1.170]  | 0.141 | 0.997 | 5         |
| 352 | medalign                                                 | +0.241 | 0.735 | [0.510, 0.960]  | 0.514 | 0.923 | 5         |
| 353 | pwc_multitq                                              | +0.244 | 0.750 | [-1.428, 2.927] | 0.578 | 0.921 | 2         |
| 354 | dyck_language                                            | +0.247 | 0.770 | [0.670, 0.869]  | 0.238 | 0.984 | 20        |
| 355 | pwc_one_billion_word                                     | +0.248 | 0.753 | [-1.472, 2.978] | 0.578 | 0.928 | 2         |
| 356 | ice                                                      | +0.255 | 0.765 | [0.584, 0.946]  | 0.280 | 0.990 | 10        |
| 357 | facts_parametric                                         | +0.260 | 0.753 | [0.462, 1.045]  | 0.434 | 0.979 | 5         |
| 358 | clear                                                    | +0.263 | 0.757 | [0.434, 1.081]  | 0.303 | 0.955 | 5         |
| 359 | multipl_e                                                | +0.269 | 0.756 | [0.338, 1.173]  | 0.164 | 0.983 | 5         |
| 360 | pwc_pubmed                                               | +0.276 | 0.781 | [0.282, 1.281]  | 0.742 | 0.821 | 2         |
| 361 | ShoppingMMLU                                             | +0.278 | 0.781 | [0.562, 1.000]  | 0.715 | 0.881 | 3         |
| 362 | pwc_arxiv_hep_th_citation_graph                          | +0.278 | 0.784 | [0.283, 1.284]  | 0.744 | 0.823 | 2         |
| 363 | workplacehumor                                           | +0.282 | 0.771 | [0.530, 1.011]  | 0.469 | 0.995 | 5         |
| 364 | rpgbench                                                 | +0.285 | 0.776 | [0.529, 1.023]  | 0.441 | 0.948 | 5         |
| 365 | ehrshot                                                  | +0.292 | 0.786 | [0.528, 1.044]  | 0.458 | 0.974 | 5         |
| 366 | pwc_webquestions                                         | +0.295 | 0.781 | [0.547, 1.014]  | 0.720 | 0.889 | 3         |
| 367 | chw_care_plan                                            | +0.308 | 0.802 | [0.641, 0.964]  | 0.646 | 0.935 | 5         |
| 368 | head_qa                                                  | +0.312 | 0.806 | [0.633, 0.979]  | 0.615 | 0.976 | 5         |
| 369 | medication_qa                                            | +0.322 | 0.816 | [0.463, 1.170]  | 0.310 | 0.990 | 5         |
| 370 | pwc_lila_ood                                             | +0.338 | 0.843 | [0.319, 1.366]  | 0.801 | 0.884 | 2         |
| 371 | pwc_sst_2_binary_classification                          | +0.342 | 0.847 | [-0.588, 2.283] | 0.734 | 0.960 | 2         |
| 372 | multi_if                                                 | +0.362 | 0.852 | [0.678, 1.026]  | 0.710 | 0.977 | 4         |
| 373 | pwc_lila_iid                                             | +0.369 | 0.874 | [0.452, 1.297]  | 0.841 | 0.908 | 2         |
| 374 | pwc_ag_news                                              | +0.371 | 0.874 | [0.520, 1.228]  | 0.710 | 0.964 | 3         |
| 375 | pwc_rte                                                  | +0.373 | 0.879 | [0.244, 1.514]  | 0.829 | 0.929 | 2         |
| 376 | pwc_kvret                                                | +0.397 | 0.902 | [0.729, 1.075]  | 0.888 | 0.916 | 2         |
| 377 | pwc_cronquestions                                        | +0.419 | 0.924 | [0.531, 1.317]  | 0.893 | 0.955 | 2         |
| 378 | pwc_mr                                                   | +0.441 | 0.946 | [0.259, 1.633]  | 0.892 | 1.000 | 2         |
| 379 | pwc_django                                               | +0.478 | 0.984 | [0.779, 1.189]  | 0.968 | 1.000 | 2         |
| 380 | pwc_conala                                               | +0.492 | 0.997 | [0.996, 0.998]  | 0.997 | 0.998 | 2         |
