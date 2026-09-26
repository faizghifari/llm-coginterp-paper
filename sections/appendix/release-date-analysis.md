# Release-date analysis

Here we check whether the factor structure changes with model release date, and whether a benchmark's release date relates to its place in that structure. Both analyses are exploratory and use the matrices of the main analysis at the 10% target density.

## Setup

We group models by release year into four groups (2022 or earlier, 2023, 2024, and 2025 or later), since the earlier years hold too few models to stand alone. Release dates are known for 99.8% to 99.9% of the models in each matrix. We take the completed C and S matrices (standard collapse) of the three imputers whose output rows are the models themselves (SoftImpute, missForest and k-NN), split their rows by year group, and run each group through the same parallel analysis, EFA and Schmid-Leiman pipeline as the pooled data (`\hyperref[factor-analysis-details]{Appendix~\ref*{factor-analysis-details}}`{=latex}). The correlation-level estimators are left out, since their completed matrix is a synthesised surrogate whose rows are not the models (`\hyperref[correlation-level-imputers]{Appendix~\ref*{correlation-level-imputers}}`{=latex}).

A smaller sample moves $\omega_h$ on its own. For each year group we therefore also factor 50 random subsets of the same size, drawn from all dated models regardless of year, and only count a group as different when its $\omega_h$ falls outside the 5th to 95th percentile of its subsets. We also compare the general factor of each fit with the pooled one by Tucker's congruence.

It must be stressed, however, that each matrix is imputed once over all models before the split. The missing cells of one year group are filled partly from the other groups, and a benchmark that no model in the group took is filled entirely from them. This happens often (Table A4), up to 42 of the 124 S benchmarks in the oldest group. Imputing each group on its own does not work either, since a benchmark with no observation in a group cannot be imputed from inside it. If the correlations between benchmarks are the same in every year and only the level of performance shifts, the shared imputation does no harm. If they are not, it pulls every group toward the pooled structure, and the differences we report below are smaller than the true ones.

`\label{tab:a4}`{=latex}**Table A4.** Size and coverage of each release-year group. Each cell gives the number of models, the share of observed cells, and the number of benchmarks with no observed score in that group.

| Densifier | Benchmarks | $\leq 2022$ | 2023 | 2024 | $\geq 2025$ |
| -------- | ---------: | -------------- | -------------- | -------------- | -------------- |
| C | 78 | 87/20%/10 | 196/14%/6 | 294/12%/21 | 93/12%/10 |
| S | 124 | 86/14%/42 | 196/9%/30 | 292/9%/26 | 94/10%/16 |

## Models by release year

`\hyperref[fig:release-year-omega]{Figure~\ref*{fig:release-year-omega}}`{=latex} plots the $\omega_h$ of each year group against the band of its random subsets. There is no trend with release year. The imputers do not even agree on which year has the strongest general factor. Still, the year groups differ from random subsets more often than chance allows. Of the 24 fits, 8 fall outside the 90% band (6 above and 2 below) where 2 or 3 are expected, and the median congruence of their general factor with the pooled one is 0.82, against 0.97 for the random subsets. In other words, the structure does shift from one year to the next, but in no consistent direction.

![[release-cohort-omega.png|$\omega_h$ of each release-year group (dots) against the 5th to 95th percentile of 50 random subsets of the same size (bars), per imputer, on the C (left) and S (right) matrices.`\label{fig:release-year-omega}`{=latex}]]

Newer models do score higher on the general factor (Table A5). We score each model as the loading-weighted sum of its standardised completed scores on the pooled general factor, so the mean over all models is zero. In four of the six solutions the mean score goes from between $-1.5$ and $-1.0$ for models of 2022 or earlier to between $0.0$ and $1.2$ for models of 2025 or later. In the other two (missForest and k-NN on S) the newest models still score highest. So newer models are better on average, but their general factor does not explain more of the variance. We find no sign that later model generations are converging on a more general intelligence.

`\label{tab:a5}`{=latex}**Table A5.** Mean general-factor score of each release-year group, with mean zero over all models.

| Densifier | Imputer | $\leq 2022$ | 2023 | 2024 | $\geq 2025$ |
| --------- | ------- | ----: | ---: | ---: | ----: |
| C | SoftImpute | -1.33 | -0.29 | 0.59 | 0.00 |
| C | missForest | -1.02 | -0.40 | 0.22 | 1.11 |
| C | k-NN | -1.36 | -0.34 | 0.25 | 1.22 |
| S | SoftImpute | -1.47 | -0.21 | 0.37 | 0.67 |
| S | missForest | 0.43 | -0.32 | -0.19 | 0.86 |
| S | k-NN | -0.52 | 0.06 | -0.27 | 1.20 |

## Without imputation

Only six benchmarks are observed in every year group (BBH, GPQA, IFEval, MATH, MMLU-Pro and MuSR, all from the Open LLM Leaderboard v2). For the 330 models that have all six, we compute the correlation matrix of their observed scores within each year group and take the share of variance of its first eigenvalue. This share is 0.43 for 2022 or earlier, 0.71 for 2023, 0.72 for 2024 and 0.57 for 2025 or later. The oldest models sit near the floor of most of these benchmarks (a mean MATH score of 1 out of 100, for instance), which lowers their correlations, and the newest group holds only 20 models, with a bootstrap interval ([0.50, 0.69]) that overlaps that of 2023 ([0.66, 0.81]). We read no trend into this check either.

## Benchmark release date

We also check whether the release year of a benchmark relates to its place in the pooled solutions. Benchmark dates are less reliable than model dates (`\hyperref[release-date-provenance]{Appendix~\ref*{release-date-provenance}}`{=latex}), so we only use the year. Since only the pooled loadings are needed here, all five imputers enter (Table A6).

First off, release year does not predict the general-factor loading. The Spearman correlation between year and absolute loading is significant in only 3 of 10 solutions, twice positive and once negative.

Benchmarks from the same era do sit closer together in loading space. We group benchmarks into four eras (2019 or earlier, 2020 to 2021, 2022 to 2023, and 2024 or later), and the mean within-era Euclidean distance between their loading vectors is smaller than under 2,000 permutations of the era labels in 9 of 10 solutions ($z < -1.96$).

Most of this closeness, however, comes from which models took each benchmark. Newer benchmarks are mostly taken by newer models (the Spearman correlation between a benchmark's year and the mean year of its models is 0.67 on S and 0.68 on C), and two benchmarks taken by the same models are filled in alike by the imputers. We regress the rank of each pair's loading distance on the ranks of its year gap and of the Jaccard distance between the two sets of observed models. The co-observation term is the larger one in all 10 solutions (0.20 to 0.54, against 0.01 to 0.20 for the year gap), although the year gap keeps a significant effect of its own in 6 of 10 (permutation test with 500 relabellings).

The observed scores alone show a small era effect on S. Among benchmark pairs observed together on at least 30 models, pairs released four or more years apart correlate at 0.36, against 0.50 for pairs released within a year of each other. On C there is no gap (0.51 against 0.51). Succinctly, most of the era effect comes from the missingness pattern, and the small part left matches the year-to-year shift we find for the models.

`\label{tab:a6}`{=latex}**Table A6.** Benchmark release year against the pooled solutions. $\rho$ is the Spearman correlation between release year and absolute general-factor loading. Era $z$ compares within-era loading distance with permuted eras (negative means same-era benchmarks sit closer). The last two columns are standardised rank-regression coefficients of a pair's loading distance on its release-year gap (with permutation $p$) and on the Jaccard distance between its sets of observed models (co-obs.).

| Densifier | Imputer | $\rho$ | Era $z$ | Year gap ($p$) | Co-obs. |
| -------- | ------------------ | -----: | -----: | ------------ | ------------: |
| C | SoftImpute | -0.16 | -6.1 | 0.07 (0.022) | 0.39 |
| C | missForest | 0.21 | -4.2 | 0.10 (0.054) | 0.31 |
| C | k-NN | -0.34 | -8.2 | 0.06 (0.082) | 0.43 |
| C | OneSidedMC | 0.10 | -12.6 | 0.15 (0.000) | 0.54 |
| C | SoftImpute (corr.) | -0.06 | -6.1 | 0.11 (0.018) | 0.25 |
| S | SoftImpute | -0.03 | -6.9 | 0.09 (0.004) | 0.20 |
| S | missForest | 0.22 | -14.2 | 0.20 (0.000) | 0.47 |
| S | k-NN | 0.26 | -6.0 | 0.01 (0.314) | 0.24 |
| S | OneSidedMC | 0.13 | -9.9 | 0.10 (0.000) | 0.45 |
| S | SoftImpute (corr.) | -0.02 | -1.7 | 0.04 (0.158) | 0.20 |

<!-- Rewrite 2026-09-26 (shorter, author voice, "cohort" replaced by "year group").
Changes besides wording: the one-row cohorts-vs-random table (old A5) and the
imputation-free table (old A7) are folded into the text, so the tables are now
A4 coverage, A5 g-score (was A6) and A6 benchmark year (was A8). The report
script still numbers them A4 to A8. The paragraph on the random subsets sharing
the imputation ("still fair, but less power") and the per-group size range
("86 to 294 models with 9% to 20% observed", which Table A4 already shows) were
cut. The full pre-rewrite text is in the ORIGINAL block below. -->

<!-- ---------- ORIGINAL (pre-revision) TEXT, before the 2026-09-26 rewrite.
Its two inline 20% comments are kept as {20% note ...} since comments cannot nest.

# Release-date analysis

This appendix looks at whether the factor structure changes with the release date of the models, and whether a benchmark's own release date relates to where it sits in that structure. Both analyses are exploratory. They reuse the completed matrices of the main analysis, and we state below the assumption under which that is valid.

## Setup

We bin models by release year into four cohorts (2022 or earlier, 2023, 2024, and 2025 or later), since earlier years hold too few models to stand alone. Release dates are known for 99.8% to 99.9% of the models in each matrix. We take the completed matrices of the three imputers whose output rows are the models themselves (SoftImpute, missForest and k-NN) on the C and S densifiers with standard collapse, split their rows by cohort, and run each cohort through the same parallel analysis, EFA and Schmid-Leiman pipeline as the pooled data (`\hyperref[factor-analysis-details]{Appendix~\ref*{factor-analysis-details}}`{=latex}). The correlation-level estimators are left out, because their completed matrix is a synthesised surrogate whose rows are not the labelled models (`\hyperref[correlation-matrix-completion-and-surrogate-synthesis]{Appendix~\ref*{correlation-matrix-completion-and-surrogate-synthesis}}`{=latex}). All matrices are those of the main analysis at the 10% target density. {20% note, was a comment: Besides the 10% target density of the main analysis, we repeat everything on matrices densified to 20% by the same algorithm. These keep fewer benchmarks (33 on C and 50 on S) but observe more of each cohort.}

A cohort is smaller than the full matrix, and a smaller sample moves $\omega_h$ on its own. For each cohort we therefore also factor 50 random subsets of the dated models of the same size, drawn regardless of year. We count a cohort as different from the pooled data only where its $\omega_h$ falls outside the 5th to 95th percentile of its subsets. We also compare the general factor of every fit with the pooled general factor by Tucker's congruence.

## Validity of the shared imputation

Each matrix is imputed once over all models before it is split. The imputed cells of a cohort therefore draw on the models of the other cohorts, and a benchmark that no model in a cohort took is filled entirely from them. Table A4 shows how often this happens. Up to 42 of the 124 S benchmarks have no observed score in the oldest cohort. Imputing each cohort separately is not feasible either. A cohort holds between 86 and 294 models with 9% to 20% of its cells observed, and a benchmark with no observation in a cohort cannot be imputed from inside it at all.

The shared imputation is valid under one assumption. A model's scores combine a task component, whose correlations between benchmarks are the same in every cohort, with a release-year component that shifts the level of performance. Under this assumption the cohorts differ only in location, and borrowing across them leaves the task correlations unbiased. Where the assumption fails, the shared imputation pulls each cohort toward the pooled structure. The differences between cohorts reported below are then smaller than the true ones, and a trend in $\omega_h$ could be hidden. The random subsets pass through the same imputation, so the comparison against them is still fair, but it has less power. {20% note, was a comment: The 20% matrices are the safer reading, since nearly every benchmark is observed in every cohort there.}

`\label{tab:a4}`{=latex}**Table A4.** Size and coverage of each release cohort. Each cell gives the number of models, the share of observed cells, and the number of benchmarks with no observed score in that cohort, separated by slashes.

| Densifier | Benchmarks | $\leq 2022$ | 2023 | 2024 | $\geq 2025$ |
| -------- | ---------: | -------------- | -------------- | -------------- | -------------- |
| C | 78 | 87/20%/10 | 196/14%/6 | 294/12%/21 | 93/12%/10 |
| S | 124 | 86/14%/42 | 196/9%/30 | 292/9%/26 | 94/10%/16 |

## Model cohorts

Figure 2 plots the $\omega_h$ of every cohort against the band of its random subsets. There is no trend with release year. The imputers disagree about which cohort carries the strongest general factor, and the same cohort can sit above its band under one imputer and below it under another. Cohorts nevertheless differ from random subsets of the same size more often than chance allows (Table A5). Of the 24 cohort fits, 8 fall outside the 90% band, against an expected 10%. {20% note, was a comment: At the 10% density 8 of 24 cohort fits fall outside the 90% band, and at the 20% density 10 of 24 do, against an expected 10%.} Their general factors also agree less with the pooled one than those of the random subsets. In other words, the structure shifts from one release cohort to the next without a consistent direction.

![[release-cohort-omega.png|$\omega_h$ of each release cohort (dots) against the 5th to 95th percentile of 50 random subsets of the same size (bars), per imputer, on the C (left) and S (right) matrices.]]

`\label{tab:a5}`{=latex}**Table A5.** Release cohorts against random subsets of the same size. "Above" and "below" count cohort fits whose $\omega_h$ lies outside the 90% band of their subsets. Congruence is the median Tucker congruence between a fit's general factor and the pooled one.

| Cohort fits | Above | Below | Congruence, cohorts | Congruence, random subsets |
| ----------: | ----: | ----: | ------------------: | -------------------------: |
| 24 | 6 | 2 | 0.82 | 0.97 |

Newer models do score higher on the general factor (Table A6). We score each model as the loading-weighted sum of its standardised completed scores on the pooled general factor, so the mean over all models is zero. In four of the six solutions the mean score rises from between $-1.5$ and $-1.0$ for models of 2022 or earlier to between $0.0$ and $1.5$ for models of 2025 or later. The two exceptions, missForest and k-NN on S, still place the newest cohort highest. Newer models are therefore better on average, but their general factor does not explain more of the variance. We find no sign that later model generations are converging on a more general intelligence.

`\label{tab:a6}`{=latex}**Table A6.** Mean general-factor score of each release cohort. The score is the loading-weighted sum of a model's standardised completed scores on the pooled general factor, with mean zero over all models.

| Densifier | Imputer | $\leq 2022$ | 2023 | 2024 | $\geq 2025$ |
| --------- | ------- | ----: | ---: | ---: | ----: |
| C | SoftImpute | -1.33 | -0.29 | 0.59 | 0.00 |
| C | missForest | -1.02 | -0.40 | 0.22 | 1.11 |
| C | k-NN | -1.36 | -0.34 | 0.25 | 1.22 |
| S | SoftImpute | -1.47 | -0.21 | 0.37 | 0.67 |
| S | missForest | 0.43 | -0.32 | -0.19 | 0.86 |
| S | k-NN | -0.52 | 0.06 | -0.27 | 1.20 |

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

First, a benchmark's release year does not predict its general-factor loading. The Spearman correlation between the year and the absolute loading is significant in 3 of 10 solutions, twice positive and once negative.

Second, benchmarks of the same era sit closer together in loading space than random sets of benchmarks. We group benchmarks into four eras (2019 or earlier, 2020 to 2021, 2022 to 2023, and 2024 or later) and compare the mean within-era Euclidean distance between their loading vectors against 2,000 permutations of the era labels. The resulting $z$ is below $-1.96$ in 9 of 10 solutions.

Third, most of that closeness comes from which models took the benchmarks. Newer benchmarks are taken mostly by newer models. The Spearman correlation between a benchmark's release year and the mean release year of the models observed on it is 0.67 on S and 0.68 on C, and two benchmarks observed on the same models are filled in alike by the imputers. We regress the rank of each pair's loading distance on the ranks of its gap in release year and of the Jaccard distance between the two benchmarks' sets of observed models. The co-observation term is the larger one in all 10 solutions (standardised coefficients of 0.20 to 0.54, against 0.01 to 0.20 for the year gap). The year gap still carries weight of its own in 6 of 10 solutions, by a permutation test that relabels benchmarks 500 times.

Fourth, the observed scores show a small era effect without any imputation. Among benchmark pairs observed together on at least 30 models, pairs released four or more years apart correlate at 0.36 on the S matrix, against 0.50 for pairs released within a year of each other. The gap is absent on the C matrix (0.51 against 0.51).

Taken together, most of the era effect comes from the missingness pattern. The small part that remains matches the shift in structure across model generations that we find in the cohort analysis.

`\label{tab:a8}`{=latex}**Table A8.** Benchmark release year against the pooled solutions. $\rho$ is the Spearman correlation between release year and absolute general-factor loading. Era $z$ compares within-era loading distance with permuted eras (negative means same-era benchmarks sit closer). The last two columns are standardised rank-regression coefficients of a pair's loading distance on its release-year gap (with permutation $p$) and on the Jaccard distance between its sets of observed models (co-obs.).

| Densifier | Imputer | $\rho$ | Era $z$ | Year gap ($p$) | Co-obs. |
| -------- | ------------------ | -----: | -----: | ------------ | ------------: |
| C | SoftImpute | -0.16 | -6.1 | 0.07 (0.022) | 0.39 |
| C | missForest | 0.21 | -4.2 | 0.10 (0.054) | 0.31 |
| C | k-NN | -0.34 | -8.2 | 0.06 (0.082) | 0.43 |
| C | OneSidedMC | 0.10 | -12.6 | 0.15 (0.000) | 0.54 |
| C | SoftImpute (corr.) | -0.06 | -6.1 | 0.11 (0.018) | 0.25 |
| S | SoftImpute | -0.03 | -6.9 | 0.09 (0.004) | 0.20 |
| S | missForest | 0.22 | -14.2 | 0.20 (0.000) | 0.47 |
| S | k-NN | 0.26 | -6.0 | 0.01 (0.314) | 0.24 |
| S | OneSidedMC | 0.13 | -9.9 | 0.10 (0.000) | 0.45 |
| S | SoftImpute (corr.) | -0.02 | -1.7 | 0.04 (0.158) | 0.20 |
-->

<!-- New appendix, written 2026-09-23. Every table, every count quoted in the
text and the figure are produced in ~/llm-coginterp by

    make release-date DATA_ROOT=<d> RESULTS_ROOT=<r>
    make release-date-report RUNS="10%=<r>/release_date"

which writes release_date_tables.md (Tables A4 to A8 plus a "Counts quoted in
the text" list) and release-cohort-omega.png. Copy the figure into the vault
root and the tables into this file after a rerun. See the README section
"Release-date analysis" in that repo.

Data (switched 2026-09-23): the canonical 10% run, 10perc.canon.zip in
results/ (analysis repo commit ed6c9f3), factored at the R2 >= 0.2 gate.
Numbers are from its bundled results/text_only/release_date_report. A local
rerun reproduces every flag and count, with a few fits differing in the third
decimal (S k-NN and missForest 2023 omega_h). Relative to the old 10perc run,
the cohort tables are unchanged and only the OneSidedMC rows of Table A8 moved,
since OneSidedMC was refactored.

The 20% density is dropped from this appendix (authors' decision, 2026-09-23,
20% results were outdated). Its old rows, in git history before this change:
Table A5 24 fits, 3 above, 7 below, congruence 0.96 / 0.99, and Table A8
counts pooled over both densities of 6, 17, 19 and 10 of 20.

Rechecked 2026-09-26 against the re-uploaded 10perc.canon.zip. Its data/ and
release_date outputs are byte-identical to the run above, so nothing changed.
The report's A5 and A7 now live in the text, and its A6 and A8 are the paper's
A5 and A6. -->
