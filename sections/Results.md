# Results

%%
PINDAH KE APPENDIX!
%%
%%## Imputation quality

We present the evaluation and parameters of the missing data imputations in table 3 below. Of the many imputation algorithms we applied, only 3 of them yielded an acceptable R² value. Excluding the PSD-smoothed correlation matrix imputation, there are 9 usable datasets for the factor analyses.

**Table 3**. Summary of accepted imputations (R² > 0.3).

| Dataset          | Imputer         |   RMSE |    R² | Parameters                         |
| ---------------- | --------------- | -----: | ----: | ---------------------------------- |
| S_standard   | softimpute      | 0.6338 | 0.504 | rank=5 (swept 1..10)               |
| C_standard   | softimpute      | 0.6575 | 0.493 | rank=9 (swept 1..10)               |
| S_standard   | missforest      | 0.6798 | 0.471 | ntree=400 (swept [50,100,200,400]) |
| C_standard   | missforest      | 0.7321 | 0.399 | ntree=50 (swept [50,100,200,400])  |
| S_standard   | softimpute_corr | 0.7637 | 0.378 | rank=6 (swept 1..10)               |
| S_standard   | onesidedmc      | 0.7500 | 0.340 | r=2 (swept 1..10)                  |
| C_aggressive | softimpute      | 0.6739 | 0.337 | rank=5 (swept 1..10)               |
| C_standard   | onesidedmc      | 0.8213 | 0.333 | r=2 (swept 1..10)                  |
| C_standard   | softimpute_corr | 0.8126 | 0.317 | rank=5 (swept 1..7)                |
%%
## Point summaries

From our imputation, only 20 dataset-imputer combination yields an $R^2$ satisfying the threshold. The full table of the imputation results are provided in (`\hyperref[imputation-results]{Appendix~\ref*{imputation-results}}`{=latex}).

Table 3 below shows the point summaries of the factor analyses. The most important statistic here is the $\omega_h$, which indicates the degree of indicator variances explained by the general factor. Two things are worth noting here. First, while $\omega_h$ has a wide range, by our estimates' maximum, **a universally causal $g$ factor accounts, at the most, 70.8% of variance in model performance**.

Still, something to note is that the range of $\omega_h$ spans quite widely. The best-performing imputer, softimpute on S_standard, yielded a solution with a modestly effective $g$ factor that accounts for just 25.7% of the variance. The same holds when we split the models by release year. Newer models score higher on the $g$ factor, but the variance it accounts for shows no trend across release cohorts (`\hyperref[release-date-analysis]{Appendix~\ref*{release-date-analysis}}`{=latex}). To ascertain whether the $\omega_h$ estimates are trustworthy, we provide additional diagnostics in (`\hyperref[omega-sensitivity]{Appendix~\ref*{omega-sensitivity}}`{=latex}).

**Table 3**. Point summaries of factor analyses results. AVE = average variance explained per factor, $k$ = number of factors extracted, $\phi$ = average inter-factor correlation.

| Dataset            | Imputer         | $k$ | $\text{AVE}$ | $\omega_h$ | $\phi_\text{avg}$ | $R^2$ |
| ------------------ | --------------- | --- | ------------ | ---------- | ----------------- | ----- |
| C_all_standard     | mean            | 14  | 5.5%         | 0.708      | 0.142             | 0.224 |
| C_all_standard     | missforest      | 4   | 22.1%        | 0.695      | 0.398             | 0.399 |
| S_all_standard     | softimpute_corr | 5   | 9.3%         | 0.676      | 0.306             | 0.378 |
| C_all_standard     | zeros           | 14  | 5.4%         | 0.621      | 0.093             | 0.286 |
| C_all_aggressive   | missforest      | 4   | 19.3%        | 0.521      | 0.112             | 0.241 |
| C_all_standard     | knn             | 7   | 10.8%        | 0.516      | 0.209             | 0.288 |
| C_all_standard     | softimpute_corr | 4   | 14.6%        | 0.514      | 0.247             | 0.317 |
| R_all_standard     | softimpute      | 20  | 4.6%         | 0.367      | 0.012             | 0.290 |
| S_all_standard     | softimpute      | 5   | 18.3%        | 0.257      | 0.094             | 0.504 |
| C_all_standard     | softimpute      | 9   | 10.5%        | 0.242      | 0.038             | 0.493 |
| S_all_aggressive   | softimpute      | 20  | 4.7%         | 0.225      | 0.031             | 0.282 |
| S_all_standard     | knn             | 11  | 6.9%         | 0.204      | 0.048             | 0.296 |
| R_all_aggressive   | softimpute      | 20  | 4.7%         | 0.187      | 0.008             | 0.209 |
| C_all_aggressive   | softimpute      | 5   | 17.8%        | 0.183      | -0.001            | 0.337 |
| raw_all_aggressive | softimpute      | 10  | 8.9%         | 0.132      | 0.013             | 0.228 |
| C_all_standard     | onesidedmc      | 2   | 50.0%        | 0.102      | 0.125             | 0.321 |
| raw_all_standard   | softimpute      | 10  | 9.0%         | 0.071      | -0.010            | 0.249 |
| C_all_aggressive   | onesidedmc      | 2   | 50.0%        | 0.065      | 0.097             | 0.278 |
| S_all_standard     | missforest      | 4   | 22.5%        | 0.032      | 0.054             | 0.471 |
| S_all_standard     | onesidedmc      | 2   | 50.0%        | 0.014      | -0.040            | 0.365 |

## Benchmark clusters

<!-- Table 4 as markdown, before being made smaller and wrapped with body text via wraptable (2026-09-23).
(2026-09-24: briefly suspected wrapfig of corrupting an unrelated appendix longtable's column widths
and reverted to a non-wrapping minipage; that table's garbling turned out to be caused by
disproportionate separator dashes in imputation-methods.md's own markdown tables, unrelated to
wrapfig, so the wraptable was restored. See that file's git history if wrapfig is ever suspected again.)

It read:

**Table 4**. Cohesion of subject labels. A is the

| Label | Median A | Significant | Median n |
|---|---|---|---|
| `code` | +0.263 | 7/16 | 11 |
| `logical_reasoning` | +0.090 | 1/16 | 6 |
| `encyclopedic` | +0.076 | 1/16 | 23 |
| `math` | +0.048 | 0/16 | 10 |
-->

```{=latex}
\begin{wraptable}{r}{0.46\textwidth}
\footnotesize\setlength{\tabcolsep}{3pt}
\centering
\textbf{Table 4.} Cohesion of subject labels. Full cohesion results for every label can be seen in \hyperref[label-cohesion-results]{Appendix~\ref*{label-cohesion-results}} \par\vspace{4pt}
\begin{tabular}{@{}lrr@{}}
\toprule
Label & Median A & Significant \\
\midrule
\texttt{code} & +0.263 & 7/16 \\
\texttt{logical\_reasoning} & +0.090 & 1/16 \\
\texttt{encyclopedic} & +0.076 & 1/16 \\
\texttt{math} & +0.048 & 0/16 \\
\bottomrule
\end{tabular}
\end{wraptable}
```

Figure 1 below shows an illustrative UMAP plot of benchmarks using composite distances aggregated from factor loadings, colored based on their subject matter (`\hyperref[benchmark-embedding]{Appendix~\ref*{benchmark-embedding}}`{=latex}). Something striking from this visual is how benchmarks with common subject only occasionally cluster together. Across the entire figure, the spaces occupied by each flagged subject matter span across the entire plot. A telling example is how, for coding, `livecodebench`, `swe_bench`, and `humaneval` stands very far apart from each other, and the same is true for math with the benchmarks `gsm8k`, `math`, and `aime25`. In other words, **capability in one task does not always generalize well to another task of the same subject**. A degree of generality exists, of course, evident by `bigcodebench` stands relatively close to `humaneval` A semantically coherent generalization is probable but not guaranteed, which can make isolating domain abilities difficult to do from a purely semantic and intuitive standpoint. This phenomena, where same-domain benchmarks lacks a tendency to cluster together, is observed in nearly all of our imputations, which we discuss further at (`\hyperref[common-subject-distances]{Appendix~\ref*{common-subject-distances}}`{=latex}).

![[S_softimpute.png| UMAP plot of S, softimpute.]]

%%Figure 1 below shows a UMAP plot of benchmarks using composite distances aggregated from factor loadings, colored based on their subject matter (`\hyperref[benchmark-embedding]{Appendix~\ref*{benchmark-embedding}}`{=latex}). Something striking from this visual is how benchmarks with common subject only occasionally cluster together. This is supported by the low cohesion scores in Table 4, where only `code` shows a weak cohesion, while others do not show a structure distinguishable to chance. It is also telling that even commonly-targeted benchmarks like `arc` and `gpqa_diamond` are located quite far from each other, and a coding benchmark like `swe_bench` is closer to some mathematics benchmarks like `math500` and `aime25` than it is to `FlashInfer-Bench`. In other words, **capability in one task does not always generalize well to another task of the same subject**.

A degree of generality exists, of course. The bottom figure, using composite distance of the S dataset, shows a clustering of several coding and math benchmarks, but other abstract reasoning benchmarks like `gsm8k` `and` arc are placed at the bottom of the continent. Note however that most clusters resemble the top, raw dataset with greatly-spaced out subjects compared to the S datasets. A semantically coherent generalization is probable but quite far from a guarantee.

![[aggregate3.png|UMAP plot of benchmarks' composite distance. Top left: raw dataset, aggregated. Top right: C dataset, softimpute. Bottom left: R, mean correlation. Bottom right: S, missforest.]]

%%

## $g$-loaded benchmarks

Another point of interest for the research question is what benchmarks act as a good proxy of general intelligence, particularly as research is concerned with performance in certain specific benchmarks to quantify intelligence advancements. Table 4 answers this question by showing the top 20 benchmarks, averaged by the normalized average rank-order[^4] based on their loadings on the $g$ factor. To account for confounding effects from benchmark frequency, we report the residuals of the rank order regressed by frequency. Further details and justification are given in (`\hyperref[benchmark-g-rankings.md]{Appendix~\ref*{benchmark-g-rankings.md}}`{=latex}).

[^4]: We use rank-order as factor loadings vary in range, and they are normalized as different datasets have different number of benchmarks.

Surprisingly, the top benchmarks are not dominated by common standard benchmarks. The top proxies include measures of creativity, legal use case, and even emotional intelligence. There is no evidence that a $g$ factor resembles anything like abstract reasoning. This diversity is expected on its own, since a general factor is indifferent to the content of its indicators. **Our results are evidence that the prevailing assumption that reasoning, mathematics, and coding benchmarks are best proxies of the latent factor $g$ best does not hold**. 

**Table 5**. Top 10 benchmarks, sorted by their average normalized rank-order (ANR) of their $g$ factor loadings, residualized (RANR) against their frequency. The normalized rank-order ranges from 0 to 1. 0 = ranked first, 1 = ranked last. $N$ cells = number of EFA solutions with that benchmark. CI and Best/Worst refers to ANR.

| No  | Benchmark       | RANR   | ANR   | 95% CI          | Best  | Worst | $N$ cells |
| --- | --------------- | ------ | ----- | --------------- | ----- | ----- | --------- |
| 1   | bhasa           | -0.346 | 0.141 | [-0.005, 0.287] | 0.024 | 0.318 | 5         |
| 2   | mtrag           | -0.341 | 0.147 | [-0.051, 0.346] | 0.021 | 0.394 | 5         |
| 3   | creativityprism | -0.339 | 0.156 | [-0.019, 0.332] | 0.026 | 0.367 | 5         |
| 4   | eqbench         | -0.332 | 0.156 | [-0.060, 0.372] | 0.017 | 0.451 | 5         |
| 5   | mceval          | -0.331 | 0.156 | [0.024, 0.288]  | 0.051 | 0.333 | 5         |
| 6   | pwc_svamp       | -0.329 | 0.169 | [-0.033, 0.371] | 0.058 | 0.298 | 4         |
| 7   | pwc_drop_test   | -0.328 | 0.162 | [-0.139, 0.462] | 0.008 | 0.431 | 4         |
| 8   | ProphetArena    | -0.315 | 0.183 | [-0.036, 0.401] | 0.092 | 0.385 | 4         |
| 9   | dialogbench     | -0.295 | 0.210 | [-1.351, 1.770] | 0.087 | 0.332 | 2         |
| 10  | pwc_piqa        | -0.282 | 0.253 | [0.162, 0.345]  | 0.003 | 0.822 | 20        |
%%
| 11  | pwc_timequestions        | -0.275 | 0.230 | [0.173, 0.288]  | 0.226 | 0.235 | 2         |
| --- | ------------------------ | ------ | ----- | --------------- | ----- | ----- | --------- |
| 12  | tablebench_data_analysis | -0.272 | 0.223 | [-0.185, 0.631] | 0.000 | 0.787 | 5         |
| 13  | pwc_multinli             | -0.271 | 0.233 | [-0.459, 0.925] | 0.179 | 0.288 | 2         |
| 14  | lawbench                 | -0.264 | 0.222 | [-0.288, 0.731] | 0.057 | 0.452 | 3         |
| 15  | pwc_arc_challenge        | -0.260 | 0.277 | [0.149, 0.405]  | 0.000 | 0.808 | 20        |
| 16  | tablebench_fact_checking | -0.260 | 0.235 | [-0.165, 0.635] | 0.020 | 0.784 | 5         |
| 17  | sea_helm                 | -0.257 | 0.235 | [-0.069, 0.539] | 0.045 | 0.603 | 5         |
| 18  | pinocchio                | -0.256 | 0.249 | [-0.564, 1.062] | 0.185 | 0.313 | 2         |
| 19  | tombench                 | -0.255 | 0.234 | [0.056, 0.413]  | 0.062 | 0.446 | 5         |
| 20  | indicgenbench            | -0.252 | 0.253 | [-0.347, 0.853] | 0.206 | 0.300 | 2         |
%%

%%


| No  | Benchmark                | RANR   | 95% CI           | SD    | ANR   | 95% CI          | Best  | Worst | $N$ cells |
| --- | ------------------------ | ------ | ---------------- | ----- | ----- | --------------- | ----- | ----- | --------- |
| 1   | bhasa                    | -0.346 | [-0.478, -0.215] | 0.106 | 0.141 | [-0.005, 0.287] | 0.024 | 0.318 | 5         |
| 2   | mtrag                    | -0.341 | [-0.558, -0.124] | 0.175 | 0.147 | [-0.051, 0.346] | 0.021 | 0.394 | 5         |
| 3   | creativityprism          | -0.339 | [-0.514, -0.164] | 0.141 | 0.156 | [-0.019, 0.332] | 0.026 | 0.367 | 5         |
| 4   | eqbench                  | -0.332 | [-0.570, -0.095] | 0.191 | 0.156 | [-0.060, 0.372] | 0.017 | 0.451 | 5         |
| 5   | mceval                   | -0.331 | [-0.488, -0.173] | 0.127 | 0.156 | [0.024, 0.288]  | 0.051 | 0.333 | 5         |
| 6   | pwc_svamp                | -0.329 | [-0.521, -0.136] | 0.121 | 0.169 | [-0.033, 0.371] | 0.058 | 0.298 | 4         |
| 7   | pwc_drop_test            | -0.328 | [-0.667, 0.012]  | 0.213 | 0.162 | [-0.139, 0.462] | 0.008 | 0.431 | 4         |
| 8   | ProphetArena             | -0.315 | [-0.519, -0.112] | 0.128 | 0.183 | [-0.036, 0.401] | 0.092 | 0.385 | 4         |
| 9   | dialogbench              | -0.295 | [-1.945, 1.354]  | 0.184 | 0.210 | [-1.351, 1.770] | 0.087 | 0.332 | 2         |
| 10  | pwc_piqa                 | -0.282 | [-0.383, -0.180] | 0.218 | 0.253 | [0.162, 0.345]  | 0.003 | 0.822 | 20        |
| 11  | pwc_timequestions        | -0.275 | [-0.420, -0.129] | 0.016 | 0.230 | [0.173, 0.288]  | 0.226 | 0.235 | 2         |
| 12  | tablebench_data_analysis | -0.272 | [-0.674, 0.131]  | 0.324 | 0.223 | [-0.185, 0.631] | 0.000 | 0.787 | 5         |
| 13  | pwc_multinli             | -0.271 | [-1.035, 0.493]  | 0.085 | 0.233 | [-0.459, 0.925] | 0.179 | 0.288 | 2         |
| 14  | lawbench                 | -0.264 | [-0.706, 0.179]  | 0.178 | 0.222 | [-0.288, 0.731] | 0.057 | 0.452 | 3         |
| 15  | pwc_arc_challenge        | -0.260 | [-0.407, -0.113] | 0.314 | 0.277 | [0.149, 0.405]  | 0.000 | 0.808 | 20        |
| 16  | tablebench_fact_checking | -0.260 | [-0.649, 0.130]  | 0.314 | 0.235 | [-0.165, 0.635] | 0.020 | 0.784 | 5         |
| 17  | sea_helm                 | -0.257 | [-0.552, 0.038]  | 0.238 | 0.235 | [-0.069, 0.539] | 0.045 | 0.603 | 5         |
| 18  | pinocchio                | -0.256 | [-0.980, 0.467]  | 0.081 | 0.249 | [-0.564, 1.062] | 0.185 | 0.313 | 2         |
| 19  | tombench                 | -0.255 | [-0.427, -0.084] | 0.138 | 0.234 | [0.056, 0.413]  | 0.062 | 0.446 | 5         |
| 20  | indicgenbench            | -0.252 | [-0.760, 0.255]  | 0.056 | 0.253 | [-0.347, 0.853] | 0.206 | 0.300 | 2         |

%%
