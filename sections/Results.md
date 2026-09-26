# Results

%%
PINDAH KE APPENDIX!
%%
%%## Imputation quality

We present the evaluation and parameters of the missing data imputations in table 3 below. Of the many imputation algorithms we applied, only 3 of them yielded an acceptable R² value. Excluding the PSD-smoothed correlation matrix imputation, there are 9 usable datasets for the factor analyses.

**Table 3**. Summary of accepted imputations (R² > 0.3).

| Dataset          | Imputer         |   RMSE |    R² | Parameters                         |
| ---------------- | --------------- | -----: | ----: | ---------------------------------- |
| S. Std.   | softimpute      | 0.6338 | 0.504 | rank=5 (swept 1..10)               |
| C. Std.   | softimpute      | 0.6575 | 0.493 | rank=9 (swept 1..10)               |
| S. Std.   | missforest      | 0.6798 | 0.471 | ntree=400 (swept [50,100,200,400]) |
| C. Std.   | missforest      | 0.7321 | 0.399 | ntree=50 (swept [50,100,200,400])  |
| S. Std.   | softimpute_corr | 0.7637 | 0.378 | rank=6 (swept 1..10)               |
| S. Std.   | onesidedmc      | 0.7500 | 0.340 | r=2 (swept 1..10)                  |
| C. Aggr. | softimpute      | 0.6739 | 0.337 | rank=5 (swept 1..10)               |
| C. Std.   | onesidedmc      | 0.8213 | 0.333 | r=2 (swept 1..10)                  |
| C. Std.   | softimpute_corr | 0.8126 | 0.317 | rank=5 (swept 1..7)                |
%%
## Point summaries

From our imputation, only 20 dataset-imputer combination yields an $R^2$ satisfying the threshold. The full table of the imputation results are provided in (`\hyperref[imputation-results]{Appendix~\ref*{imputation-results}}`{=latex}).

Table 3 below shows the point summaries of the factor analyses. The most important statistic here is the $\omega_h$, which indicates the degree of indicator variances explained by the general factor. **At most, a universally causal $g$ factor accounts for 70.8% of variance in model performance**.

<!-- Style pass 2026-09-24 (signposting 'Two things are worth noting' with no second point). The paragraph read: Table 3 below shows the point summaries of the factor analyses. The most important statistic here is the $\omega_h$, which indicates the degree of indicator variances explained by the general factor. Two things are worth noting here. First, while $\omega_h$ has a wide range, by our estimates' maximum, **a universally causal $g$ factor accounts, at the most, 70.8% of variance in model performance**. -->

The range of $\omega_h$ is wide. The best-performing imputer, softimpute on S. Std., yielded a $g$ factor that accounts for 25.7% of the variance. The same holds when we split the models by release year. Newer models score higher on the $g$ factor, but the variance it accounts for shows no trend with release year (`\hyperref[release-date-analysis]{Appendix~\ref*{release-date-analysis}}`{=latex}). To ascertain whether the $\omega_h$ estimates are trustworthy, we provide additional diagnostics in (`\hyperref[omega-sensitivity]{Appendix~\ref*{omega-sensitivity}}`{=latex}).

<!-- Wording 2026-09-26 ('cohort' dropped with the release-date appendix rewrite). The sentence read: Newer models score higher on the $g$ factor, but the variance it accounts for shows no trend across release cohorts. -->

<!-- Style pass 2026-09-24 (fillers 'something to note', 'quite', 'modestly effective', 'just'). The paragraph read: Still, something to note is that the range of $\omega_h$ spans quite widely. The best-performing imputer, softimpute on S. Std., yielded a solution with a modestly effective $g$ factor that accounts for just 25.7% of the variance. The same holds when we split the models by release year. Newer models score higher on the $g$ factor, but the variance it accounts for shows no trend across release cohorts (`\hyperref[release-date-analysis]{Appendix~\ref*{release-date-analysis}}`{=latex}). To ascertain whether the $\omega_h$ estimates are trustworthy, we provide additional diagnostics in (`\hyperref[omega-sensitivity]{Appendix~\ref*{omega-sensitivity}}`{=latex}). -->

**Table 3**. Point summaries of factor analyses results. AVE = average variance explained per factor, $k$ = number of factors extracted, $\phi_\text{avg}$ = average inter-factor correlation.

| Dataset            | Imputer         | $k$ |   AVE | $\omega_h$ | $\phi_\text{avg}$ | $R^2$ |
| ------------------ | --------------- | --: | ----: | ---------: | ----------------: | ----: |
| C. Std.     | fill-mean       |  14 |  5.5% |      0.708 |             0.142 | 0.224 |
| C. Std.     | missforest      |   4 | 22.1% |      0.695 |             0.398 | 0.399 |
| S. Std.     | softimpute_corr |   5 |  9.3% |      0.676 |             0.306 | 0.378 |
| C. Std.     | fill-zeros      |  14 |  5.4% |      0.621 |             0.093 | 0.286 |
| C. Aggr.   | missforest      |   4 | 19.3% |      0.521 |             0.112 | 0.241 |
| C. Std.     | knn             |   7 | 10.8% |      0.516 |             0.209 | 0.288 |
| C. Std.     | softimpute_corr |   4 | 14.6% |      0.514 |             0.247 | 0.317 |
| R. Std.     | softimpute      |  20 |  4.6% |      0.367 |             0.012 | 0.290 |
| S. Std.     | softimpute      |   5 | 18.3% |      0.257 |             0.094 | 0.504 |
| C. Std.     | softimpute      |   9 | 10.5% |      0.242 |             0.038 | 0.493 |
| S. Aggr.   | softimpute      |  20 |  4.7% |      0.225 |             0.031 | 0.282 |
| S. Std.     | knn             |  11 |  6.9% |      0.204 |             0.048 | 0.296 |
| R. Aggr.   | softimpute      |  20 |  4.7% |      0.187 |             0.008 | 0.209 |
| C. Aggr.   | softimpute      |   5 | 17.8% |      0.183 |            -0.001 | 0.337 |
| raw. Aggr. | softimpute      |  10 |  8.9% |      0.132 |             0.013 | 0.228 |
| C. Std.     | onesidedmc      |   2 | 50.0% |      0.102 |             0.125 | 0.321 |
| raw. Std.   | softimpute      |  10 |  9.0% |      0.071 |            -0.010 | 0.249 |
| C. Aggr.   | onesidedmc      |   2 | 50.0% |      0.065 |             0.097 | 0.278 |
| S. Std.     | missforest      |   4 | 22.5% |      0.032 |             0.054 | 0.471 |
| S. Std.     | onesidedmc      |   2 | 50.0% |      0.014 |            -0.040 | 0.365 |

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
\begin{wraptable}{R}{0.48\textwidth}
\vspace{-2pt}
\footnotesize\setlength{\tabcolsep}{3pt}
\centering
\textbf{Table 4.} Cohesion of subject labels. Full cohesion results for every label can be seen in \hyperref[label-cohesion-results]{Appendix~\ref*{label-cohesion-results}} \par\vspace{4pt}
\begin{tabular}{@{}lrr@{}}
\toprule
Label & Median A & Significant \\
\midrule
\texttt{code} & +0.264 & 6/18 \\
\texttt{logical\_reasoning} & +0.068 & 2/18 \\
\texttt{encyclopedic} & +0.104 & 1/18 \\
\texttt{math} & +0.031 & 0/18 \\
\bottomrule
\end{tabular}
\vspace{4pt}
\end{wraptable}
```

Figure 1 below shows an illustrative UMAP plot of benchmarks using composite distances aggregated from factor loadings, colored based on their subject matter (`\hyperref[benchmark-embedding]{Appendix~\ref*{benchmark-embedding}}`{=latex}). In this plot, benchmarks with a common subject only occasionally cluster together. This is supported by the low cohesion scores in Table 4, where only `code` shows a weak cohesion, while other labels show no structure distinguishable from chance. Across the entire figure, the spaces occupied by each flagged subject matter span across the entire plot. For coding, `livecodebench`, `swe_bench`, and `humaneval` stand far apart from each other, and the same is true for math with the benchmarks `gsm8k`, `math`, and `aime25`. In other words, **capability in one task does not always generalize to another task of the same subject**. A semantically coherent generalization is probable but not guaranteed, which makes domain abilities difficult to isolate from a purely semantic and intuitive standpoint. This phenomenon, where same-domain benchmarks lack a tendency to cluster together, is observed in nearly all of our imputations, which we discuss further in (`\hyperref[common-subject-distances]{Appendix~\ref*{common-subject-distances}}`{=latex}).

<!-- Style pass 2026-09-24 (fillers 'striking', 'telling', 'of course', plus a missing period and grammar). The paragraph read: Figure 1 below shows an illustrative UMAP plot of benchmarks using composite distances aggregated from factor loadings, colored based on their subject matter (`\hyperref[benchmark-embedding]{Appendix~\ref*{benchmark-embedding}}`{=latex}). Something striking from this visual is how benchmarks with common subject only occasionally cluster together. Across the entire figure, the spaces occupied by each flagged subject matter span across the entire plot. A telling example is how, for coding, `livecodebench`, `swe_bench`, and `humaneval` stands very far apart from each other, and the same is true for math with the benchmarks `gsm8k`, `math`, and `aime25`. In other words, **capability in one task does not always generalize well to another task of the same subject**. A degree of generality exists, of course, evident by `bigcodebench` stands relatively close to `humaneval` A semantically coherent generalization is probable but not guaranteed, which can make isolating domain abilities difficult to do from a purely semantic and intuitive standpoint. This phenomena, where same-domain benchmarks lacks a tendency to cluster together, is observed in nearly all of our imputations, which we discuss further at (`\hyperref[common-subject-distances]{Appendix~\ref*{common-subject-distances}}`{=latex}). -->

![[umaps/S_softimpute.png| UMAP plot of benchmark distances from S, softimpute. Domain-similar benchmarks are not guaranteed to cluster together.]]


## Benchmarks' $g$-centrality

Another point of interest for the research question is what benchmarks act as a good proxy of general intelligence, particularly as research is concerned with performance in certain specific benchmarks to quantify intelligence advancements. Table 5 answers this question by showing the benchmarks' averaged by the normalized average rank-order[^4] based on their loadings on the $g$ factor, denoted by ($\rho$). To account for confounding effects from benchmark frequency, we report the residuals of the rank order regressed by frequency ($\rho_\epsilon$). Further details and justification are given in (`\hyperref[benchmark-g-rankings]{Appendix~\ref*{benchmark-g-rankings}}`{=latex}).

<!-- Style pass 2026-09-24 (table number and row count did not match Table 5, and the appendix label had .md so it rendered as Appendix ??). The paragraph read: Another point of interest for the research question is what benchmarks act as a good proxy of general intelligence, particularly as research is concerned with performance in certain specific benchmarks to quantify intelligence advancements. Table 4 answers this question by showing the top 20 benchmarks, averaged by the normalized average rank-order[^4] based on their loadings on the $g$ factor. To account for confounding effects from benchmark frequency, we report the residuals of the rank order regressed by frequency. Further details and justification are given in (`\hyperref[benchmark-g-rankings.md]{Appendix~\ref*{benchmark-g-rankings.md}}`{=latex}). -->

[^4]: We use rank-order as factor loadings vary in range, and they are normalized as different datasets have different number of benchmarks.

Surprisingly, the top benchmarks are not dominated by common standard benchmarks. The top proxies include measures of creativity, legal use case, and even emotional intelligence. There is no evidence that a $g$ factor resembles anything like abstract reasoning. This diversity is expected on its own, since a general factor is indifferent to the content of its indicators. To add to this, standard intelligence benchmarks like `arc` and `gpqa_diamond` are placed near the middle of the rankings. **Our results are evidence that the prevailing assumption that reasoning, mathematics, and coding benchmarks are the best proxies of general intelligence does not hold**. 

<!-- Style pass 2026-09-24 (doubled 'best'). The paragraph read: Surprisingly, the top benchmarks are not dominated by common standard benchmarks. The top proxies include measures of creativity, legal use case, and even emotional intelligence. There is no evidence that a $g$ factor resembles anything like abstract reasoning. This diversity is expected on its own, since a general factor is indifferent to the content of its indicators. **Our results are evidence that the prevailing assumption that reasoning, mathematics, and coding benchmarks are best proxies of the latent factor $g$ best does not hold**. -->

**Table 5**. Benchmarks and their average normalized rank-order ($\rho$) of their $g$ factor loadings. Sorted by frequency-residualized rank ($\rho_\epsilon$). $\rho$ ranges from 0 to 1, where 0 = ranked first, 1 = ranked last. $N$ = number of EFA estimations with that benchmark. CI and Best/Worst refers to $\rho$.


| No  | Benchmark           | $\rho_\epsilon$ | $\rho$ | 95% CI          | Best  | Worst | $N$ |
| --  | ------------------ | -------- | ----- | --------------- | ----- | ----- | -- |
| 1   | bhasa           | -0.346          | 0.141  | [-0.005, 0.287] | 0.024 | 0.318 | 5   |
| 2   | mtrag           | -0.341          | 0.147  | [-0.051, 0.346] | 0.021 | 0.394 | 5   |
| 3   | creativityprism | -0.339          | 0.156  | [-0.019, 0.332] | 0.026 | 0.367 | 5   |
| 4   | eqbench         | -0.332          | 0.156  | [-0.060, 0.372] | 0.017 | 0.451 | 5   |
| 5   | mceval          | -0.331          | 0.156  | [0.024, 0.288]  | 0.051 | 0.333 | 5   |
| 6   | pwc_svamp       | -0.329          | 0.169  | [-0.033, 0.371] | 0.058 | 0.298 | 4   |
| 7   | pwc_drop_test   | -0.328          | 0.162  | [-0.139, 0.462] | 0.008 | 0.431 | 4   |
| 8   | ProphetArena    | -0.315          | 0.183  | [-0.036, 0.401] | 0.092 | 0.385 | 4   |
| 9   | dialogbench     | -0.295          | 0.210  | [-1.351, 1.770] | 0.087 | 0.332 | 2   |
| 10  | pwc_piqa        | -0.282          | 0.253  | [0.162, 0.345]  | 0.003 | 0.822 | 20  |
| 57  | gsm                                                      | -0.169 | 0.319 | [0.162, 0.476]  | 0.000 | 0.936 | 20        |
| 138 | arc                                                      | -0.056 | 0.356 | [0.230, 0.481]  | 0.049 | 1.000 | 20        |
| 139 | gpqa_diamond                                             | -0.054 | 0.475 | [0.355, 0.595]  | 0.016 | 0.992 | 20        |
| 202 | gsm8k                                                    | +0.017 | 0.413 | [0.263, 0.563]  | 0.000 | 1.000 | 20        |
| 327 | humanitys_last_exam                                      | +0.181 | 0.672 | [0.162, 1.182]  | 0.047 | 0.966 | 5         |
