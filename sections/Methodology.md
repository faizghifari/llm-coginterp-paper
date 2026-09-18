# Methodology

In this study we investigate the low-dimensional structure of model benchmark scores, which comprise of distinct but correlated latent factors that each dominantly affects different clusters of benchmarks, and a $G$ factor that accounts for the variances of all benchmarks. To this end we collect a raw data matrix with size $1,618 \times 456$. One challenge in analyzing this dataset is that the raw matrix is supersparse (~1.8% density). Both benchmarks and models differ in popularity, so famous benchmarks and models have considerably higher observations. Moreover, The dataset exhibits a missing not at random (MNAR) pattern \citep{rubin1976}. Popular models are more likely to be benchmarked, and popular benchmarks are more likely to be administered. To handle this issue, we implement multiple peeling strategy to drop columns and/or rows to improve the matrix density, and applied several missing data imputation strategy. Given the dataset's difficult conditions we prefer a collection or aggregate of results from different densification and imputation methods (wherein each introduce their own biases and assumptions), with the goal to triangulate each of their results to find a common characteristic.

## Data Collection

**Scope.** The scope of this study is limited to the evaluation of generative language models on a set of text-only benchmarks. We define generative language models as those that accept arbitrary prompts and produce text completions. Encoder-only classifiers, narrow task-specific systems (dedicated MT/ASR/TTS models), and undocumented community uploads are excluded. Benchmarks are included if they have at least one in-scope result row. For each row, we follow the schema from EveryEvalEver \citep{everyevalever2026} to unify the evaluation results. The schema includes fields for model, benchmark, metric, score, and other metadata such as inference setup, metric interpretation, evaluation date, and source. Full inclusion and exclusion criteria are given in [[Appendix-Methods#B Inclusion and exclusion criteria|Appendix B]].

**Sources.** We collect the benchmark data from four types of source, in descending order of volume: (i) large curated evaluation suites, (ii) aggregated leaderboards, (iii) benchmark-specific leaderboards, and (iv) papers. Specifically, these sources can be broken down into source families such as Stanford HELM \citep{helm2023}, HuggingFace Open LLM Leaderboard (v1 and v2) \citep{openllmleaderboard2024}, Papers With Code, Kaggle AI Benchmarks, Chatbot Arena / LMArena \citep{chatbotarena2024}, llm-stats.com, Artificial Analysis, Vellum, and LiveBench, together with benchmark-specific leaderboards and primary papers reporting original evaluations. Table 1 gives the composition of the text-only corpus by source family. [[Appendix-Methods#A Data sources and extraction|Appendix A]] lists every named source and the extraction route used for each.

**Table 1.** Composition of the text-only corpus by source family (13,251 result rows over 456 benchmarks and 1,618 models).

| Source family | Result rows | Distinct benchmarks |
|---|---:|---:|
| Stanford HELM | 4,942 | 138 |
| HF Open LLM Leaderboard | 4,529 | 12 |
| Papers With Code | 1,378 | 151 |
| Kaggle AI Benchmarks | 844 | 26 |
| Primary papers | 587 | 95 |
| Other named leaderboards | 420 | 45 |
| Chatbot Arena / LMArena | 202 | 1 |
| llm-stats.com | 121 | 11 |
| Vellum | 96 | 7 |
| Artificial Analysis | 77 | 2 |
| LiveBench | 55 | 1 |


**Protocol.** Given the large number of fields from the EveryEvalEver schema, we follows a strict source-verification protocol. For every row, each field is populated only if the verified source explicitly documented it. In exception, there are some fields that can be inferred from the source and record itself using some deductive rules with small risk of error (full deductive rules are enumerated in [[Appendix-Methods#A Data sources and extraction|Appendix A]]). In particular, we put some focus on obtaining the release date field for both models and benchmarks, since we do some analysis on the temporal evolution of model intelligence. We only accept a release date if it is explicitly documented in the source, with principle that a dating source is trustworthy only when the model's identity is *given* or can be safely inferred. The release date info coverage is 2,007/2,014 models (99.7 %) and 623/624 benchmarks (99.8 %). However, since the quality of the model and benchmark release dates are different (97.3% vs 73.4% at month precision), we focus on temporal analysis on the model axis and treat the benchmark axis as provisional (see [[Appendix-Methods#L Known limitations and deviations|Appendix L.8]]).

**Redundancy.** We handle redundancy at two levels. At the row level, we deduplicate rows given a (model, benchmark) pair with the same evaluation setup by collapsing them to one row and resolve them by source-trust tier and recency ([[Appendix-Methods#C.4 Duplicate detection and integrity checks|Appendix C.4]]).
Surviving rows for the same (model, benchmark) pair are later averaged into a single score (see Aggregation below). At the benchmark level, some benchmark identifiers measure the same thing under different attributes such as version, dialect, difficulty, num sample, or language splits of a translated benchmark. For each suspected case we compute the pairwise Pearson correlation between its columns over the models evaluated on both, and collapse the family to one representative only when correlations are near-perfect across a non-trivial shared model set. This removes 47 benchmark identifiers and 2,216 rows across seven families ([[Appendix-Methods#E Score-redundancy pruning|Appendix E]]). A separate, earlier pass removes literal-translation duplicates at the corpus level, keeping multilingual benchmarks whose per-language content is independently sourced. After both passes, the text-only corpus stands at 456 benchmarks, 1,618 models, and 13,251 result rows.

## Data Processing

### Aggregation

<!-- The collected datasets contain same models evaluated under different conditions, e.g., chain-of-thought vs. no chain-of-thought. Since including the same models would lead to a violation of independence of distribution, multiple evaluation rows retained at collection time are averaged within each (model, benchmark) pair. Model identity is then resolved at two choices of granularities: -->

To deduplicate rows with the same models under different conditions (e.g. reasoning effort), we average rows under two collapse strategies:

<!-- - **`all_standard`** — variant-level. Source-specific model identifiers are normalised (organisation prefixes stripped, release dates and checkpoint stamps removed, context-length and reasoning-effort tags dropped, parameter counts canonicalised) so that different spellings of the same released variant collapse together, while genuinely different variants (sizes, generations, named tiers) stay distinct.
- **`all_aggressive`** — family-level. Every model is collapsed to its base family token, so all sizes and generations of a family form one row. -->

- **`all_standard`**: variant-level. Keeps different version numbers and parameter count, while collapsing reasoning effort, knowledge cutoff, etc.
- **`all_aggressive`**: family-level. Every model is collapsed to its base family token (Claude, Llama, etc.), so all sizes and generations of a family form one row.

The two strategies trade sample size against row homogeneity: the standard collapse preserves more rows but leaves each row thinly observed, while the aggressive collapse produces far fewer, much better-observed rows at the cost of treating a 7B and a 405B model of one family as one entity. The token-level rules are given in [[Appendix-Methods#F Model-identity collapse|Appendix F]].

### Metric selection

About 92 of our collected benchmarks were reported under several metrics. As different metrics are not comparable, we keep one metric covering the most distinct models, so the widest comparable population survives. A per-benchmark override list handles cases where coverage alone chooses badly. This drops 1,420 result rows and 706 model-cells. Finally, benchmarks observed for only one model are dropped.

### Densification

<!-- At 2–4 % observed, the raw data is ineligible for virtually any data analysis. We therefore improve the dataset density by applying several additional steps that discard missing data, described below. All three densifiers greedily peel the matrix toward a common target density, differing only in which axis they sacrifice: -->

We further improve the data density by greedily peeling the matrix towards a common target density. We feature three densifiers, differing by the axis they sacrifice:

- **C (column-primary)**: repeatedly drop the least-observed benchmark, then any model left empty. Retains famous benchmarks with wide model coverage.
- **R (row-primary)**: repeatedly drop the least-observed model, then any benchmark left empty. Retains a broad benchmark set, including obscure ones, over a small set of heavily-evaluated models. This densifier leads to having more observations than variables. 
- **S (symmetric)**: drop whichever marginal has the lowest fill-rate, privileging neither axis.

After peeling, models and benchmarks that has less than 3 observed scores are dropped. Columns with zero variance among observed values are also dropped, since they carry no correlational signal. The algorithm is given in [[Appendix-Methods#G Densification algorithm|Appendix G]]. Note that we select a still relatively low target density at 10%, so that we can include as much different benchmarks as possible.

**Table 2.** Aggregated model × benchmark matrices, text-only corpus. "Retained" is the fraction of observed cells surviving the densifier peel.

| Densifier | Strategy         | Shape      | Density | Retained |
| --------- | ---------------- | ---------- | ------: | -------: |
| raw       | `all_standard`   | 1266 × 404 |    2.2% |          |
| raw       | `all_aggressive` | 334 × 380  |    3.5% |          |
| C         | `all_standard`   | 671 × 78   |   13.8% |      65% |
| C         | `all_aggressive` | 201 × 102  |   13.6% |      63% |
| S         | `all_standard`   | 669 × 124  |     10% |      75% |
| S         | `all_aggressive` | 124 × 293  |     10% |      81% |
| R         | `all_standard`   | 175 × 298  |   11.8% |      55% |
| R         | `all_aggressive` | 97 × 310   |   11.7% |      78% |


### Matrix imputation

<!-- Already stated in beginning of methodology -->
<!-- The dataset exhibits a missing not at random (MNAR) pattern \citep{rubin1976}. Popular models are more likely to be benchmarked, and popular benchmarks are more likely to be administered. Since different densifiers and imputers has their own biases and assumptions, we run multiple different imputations, comparing the performance of each, and aggregating the results.  -->
<!-- The core idea is, since the distribution of the missing data is impossible to recover, it is better to triangulate results from different densifiers and different imputers, each with their own biases and assumptions, and recover common patterns as the kernel of truth. -->

<!--
Full dataset imputers estimates the missing entries of the dataset directly: **SoftImpute** \citep{mazumder2010} (nuclear-norm-penalised low-rank completion by iterative soft-thresholded SVD; assumes a low-rank signal plus noise, and is our primary cell-level method); **k-NN** (each missing cell filled from the $k$ most similar models — an assumption-light baseline with no low-rank, linearity, or normality assumption); **missForest** \citep{stekhoven2012} (iterative random-forest imputation, nonparametric, able to capture nonlinear dependence the low-rank methods cannot represent).

**Correlation-level recovery** exploits the fact that factor analysis needs a correlation matrix, not a data matrix. When observations are too sparse to complete cells reliably, the correlation structure may still be recoverable — a substantially weaker requirement. This family estimates the benchmark × benchmark correlation matrix directly and never claims to know individual cells: **OneSidedMC** \citep{cao2023} recovers the benchmark-space right singular vectors from pairwise products of co-observed scores, yielding an estimate $\hat{\Theta}$ of the benchmark covariance; **SoftImpute-corr**, **OptSpace** \citep{keshavan2010}, and **USVT** \citep{chatterjee2015} apply matrix-completion estimators to the *observed pairwise correlation matrix*, whose missing entries are exactly the benchmark pairs that were never co-observed; and two structured completions target positive-definiteness directly — a **maximum-determinant** SDP completion, which maximises $\log\det\Sigma$ subject to $\Sigma \succeq 0$ and to each observed correlation lying within a per-pair Fisher-*z* confidence band scaled to that pair's co-observation count, and a **Gaussian graphical model** MLE completion over the observed-pair graph.
-->

We further densify the data using 2 families of imputers: 

- **Full dataset imputers**: estimates the missing entries of the dataset directly. Includes SoftImpute \citep{mazumder2010}, k-NN, and missForest \citep{stekhoven2012}.
- **Correlation-level recovery**: instead exploits the fact that factor analysis needs a correlation matrix, not a data matrix. The benchmark × benchmark correlation structure is a substantially weaker requirement, and so this family estimates that correlation matrix directly. Includes OneSidedMC \citep{cao2023}, SoftImpute-corr, OptSpace \citep{keshavan2010}, USVT \citep{chatterjee2015}, maximum-determinant SDP completion, and Gaussian graphical model completion

Method-level descriptions and implementation detail for all of the above are given in [[Appendix-Methods#H Completion methods|Appendix H]].


### Evaluating the completion
At each stage of the imputation, we masked ~20% of the observed cells as an evaluation set. To prevent high-observation benchmarks from inflating the score, we use a column-stratified mask, such that each benchmark is masked at least once and leaving at least two training observations in every column. Columns are standardised using training-cell moments only.

<!-- Without this column stratification, our evaluation score is inflated by the fact that high-observation benchmarks (which are the least difficult to impute) are sampled more often than low-observation ones. -->

Held-out cells are scored in standard-deviation units against a baseline that predicts each column's training mean:

$$\text{RMSE} = \sqrt{\overline{(\hat z - z)^2}}, \qquad R^2 = 1 - \frac{\text{MSE}}{\text{MSE}_{\text{baseline}}}$$

Here, $\text{RMSE}$ provides a single scalar for prediction error. However, it is difficult to interpret $\text{RMSE}$s at face value as to how well the imputer performs. As such, we use the $\text{R}^2$ as a relative measure to compare how well the imputer predicts held-out values compared to the the expected value of the training cells. Intuitively, by the $\text{MSE}$ division, the $\text{R}^2$ measures the proportion of errors reduced from using a model relative to the baseline. Notably, both measures are column-balanced, so the final $\text{RMSE}$ is an average of column-wise $\text{RMSE}$, and the $\text{MSE}$ used in $\text{RMSE}^2$ are also averages of column-wise $\text{MSE}$s.

This metric is used for hyperparameter selection within each method (rank, $k$, number of trees, etc.), and as a gate for factor analysis. Imputation results whose held-out $\text{R}^2$ falls below 0.4 is not factored at all, as it indicates that data-fill is not trustworthy.

## Factor analysis

<!-- Is this paragraph needed? -->
We dedicate this section to be a little longer, as we use methodologies that are standard in psychometric research, but critically lacking in LLM intelligence research \citep{ilicagignac2024,burnell2023,ye2025}. There are 3 issues common in LLM intelligence research: 1. The use of principal components analysis (PCA) over exploratory factor analysis (EFA), 2. Not rotating factor solutions, 3. Not using bifactor transformation and reporting $\omega$ coefficients.

First, the use of EFA over PCA is informed by the causal effect of the latent variables over the benchmark scores. As described in the introduction, an abstract, "raw" intelligence is assumed, by existing literature, to precedes performance in domain-specific skills \citep{schneider2018}, correlations between benchmarks are directly and causally influenced by variance of the lower-dimensional latent variables. Crucially, direct eigendecomposition does not try to exclude or partition any variance, so principal components captures both systematic and error/random variance. The same is not true for EFA's multi-step algorithm. Psychometricians would call this this distinction between PCA and EFA to be formative vs. causal \citep{vandermaas2014}.

Another important step, also standard in psychometrics but rarely done in ML, is the rotation of the resulting loading matrix. The matrix results of PCA and EFA are rotation-invariant, which tends to group all variances in the first latent factor. However, this means that the result of factor analysis tends to be difficult to interpret. Factor rotation means to find an alternative solution that rearranges loadings to be more cleanly partitioned (a "simple structure"; \citealp{gorsuch1983}%% could not confirm "Gorsuch, 2004" -- swap for \citealp{gorsuch2015} (Routledge "Classic Edition" reprint) if that's the intended source %%) between all of the extracted factors. Factor rotation can be thought of as improving the "cluster" of the variables to group closer to their cluster centroid. Another advantage of factor rotation is that it allows the loadings vectors to be positively correlated, while bare eigendecomposition yields orthogonal factors.

The last important step, particularly with respect to the inquiries about a $G$ factor, is the use of Schmid-Leiman \citep{schmidleiman1957} bifactor transformation. In essence, this technique ran factor analysis hierarchically, yielding one additional factor that causally affects the rest of the extracted factor. Yet again, this technique is quite well-used in psychometric research explicitly about a $G$ factor of intelligence \citep{johnson2004,johnson2008} that have been missing in LLM research. 

This yields three reported quantities \citep{revelle2009}: $\omega_h$, the proportion of total score variance attributable to $G$; $\omega_{total}$, the proportion attributable to all common factors; and the vector $\omega_{hs}$ of domain-factor reliabilities. The ratio $\omega_h / \omega_{total}$ reads as "of the common variance, how much is general", which is the direct analogue of the $g$-saturation question in human psychometrics

One additional step we do is parallel analysis \citep{horn1965} to select the number of factor analysis dimensions. It uses simulated random values to determine eigenvalue cutoffs to discard low-variance factors. To keep wall-clock time tractable we limit the number of factors extracted to 20. 

We ran 2 factor analysis for each dataset: once using the parallel analysis-derived number of factors, and once by forcing the number of factors to 2 (not including the bifactor $G$ factor). The forced-2 run exists because the parallel-analysis count is itself unstable under different imputation algorithms.
