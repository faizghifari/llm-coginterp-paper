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

Table 3 below shows the point summaries of the factor analyses. The most important statistic here is the $\omega_h$, which indicates the degree of indicator variances explained by the general factor. Two things are worth noting here. First, while $\omega_h$ has a wide range, by our estimates' maximum, **a universally causal $g$ factor accounts, at the most, 74.7% of variance in model performance**.

Still, something to note is that the range of $\omega_h$ spans quite widely. The best-performing imputer, softimpute on S_standard, yielded a solution with a modestly effective $g$ factor that accounts for just 25.7% of the variance.

**Table 3**. Point summaries of factor analyses results. Var% = percentage of variance explained, $k$ = number of factors extracted, $\phi$ = average inter-factor correlation.  

| Dataset            | Imputer         | $k$ | Var%   | $\omega_h$ | $\phi_{\text{avg}}$ | $R^2$ |
| ------------------ | --------------- | --- | -------- | ---------- | ---------------- | ------ |
| C_standard     | mean            | 20  | 85.6%  | 0.747      | 0.090               |       |
| raw_standard   | mean            | 20  | 46.0%  | 0.701      | 0.071               |       |
| C_standard     | missforest      | 4   | 88.4%  | 0.695      | 0.398               | 0.399 |
| S_standard     | softimpute_corr | 5   | 46.6%  | 0.676      | 0.306               | 0.378 |
| S_standard     | mean            | 20  | 73.2%  | 0.675      | 0.066               |       |
| C_standard     | zeros           | 20  | 84.9%  | 0.661      | 0.080               |       |
| R_standard     | mean            | 20  | 51.4%  | 0.649      | 0.094               |       |
| S_standard     | zeros           | 20  | 72.5%  | 0.562      | 0.033               |       |
| C_standard     | softimpute_corr | 4   | 58.6%  | 0.514      | 0.247               | 0.317 |
| R_standard     | zeros           | 20  | 49.9%  | 0.484      | 0.033               |       |
| raw_standard   | zeros           | 20  | 38.3%  | 0.459      | 0.024               |       |
| R_aggressive   | zeros           | 20  | 66.4%  | 0.457      | -0.003              |       |
| S_aggressive   | zeros           | 20  | 67.4%  | 0.454      | 0.004               |       |
| raw_aggressive | zeros           | 20  | 57.1%  | 0.445      | 0.012               |       |
| R_aggressive   | mean            | 20  | 66.4%  | 0.431      | -0.002              |       |
| S_aggressive   | mean            | 20  | 67.4%  | 0.410      | -0.008              |       |
| raw_aggressive | mean            | 20  | 58.4%  | 0.332      | 0.023               |       |
| S_standard     | softimpute      | 5   | 91.3%  | 0.257      | 0.094               | 0.504 |
| C_standard     | softimpute      | 9   | 94.3%  | 0.242      | 0.038               | 0.493 |
| C_aggressive   | softimpute      | 5   | 89.0%  | 0.183      | -0.001              | 0.337 |
| C_aggressive   | mean            | 20  | 83.6%  | 0.072      | 0.025               |       |
| C_aggressive   | zeros           | 20  | 83.6%  | 0.072      | 0.044               |       |
| C_standard     | onesidedmc      | 2   | 100.0% | 0.036      | 0.054               | 0.333 |
| S_standard     | missforest      | 4   | 90.0%  | 0.032      | 0.054               | 0.471 |
| S_standard     | onesidedmc      | 2   | 100.0% | 0.006      | 0.015               | 0.340 |
## Benchmark clusters

Figure 1 below shows a UMAP plot of benchmarks using composite distances aggregated from factor loadings, colored based on their subject matter (`\hyperref[benchmark-embedding]{Appendix~\ref*{benchmark-embedding}}`{=latex}). Something striking from this visual is how benchmarks with common subject only occasionally cluster together. Across the entire figure, the spaces occupied by each flagged subject matter span across the entire plot. It is also telling that even commonly-targeted benchmarks like `arc` and `gpqa_diamond` are located quite far from each other, and a coding benchmark like `swe_bench` is closer to some mathematics benchmarks like `math500` and `aime25` than it is to `FlashInfer-Bench`. In other words, **capability in one task does not always generalize well to another task of the same subject**.

A degree of generality exists, of course. The bottom figure, using composite distance of the S dataset, shows a clustering of several coding and math benchmarks, but other abstract reasoning benchmarks like `gsm8k` `and` arc are placed at the bottom of the continent. Note however that most clusters resemble the top, raw dataset with greatly-spaced out subjects compared to the S datasets. A semantically coherent generalization is probable but quite far from a guarantee.

![[aggregate3.png|UMAP plot of benchmarks' composite distance. Top left: raw dataset, aggregated. Top right: C dataset, softimpute. Bottom left: R, mean correlation. Bottom right: S, missforest.]]

## $g$-loaded benchmarks

Another point of interest for the research question is what benchmarks act as a good proxy of general intelligence, particularly as research is concerned with performance in certain specific benchmarks to quantify intelligence advancements. Table 4 answers this question by showing the top 20 benchmarks, averaged by the normalized average rank-order[^4] based on their loadings on the $g$ factor.

[^4]: We use rank-order as factor loadings vary in range, and they are normalized as different datasets have different number of benchmarks.

Surprisingly, the top benchmarks are not dominated by common standard benchmarks. The top proxies include measures of traditional NLP tasks, legal use case, sports-related knowledge, and even emotional intelligence. There is no evidence that a $g$ factor is abstract reasoning. This diversity is expected on its own, since a general factor is indifferent to the content of its indicators. **The assumption that reasoning, mathematics, and coding benchmarks measure $g$ best does not hold**.

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


**Table 4**. Top 20 benchmarks, sorted by the normalized rank-order of their $g$ factor loadings, ranging from 0 to 1. 0 = ranked first, 1 = ranked last. N is the number of solutions containing the benchmark, and the 95% CI is a t-interval over those N, so it is not bounded to [0, 1].

| No  | Benchmark                      | Avg.  | SD    | 95% CI          | N   | Best  | Worst |
| --- | ------------------------------ | ----- | ----- | --------------- | --- | ----- | ----- |
| 1   | hagendorff_biases_2023         | 0.027 | 0.039 | [-0.320, 0.374] | 2   | 0.000 | 0.055 |
| 2   | parsiNLU                       | 0.030 | 0.039 | [-0.317, 0.377] | 2   | 0.002 | 0.057 |
| 3   | eqbench                        | 0.038 | 0.048 | [0.003, 0.072]  | 10  | 0.000 | 0.134 |
| 4   | ewok_spatial_relations         | 0.040 | 0.071 | [-0.011, 0.091] | 10  | 0.000 | 0.236 |
| 5   | ewok_physical_interactions     | 0.053 | 0.089 | [-0.011, 0.117] | 10  | 0.000 | 0.293 |
| 6   | tablebench_fact_checking       | 0.062 | 0.048 | [0.027, 0.097]  | 10  | 0.007 | 0.174 |
| 7   | ewok                           | 0.062 | 0.075 | [0.008, 0.115]  | 10  | 0.007 | 0.268 |
| 8   | ewok_social_interactions       | 0.067 | 0.063 | [0.022, 0.112]  | 10  | 0.002 | 0.221 |
| 9   | tablebench_data_analysis       | 0.086 | 0.055 | [0.047, 0.125]  | 10  | 0.010 | 0.176 |
| 10  | ewok_physical_relations        | 0.088 | 0.114 | [0.007, 0.170]  | 10  | 0.014 | 0.380 |
| 11  | ewok_agent_properties          | 0.095 | 0.079 | [0.039, 0.151]  | 10  | 0.022 | 0.298 |
| 12  | lawbench                       | 0.096 | 0.094 | [-0.003, 0.194] | 6   | 0.008 | 0.242 |
| 13  | tombench                       | 0.113 | 0.076 | [0.058, 0.167]  | 10  | 0.034 | 0.266 |
| 14  | cmmlu                          | 0.113 | 0.107 | [0.001, 0.226]  | 6   | 0.011 | 0.256 |
| 15  | sportqa                        | 0.115 | 0.083 | [0.046, 0.185]  | 8   | 0.029 | 0.253 |
| 16  | ewok_social_properties         | 0.119 | 0.144 | [0.016, 0.221]  | 10  | 0.017 | 0.469 |
| 17  | tablebench_numerical_reasoning | 0.120 | 0.079 | [0.064, 0.176]  | 10  | 0.003 | 0.201 |
| 18  | mceval                         | 0.123 | 0.036 | [0.097, 0.149]  | 10  | 0.044 | 0.184 |
| 19  | ewok_material_properties       | 0.124 | 0.077 | [0.069, 0.179]  | 10  | 0.005 | 0.261 |
| 20  | ewok_social_relations          | 0.126 | 0.076 | [0.072, 0.180]  | 10  | 0.040 | 0.313 |
