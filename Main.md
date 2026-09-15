---
title: The dimensionality of machine intelligence is only partially interpretable
abstract: 'We take a multi-order latent variable approach to intelligence in language models, similar to how psychometricians formulate psychological traits. Performance in every specific problem set is influenced by a domain-specific and a domain-agnostic latent factor. Using factor analysis as a dimension-reduction technique, we analyse 13,251 published evaluation scores covering 1,618 language models across 456 different text-only benchmarks. Due to the super-sparse nature of the dataset, we triangulate our analysis across different data densifiers and imputation methods. A robust pattern across different modes of bias is that 1. factor patterns are only partially interpretable and often incoherent, 2. no silver-bullet "general intelligence" factor exists. Our findings goes against current endeavors of defining, identifying, and targeting general intelligence in language model development. It is not possible to develop a generally-intelligent language model by targeting single conceptual ability: general intelligence is only achievable by training on the first-order intelligence domains, but these are often partially idiosyncratic and not identifiable in practice.'
---

%% NOTE ON NUMBERS: the abstract and §Introduction now quote the CORPUS
(456 benchmarks / 1,618 models / 13,251 rows), which is settled and independent of the
pipeline. The aggregated MATRIX dimensions in Methodology Table 2 (1,310 x 455) are a
different object and are still provisional -- they were read off matrices predating the
score-redundancy pruning, and must be swapped together with Table 3 and the Results
tables once the pipeline re-runs. See Appendix-Methods L.3a. Do not mix the two: 14,838
was a corpus row count and 1310 x 455 were matrix dimensions, and the previous abstract
presented them as one figure. %%

%% contoh judul
 The covariance structure of machine intelligence
 On the degree of generality in machine intelligence
 A statistical analysis of "general" machine intelligence
 The dimensionality of machine intelligence is only partially interpretable
 Machine intelligence is idiosyncratic and uninterpretably structured 
%%

# Introduction

The field of artificial intelligence is rife with theories and conceptualization about what intelligence "is" (). With neural network specifically, a longstanding issue is how the models are "overfitting" their training set, and thus their performance in various tasks ("intelligence", so to say) lack powerful generalizability that cognitive entities like humans have. Thus, the development of advanced intelligent systems rely on a working notion of intelligence as adaptive and effective across diverse tasks: a singular notion of "generalizability."

There is, in this endeavor, an implicit and subtle assumption: it is that in neural networks, much like humans, cognitive abilities are structured according to a causal hierarchy. The word causal is important here. A popular notion of general intelligence in the field is the concept "fluid intelligence" borrowed from psychometric research, defined loosely as the ability to perform well in any tasks regardless of the content (i.e., a "domain-free" cognitive capacity). By definition this construct holds a causal relation, where an increase of fluid intelligence leads to an increase in the mastery of every other cognitive task. In other words, domain-general ability *precedes and builds* domain-specific abilities. 

It is, therefore, useful to ascertain whether it is plausible that cognitive abilities in neural networks follow a coherent hierarchical causal structure. An important implication is that if such structures prove to be incoherent or idiosyncratic, then the entire program of general intelligence as a silver bullet construct (e.g., "AGI") falls apart and is entirely impossible: there is no efficient way to achieve perfect-general intelligence without brute-forcing the training set to cover the universe of all possible tasks, as there are no coherent higher-order facets that researchers can target.

Why this causal hierarchy assumption is so rife in the first place is, in our view, the application of both our theories and common sense about our own intelligences to neural networks. No matter what one's stance on the cognitive nature of AI is--whether or not they are conscious, intelligent, or if they have internal representations proper--it is reasonable to assert that AI are not humans. As such, the application of top-down, human-based theories of intelligence to neural network models are a category error. We cannot describe what machine intelligence is like by overfitting theories of human intelligence on neural networks.

For this reason it is important to study the structure of machine intelligence in a bottom-up manner. Borrowing from psychometrics yet again, the application of exploratory factor analysis, a dimension-reduction statistical method, allows us to summarize performance in a series of abilities (measured through benchmarks) as influenced by a higher-order latent variable in a plausibly causal manner.

Prior work has tried applying factor analysis to benchmark scores. Ilica & Gignac (2024) have applied factor analysis to hundreds of models and found that the models' performance fits a human-informed causal structure. However, the study is flawed by their use of confirmatory factor analysis, which is a hypothesis-testing procedure, and follows the mistake of fitting a human-informed theory rather than understanding model intelligence from the bottom-up. It is also severely flawed in that a large proportion of their benchmarks are simply variants of the popular MMLU benchmark (), heightens the risk of common-method bias polluting the model fit.

Another relevant work is Burnell et al. (2023), which correctly applied EFA to model benchmark scores. They found that LLM abilities are hierarchically structured under three major factors. However, they did not do higher-order factor analysis, where EFA is run on the resulting factor loadings, thus allowing us to understand to what extent are latent factors influenced by a presumable g-factor.

<!-- need to add related paper from Krauker 2026: rise and fall of G in AGI. need to study how they come up with the selection, grouping/categorization, etc. then find 
differentiation between this paper and that paper except from the wide range of models and datasets. 
What i am thinking of, maybe discussing the theories like what happened in Krauker 2026? But since we are different in terms of data and models to analyze, then what kind
of theories that makes a different to that paper? Maybe the -->

A common weakness of both papers, though, are the relatively few number of benchmarks or variables derived thereof. Ilica & Gignac (2024) fit a model with 20 variables, while Burnell et al. (2023) uses 23 variables. Most of these benchmarks are popular benchmarks measuring "smartness" for a lack of better term, like mathematics, academic knowledge, and common-sense reasoning.

Within the context of prior work, our study presents an unprecedentedly large factor analysis of benchmark scores. The curated archive holds 2,014 models and 624 benchmarks; the text-only subset all analyses run on comprises 1,618 models and 456 benchmarks over 13,251 evaluation scores. Crucially, our pool of benchmarks covers a highly diverse set of tasks, including those quite outside of the mainstream. Covering only few popular benchmarks like prior work does is problematic. First, given their popularity, these benchmarks may well be correlated due to what we call a common-investment bias: there is a high chance their correlations substantially polluted by the fact that organizations expend more efforts to perform well in said benchmarks. Second, there should be no discrimination as to what tasks are important and which aren't: whether a task appears miscellaneous is also no reason to exclude them. A useful analogy is that reaction time in humans is correlated to intelligence (Kranzler & Jensen, 1989): no matter how seemingly unimportant a task may be, it may provide useful information that is entirely unintuitive to our subjective understanding.


# Methodology

In this study we investigate the low-dimensional structure of model benchmark scores, which comprise of distinct but correlated latent factors that each dominantly affects different clusters of benchmarks, and a $G$ factor that accounts for the variances of all benchmarks. To this end we collect a raw data matrix with size $1,618 \times 456$. One challenge in analyzing this dataset is that the raw matrix is supersparse (~1.8% density). Both benchmarks and models differ in popularity, so famous benchmarks and models have considerably higher observations. To handle this issue, we implement multiple peeling strategy to drop columns and/or rows to improve the matrix density, and applied several missing data imputation strategy. Given the dataset's difficult conditions we prefer a collection or aggregate of results from different densification and imputation methods (wherein each introduce their own biases and assumptions), with the goal to triangulate each of their results to find a common characteristic.

#### Dataset

##### Sources
We draw benchmarking data from four kinds of source, in descending order of volume: (i) large curated evaluation suites, (ii) aggregate leaderboards, (iii) benchmark-specific leaderboards, and (iv) primary papers. Concretely, the corpus draws on the Stanford HELM family (Classic, Lite, Safety, Reasoning, MedHELM, SEA-HELM, Arabic, ThaiExam, EWoK, TORR, Finance), the HuggingFace Open LLM Leaderboard (v1 and v2), Papers With Code evaluation tables, Kaggle AI Benchmarks, Chatbot Arena / LMArena, llm-stats.com, Artificial Analysis, Vellum, and **LiveBench**, together with benchmark-specific leaderboards (e.g. BigCodeBench, CRUXEval, SWE-bench, BFCL/Gorilla, VMLU, SEA-LION) and primary arXiv/ACL papers reporting original evaluations. Table 1 gives the composition of the text-only corpus by source family; [[Appendix-Methods#A Data sources and extraction|Appendix A]] lists every named source and the extraction route used for each.

**Table 1.** Composition of the text-only corpus by source family (13,251 result rows over 456 benchmarks and 1,618 models).

| Source family | Result rows | Distinct benchmarks |
|---|---:|---:|
| Stanford HELM (11 sub-leaderboards) | 4,942 | 138 |
| HF Open LLM Leaderboard (v1 + v2) | 4,529 | 12 |
| Papers With Code | 1,378 | 151 |
| Kaggle AI Benchmarks | 844 | 26 |
| Primary papers (arXiv / ACL / journals) | 430 | 69 |
| Other named leaderboards and papers (26 sources) | 300 | 37 |
| Unattributed | 295 | 40 |
| Chatbot Arena / LMArena | 202 | 1 |
| llm-stats.com | 121 | 11 |
| Vellum | 84 | 7 |
| Artificial Analysis | 71 | 2 |
| LiveBench | 55 | 1 |

##### Collection protocol

Collection follows a **strict source-verification** rule: a field is populated only if the benchmark's authors or the evaluator explicitly documented it. No value is inferred from a plausible default — we never assume, for example, that an open-weights model was evaluated with a particular inference stack, or that an undocumented decoding configuration was greedy. Undocumented fields are left blank. The one class of exception is a small set of deductive rules that cannot be wrong given the record itself (e.g. a closed model accessed over a vendor API cannot have been run locally); these are enumerated in [[Appendix-Methods#A Data sources and extraction|Appendix A]].

Records are stored in three linked tables — `benchmarks` (one row per benchmark), `models` (one row per model), and `results` (one row per model × benchmark × evaluation setup). Both `benchmarks` and `models` additionally carry a `release_date` (year-month) and a `release_date_source` recording *how* that date was established. The second column is not bookkeeping: the sources differ sharply enough in reliability that treating the date field as uniform would be a category error, and the tiers are ordered so that an analysis can filter on them ([[Appendix-Methods#A.5 Release-date provenance|Appendix A.5]]).

The governing principle is that **a dating source is trustworthy only when the model's identity is *given* rather than inferred**. An arXiv identifier encodes its submission month exactly; a HuggingFace repository whose name *is* the model reports its own creation timestamp; a publisher's launch announcement names what it is announcing. By contrast, any procedure that must normalise a model name before matching it discards precisely the tokens that separate a model from its family, and so systematically mis-dates a version to its family's launch. We adopted this rule after two search-based sources failed it on measurement rather than on principle, and after finding the same error already present in the corpus: twenty models sat at GPT-4's launch month, among them `GPT-4.1 mini` and `GPT-4.1 nano`, which postdate it by two years.

Coverage is 2,007/2,014 models (99.7 %) and 623/624 benchmarks (99.8 %). The two tables are **not** of comparable quality, and the near-identical coverage figures conceal this: 78 % of model dates now rest on an exact identifier, a repository timestamp, or a verified announcement, against 0.5 % of benchmark dates, 85 % of which remain on the weakest tiers. Model dates are at month precision in 97.3 % of rows; benchmark dates in 73.4 %. Any temporal analysis should therefore be run on the model axis and treat the benchmark axis as provisional ([[Appendix-Methods#L Known limitations and deviations|Appendix L.8]]). No stage of the pipeline reads `release_date` — densification, completion and factoring operate on the score matrix alone — so none of the results reported here depend on it.

Multiple scores for the same model–benchmark pair are **kept as separate rows** whenever they differ in evaluation setup, evaluator, or language, rather than being averaged at collection time; they are reconciled only at the aggregation step ([[#Aggregation]]), where the choice is explicit and reversible. Scores are normalised to a 0–100 scale, with documented exceptions for metrics that have no natural percentage interpretation (perplexity, bits-per-byte, Elo); metric direction is recorded rather than used to rescale ([[Appendix-Methods#C Normalisation rules|Appendix C]]).

Inclusion criteria are applied at both axes. A **model** is included if it is a generative language model that accepts arbitrary prompts; encoder-only classifiers, narrow task-specific systems (dedicated MT/ASR/TTS models), and undocumented community uploads are excluded, and different *setups* of one model (context length, reasoning effort, prompting scheme) are recorded as setup attributes rather than as distinct models. A **benchmark** is included if it has at least one in-scope result row; zero-result stubs are removed. We deliberately impose no relevance filter on benchmark content: a task is not excluded for appearing miscellaneous or unrelated to "intelligence", for the reason given in the introduction. Full criteria, and the review procedure applied to every borderline case, are in [[Appendix-Methods#B Inclusion and exclusion criteria|Appendix B]].

Every edit to the corpus is followed by an automated integrity pass: referential integrity in both directions, absence of orphan rows on either axis, duplicate detection on a composite evaluation-identity key, and a flag for benchmarks with implausibly few rows. Duplicate detection distinguishes *pure redundancy* (the same evaluation transcribed twice) from *conflicts* (different scores for what should be the same evaluation); conflicts are resolved by source-trust tier and recency, never silently averaged ([[Appendix-Methods#C Normalisation rules|Appendix C]]).

##### Modality scope

All analyses in this paper are performed on a text-only benchmarks (no multimodality). This restriction is applied by a classifier step described in [[Appendix-Methods#D Text-only classifier|Appendix D]]. Classification is followed by a cascade removal, leaving 121 of 624 benchmarks (2,100 result rows) and 345 models, leaving 503 benchmarks and 1,669 models.

##### Score-redundant benchmark splits

For each suspected family we compute the full pairwise Pearson correlation among its columns over the models evaluated on both, and decide per family: a family is collapsed to a single representative only when its columns are near-perfectly correlated across a non-trivial shared model set. This yields seven removals in total (version splits, dialect splits, difficulty and shot variants, per-language splits of a translated benchmark, a cross-source re-import, a corrupted composite identifier, and one partially redundant national-exam trio), for 47 benchmark identifiers and 2,216 result rows

A separate, earlier pass removed translation duplicates at corpus level, i.e. benchmarks that are literal translations of an original already present,  while retaining multilingual benchmarks whose per-language content is independently sourced. After both passes, and after the canonical-metric filter and scale fix described below remove a further 1,463 rows, the text-only corpus contains 456 benchmarks, 1,618 models, and 13,251 result rows from a canonical archive of 624 benchmarks, 2,014 models and 19,030 result rows.

##### Aggregation

The collected datasets contain same models evaluated under different conditions, e.g., chain-of-thought vs. no chain-of-thought. Since including the same models would lead to a violation of independence of distribution, multiple evaluation rows retained at collection time are averaged within each (model, benchmark) pair. Averaging is done after identity cleanup, so that it never masks a duplicate that should have been removed.

Model identity is then resolved at two granularities, run as parallel conditions throughout the rest of the pipeline:

- **`all_standard`** — variant-level. Source-specific model identifiers are normalised (organisation prefixes stripped, release dates and checkpoint stamps removed, context-length and reasoning-effort tags dropped, parameter counts canonicalised) so that different spellings of the same released variant collapse together, while genuinely different variants (sizes, generations, named tiers) stay distinct.
- **`all_aggressive`** — family-level. Every model is collapsed to its base family token, so all sizes and generations of a family form one row.

The two strategies trade sample size against row homogeneity: the standard collapse preserves more rows but leaves each row thinly observed; the aggressive collapse produces far fewer, much better-observed rows at the cost of treating a 7B and a 405B model of one family as one entity. Neither is correct a priori, which is why both are carried forward. The token-level rules are given in [[Appendix-Methods#F Model-identity collapse|Appendix F]].

##### Metric selection


About 92 of our collected benchmarks were reported under several metrics. As different metrics are not comparable, we kept exactly one metric per benchmark. Given a choice between several metrics, we keep the metric covering the most distinct models, so the widest comparable population survives; a per-benchmark override list handles cases where coverage alone chooses badly. This drops 1,420 result rows and 706 model-cells.

Finally, benchmarks observed for only one model are dropped, since a single observation contributes no covariance. The resulting matrices are:


#### Sparsity Handling

At 2–4 % observed, neither matrix admits a classical factor analysis: the correlation matrix cannot be estimated by listwise deletion, since there are no complete cases, and pairwise-complete estimation leaves many benchmark pairs with zero or near-zero co-observation. The missingness is moreover **not at random** — a benchmark is missing for a model precisely because that model was not considered interesting enough to evaluate on it, which is itself a function of the latent ability we are trying to measure.

##### Densification

We therefore construct **densified sub-matrices**, and we construct several of them with deliberately opposed biases rather than one "best" one. All three densifiers greedily peel the matrix toward a common target density (10 %), differing only in which axis they sacrifice:

- **C (column-primary)** — repeatedly drop the least-observed *benchmark*, then any model left empty. Retains famous benchmarks with wide model coverage.
- **R (row-primary)** — repeatedly drop the least-observed *model*, then any benchmark left empty. Retains a broad benchmark set, including obscure ones, over a small set of heavily-evaluated models.
- **S (symmetric)** — at each step drop whichever marginal has the lowest *fill-rate*, privileging neither axis.

After peeling, a floor is enforced on both axes so that every retained model and benchmark has at least two observed scores; columns with zero variance among observed values are also dropped, since they carry no correlational signal. The peel targets density only. We deliberately do **not** optimise pairwise overlap or positive-definiteness, because those are the success criteria of particular downstream estimators — optimising them here would tilt the comparison in [[#Matrix completion]] toward the methods that need them. The algorithm is given in [[Appendix-Methods#G Densification algorithm|Appendix G]].

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

The three densifiers span the aspect-ratio space: C yields tall matrices (models ≫ benchmarks), R yields wide ones (benchmarks ≫ models), and S sits between. The undensified matrix is additionally carried through the pipeline as a `raw` contrast level, analysed without imputation.
##### Matrix completion

Every densified matrix is still ~90 % missing, so a completion step is required before factoring. We use **three families** of method with different — in places incompatible — assumptions, so that a structure recovered by all of them is unlikely to be an artefact of any one.

**Cell-level imputation** estimates the missing entries directly: **SoftImpute** (nuclear-norm-penalised low-rank completion by iterative soft-thresholded SVD; assumes a low-rank signal plus noise, and is our primary cell-level method); **k-NN** (each missing cell filled from the $k$ most similar models — an assumption-light baseline with no low-rank, linearity, or normality assumption); **missForest** (iterative random-forest imputation, nonparametric, able to capture nonlinear dependence the low-rank methods cannot represent); and **MICE** (multiple imputation by chained equations, where factoring receives the mean of the $m$ completions while the spread across completions is the only natively probabilistic uncertainty estimate available to us).

**Correlation-level recovery** exploits the fact that factor analysis needs a correlation matrix, not a data matrix. When observations are too sparse to complete cells reliably, the correlation structure may still be recoverable — a substantially weaker requirement. This family estimates the benchmark × benchmark correlation matrix directly and never claims to know individual cells: **OneSidedMC** (Cao, Liang & Valiant, 2023) recovers the benchmark-space right singular vectors from pairwise products of co-observed scores, yielding an estimate $\hat{\Theta}$ of the benchmark covariance; **SoftImpute-corr**, **OptSpace** (Keshavan, Montanari & Oh, 2010), and **USVT** (Chatterjee, 2015) apply matrix-completion estimators to the *observed pairwise correlation matrix*, whose missing entries are exactly the benchmark pairs that were never co-observed; and two structured completions target positive-definiteness directly — a **maximum-determinant** SDP completion, which maximises $\log\det\Sigma$ subject to $\Sigma \succeq 0$ and to each observed correlation lying within a per-pair Fisher-*z* confidence band scaled to that pair's co-observation count, and a **Gaussian graphical model** MLE completion over the observed-pair graph.

Because these methods produce a correlation matrix rather than data, two shared devices make them commensurable with the cell-level family. First, the completed correlation matrix is symmetrised and projected to the nearest valid (positive definite, unit-diagonal) correlation matrix, so every principal submatrix is invertible. Second, a **covariance-matched surrogate** data matrix is synthesised whose sample covariance equals the recovered correlation matrix, on the original column scale, and that surrogate is handed to the identical factoring code used for every other method. The surrogate is explicitly *not* an estimate of the real cells; it is a device for passing a covariance structure through a data-matrix interface, and no per-model quantity computed from it is interpretable ([[Appendix-Methods#H Completion methods|Appendix H]]).

**No-imputation baselines** bound how much of any recovered structure is manufactured by imputation. The undensified matrix is also factored with no completion at all, from a pairwise-complete correlation matrix. Because that matrix has undefined entries (never co-observed pairs) and is generally indefinite, two treatments are compared: filling with the mean off-diagonal correlation, and filling with zero (treating absent co-observation as absent association). Both are then PSD-smoothed before factoring ([[Appendix-Methods#H Completion methods|Appendix H]]).

##### Evaluating the completion
Given the challenging nature of our dataset's missingness pattern, we need a way to measure the quality of our data imputation. As such, at each stage of the imputation, we masked ~20% of the observed cells as an evaluation set. This mask is column-stratified, such that each benchmark is masked at least once, leaving at least two training observations in every column. Without this column stratification, our evaluation score is inflated by the fact that high-observation benchmarks (which are the least difficult to impute) are sampled more often than low-observation ones. Columns are standardised using training-cell moments only.

Held-out cells are scored in standard-deviation units against a baseline that predicts each column's training mean:

$$\text{RMSE} = \sqrt{\overline{(\hat z - z)^2}}, \qquad R^2 = 1 - \frac{\text{MSE}}{\text{MSE}_{\text{baseline}}}$$

Here, $\text{RMSE}$ provides a single scalar for prediction error. However, it is difficult to interpret $\text{RMSE}$s at face value as to how well the imputer performs. As such, we use the $\text{R}^2$ as a relative measure to compare how well the imputer predicts held-out values compared to the the expected value of the training cells. Intuitively, by the $\text{MSE}$ division, the $\text{R}^2$ measures the proportion of errors reduced from using a model relative to the baseline. Notably, both measures are column-balanced, so the final $\text{RMSE}$ is an average of column-wise $\text{RMSE}$, and the $\text{MSE}$ used in $\text{RMSE}^2$ are also averages of column-wise $\text{MSE}$s.

This metric is used for hyperparameter selection within each method (rank, $k$, number of trees, etc.), and as a gate for factor analysis. Imputation results whose held-out $\text{R}^2$ falls below 0.4 is not factored at all, as it indicates that data-fill is not trustworthy.

#### Factor analysis

We dedicate this section to be a little longer, as we use methodologies that are standard in psychometric research, but critically lacking in LLM intelligence research (). There are 3 mistakes in LLM research: 1. The use of principal components analysis (PCA) over exploratory factor analysis (EFA), 2. Not rotating factor solutions, 3. Not using bifactor transformation and reporting $\omega$ coefficients.

First, the use of EFA over PCA is informed by the causal effect of the latent variables over the benchmark scores. As described in the introduction, an abstract, "raw" intelligence is assumed, by existing literature, to precedes performance in domain-specific skills (), correlations between benchmarks are directly and causally influenced by variance of the lower-dimensional latent variables. Crucially, direct eigendecomposition does not try to exclude or partition any variance, so principal components captures both systematic and error/random variance. The same is not true for EFA's multi-step algorithm. Psychometricians would call this this distinction between PCA and EFA to be formative vs. causal ().

Another important step, also standard in psychometrics but rarely done in ML, is the rotation of the resulting loading matrix. The matrix results of PCA and EFA are rotation-invariant, which tends to group all variances in the first latent factor. However, this means that the result of factor analysis tends to be difficult to interpret. Factor rotation means to find an alternative solution that rearranges loadings to be more cleanly partitioned (a "simple structure"; Gorsuch, 2004) between all of the extracted factors. Factor rotation can be thought of as improving the "cluster" of the variables to group closer to their cluster centroid. Another advantage of factor rotation is that it allows the loadings vectors to be positively correlated, while bare eigendecomposition yields orthogonal factors.

The last important step, particularly with respect to the inquiries about a $G$ factor, is the use of Schmid-Leiman bifactor transformation. In essence, this technique ran factor analysis hierarchically, yielding one additional factor that causally affects the rest of the extracted factor. Yet again, this technique is quite well-used in psychometric research explicitly about a $G$ factor of intelligence () that have been missing in LLM research. 

This yields three reported quantities: $\omega_h$, the proportion of total score variance attributable to $G$; $\omega_{total}$, the proportion attributable to all common factors; and the vector $\omega_{hs}$ of domain-factor reliabilities. The ratio $\omega_h / \omega_{total}$ reads as "of the common variance, how much is general" — the direct analogue of the $g$-saturation question in human psychometrics

One additional step we do is parallel analysis (Horn, 1965) to select the number of factor analysis dimensions. It uses simulated random values to determine eigenvalue cutoffs to discard low-variance factors. To keep wall-clock time tractable we limit the number of factors extracted to 20. 

We ran 2 factor analysis for each dataset: once using the parallel analysis-derived number of factors, and once by forcing the number of factors to 2 (not including the bifactor $G$ factor). The forced-2 run exists because the parallel-analysis count is itself unstable under different imputation algorithms.

# Results

# Discussion

## The g-factor is only partially coherent
%% 
Note: many items have .99 loadings to the g-factor, mostly low-observations data.
If this is not
%%
## Bottom-up theories of LLM intelligence

Importantly what we find is that, unlike theories of human psychology () where intelligence are explicitly assumed to possess higher-order structure, with fluid intelligence as a higher-order factor that have theoretical causal effects () to the performance of other cognitive abilities, fluid intelligence, wikipedia memorization, agentic tool use, are more likely to be horizontal with respect to each other with no clear higher-order structure. Ablation studies provide experimental evidence to this point: ...

This is also not to say that LLMs are not intelligent (in our private view, they very clearly are). But it is important to realize that just as humans and ants are differentially but equally "cognitive", LLMs are intelligent in a considerably different way to humans. This means that a theory of intelligence requires a blank-slate, bottom-up empirical approach without overfitting theories of human intelligence into systems that possess significant architectural and functional divergence from humans.

## Mechanisms for a possible g-factor

# References

%% Compiled from [[References]], grouped by theme as drafted there. Inline citation
keys in Introduction/Methodology/Discussion (the bare `()` placeholders and named
author-year mentions) are not yet wired to these entries — that pass, plus final
citation-style formatting, is still open. %%

## Psychometric g-factor

- Waterhouse, L. (2023). Why multiple intelligences theory is a neuromyth. *Frontiers in psychology*, *14*, 1217288.
- Pokropek, A., Marks, G. N., & Borgonovi, F. (2022). How much do students' scores in PISA reflect general intelligence and how much do they reflect specific abilities? *Journal of Educational Psychology*, *114*(5), 1121.
- Johnson, W., Bouchard Jr, T. J., Krueger, R. F., McGue, M., & Gottesman, I. I. (2004). Just one g: Consistent results from three test batteries. *Intelligence*, *32*(1), 95-107.
- Johnson, W., Te Nijenhuis, J., & Bouchard Jr, T. J. (2008). Still just 1 g: Consistent results from five test batteries. *Intelligence*, *36*(1), 81-95.
- Van der Maas, H. L., Kan, K. J., & Borsboom, D. (2014). Intelligence is what the intelligence test measures. Seriously. *Journal of Intelligence*, *2*(1), 12-15.
- Major, J. T., Johnson, W., & Bouchard Jr, T. J. (2011). The dependability of the general factor of intelligence: Why small, single-factor models do not adequately represent g. *Intelligence*, *39*(5), 418-433.
- Kranzler, J. H., & Jensen, A. R. (1989). Inspection time and intelligence: A meta-analysis. *Intelligence*, *13*(4), 329-347.
- Jensen, A. R. (2002). Psychometric g: Definition and substantiation. In *The general factor of intelligence* (pp. 51-66). Psychology Press.

## Intelligence in AI/ML/Compsci

- Morris, M. R., Sohl-Dickstein, J., Fiedel, N., Warkentin, T., Dafoe, A., Faust, A., ... & Legg, S. (2023). Levels of AGI for Operationalizing Progress on the Path to AGI. *arXiv preprint arXiv:2311.02462*.
- Chollet, F., Knoop, M., Kamradt, G., Landers, B., & Pinkard, H. (2025). Arc-agi-2: A new challenge for frontier ai reasoning systems. *arXiv preprint arXiv:2505.11831*.

## Prior work

- Ilica, D., & Gignac, G. E. (2024). Evidence of interrelated cognitive-like capabilities in large language models: Indications of artificial general intelligence or achievement? *Intelligence*, *106*, 101858.
- Burnell, R., Hao, H., Conway, A. R., & Orallo, J. H. (2023). Revealing the structure of language model capabilities. *arXiv preprint arXiv:2306.10062*.

## Methods and statistical tools

- Horn, J. L. (1965). A rationale and test for the number of common factors. *Psychometrika*, *30*(2), 179-185.
- Schmid, J., & Leiman, J. M. (1957). The development of hierarchical factor solutions. *Psychometrika*, *22*(1), 53-61.
- Revelle, W., & Zinbarg, R. E. (2009). Coefficients alpha, beta, omega, and the glb: Comments on Sijtsma. *Psychometrika*, *74*(1), 145-154.
- Revelle, W. (2024). *psych: Procedures for Psychological, Psychometric, and Personality Research*. R package.
- Lorenzo-Seva, U., & ten Berge, J. M. (2006). Tucker's congruence coefficient as a meaningful index of factor similarity. *Methodology*, *2*(2), 57-64.
- Mazumder, R., Hastie, T., & Tibshirani, R. (2010). Spectral regularization algorithms for learning large incomplete matrices. *Journal of Machine Learning Research*, *11*, 2287-2322.
- Cao, Y., Liang, Y., & Valiant, G. (2023). One-sided matrix completion from two observations per row. *ICML*.
- Keshavan, R. H., Montanari, A., & Oh, S. (2010). Matrix completion from a few entries. *IEEE Transactions on Information Theory*, *56*(6), 2980-2998.
- Chatterjee, S. (2015). Matrix estimation by universal singular value thresholding. *The Annals of Statistics*, *43*(1), 177-214.
- Stekhoven, D. J., & Bühlmann, P. (2012). MissForest — non-parametric missing value imputation for mixed-type data. *Bioinformatics*, *28*(1), 112-118.
- van Buuren, S., & Groothuis-Oudshoorn, K. (2011). mice: Multivariate imputation by chained equations in R. *Journal of Statistical Software*, *45*(3), 1-67.
- Higham, N. J. (2002). Computing the nearest correlation matrix — a problem from finance. *IMA Journal of Numerical Analysis*, *22*(3), 329-343.
- Rubin, D. B. (1976). Inference and missing data. *Biometrika*, *63*(3), 581-592.
- Liang, P., Bommasani, R., Lee, T., et al. (2023). Holistic evaluation of language models (HELM). *TMLR*.
- Fourrier, C., Habib, N., Lozovskaya, A., Szafer, K., & Wolf, T. (2024). Open LLM Leaderboard v2. Hugging Face.
- Chiang, W. L., Zheng, L., Sheng, Y., et al. (2024). Chatbot Arena: An open platform for evaluating LLMs by human preference. *ICML*.
