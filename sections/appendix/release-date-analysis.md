# Release-date analysis

This appendix looks at whether the factor structure changes with the release date of the models, and whether a benchmark's own release date relates to where it sits in that structure. Both analyses are exploratory. They reuse the completed matrices of the main analysis, and we state below the assumption under which that is valid.

## Setup

We bin models by release year into four cohorts (2022 or earlier, 2023, 2024, and 2025 or later), since earlier years hold too few models to stand alone. Release dates are known for 99.8% to 99.9% of the models in each matrix. We take the completed matrices of the three imputers whose output rows are the models themselves (SoftImpute, missForest and k-NN) on the C and S densifiers with standard collapse, split their rows by cohort, and run each cohort through the same parallel analysis, EFA and Schmid-Leiman pipeline as the pooled data (`\hyperref[factor-analysis-details]{Appendix~\ref*{factor-analysis-details}}`{=latex}). The correlation-level estimators are left out, because their completed matrix is a synthesised surrogate whose rows are not the labelled models (`\hyperref[correlation-matrix-completion-and-surrogate-synthesis]{Appendix~\ref*{correlation-matrix-completion-and-surrogate-synthesis}}`{=latex}). Besides the 10% target density of the main analysis, we repeat everything on matrices densified to 20% by the same algorithm. These keep fewer benchmarks (33 on C and 50 on S) but observe more of each cohort.

A cohort is smaller than the full matrix, and a smaller sample moves $\omega_h$ on its own. For each cohort we therefore also factor 50 random subsets of the dated models of the same size, drawn regardless of year. We count a cohort as different from the pooled data only where its $\omega_h$ falls outside the 5th to 95th percentile of its subsets. We also compare the general factor of every fit with the pooled general factor by Tucker's congruence.

## Validity of the shared imputation

Each matrix is imputed once over all models before it is split. The imputed cells of a cohort therefore draw on the models of the other cohorts, and a benchmark that no model in a cohort took is filled entirely from them. Table A4 shows how often this happens. At the 10% density up to 42 of the 124 S benchmarks have no observed score in the oldest cohort. Imputing each cohort separately is not feasible either. A cohort holds between 59 and 294 models with 9% to 29% of its cells observed, and a benchmark with no observation in a cohort cannot be imputed from inside it at all.

The shared imputation is valid under one assumption. A model's scores combine a task component, whose correlations between benchmarks are the same in every cohort, with a release-year component that shifts the level of performance. Under this assumption the cohorts differ only in location, and borrowing across them leaves the task correlations unbiased. Where the assumption fails, the shared imputation pulls each cohort toward the pooled structure. The differences between cohorts reported below are then smaller than the true ones, and a trend in $\omega_h$ could be hidden. The random subsets pass through the same imputation, so the comparison against them is still fair, but it has less power. The 20% matrices are the safer reading, since nearly every benchmark is observed in every cohort there.

`\label{tab:a4}`{=latex}**Table A4.** Size and coverage of each release cohort. Each cell gives the number of models, the share of observed cells, and the number of benchmarks with no observed score in that cohort, separated by slashes.

| Density | Densifier | Benchmarks | $\leq 2022$ | 2023 | 2024 | $\geq 2025$ |
| ------ | -------- | ---------: | -------------- | -------------- | -------------- | -------------- |
| 10% | C | 78 | 87/20%/10 | 196/14%/6 | 294/12%/21 | 93/12%/10 |
| 10% | S | 124 | 86/14%/42 | 196/9%/30 | 292/9%/26 | 94/10%/16 |
| 20% | C | 33 | 85/26%/0 | 187/29%/0 | 261/28%/4 | 59/19%/3 |
| 20% | S | 50 | 83/26%/1 | 186/22%/0 | 262/19%/14 | 73/15%/4 |

## Model cohorts

Figure 2 plots the $\omega_h$ of every cohort against the band of its random subsets. There is no trend with release year. The imputers disagree about which cohort carries the strongest general factor, and the same cohort can sit above its band under one imputer and below it under another. Cohorts nevertheless differ from random subsets of the same size more often than chance allows (Table A5). At the 10% density 8 of 24 cohort fits fall outside the 90% band, and at the 20% density 10 of 24 do, against an expected 10%. Their general factors also agree less with the pooled one than those of the random subsets. In other words, the structure shifts from one release cohort to the next without a consistent direction.

![[release-cohort-omega.png|$\omega_h$ of each release cohort (dots) against the 5th to 95th percentile of 50 random subsets of the same size (bars), per imputer. The top row shows C and S at the 10% target density, and the bottom row the same at 20%.]]

`\label{tab:a5}`{=latex}**Table A5.** Release cohorts against random subsets of the same size. "Above" and "below" count cohort fits whose $\omega_h$ lies outside the 90% band of their subsets. Congruence is the median Tucker congruence between a fit's general factor and the pooled one.

| Density | Cohort fits | Above | Below | Congruence, cohorts | Congruence, random subsets |
| ------- | ----------: | ----: | ----: | ------------------: | -------------------------: |
| 10% | 24 | 6 | 2 | 0.82 | 0.97 |
| 20% | 24 | 3 | 7 | 0.96 | 0.99 |

Newer models do score higher on the general factor (Table A6). We score each model as the loading-weighted sum of its standardised completed scores on the pooled general factor, so the mean over all models is zero. In ten of the twelve solutions the mean score rises from between $-1.5$ and $-1.0$ for models of 2022 or earlier to between $0.0$ and $1.5$ for models of 2025 or later. The two exceptions, missForest and k-NN on S at 10%, still place the newest cohort highest. Newer models are therefore better on average, but their general factor does not explain more of the variance. We find no sign that later model generations are converging on a more general intelligence.

`\label{tab:a6}`{=latex}**Table A6.** Mean general-factor score of each release cohort. The score is the loading-weighted sum of a model's standardised completed scores on the pooled general factor, with mean zero over all models.

| Density | Densifier | Imputer | $\leq 2022$ | 2023 | 2024 | $\geq 2025$ |
| ------- | --------- | ------- | ----: | ---: | ---: | ----: |
| 10% | C | SoftImpute | -1.33 | -0.29 | 0.59 | -0.01 |
| 10% | C | missForest | -1.02 | -0.40 | 0.22 | 1.11 |
| 10% | C | k-NN | -1.36 | -0.34 | 0.25 | 1.22 |
| 10% | S | SoftImpute | -1.47 | -0.21 | 0.37 | 0.67 |
| 10% | S | missForest | 0.43 | -0.32 | -0.19 | 0.86 |
| 10% | S | k-NN | -0.52 | 0.06 | -0.27 | 1.20 |
| 20% | C | SoftImpute | -1.12 | -0.10 | 0.37 | 0.32 |
| 20% | C | missForest | -1.06 | -0.41 | 0.38 | 1.14 |
| 20% | C | k-NN | -1.25 | -0.53 | 0.45 | 1.47 |
| 20% | S | SoftImpute | -1.32 | -0.19 | 0.55 | 0.01 |
| 20% | S | missForest | -1.05 | -0.45 | 0.36 | 1.05 |
| 20% | S | k-NN | -1.46 | -0.43 | 0.44 | 1.16 |

## An imputation-free check

Only six benchmarks are observed in every cohort (BBH, GPQA, IFEval, MATH, MMLU-Pro and MuSR, all from the second version of the Open LLM Leaderboard). For the 330 models that have all six, we compute the correlation matrix of their observed scores within each cohort and report the share of variance carried by its first eigenvalue, with a 95% bootstrap interval over 1,000 resamples of models (Table A7). The share rises from 0.43 in the oldest cohort to 0.71 and 0.72 in 2023 and 2024, then falls to 0.57 for models of 2025 or later. The oldest cohort sits near the floor of most of these benchmarks (a mean MATH score of 1 out of 100, for instance), which compresses its correlations. The newest cohort holds only 20 models and its interval overlaps that of 2023. We therefore read no trend into this check either.

`\label{tab:a7}`{=latex}**Table A7.** Share of variance carried by the first eigenvalue of the observed correlation matrix over the six benchmarks shared by all cohorts, with 95% bootstrap intervals.

| Cohort | Models | First-eigenvalue share | 95% interval | Mean correlation |
| ------ | -----: | ---------------------: | ------------ | ---------------: |
| $\leq 2022$ | 26 | 0.43 | [0.38, 0.55] | 0.26 |
| 2023 | 77 | 0.71 | [0.66, 0.81] | 0.64 |
| 2024 | 207 | 0.72 | [0.68, 0.76] | 0.65 |
| $\geq 2025$ | 20 | 0.57 | [0.50, 0.69] | 0.41 |

## Benchmark release date

We also ask whether a benchmark's own release date relates to its place in the pooled solutions. Benchmark dates are the weaker of the two date fields (`\hyperref[release-date-provenance]{Appendix~\ref*{release-date-provenance}}`{=latex}), so we use the year alone. Here the question concerns the pooled loadings, so all five imputers enter, including the correlation-level estimators. Table A8 gives the results per solution.

First, a benchmark's release year does not predict its general-factor loading. The Spearman correlation between the year and the absolute loading is significant in 6 of 20 solutions, three times positive and three times negative.

Second, benchmarks of the same era sit closer together in loading space than random sets of benchmarks. We group benchmarks into four eras (2019 or earlier, 2020 to 2021, 2022 to 2023, and 2024 or later) and compare the mean within-era Euclidean distance between their loading vectors against 2,000 permutations of the era labels. The resulting $z$ is below $-1.96$ in 17 of 20 solutions.

Third, most of that closeness comes from which models took the benchmarks. Newer benchmarks are taken mostly by newer models. The Spearman correlation between a benchmark's release year and the mean release year of the models observed on it is 0.60 to 0.68 across the four matrices, and two benchmarks observed on the same models are filled in alike by the imputers. We regress the rank of each pair's loading distance on the ranks of its gap in release year and of the Jaccard distance between the two benchmarks' sets of observed models. The co-observation term is the larger one in 19 of 20 solutions (standardised coefficients of 0.14 to 0.63, against 0.00 to 0.31 for the year gap). The year gap still carries weight of its own in 10 of 20 solutions, by a permutation test that relabels benchmarks 500 times.

Fourth, the observed scores show a small era effect without any imputation. Among benchmark pairs observed together on at least 30 models, pairs released four or more years apart correlate at 0.37 on the 10% S matrix, against 0.50 for pairs released within a year of each other. The gap shrinks at 20% (0.62 against 0.66) and is absent on the C matrices.

Taken together, most of the era effect comes from the missingness pattern. The small part that remains matches the shift in structure across model generations that we find in the cohort analysis.

`\label{tab:a8}`{=latex}**Table A8.** Benchmark release year against the pooled solutions. $\rho$ is the Spearman correlation between release year and absolute general-factor loading. Era $z$ compares within-era loading distance with permuted eras (negative means same-era benchmarks sit closer). The last two columns are standardised rank-regression coefficients of a pair's loading distance on its release-year gap (with permutation $p$) and on the Jaccard distance between its sets of observed models (co-obs.).

| Density | Densifier | Imputer | $\rho$ | Era $z$ | Year gap ($p$) | Co-obs. |
| ------ | -------- | ------------------ | -----: | -----: | ------------ | ------------: |
| 10% | C | SoftImpute | -0.16 | -6.1 | 0.07 (0.022) | 0.39 |
| 10% | C | missForest | 0.21 | -4.2 | 0.10 (0.054) | 0.31 |
| 10% | C | k-NN | -0.34 | -8.2 | 0.06 (0.082) | 0.43 |
| 10% | C | OneSidedMC | 0.09 | -12.5 | 0.18 (0.000) | 0.49 |
| 10% | C | SoftImpute (corr.) | -0.06 | -6.1 | 0.11 (0.018) | 0.25 |
| 10% | S | SoftImpute | -0.03 | -6.9 | 0.09 (0.004) | 0.20 |
| 10% | S | missForest | 0.22 | -14.2 | 0.20 (0.000) | 0.47 |
| 10% | S | k-NN | 0.26 | -6.0 | 0.01 (0.314) | 0.24 |
| 10% | S | OneSidedMC | -0.10 | -1.7 | 0.03 (0.154) | 0.20 |
| 10% | S | SoftImpute (corr.) | -0.02 | -1.7 | 0.04 (0.158) | 0.20 |
| 20% | C | SoftImpute | -0.49 | -2.5 | 0.11 (0.046) | 0.50 |
| 20% | C | missForest | -0.40 | -6.9 | 0.31 (0.000) | 0.15 |
| 20% | C | k-NN | -0.26 | -3.6 | 0.00 (0.424) | 0.37 |
| 20% | C | OneSidedMC | -0.01 | -3.1 | 0.17 (0.002) | 0.43 |
| 20% | C | SoftImpute (corr.) | -0.29 | -2.2 | 0.12 (0.096) | 0.35 |
| 20% | S | SoftImpute | -0.18 | -4.6 | 0.05 (0.174) | 0.55 |
| 20% | S | missForest | 0.28 | -6.0 | 0.19 (0.004) | 0.43 |
| 20% | S | k-NN | -0.24 | -5.2 | 0.02 (0.388) | 0.49 |
| 20% | S | OneSidedMC | -0.08 | -7.5 | 0.18 (0.000) | 0.63 |
| 20% | S | SoftImpute (corr.) | 0.22 | -1.2 | 0.06 (0.214) | 0.14 |

<!-- New appendix, written 2026-09-23. Every table, every count quoted in the
text and the figure are produced in ~/llm-coginterp by

    make release-date DATA_ROOT=<d> RESULTS_ROOT=<r>          (once per density)
    make release-date-report RUNS="10%=<r10>/release_date 20%=<r20>/release_date"

which writes release_date_tables.md (Tables A4 to A8 plus a "Counts quoted in
the text" list) and release-cohort-omega.png. Copy the figure into the vault
root and the tables into this file after a rerun. See the README section
"Release-date analysis" in that repo.

Data: results/text_only/10perc (the matrices behind Table 3) and 20perc (same
densifier at TARGET = 0.2). Release years come from the corrected join through
results.model_name -> models.model_id (commit 1c0c591 in the analysis repo).

Gate: reported at the pipeline's R2 >= 0.2 (aecfa86), which admits k-NN at
10% (R2 0.288 on C, 0.296 on S). The rest of the paper still states 0.3 and is
due to move to 0.2. At 0.3 the 10% k-NN rows drop out: Table A5's 10% row
becomes 16 fits, 3 above, 1 below, congruence 0.83, and Table A8's counts
become 4 of 18, 15 of 18, 17 of 18 and 10 of 18.

The 20% density will be added to the main paper as well (authors' decision,
2026-09-23). Until then this appendix is the only place it appears. -->
