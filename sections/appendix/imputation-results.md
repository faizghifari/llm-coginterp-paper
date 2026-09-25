# Imputation Results

<!--To gauge whether the dataset correlations are trustworthy, we present diagnostics that describe the missingness pattern in the dataset or how said pattern correlate with our results.

## Observation counts

In descriptive terms, knowing the missingness pattern 
### Pairwise-correlation computability

**Table 1**. Descriptive data of benchmarks with computable correlations. A correlation counts as computable when pairwise-complete $N \ge 4$., although note that this minimum N is not enforced in correlation matrix imputers. N Compt = number of benchmarks with computable correlations. Corrs. = number of computable correlations.  $\text{N}_\text{avg}$ = mean observations (models) per computable correlation.

| Dataset            |   N | N Compt. | Mean Corrs. | SD Corrs. | Max Corrs. | Mean $\text{N}_\text{avg}$ | SD $\text{N}_\text{avg}$ |
| ------------------ | --: | -------: | ----------: | --------: | ---------: | -------------------------: | -----------------------: |
| Raw. Std.   | 404 |      312 |        61.6 |      62.6 |        229 |                        7.6 |                      7.9 |
| Raw. Aggr. | 380 |      301 |       106.6 |      85.2 |        254 |                        4.6 |                      2.8 |
| C. Std.     |  78 |       78 |        47.2 |      13.4 |         77 |                       28.6 |                     14.0 |
| C. Aggr.   | 102 |      102 |        78.5 |      17.8 |        101 |                        9.6 |                      3.4 |
| R. Std.     | 298 |      270 |        81.4 |      59.9 |        228 |                        8.8 |                      7.2 |
| R. Aggr.   | 310 |      283 |       130.2 |      76.4 |        254 |                        5.3 |                      2.2 |
| S. Std.     | 124 |      124 |        67.7 |      21.5 |        118 |                       20.2 |                     11.2 |
| S. Aggr.   | 293 |      292 |       138.1 |      71.2 |        254 |                        5.8 |                      1.6 |


**Table 2**. Per-benchmark-pair: shared N and $|r|$ of computable correlations (unit = benchmark pair). N/pair = shared non-missing models.

| Dataset            | N Total | N Compt. | %Compt. | Mean N/pair | SD N/Pair | Max N/pair | Mean $\lvert r \lvert$ | SD $\lvert r \lvert$ |
| ------------------ | ------: | -------: | ------: | ----------: | --------: | ---------: | ---------------------: | -------------------: |
| Raw. Std.   |   81406 |    12442 |    15.3 |        11.3 |      18.2 |        332 |                 0.5046 |               0.2871 |
| Raw. Aggr. |   72010 |    20261 |    28.1 |         6.2 |       4.8 |        105 |                 0.4662 |               0.2813 |
| C. Std.     |    3003 |     1840 |    61.3 |        30.2 |      40.9 |        332 |                 0.5393 |               0.2711 |
| C. Aggr.   |    5151 |     4006 |    77.8 |         9.9 |       9.7 |        105 |                 0.4315 |               0.2641 |
| R. Std.     |   44253 |    12134 |    27.4 |        10.3 |      10.3 |        109 |                 0.5031 |               0.2872 |
| R. Aggr.   |   47895 |    20188 |    42.2 |         6.1 |       4.0 |         64 |                 0.4665 |               0.2813 |
| S. Std.     |    7626 |     4198 |    55.0 |        20.0 |      29.1 |        332 |                 0.4848 |               0.2731 |
| S. Aggr.   |   42778 |    20230 |    47.3 |         6.1 |       4.2 |         70 |                 0.4661 |               0.2813 |
-->

%%
### Plots

![[density_corr_count.png| Descriptive plot of computable pairwise Pearson correlations for each individual benchmark.]]

Figure shows the average number of shared observations underlying each benchmark's computable correlations.

![[density_corr_n.png| Plot of average number of shared observations underlying each benchmark's computable correlations]]

Figure shows the distribution of observation counts per benchmark.

![[density_data.png | Plot of observation counts per benchmark.]]

Figure shows the distribution of shared non-missing observations per computable benchmark pair.

![[density_pair_n.png | Plot of the number of unique benchmark pairs with computable correlations.]]
%%
<!--
density_corr_count.png
density_corr_n.png
density_data.png
density_pair_n.png-->

<!--## Imputation results-->

The table below lists, for every dataset-imputer combination, the held-out RMSE, $R^2$, and the selected configuration. Rows are sorted by $R^2$.As decsribed in the results, only 20 of the combinations pass the $R^2 \ge 0.2$ gate. In particular, USVT yielded no usable solutions, while CVXR and GGM completely failed to converge, hence they are missing from this table.

**Table 3**. Result of all imputation runs, sorted by $R^2$.

| Dataset            | Imputer         |   RMSE |   $R^2$ | Configuration                      |
| ------------------ | --------------- | -----: | ------: | ---------------------------------- |
| S. Std.     | softimpute      | 0.6338 |   0.504 | rank=5 (swept 1..10)               |
| C. Std.     | softimpute      | 0.6575 |   0.493 | rank=9 (swept 1..10)               |
| S. Std.     | missforest      | 0.6798 |   0.471 | ntree=400 (swept [50,100,200,400]) |
| C. Std.     | missforest      | 0.7321 |   0.399 | ntree=50 (swept [50,100,200,400])  |
| S. Std.     | softimpute_corr | 0.7637 |   0.378 | rank=6 (swept 1..10)               |
| S. Std.     | onesidedmc      | 0.7554 |   0.365 | r=2 (swept 1..10)                  |
| C. Aggr.   | softimpute      | 0.6739 |   0.337 | rank=5 (swept 1..10)               |
| C. Std.     | onesidedmc      | 0.7261 |   0.321 | r=2 (swept 1..10)                  |
| C. Std.     | softimpute_corr | 0.8126 |   0.317 | rank=5 (swept 1..7)                |
| S. Std.     | knn             | 0.8104 |   0.296 | k=5 (swept 1..10)                  |
| R. Std.     | softimpute      | 0.7245 |   0.290 | rank=4 (swept 1..10)               |
| C. Std.     | knn             | 0.8232 |   0.288 | k=5 (swept 1..10)                  |
| C. Std.     | fill-zeros           | 0.8910 |   0.286 | fill=zero                          |
| S. Aggr.   | softimpute      | 0.7068 |   0.282 | rank=10 (swept 1..10)              |
| C. Aggr.   | onesidedmc      | 0.8815 |   0.278 | r=2 (swept 1..10)                  |
| Raw. Std.   | softimpute      | 0.7401 |   0.249 | rank=9 (swept 1..10)               |
| C. Aggr.   | missforest      | 0.8275 |   0.241 | ntree=50 (swept [50,100,200,400])  |
| Raw. Aggr. | softimpute      | 0.7457 |   0.228 | rank=10 (swept 1..10)              |
| C. Std.     | fill-mean       | 0.9268 |   0.224 | fill=mean                          |
| R. Aggr.   | softimpute      | 0.7370 |   0.209 | rank=10 (swept 1..10)              |
| S. Std.     | fill-zeros           | 0.8926 |   0.180 | fill=zero                          |
| S. Std.     | fill-mean       | 0.8923 |   0.179 | fill=mean                          |
| S. Aggr.   | onesidedmc      | 0.9311 |   0.160 | r=2 (swept 1..10)                  |
| C. Aggr.   | knn             | 0.9253 |   0.085 | k=6 (swept 1..10)                  |
| S. Aggr.   | softimpute_corr | 1.0514 |   0.076 | rank=1                             |
| Raw. Aggr. | softimpute_corr | 1.1797 |   0.075 | rank=3 (swept 1..3)                |
| S. Aggr.   | knn             | 1.0841 |   0.069 | k=4 (swept 1..10)                  |
| R. Std.     | softimpute_corr | 1.2346 |   0.047 | rank=5 (swept 1..10)               |
| Raw. Std.   | onesidedmc      | 1.1045 |   0.044 | r=2 (swept 1..10)                  |
| S. Aggr.   | missforest      | 1.0635 |   0.041 | ntree=100 (swept [50,100,200,400]) |
| R. Std.     | missforest      | 1.2253 |   0.036 | ntree=200 (swept [50,100,200,400]) |
| R. Std.     | onesidedmc      | 1.3507 |   0.035 | r=2 (swept 1..10)                  |
| Raw. Aggr. | missforest      | 1.2200 |   0.026 | ntree=400 (swept [50,100,200,400]) |
| Raw. Aggr. | knn             | 1.2247 |   0.021 | k=3 (swept 1..10)                  |
| R. Aggr.   | softimpute_corr | 1.3517 |   0.019 | rank=1                             |
| Raw. Std.   | softimpute_corr | 1.2551 |   0.015 | rank=2 (swept 1..10)               |
| Raw. Aggr. | onesidedmc      | 1.5050 |   0.015 | r=2 (swept 1..10)                  |
| Raw. Std.   | missforest      | 1.2441 |   0.015 | ntree=200 (swept [50,100,200,400]) |
| R. Aggr.   | knn             | 1.4189 |   0.013 | k=2 (swept 1..10)                  |
| R. Std.     | knn             | 1.2854 |   0.011 | k=3 (swept 1..10)                  |
| R. Aggr.   | onesidedmc      | 2.0522 |   0.007 | r=2 (swept 1..10)                  |
| R. Aggr.   | missforest      | 1.3915 |   0.006 | ntree=200 (swept [50,100,200,400]) |
| Raw. Std.   | fill-mean       | 1.3404 |   0.000 | fill=mean                          |
| Raw. Std.   | knn             | 1.3065 |  -0.004 | k=5 (swept 1..10)                  |
| R. Std.     | fill-mean       | 1.3990 |  -0.049 | fill=mean                          |
| S. Aggr.   | fill-mean       | 1.2040 |  -0.087 | fill=mean                          |
| S. Aggr.   | fill-zeros           | 1.2298 |  -0.139 | fill=zero                          |
| R. Std.     | usvt            | 2.5911 |  -1.635 | eta=0.01                           |
| S. Std.     | usvt            | 1.7823 |  -2.965 | eta=0.01                           |
| Raw. Std.   | usvt            | 2.9244 |  -5.031 | eta=0.01                           |
| S. Aggr.   | usvt            | 2.9488 | -12.278 | eta=0.01                           |
