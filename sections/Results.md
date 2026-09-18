# Results
%%

pindah ke appendix?
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
%%
## Imputation quality

We present the evaluation and parameters of the missing data imputations in table 3 below. Of the many imputation algorithms we applied, only 3 of them yielded an acceptable R² value. Excluding the PSD-smoothed correlation matrix imputation, there are 9 usable datasets for the factor analyses.

**Table 3**. Summary of accepted imputations (R² > 0.3).

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
## Point summaries

Table 4 below shows the point summaries of the factor analyses. The most important statistic here is the $\omega_h$, which indicates the degree of indicator variances explained by the general factor. Two things are worth noting here. First, while $\omega_h$ has a wide range, by our estimates' maximum, **a universally causal $G$ factor accounts, at the most, 74% of variance in model performance**.

**Table 4**. Point summaries of factor analyses results. k = number of factors extracted. Var% = percentage of variance explained, $k$ = number of factors extracted, $\phi$ = average inter-factor correlation.  

| Dataset            | Imputer         | $k$ | Var%   | $\omega_h$ | $\phi_{\text{avg}}$ | $R²$  |
| ------------------ | --------------- | --- | ------ | ---------- | ------------------- | ----- |
| C_all_standard     | mean            | 20  | 85.6%  | 0.747      | 0.090               |       |
| raw_all_standard   | mean            | 20  | 46.0%  | 0.701      | 0.071               |       |
| C_all_standard     | missforest      | 4   | 88.4%  | 0.695      | 0.398               | 0.399 |
| S_all_standard     | softimpute_corr | 5   | 46.6%  | 0.676      | 0.306               | 0.378 |
| S_all_standard     | mean            | 20  | 73.2%  | 0.675      | 0.066               |       |
| C_all_standard     | zeros           | 20  | 84.9%  | 0.661      | 0.080               |       |
| R_all_standard     | mean            | 20  | 51.4%  | 0.649      | 0.094               |       |
| S_all_standard     | zeros           | 20  | 72.5%  | 0.562      | 0.033               |       |
| C_all_standard     | softimpute_corr | 4   | 58.6%  | 0.514      | 0.247               | 0.317 |
| R_all_standard     | zeros           | 20  | 49.9%  | 0.484      | 0.033               |       |
| raw_all_standard   | zeros           | 20  | 38.3%  | 0.459      | 0.024               |       |
| R_all_aggressive   | zeros           | 20  | 66.4%  | 0.457      | -0.003              |       |
| S_all_aggressive   | zeros           | 20  | 67.4%  | 0.454      | 0.004               |       |
| raw_all_aggressive | zeros           | 20  | 57.1%  | 0.445      | 0.012               |       |
| R_all_aggressive   | mean            | 20  | 66.4%  | 0.431      | -0.002              |       |
| S_all_aggressive   | mean            | 20  | 67.4%  | 0.410      | -0.008              |       |
| raw_all_aggressive | mean            | 20  | 58.4%  | 0.332      | 0.023               |       |
| S_all_standard     | softimpute      | 5   | 91.3%  | 0.257      | 0.094               | 0.504 |
| C_all_standard     | softimpute      | 9   | 94.3%  | 0.242      | 0.038               | 0.493 |
| C_all_aggressive   | softimpute      | 5   | 89.0%  | 0.183      | -0.001              | 0.337 |
| C_all_aggressive   | mean            | 20  | 83.6%  | 0.072      | 0.025               |       |
| C_all_aggressive   | zeros           | 20  | 83.6%  | 0.072      | 0.044               |       |
| C_all_standard     | onesidedmc      | 2   | 100.0% | 0.036      | 0.054               | 0.333 |
| S_all_standard     | missforest      | 4   | 90.0%  | 0.032      | 0.054               | 0.471 |
| S_all_standard     | onesidedmc      | 2   | 100.0% | 0.006      | 0.015               | 0.340 |
## Benchmark clusters
Figure 1 below shows a UMAP plot of benchmarks using composite distances aggregated from factor loadings. 

![[Pasted image 20260918013843.png]]

