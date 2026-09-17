# Results

## Dataset characteristics

Table 3 below shows the 

**Table 3**. Benchmark statistics with respect of their computable pairwise Pearson correlation. A pairwise correlation is computable when n >= 4. Compt. = computable benchmarks, Corrs = correlations.

| Dataset            |   N | N Compt. | Mean Corrs. | Max Corrs. | Min Avg. N | Mean Avg. N | Max Avg. N |
| ------------------ | --: | -------: | ----------: | ---------: | ---------: | ----------: | ---------: |
| raw_all_standard   | 404 |      312 |        61.6 |        229 |        0.0 |         7.6 |       39.4 |
| raw_all_aggressive | 380 |      301 |       106.6 |        254 |        0.0 |         4.6 |       10.9 |
| C_all_standard     |  78 |       78 |        47.2 |         77 |        5.8 |        28.6 |       54.9 |
| C_all_aggressive   | 102 |      102 |        78.5 |        101 |        4.4 |         9.6 |       18.1 |
| R_all_standard     | 298 |      270 |        81.4 |        228 |        0.0 |         8.8 |       30.5 |
| R_all_aggressive   | 310 |      283 |       130.2 |        254 |        0.0 |         5.3 |        9.9 |
| S_all_standard     | 124 |      124 |        67.7 |        118 |        5.7 |        20.2 |       47.1 |
| S_all_aggressive   | 293 |      292 |       138.1 |        254 |        0.0 |         5.8 |       10.0 |


**Table 4.** Per-benchmark pairs statistics: Shared n and |r| of computable correlations. Compt. = computable pairs.

| Dataset            |     N | N Compt. | % Compt. | Mean N/pair | Max N/pair | Mean \|r\| | SD \|r\| |
| ------------------ | ----: | -------: | -------: | ----------: | ---------: | ---------: | -------: |
| raw_all_standard   | 81406 |    12442 |     15.3 |        11.3 |        332 |      0.505 |    0.287 |
| raw_all_aggressive | 72010 |    20261 |     28.1 |         6.2 |        105 |      0.466 |    0.281 |
| C_all_standard     |  3003 |     1840 |     61.3 |        30.2 |        332 |      0.539 |    0.271 |
| C_all_aggressive   |  5151 |     4006 |     77.8 |         9.9 |        105 |      0.432 |    0.264 |
| R_all_standard     | 44253 |    12134 |     27.4 |        10.3 |        109 |      0.503 |    0.287 |
| R_all_aggressive   | 47895 |    20188 |     42.2 |         6.1 |         64 |      0.466 |    0.281 |
| S_all_standard     |  7626 |     4198 |     55.0 |        20.0 |        332 |      0.485 |    0.273 |
| S_all_aggressive   | 42778 |    20230 |     47.3 |         6.1 |         70 |      0.466 |    0.281 |

## Imputation quality

We present the result of the imputations 

**Table 4** Summary of accepted imputations (R² > 0.3).

| Dataset          | Imputer         |   RMSE |    R² | Parameters                         |
| ---------------- | --------------- | -----: | ----: | ---------------------------------- |
| S_all_standard   | softimpute      | 0.6338 | 0.504 | rank=5 (swept 1..10)               |
| C_all_standard   | softimpute      | 0.6575 | 0.493 | rank=9 (swept 1..10)               |
| S_all_standard   | missforest      | 0.6798 | 0.471 | ntree=400 (swept [50,100,200,400]) |
| C_all_standard   | missforest      | 0.7321 | 0.399 | ntree=50 (swept [50,100,200,400])  |
| S_all_standard   | softimpute_corr | 0.7637 | 0.378 | rank=6 (swept 1..10)               |
| S_all_standard   | onesidedmc      | 0.7500 | 0.340 | r=2 (swept 1..10)                  |
| C_all_aggressive | softimpute      | 0.6739 | 0.337 | rank=5 (swept 1..10)               |
| C_all_standard   | onesidedmc      | 0.8213 | 0.333 | r=2 (swept 1..10)                  |
| C_all_standard   | softimpute_corr | 0.8126 | 0.317 | rank=5 (swept 1..7)                |


