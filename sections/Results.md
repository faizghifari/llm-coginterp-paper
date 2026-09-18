# Results

%%
PINDAH KE APPENDIX!
%%
%%## Imputation quality

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
%%
## Point summaries

Table 3 below shows the point summaries of the factor analyses. The most important statistic here is the $\omega_h$, which indicates the degree of indicator variances explained by the general factor. Two things are worth noting here. First, while $\omega_h$ has a wide range, by our estimates' maximum, **a universally causal $G$ factor accounts, at the most, 74.7% of variance in model performance**.

Still, something to note is that the range of $\omega_h$ spans quite widely. The best-performing imputer, softimpute on S_all_standard, yielded a solution with a modestly effective $G$ factor that accounts for just 25.7% of the variance.

**Table 3**. Point summaries of factor analyses results. k = number of factors extracted. Var% = percentage of variance explained, $k$ = number of factors extracted, $\phi$ = average inter-factor correlation.  

| Dataset            | Imputer         | $k$ | Var%   | $\omega_h$ | $\phi_{\text{avg}}$ | $R^2$ |
| ------------------ | --------------- | --- | -------- | ---------- | ---------------- | ------ |
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
Figure 1 below shows a UMAP plot of benchmarks using composite distances aggregated from factor loadings, colored based on their subject matter. Something striking from this visual is how benchmarks with common subject only occasionally cluster together. Across the entire figure, the spaces occupied by each flagged subject matter spans across the entire plot. It is also telling that even commonly-targeted benchmarks like `arc` and `gpqa_diamond` fail are located quite far from each other, and a coding benchmark like `swe_bench` is closer to some mathematics benchmarks like `math500` and `aime25` than it is to `FlashInfer-Bench`. In other words, **capability in one task does not always generalize well to another task of the same subject**.

A degree of generality exists, of course. The bottom figure, using composite distance of the S dataset, shows a clustering of several coding and math benchmarks, but other abstract reasoning benchmarks like `gsm8k` `and` arc are placed at the bottom of the continent. Note however that most clusters resemble the top, raw dataset with greatly-spaced out subjects compared to the S datasets. A semantically coherent generalization is probable but quite far from a guarantee.

![[aggregate.png|UMAP plot of benchmarks' composite distance. Top: raw dataset, bottom: S dataset. Both are composited across all aggregations and valid imputers. Not visible/covered: aime25 under math500 in the bottom figure.]]

