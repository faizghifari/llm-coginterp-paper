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

From our imputation, only 20 dataset-imputer combination yields an $R^2$ satisfying the threshold. Additional diagnostics and trustworthiness analyses are provided in (`\hyperref[imputation-diagnostics]{Appendix~\ref*{imputation-diagnostics}}`{=latex}).

Table 3 below shows the point summaries of the factor analyses. The most important statistic here is the $\omega_h$, which indicates the degree of indicator variances explained by the general factor. Two things are worth noting here. First, while $\omega_h$ has a wide range, by our estimates' maximum, **a universally causal $g$ factor accounts, at the most, 70.8% of variance in model performance**.

Still, something to note is that the range of $\omega_h$ spans quite widely. The best-performing imputer, softimpute on S_standard, yielded a solution with a modestly effective $g$ factor that accounts for just 25.7% of the variance. The same holds when we split the models by release year. Newer models score higher on the $g$ factor, but the variance it accounts for shows no trend across release cohorts (`\hyperref[release-date-analysis]{Appendix~\ref*{release-date-analysis}}`{=latex}).

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

<!-- Table 4 as markdown, before being made smaller and wrapped with body text via wraptable (2026-09-23):

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
\textbf{Table 4.} Cohesion of subject labels. Full cohesion results for every label can be seen in Appendix XXX \par\vspace{4pt}
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

![[S_softimpute.png]]

%%Figure 1 below shows a UMAP plot of benchmarks using composite distances aggregated from factor loadings, colored based on their subject matter (`\hyperref[benchmark-embedding]{Appendix~\ref*{benchmark-embedding}}`{=latex}). Something striking from this visual is how benchmarks with common subject only occasionally cluster together. This is supported by the low cohesion scores in Table 4. It is also telling that even commonly-targeted benchmarks like `arc` and `gpqa_diamond` are located quite far from each other, and a coding benchmark like `swe_bench` is closer to some mathematics benchmarks like `math500` and `aime25` than it is to `FlashInfer-Bench`. In other words, **capability in one task does not always generalize well to another task of the same subject**.

A degree of generality exists, of course. The bottom figure, using composite distance of the S dataset, shows a clustering of several coding and math benchmarks, but other abstract reasoning benchmarks like `gsm8k` `and` arc are placed at the bottom of the continent. Note however that most clusters resemble the top, raw dataset with greatly-spaced out subjects compared to the S datasets. A semantically coherent generalization is probable but quite far from a guarantee.

![[aggregate3.png|UMAP plot of benchmarks' composite distance. Top left: raw dataset, aggregated. Top right: C dataset, softimpute. Bottom left: R, mean correlation. Bottom right: S, missforest.]]

%%

## $g$-loaded benchmarks

Another point of interest for the research question is what benchmarks act as a good proxy of general intelligence, particularly as research is concerned with performance in certain specific benchmarks to quantify intelligence advancements. Table 4 answers this question by showing the top 20 benchmarks, averaged by the normalized average rank-order[^4] based on their loadings on the $g$ factor.

[^4]: We use rank-order as factor loadings vary in range, and they are normalized as different datasets have different number of benchmarks.

Surprisingly, the top benchmarks are not dominated by common standard benchmarks. The top proxies include measures of traditional NLP tasks, legal use case, sports-related knowledge, and even emotional intelligence. There is no evidence that a $g$ factor is abstract reasoning. This diversity is expected on its own, since a general factor is indifferent to the content of its indicators. **The assumption that reasoning, mathematics, and coding benchmarks are best proxies of the latent factor $g$ best does not hold**.

<!-- REVISED in response to the Google PAT review, weakness 4 and Results point 3.
The superseded text read:

Surprisingly, the top benchmarks are not dominated by common standard benchmarks.
Rather, there is no coherent common top 20 benchmarks. The top proxies include
measures of traditional NLP tasks, legal use case, sports-related knowledge, and
even emotional intelligence. There is no evidence that a $g$ factor is abstract
reasoning. Rather, it tends to be more a "dump" of diverse semantically unrelated
and miscellaneous tasks. **In other words, the $g$ factor of LLMs are arbitrary,
incoherent, and uninterpretable**.

Two sentences were cut and one replaced, all of them the ones resting on semantic
diversity. Under Spearman's indifference of the indicator a general factor is
expected to be indifferent to the content of its indicators, so a diverse top 20
is what classical theory predicts and cannot be evidence against a general
factor. Background 2.3 now concedes this explicitly, so leaving the inference
here would have put the Background and the Results in contradiction.

What survives is the attack on the proxy assumption: the top benchmarks are not
the standard ones, and there is no evidence G is abstract reasoning. Indifference
of the indicator has no bearing on either. The new bolded sentence is worded to
echo Background 2.2 ("a subset of T, mostly assumed to be reasoning, mathematics,
and coding, measures G better than the rest") so that the Background states the
assumption and this section refutes it.

Also fixes the subject-verb error in the old bolded sentence ("the G factor of
LLMs are").

Note on the title: "uninterpretable" was load-bearing for "Machine Intelligence is
Idiosyncratic and Uninterpretably Structured". Its support now comes from 4.2
(content-similar benchmarks not clustering, so the group factors do not map onto
content domains, which indifference of the indicator does not defend since group
factors are exactly what should be content-organised) and from the variance
instability in 4.1. The authors plan to change the title in any case.

Still open here and not addressed by this edit: Table 4's top two rows have N = 2
of about 19 pipeline configurations and CIs spanning negative values on a stated
[0, 1] scale, which the same review raises separately. -->


**Table 5**. Top 20 benchmarks, sorted by the normalized rank-order of their $g$ factor loadings, ranging from 0 to 1. 0 = ranked first, 1 = ranked last. N is the number of solutions containing the benchmark, and the 95% CI is a t-interval over those N, so it is not bounded to [0, 1].

| no  | Benchmark                | Average | SD    | 95% CI          | N | Best  | Worst |
| --- | ------------------------ | ------------- | ----- | --------------- | ------- | ----- | ----- |
| 1   | bhasa                    | 0.141         | 0.118 | [-0.005, 0.287] | 5       | 0.024 | 0.318 |
| 2   | mtrag                    | 0.147         | 0.160 | [-0.051, 0.346] | 5       | 0.021 | 0.394 |
| 3   | eqbench                  | 0.156         | 0.174 | [-0.060, 0.372] | 5       | 0.017 | 0.451 |
| 4   | mceval                   | 0.156         | 0.106 | [0.024, 0.288]  | 5       | 0.051 | 0.333 |
| 5   | creativityprism          | 0.156         | 0.141 | [-0.019, 0.332] | 5       | 0.026 | 0.367 |
| 6   | pwc_drop_test            | 0.162         | 0.189 | [-0.139, 0.462] | 4       | 0.008 | 0.431 |
| 7   | pwc_svamp                | 0.169         | 0.127 | [-0.033, 0.371] | 4       | 0.058 | 0.298 |
| 8   | ProphetArena             | 0.183         | 0.137 | [-0.036, 0.401] | 4       | 0.092 | 0.385 |
| 9   | dialogbench              | 0.210         | 0.174 | [-1.351, 1.770] | 2       | 0.087 | 0.332 |
| 10  | lawbench                 | 0.222         | 0.205 | [-0.288, 0.731] | 3       | 0.057 | 0.452 |
| 11  | tablebench_data_analysis | 0.223         | 0.328 | [-0.185, 0.631] | 5       | 0.000 | 0.787 |
| 12  | pwc_timequestions        | 0.230         | 0.006 | [0.173, 0.288]  | 2       | 0.226 | 0.235 |
| 13  | pwc_multinli             | 0.233         | 0.077 | [-0.459, 0.925] | 2       | 0.179 | 0.288 |
| 14  | tombench                 | 0.234         | 0.144 | [0.056, 0.413]  | 5       | 0.062 | 0.446 |
| 15  | sea_helm                 | 0.235         | 0.245 | [-0.069, 0.539] | 5       | 0.045 | 0.603 |
| 16  | tablebench_fact_checking | 0.235         | 0.322 | [-0.165, 0.635] | 5       | 0.020 | 0.784 |
| 17  | dischargeme              | 0.245         | 0.122 | [0.093, 0.396]  | 5       | 0.087 | 0.402 |
| 18  | milu                     | 0.248         | 0.126 | [0.092, 0.404]  | 5       | 0.044 | 0.350 |
| 19  | pinocchio                | 0.249         | 0.090 | [-0.564, 1.062] | 2       | 0.185 | 0.313 |
| 20  | indicgenbench            | 0.253         | 0.067 | [-0.347, 0.853] | 2       | 0.206 | 0.300 |
