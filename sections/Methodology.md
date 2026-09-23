# Methodology

In this study we investigate the low-dimensional structure of model benchmark scores, which is comprised of distinct but correlated latent factors that each dominantly affects different clusters of benchmarks, and a $g$ factor that accounts for the variances of all benchmarks. To this end we collect a raw data matrix with size $1,618 \times 456$. One challenge in analyzing this dataset is that the raw matrix is supersparse (~1.8% density). Both benchmarks and models differ in popularity, so famous benchmarks and models have considerably higher observations. Moreover, the dataset exhibits a missing not at random (MNAR) pattern \citep{rubin1976}. Popular models are more likely to be benchmarked, and popular benchmarks are more likely to be administered. To handle this issue, we implement multiple peeling strategies to drop columns and/or rows to improve the matrix density, and apply several missing data imputation strategies. Given the dataset's difficult conditions we prefer a collection or aggregate of results from different densification and imputation methods (each of which introduces its own biases and assumptions), with the goal to triangulate each of their results to find a common characteristic.

## Data Collection

**Scope.** We limit this study to the evaluation of generative language models on a set of text-only benchmarks. We define generative language models as those that accept arbitrary prompts and produce text completions. Encoder-only classifiers, narrow task-specific systems (dedicated MT/ASR/TTS models), and undocumented community uploads are excluded. Benchmarks are included if they have at least one in-scope result row. For each row, we follow the schema from EveryEvalEver \citep{everyevalever2026} to unify the evaluation results. The schema includes fields for model, benchmark, metric, score, and other metadata such as inference setup, metric interpretation, evaluation date, and source. Full inclusion and exclusion criteria are given in `\hyperref[inclusion-and-exclusion-criteria]{Appendix~\ref*{inclusion-and-exclusion-criteria}}`{=latex}.

**Sources.** We collect the benchmark data from four types of source, in descending order of volume: (i) large curated evaluation suites, (ii) aggregated leaderboards, (iii) benchmark-specific leaderboards, and (iv) papers. Table 1 gives the composition of the text-only corpus by source family. `\hyperref[data-source-and-normalization]{Appendix~\ref*{data-source-and-normalization}}`{=latex} lists every named source and the extraction route used for each.
<!-- Specifically, these sources can be broken down into source families such as Stanford HELM \citep{helm2023}, HuggingFace Open LLM Leaderboard (v1 and v2) \citep{openllmleaderboard2024}, Papers With Code, Kaggle AI Benchmarks, Chatbot Arena / LMArena \citep{chatbotarena2024}, llm-stats.com, Artificial Analysis, Vellum, and LiveBench, together with benchmark-specific leaderboards and primary papers reporting original evaluations.  -->

<!-- Tables 1 and 2 are typeset side by side in the raw LaTeX block below to save
space (2026-09-23). Their markdown versions are kept in comments, Table 1 here and
Table 2 at the end of Densification. Keep the numbers in both places in step. -->

```{=latex}
\begin{center}\small\setlength{\tabcolsep}{4pt}
\begin{minipage}[t]{0.47\textwidth}
\label{tab:sources}\textbf{Table 1.} Composition of the text-only corpus by source family (13,251 result rows over 456 benchmarks and 1,618 models). More detailed breakdown is given in \hyperref[tab:a1]{Table A1}.\par\vspace{4pt}
\centering
\begin{tabular}{@{}lrr@{}}
\toprule
Source family & Rows & Benchmarks \\
\midrule
Stanford HELM & 4,942 & 138 \\
HF Open LLM Leaderboard & 4,529 & 12 \\
Papers With Code & 1,378 & 151 \\
Other online leaderboards & 971 & 67 \\
Kaggle AI Benchmarks & 844 & 26 \\
Primary papers & 587 & 95 \\
\bottomrule
\end{tabular}
\end{minipage}\hfill
\begin{minipage}[t]{0.49\textwidth}
\label{tab:matrices}\textbf{Table 2.} Aggregated model $\times$ benchmark matrices, text-only corpus. ``Retained'' is the fraction of observed cells surviving the densifier peel.\par\vspace{4pt}
\centering
\begin{tabular}{@{}llrrr@{}}
\toprule
Densifier & Strategy & Shape & Density & Retained \\
\midrule
raw & Standard & 1266 $\times$ 404 & 2.2\% & \\
raw & Aggressive & 334 $\times$ 380 & 3.5\% & \\
C & Standard & 671 $\times$ 78 & 13.8\% & 65\% \\
C & Aggressive & 201 $\times$ 102 & 13.6\% & 63\% \\
S & Standard & 669 $\times$ 124 & 10\% & 75\% \\
S & Aggressive & 124 $\times$ 293 & 10\% & 81\% \\
R & Standard & 175 $\times$ 298 & 11.8\% & 55\% \\
R & Aggressive & 97 $\times$ 310 & 11.7\% & 78\% \\
\bottomrule
\end{tabular}
\end{minipage}
\end{center}
```

<!-- Table 1 as markdown, before the side-by-side layout:

`\label{tab:sources}`{=latex}**Table 1.** Composition of the text-only corpus by source family (13,251 result rows over 456 benchmarks and 1,618 models). More detailed breakdown is given in `\hyperref[tab:a1]{Table A1}`{=latex}.

| Source family | Result rows | Distinct benchmarks |
|---|---:|---:|
| Stanford HELM | 4,942 | 138 |
| HF Open LLM Leaderboard | 4,529 | 12 |
| Papers With Code | 1,378 | 151 |
| Other online leaderboards | 971 | 67 |
| Kaggle AI Benchmarks | 844 | 26 |
| Primary papers | 587 | 95 |
-->

**Protocol.** Given the large number of fields from the EveryEvalEver schema, we follow a strict source-verification protocol, meaning each field is populated only if the verified source explicitly documented it. In exception, some fields can be inferred from the record itself using deductive rules with small risk of error (see `\hyperref[deductive-fills]{Appendix~\ref*{deductive-fills}}`{=latex}). In particular, we put some focus on obtaining the release date field for both models and benchmarks, and only accept a release date if it is explicitly documented in the source (`\hyperref[release-date-provenance]{Appendix~\ref*{release-date-provenance}}`{=latex}). 
<!-- The release date info coverage is 99.7 % of models and 99.8 % of benchmarks.  -->
<!-- However, since the quality of the model and benchmark release dates are different (97.3% vs 73.4% at month precision), we treat the benchmark axis as provisional (see `\hyperref[benchmark-dates-are-much-weaker-than-model-dates.]{Appendix~\ref*{benchmark-dates-are-much-weaker-than-model-dates.}}`{=latex}).  -->
We also handle redundancy at two levels. Redundant duplicate rows are removed (`\hyperref[duplicate-detection-and-integrity-checks]{Appendix~\ref*{duplicate-detection-and-integrity-checks}}`{=latex}), and near-perfectly correlated benchmark identifiers (version, dialect, or language splits of one benchmark) are collapsed to one representative, which removes 47 identifiers and 2,216 rows (`\hyperref[score-redundancy-pruning]{Appendix~\ref*{score-redundancy-pruning}}`{=latex}). A separate, earlier pass removes benchmarks that are literal-translation duplicates at the corpus level, keeping multilingual benchmarks whose per-language content is independently sourced (`\hyperref[benchmark-translation-duplicates]{Appendix~\ref*{benchmark-translation-duplicates}}`{=latex}).

<!-- The two sentences above replace a standalone **Redundancy.** paragraph that
ran to 169 words. Everything cut is already written up in the appendix: the
row-level pass in the Duplicate detection section, the correlation audit and its
per-family table in Score-redundancy pruning, and the translation pass in
Benchmark translation duplicates. The superseded paragraph read:

**Redundancy.** We handle redundancy at two levels. At the row level, we
deduplicate rows given a (model, benchmark) pair with the same evaluation setup
by collapsing them to one row and resolve them by source-trust tier and recency
(Appendix duplicate-detection-and-integrity-checks). Surviving rows for the same
(model, benchmark) pair are later averaged into a single score (see Aggregation
below). At the benchmark level, some benchmark identifiers measure the same thing
under different attributes such as version, dialect, difficulty, num sample, or
language splits of a translated benchmark. For each suspected case we compute the
pairwise Pearson correlation between its columns over the models evaluated on
both, and collapse the family to one representative only when correlations are
near-perfect across a non-trivial shared model set. This removes 47 benchmark
identifiers and 2,216 rows across seven families (Appendix
score-redundancy-pruning). A separate, earlier pass removes literal-translation
duplicates at the corpus level, keeping multilingual benchmarks whose
per-language content is independently sourced. After both passes, the text-only
corpus stands at 456 benchmarks, 1,618 models, and 13,251 result rows.

The final sentence was dropped rather than shortened because the Table 1 caption
and the section opener already give 456 / 1,618 / 13,251. The averaging sentence
moved into Aggregation below, where the step actually happens.

Protocol was then cut from 230 words to 120. The superseded opening read:

**Protocol.** Given the large number of fields from the EveryEvalEver schema, we
follows a strict source-verification protocol. For every row, each field is
populated only if the verified source explicitly documented it. In exception,
there are some fields that can be inferred from the source and record itself
using some deductive rules with small risk of error (full deductive rules are
enumerated in Appendix deductive-fills). In particular, we put some focus on
obtaining the release date field for both models and benchmarks, since we do some
analysis on the temporal evolution of model intelligence. We only accept a
release date if it is explicitly documented in the source, with principle that a
dating source is trustworthy only when the model's identity is *given* or can be
safely inferred. The release date info coverage is 2,007/2,014 models (99.7 %)
and 623/624 benchmarks (99.8 %). However, since the quality of the model and
benchmark release dates are different (97.3% vs 73.4% at month precision), we
focus on temporal analysis on the model axis and treat the benchmark axis as
provisional (see Appendix benchmark-dates-are-much-weaker-than-model-dates).

What was cut, all of it by deletion within the existing sentences rather than by
rewriting them. (i) "since we do some analysis on the temporal evolution of model
intelligence" and "we focus on temporal analysis on the model axis". The paper
contains no temporal analysis, Results has only Point summaries and Benchmark
clusters, and Appendix L.12 states that no stage of the pipeline reads
release_date. Restore both clauses if a temporal section is written. (ii) "with
principle that a dating source is trustworthy only when the model's identity is
given or can be safely inferred", which the Release-date provenance appendix
covers in full. (iii) The raw dating counts 2,007/2,014 and 623/624, leaving the
percentages that were already beside them. (iv) "from the source and", "some" and
"there are some fields that", as filler. -->


## Data Processing

<!-- The Data Processing subsections were turned into run-in bold paragraph labels (2026-09-23), as in Data Collection, to save the space each numbered heading took. They were ### Deduplication, ### Metric selection, ### Densification, ### Imputation and ### Evaluating the imputations. -->

<!-- The collected datasets contain same models evaluated under different conditions, e.g., chain-of-thought vs. no chain-of-thought. Since including the same models would lead to a violation of independence of distribution, multiple evaluation rows retained at collection time are averaged within each (model, benchmark) pair. Model identity is then resolved at two choices of granularities: -->

**Deduplication.** Rows surviving duplicate removal for the same (model, benchmark) pair are averaged into a single score. To keep near-duplicate results from the same models under different conditions (e.g. reasoning effort) from breaking the IID assumption, and to further densify the data, we average rows under two collapse strategies: The **standard** strategy is variant-level. It keeps different version numbers and parameter count, while collapsing reasoning effort, knowledge cutoff, etc. The **aggressive** strategy is family-level. Every model is collapsed to its base family token (Claude, Llama, etc.), so all sizes and generations of a family form one row.

<!-- - **`standard`** — variant-level. Source-specific model identifiers are normalised (organisation prefixes stripped, release dates and checkpoint stamps removed, context-length and reasoning-effort tags dropped, parameter counts canonicalised) so that different spellings of the same released variant collapse together, while genuinely different variants (sizes, generations, named tiers) stay distinct.
- **`aggressive`** — family-level. Every model is collapsed to its base family token, so all sizes and generations of a family form one row. -->
%%
- **Standard**: variant-level. Keeps different version numbers and parameter count, while collapsing reasoning effort, knowledge cutoff, etc.
- **Aggressive**: family-level. Every model is collapsed to its base family token (Claude, Llama, etc.), so all sizes and generations of a family form one row.

The two strategies trade sample size against row homogeneity: the standard collapse preserves more rows but leaves each row thinly observed, while the aggressive collapse produces far fewer, much better-observed rows at the cost of treating a 7B and a 405B model of one family as one entity. The token-level rules are given in `\hyperref[model-identity-collapse]{Appendix~\ref*{model-identity-collapse}}`{=latex}.%%

**Metric selection.** About 92 of our collected benchmarks were reported under several metrics. As different metrics are not comparable, we keep one metric covering the most distinct models, so the widest comparable population survives. A per-benchmark override list handles cases where coverage alone chooses badly. This drops 1,420 result rows and 706 model-cells. Finally, benchmarks observed for only one model are dropped.

<!-- At 2–4 % observed, the raw data is ineligible for virtually any data analysis. We therefore improve the dataset density by applying several additional steps that discard missing data, described below. All three densifiers greedily peel the matrix toward a common target density, differing only in which axis they sacrifice: -->

**Densification.** We further improve the data density by greedily peeling the matrix towards a common target density. We feature three densifiers, differing by the axis they sacrifice: **C (column-primary)** drops the least-observed benchmarks, then any model left empty, retaining famous benchmarks with wide model coverage. **R (row-primary)** drops the least-observed models, then any benchmark left empty, retaining a broad benchmark set over a small set of heavily-evaluated models, and leads to having more observations than variables. **S (symmetric)** drops whichever marginal has the lowest fill-rate, privileging neither axis.

After peeling, models and benchmarks that have fewer than 3 observed scores are dropped. Columns with zero variance among observed values are also dropped, since they carry no correlational signal. The algorithm is given in `\hyperref[densification-algorithm]{Appendix~\ref*{densification-algorithm}}`{=latex}. Note that we select a still relatively low target density at 10%, so that we can include as many different benchmarks as possible.

<!-- Table 2 as markdown, before the side-by-side layout (now typeset next to
Table 1 in Data Collection):

`\label{tab:matrices}`{=latex}**Table 2.** Aggregated model × benchmark matrices, text-only corpus. "Retained" is the fraction of observed cells surviving the densifier peel.

| Densifier | Strategy         | Shape      | Density | Retained |
| --------- | ---------------- | ---------- | ------: | -------: |
| raw       | Standard     | 1266 × 404 |    2.2% |          |
| raw       | Aggressive   | 334 × 380  |    3.5% |          |
| C         | Standard     | 671 × 78   |   13.8% |      65% |
| C         | Aggressive   | 201 × 102  |   13.6% |      63% |
| S         | Standard     | 669 × 124  |     10% |      75% |
| S         | Aggressive   | 124 × 293  |     10% |      81% |
| R         | Standard     | 175 × 298  |   11.8% |      55% |
| R         | Aggressive   | 97 × 310   |   11.7% |      78% |
-->

%%We further densify the data using 2 families of imputers: 

- **Full dataset imputers**: estimates the missing entries of the dataset directly. Includes SoftImpute \citep{mazumder2010}, k-NN, and missForest \citep{stekhoven2012}.
- **Correlation-level recovery**: instead exploits the fact that factor analysis needs a correlation matrix, not a data matrix. The benchmark × benchmark correlation structure is a substantially weaker requirement, and so this family estimates that correlation matrix directly. Includes OneSidedMC \citep{cao2023}-corr, OptSpace \citep{keshavan2010}, USVT \citep{chatterjee2015}, maximum-determinant SDP completion, and Gaussian graphical model completion. We also reused the softimpute algorithm as a correlation matrix imputer.
- **PSD smoothing**: a variant of the correlation-level recovery is by filling the missing entries with a scalar, then applying a PSD smoothing for the resulting matrix. The zeros method fill the missing entries with 0, while the mean uses the mean observed Pearson r.%%

**Imputation.** We applied 2 families of missing data imputers: **full-dataset** algorithms (SoftImpute \citep{mazumder2010}, k-NN, and missForest \citep{stekhoven2012}) and **correlation recovery** (OneSidedMC \citep{cao2023}-corr, USVT \citep{chatterjee2015}, and SoftImpute on the correlation matrix). Method-level descriptions and implementation detail for all of the above are given in `\hyperref[completion-methods]{Appendix~\ref*{completion-methods}}`{=latex}.


**Evaluating the imputations.** At each stage of the imputation, we masked ~20% of the observed cells as an evaluation set. To prevent high-observation benchmarks from inflating the score, we use a column-stratified mask, such that each benchmark is masked at least once and leaving at least two training observations in every column. Without column stratification, our evaluation score is inflated by the fact that high-observation benchmarks (which are the least difficult to impute) are sampled more often than low-observation ones. Columns are standardised using training-cell moments only.

Held-out cells are scored in standard-deviation units against a baseline that predicts each column's training mean:

$$\text{RMSE} = \sqrt{\frac{1}{n}\sum{(\hat z_i - z_i)^2}}, \qquad R^2 = 1 - \frac{\text{MSE}}{\text{MSE}_{\text{baseline}}}$$

Intuitively, by the $\text{MSE}$ division, the ${R}^2$ measures the proportion of errors reduced from using a model relative to the baseline. Notably, both measures are column-balanced, so the final $\text{RMSE}$ is an average of column-wise $\text{RMSE}$, and the $\text{MSE}$ used in $\text{RMSE}$ are also averages of column-wise $\text{MSE}$s. $R^2$ is used for hyperparameter selection within each method (rank, $k$, number of trees, etc.), and as a gate for factor analysis. Imputations whose held-out $R^2$ falls below 0.2 are not factored.

%%Here, $\text{RMSE}$ provides a single scalar for prediction error. However, it is difficult to interpret $\text{RMSE}$s at face value as to how well the imputer performs. As such, we use the ${R}^2$ as a relative measure to compare how well the imputer predicts held-out values compared to the the expected value of the training cells. Intuitively, by the $\text{MSE}$ division, the ${R}^2$ measures the proportion of errors reduced from using a model relative to the baseline. Notably, both measures are column-balanced, so the final $\text{RMSE}$ is an average of column-wise $\text{RMSE}$, and the $\text{MSE}$ used in $\text{RMSE}$ are also averages of column-wise $\text{MSE}$s. $R^2$ is used for hyperparameter selection within each method (rank, $k$, number of trees, etc.), and as a gate for factor analysis. Imputation results whose held-out ${R}^2$ falls below 0.2 is not factored at all, as it indicates that data-fill is not trustworthy. The split rule and the exact aggregation used for both measures are given in `\hyperref[held-out-metric]{Appendix~\ref*{held-out-metric}}`{=latex}.%%

<!-- Superseded imputation paragraph (before the switch to the canonical 10%
run, 2026-09-23). The fill-and-smooth baselines are dropped because the canon run
does not factor them, and OptSpace because the canon run has no 10% OptSpace
imputation. SoftImpute on the correlation matrix (softimpute_corr) was already in
the pipeline and is now named here. It read:

We applied 3 families of missing data imputers: **full-dataset** algorithms
(SoftImpute \citep{mazumder2010}, k-NN, and missForest \citep{stekhoven2012}),
reduced matrix, **correlation recovery** (OneSidedMC \citep{cao2023}-corr,
OptSpace \citep{keshavan2010}, USVT \citep{chatterjee2015}), and **directly fill
and apply PSD smoothing** (filling with either r = 0 or using the mean observed
correlations). -->

## Factor analysis

To perform our dimension reduction, we use exploratory factor analysis (EFA) with the minimum residual estimator and the oblique promax rotation[^2]. Importantly, particularly with respect to the inquiries about a $g$ factor, is the use of Schmid-Leiman \citep{schmidleiman1957} bifactor transformation. In essence, this technique runs factor analysis hierarchically, yielding one additional factor that influences the rest of the extracted factor. This technique is quite well-used in psychometric research explicitly about a $g$ factor of intelligence \citep{johnson2004,johnson2008}. The hierarchical step makes it a more principled choice over interpreting the highest-eigenvalue solution (e.g., \citealp{krakauer2026}) as the $g$ factor.

An important statistic from the bifactor EFA is the $\omega_h$ coefficient. There are many statistics labelled $\omega$ commonly used to quantify the reliability of psychometric measures, but in our present purpose, we use $\omega_h$ to quantify the variance explained by the $g$ factor. 

**Definition 3**. Let $T$ be a matrix of test scores that can be decomposed into independent additive components due to a **general factor** (g), **specific factors** (s)[^3], and **error** ($\epsilon$), so that
$$\sigma_T^2 = \sigma^2_{\mathrm{g}} + \sigma^2_{\mathrm{s}} + \sigma^2_{\epsilon}$$
$\omega_h$ is the estimand
$$\omega_h = \frac{\sigma^2_{\mathrm{g}}}{\sigma_T^2}$$
%%i.e., the proportion of observed-score variance attributable to the general factor. In matrix form, for a bifactor loading matrix $\Lambda$ whose first column contains the general-factor loadings $\lambda$ and whose remaining columns contain group-factor loadings, with diagonal error-variance matrix $\Theta^2$:
$$\omega_h = \frac{\mathbf{1}'\lambda\lambda'\mathbf{1}}{\mathbf{1}'(\Lambda\Lambda' + \Theta^2)\mathbf{1}}$$
where $\mathbf{1}$ is a vector of ones \citep{cho2025}.%%

[^2]: As eigenvector matrices are rotation-invariant, it is typical in psychometrics to run factor rotation algorithms to get an interpretable "simple structure". Oblique families of rotations, in addition, allow eigenvectors to correlate with each other, while default eigendecomposition yields orthogonal solutions.
[^3]: This is more standardly called "group factors", but we use the term "specific factor" to avoid possible confusion with observation grouping


One additional step we do is parallel analysis \citep{horn1965} to select the number of factor analysis dimensions. It uses simulated random values to determine eigenvalue cutoffs to discard low-variance factors. To keep wall-clock time tractable we cap the number of factors extracted to 20. 

%%Estimator settings, the factor-count rule and its caps, and the leave-one-covariate-out procedure are given in `\hyperref[factor-analysis-details]{Appendix~\ref*{factor-analysis-details}}`{=latex}.
%%

%%**Implementation.** We implement the corpus construction, densification, and plotting in Python, the imputations and factor analyses in R, and the OneSidedMC estimator in Julia, with environments pinned per language. Every numeric result is written to a single relational store keyed by dataset, method, and run, so the full design is queryable rather than reconstructed after the fact.%%

<!-- TODO: add the code and data availability sentence here, with the anonymised repository URL, before submission. ICLR expects a reproducibility statement and the appendix that used to carry one has been removed. -->

<!-- This paragraph replaces the whole of the former Appendix I, "Software
environment and reproduction", which was deleted in pass 5. That appendix was a
README: an eleven-line shell block (make deps, python3 scripts/verify_data.py,
Rscript src/run/impute.R --method <m> --data-root ... and so on), the output
directory layout, the flat output filename pattern, the three SQLite table names,
a list of twenty-odd package names, and two diagnostic script names. None of it
is method, and none of it is reproducible from the paper anyway, since it only
makes sense next to the repository. The two facts worth keeping are above.

Its shell comments also cited "Appendix D/F/G/J.5/J.6", which indexed the old
root-level Appendix-Methods.md lettering and pointed at nothing in this paper. -->
