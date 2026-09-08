---
title: "Machine intelligence is idiosyncratic and incoherently structured"
abstract: |
  We take a multi-order latent variable approach to intelligence in language models, similar to how psychometricians formulate psychological traits. Performance in every specific problem set is influenced by a domain-specific and a domain-agnostic latent factor. Using factor analysis as a dimension-reduction technique, we analyse 13,251 published evaluation scores covering 1,618 language models across 456 different text-only benchmarks. Due to the super-sparse nature of the dataset, we triangulate our analysis across different data densifiers and imputation methods. A robust pattern across different modes of bias is that 1. factor patterns are only partially interpretable and often incoherent, 2. no silver-bullet "general intelligence" factor exists. Our findings goes against current endeavors of defining, identifying, and targeting general intelligence in language model development. It is not possible to develop a generally-intelligent language model by targeting single conceptual ability: general intelligence is only achievable by training on the first-order intelligence domains, but these are often partially idiosyncratic and not identifiable in practice.
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

A common weakness of both papers, though, are the relatively few number of benchmarks or variables derived thereof. Ilica & Gignac (2024) fit a model with 20 variables, while Burnell et al. (2023) uses 23 variables. Most of these benchmarks are popular benchmarks measuring "smartness" for a lack of better term, like mathematics, academic knowledge, and common-sense reasoning.

Within the context of prior work, our study presents an unprecedentedly large factor analysis of benchmark scores. The curated archive holds 2,014 models and 624 benchmarks; the text-only subset all analyses run on comprises 1,618 models and 456 benchmarks over 13,251 evaluation scores. Crucially, our pool of benchmarks covers a highly diverse set of tasks, including those quite outside of the mainstream. Covering only few popular benchmarks like prior work does is problematic. First, given their popularity, these benchmarks may well be correlated due to what we call a common-investment bias: there is a high chance their correlations substantially polluted by the fact that organizations expend more efforts to perform well in said benchmarks. Second, there should be no discrimination as to what tasks are important and which aren't: whether a task appears miscellaneous is also no reason to exclude them. A useful analogy is that reaction time in humans is correlated to intelligence (Kranzler & Jensen, 1989): no matter how seemingly unimportant a task may be, it may provide useful information that is entirely unintuitive to our subjective understanding.


# Methodology

We ask whether the covariance among language models' published benchmark scores admits a low-dimensional latent structure, and in particular whether it supports a global general factor $G$ in the sense of [[Appendix#Definitions]]. The empirical object is a **model × benchmark score matrix** assembled from public evaluation records. That matrix is extremely sparse and its missingness is not at random: widely-known models are evaluated on widely-used benchmarks, while obscure benchmarks co-occur with almost nothing. Our methodology is therefore organised around a single principle — **no single repair of the matrix is trustworthy on its own** — so we run a cross-product of deliberately different repairs and treat their agreement or disagreement as the finding, rather than selecting one recipe and reporting its output as the answer.

The pipeline has five stages: *collection* → *scoping* → *aggregation* → *densification* → *completion* → *factor analysis*.

All analyses reported here use the **text-only** subset of the corpus (see [[#Modality scope]]); the multimodal-inclusive corpus is used only as a contrast condition where explicitly stated.

#### Dataset

##### Sources

Scores are transcribed from public evaluation records, not re-run by us. We draw from four kinds of source, in descending order of volume: (i) large curated evaluation suites, (ii) aggregate leaderboards, (iii) benchmark-specific leaderboards, and (iv) primary papers. Concretely, the corpus draws on the **Stanford HELM** family (Classic, Lite, Safety, Reasoning, MedHELM, SEA-HELM, Arabic, ThaiExam, EWoK, TORR, Finance), the **HuggingFace Open LLM Leaderboard** (v1 and v2), **Papers With Code** evaluation tables, **Kaggle AI Benchmarks**, **Chatbot Arena / LMArena**, **llm-stats.com**, **Artificial Analysis**, **Vellum**, and **LiveBench**, together with benchmark-specific leaderboards (e.g. BigCodeBench, CRUXEval, SWE-bench, BFCL/Gorilla, VMLU, SEA-LION) and primary arXiv/ACL papers reporting original evaluations. Table 1 gives the composition of the text-only corpus by source family; [[Appendix-Methods#A Data sources and extraction|Appendix A]] lists every named source and the extraction route used for each.

**Table 1.** Composition of the text-only corpus by source family (13,251 result rows over 456 benchmarks and 1,618 models). Families are aggregated from the recorded `source_organization` field.

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

##### Sources partition the matrix

One consequence of this composition deserves stating before any of the machinery, because it constrains what the analysis can recover. Benchmark columns are largely *owned* by a single evaluation suite, and the suites evaluate near-disjoint sets of models. Measuring co-observation between columns, grouped by the source that supplies most of each column's rows:

| column pair | median models observed on both | pairs with <2 shared models (correlation not estimable) |
|---|---:|---:|
| HELM × HELM | 4 | 33 % |
| Open LLM Leaderboard × Open LLM Leaderboard | 160 | 0 % |
| **HELM × Open LLM Leaderboard** | **0** | **87 %** |

The matrix is therefore closer to two weakly-connected blocks than to one sparse whole: within the Open LLM Leaderboard block, correlations rest on ~160 shared models; across the two blocks, 87 % of column pairs cannot support a correlation estimate at all. This is not a curation artefact we can repair — it is a direct consequence of which models each leaderboard chooses to evaluate — and it means any general factor recovered here is at risk of being a within-block factor. We return to it when interpreting the results, and it is the structural reason the cross-densifier comparison matters: the column-primary peel retains famous benchmarks, which are disproportionately the densely-connected block.

Two further properties matter downstream. First, source volume is highly unequal: two source families supply two-thirds of all records, so the *missingness pattern* is largely inherited from those two suites' model selection policies. Second, benchmark breadth and row volume are anti-correlated — Papers With Code contributes the most distinct benchmarks but relatively few rows per benchmark, while the Open LLM Leaderboard contributes 12 benchmarks with very deep model coverage. This is precisely the structure that makes the densification choice in [[#Sparsity Handling]] consequential rather than cosmetic, and it is what motivates the per-benchmark influence analysis in [[Analysis#Robustness and sensitivity analyses]].

##### Collection protocol

Collection follows a **strict source-verification** rule: a field is populated only if the benchmark's authors or the evaluator explicitly documented it. No value is inferred from a plausible default — we never assume, for example, that an open-weights model was evaluated with a particular inference stack, or that an undocumented decoding configuration was greedy. Undocumented fields are left blank. The one class of exception is a small set of deductive rules that cannot be wrong given the record itself (e.g. a closed model accessed over a vendor API cannot have been run locally); these are enumerated in [[Appendix-Methods#A Data sources and extraction|Appendix A]].

Records are stored in three linked tables — `benchmarks` (one row per benchmark), `models` (one row per model), and `results` (one row per model × benchmark × evaluation setup). Both `benchmarks` and `models` additionally carry a `release_date` (year-month) and a `release_date_source` recording *how* that date was established. The second column is not bookkeeping: the sources differ sharply enough in reliability that treating the date field as uniform would be a category error, and the tiers are ordered so that an analysis can filter on them ([[Appendix-Methods#A.5 Release-date provenance|Appendix A.5]]).

The governing principle is that **a dating source is trustworthy only when the model's identity is *given* rather than inferred**. An arXiv identifier encodes its submission month exactly; a HuggingFace repository whose name *is* the model reports its own creation timestamp; a publisher's launch announcement names what it is announcing. By contrast, any procedure that must normalise a model name before matching it discards precisely the tokens that separate a model from its family, and so systematically mis-dates a version to its family's launch. We adopted this rule after two search-based sources failed it on measurement rather than on principle, and after finding the same error already present in the corpus: twenty models sat at GPT-4's launch month, among them `GPT-4.1 mini` and `GPT-4.1 nano`, which postdate it by two years.

Coverage is 2,007/2,014 models (99.7 %) and 623/624 benchmarks (99.8 %). The two tables are **not** of comparable quality, and the near-identical coverage figures conceal this: 78 % of model dates now rest on an exact identifier, a repository timestamp, or a verified announcement, against 0.5 % of benchmark dates, 85 % of which remain on the weakest tiers. Model dates are at month precision in 97.3 % of rows; benchmark dates in 73.4 %. Any temporal analysis should therefore be run on the model axis and treat the benchmark axis as provisional ([[Appendix-Methods#L Known limitations and deviations|Appendix L.8]]). No stage of the pipeline reads `release_date` — densification, completion and factoring operate on the score matrix alone — so none of the results reported here depend on it.

Multiple scores for the same model–benchmark pair are **kept as separate rows** whenever they differ in evaluation setup, evaluator, or language, rather than being averaged at collection time; they are reconciled only at the aggregation step ([[#Aggregation]]), where the choice is explicit and reversible. Scores are normalised to a 0–100 scale, with documented exceptions for metrics that have no natural percentage interpretation (perplexity, bits-per-byte, Elo); metric direction is recorded rather than used to rescale ([[Appendix-Methods#C Normalisation rules|Appendix C]]).

Inclusion criteria are applied at both axes. A **model** is included if it is a generative language model that accepts arbitrary prompts; encoder-only classifiers, narrow task-specific systems (dedicated MT/ASR/TTS models), and undocumented community uploads are excluded, and different *setups* of one model (context length, reasoning effort, prompting scheme) are recorded as setup attributes rather than as distinct models. A **benchmark** is included if it has at least one in-scope result row; zero-result stubs are removed. We deliberately impose no relevance filter on benchmark content: a task is not excluded for appearing miscellaneous or unrelated to "intelligence", for the reason given in the introduction. Full criteria, and the review procedure applied to every borderline case, are in [[Appendix-Methods#B Inclusion and exclusion criteria|Appendix B]].

Every edit to the corpus is followed by an automated integrity pass: referential integrity in both directions, absence of orphan rows on either axis, duplicate detection on a composite evaluation-identity key, and a flag for benchmarks with implausibly few rows. Duplicate detection distinguishes *pure redundancy* (the same evaluation transcribed twice) from *conflicts* (different scores for what should be the same evaluation); conflicts are resolved by source-trust tier and recency, never silently averaged ([[Appendix-Methods#C Normalisation rules|Appendix C]]).

##### Modality scope

All analyses in this paper are performed on a **text-only** subset. The motivation is construct validity: a vision- or audio-conditioned benchmark scores a model's perceptual front-end at least as much as its language ability, so including such benchmarks mixes two different latent spaces into one covariance matrix. A pilot comparison additionally showed that removing them changes held-out predictive accuracy and factor counts materially, i.e. the distinction is not cosmetic.

The restriction is applied by an auditable classifier rather than by hand. Each benchmark's identifier and free-text metadata (category, subcategory, task type, domain, name, description) are pooled and matched against a fixed vocabulary of non-text modality terms under **whole-word** matching, which avoids the substring false positives (e.g. *vision* inside *revisionism*) that a naive contains-check produces. Because leaderboard metadata is itself unreliable, the classifier is bracketed by two manually curated, mutually disjoint override sets consulted before the pattern match: an **allow-list** of benchmarks whose metadata suggests a non-text modality but which are text-only on inspection (e.g. a music benchmark in ABC notation, a clinical-note task whose "spoken dialogue" is supplied as a transcript), and a **deny-list** of benchmarks confirmed non-text despite absent or mislabelled metadata (e.g. an entry named "Chinese Multilingual MMLU" whose rows in fact cite CMMMU, a multimodal benchmark, and were scored on vision-language models). Every override carries a written justification and the evidence used ([[Appendix-Methods#D Text-only classifier|Appendix D]]).

Classification is followed by a **cascade removal**: each non-text benchmark is dropped together with all of its result rows, and any model left with zero remaining results is dropped in turn; the integrity checks are re-run on the result. The derived copy is regenerated from the canonical tables by script and is never hand-edited, so re-running it after any corpus change or any revision to the pattern and override sets is a single deterministic operation. This step removes 121 of 624 benchmarks (2,100 result rows) and, by cascade, 345 models, leaving 503 benchmarks and 1,669 models.

##### Score-redundant benchmark splits

Public leaderboards frequently publish one benchmark as several near-identical columns — version-dated re-releases, difficulty or subset variants, per-language splits of a translated test set, or the same benchmark re-imported from a second source. Each such column enters the matrix as a nominally distinct benchmark, and a factor analysis will duly recover a "factor" that is nothing more than one benchmark's identity replicated $k$ times. Because our factor-count and general-factor estimates are exactly the quantities such duplication inflates — and because this is one of the criticisms we level at prior work — we prune these before analysis.

Pruning is evidence-driven, not name-driven. For each suspected family we compute the full pairwise Pearson correlation among its columns over the models evaluated on both, and decide per family: a family is collapsed to a single representative only when its columns are near-perfectly correlated across a non-trivial shared model set. Where correlations reveal genuine structure instead of redundancy, the family is kept intact — and in two of the eight audited families it was kept, wholly or partly, for that reason. This yields seven removals in total (version splits, dialect splits, difficulty and shot variants, per-language splits of a translated benchmark, a cross-source re-import, a corrupted composite identifier, and one partially redundant national-exam trio), for 47 benchmark identifiers and 2,216 result rows. Every decision, with its correlation statistics and the reasoning for keeping or dropping, is recorded in [[Appendix-Methods#E Score-redundancy pruning|Appendix E]].

A separate, earlier pass removed *translation duplicates* at corpus level — benchmarks that are literal translations of an original already present — while retaining multilingual benchmarks whose per-language content is independently sourced. That distinction is a content judgement made against each benchmark's source paper, not a heuristic ([[Appendix-Methods#C Normalisation rules|Appendix C]]).

After both passes, and after the canonical-metric filter and scale fix described below remove a further 1,463 rows, the text-only corpus contains **456 benchmarks, 1,618 models, and 13,251 result rows** — from a canonical archive of 624 benchmarks, 2,014 models and 19,030 result rows.

##### Aggregation

Factor analysis requires one score per model–benchmark cell, so the multiple evaluation rows retained at collection time are averaged within each (model, benchmark) pair. Averaging is deliberately placed here, after all identity cleanup, so that it never masks a duplicate that should have been removed.

Model identity is then resolved at **two granularities**, run as parallel conditions throughout the rest of the pipeline:

- **`all_standard`** — variant-level. Source-specific model identifiers are normalised (organisation prefixes stripped, release dates and checkpoint stamps removed, context-length and reasoning-effort tags dropped, parameter counts canonicalised) so that different spellings of the same released variant collapse together, while genuinely different variants (sizes, generations, named tiers) stay distinct.
- **`all_aggressive`** — family-level. Every model is collapsed to its base family token, so all sizes and generations of a family form one row.

The two strategies trade sample size against row homogeneity: the standard collapse preserves more rows but leaves each row thinly observed; the aggressive collapse produces far fewer, much better-observed rows at the cost of treating a 7B and a 405B model of one family as one entity. Neither is correct *a priori*, which is why both are carried forward. The token-level rules are given in [[Appendix-Methods#F Model-identity collapse|Appendix F]].

##### Metric selection

A benchmark is frequently reported under several metrics — 92 of ours were — and the aggregation above would average them into one cell. That is not merely untidy: on `truthfulqa` the cell would mix a "% informative" rate with a BLEU *difference* score, which can be negative. Worse, **which** metric a model received is largely determined by which leaderboard evaluated it, so the resulting column carries variance attributable to its source rather than to capability. On `truthfulqa`, 325 models are scored by accuracy (mean 46.9) and 67 by exact match (mean 27.5), with the two populations essentially disjoint; on `ifeval` the corresponding gap is 46 points. Because no model is scored under both, the offset cannot even be estimated and removed from within the data.

We therefore keep exactly **one metric per benchmark**. Metric names are first normalised for case and whitespace — without which `Accuracy` and `accuracy` count as rivals and `gsm8k` would forfeit 149 rows to a capitalisation difference — then a small curated alias map merges verified spelling variants of one measurement (e.g. `bits per byte` and `bpb`). Where a genuine choice remains, we keep the metric covering the most distinct models, so the widest comparable population survives; a per-benchmark override list handles cases where coverage alone chooses badly. This drops 1,420 result rows and 706 model-cells.

Two residual defects sit *below* the metric name and need separate treatment. `gpqa` carried one metric name covering two incompatible conventions: 447 of its 454 rows are Open LLM Leaderboard v2 **normalised** accuracy, in which the random-chance baseline is mapped to zero (range 0–24.9), while the remaining 7 are raw accuracy from papers (range 39–94). Since correlations are unchanged by a linear rescaling of an entire column, a normalised column is perfectly usable *provided every row shares the convention*; we therefore keep the 447 and drop the 7, rather than back-transforming on an assumed formula. The caveat is that 13 % of those rows sit exactly at the clamp, so the column under-discriminates among weak models. `elephant` is removed outright: its metric field holds model configurations rather than metrics, so no choice among them measures anything. (`vectara`, whose two metrics were complements, and `pwc_lambada`, which mixed accuracy with perplexity, are both resolved by the metric filter itself.)

Finally, benchmarks observed for only one model are dropped, since a single observation contributes no covariance. The resulting matrices are:

%% PROVISIONAL — Tables 2 and 3 below were read off matrices generated 2026-07-20,
which PREDATE the 2026-08-10 score-redundancy pruning. They still contain all 47
pruned columns (31 MultiLoKo language splits, LiveCodeBench v1-v6, the 4 GPQA
variants, etc.), so they describe a corpus the surrounding text says we removed.

They also predate the canonical-metric filter and the source-scale fix (see
"Metric selection" below). Recomputed with ALL of them applied (same code,
aggregation only — no R needed):

  Corpus    456 benchmarks, 1,618 models, 13,251 result rows
            (was 459 / 1,682 / 14,838 pre-filter; the further drop is the
             2026-08-31 removal of 12 non-model scraping artifacts and their
             3 orphaned benchmarks, plus two model merges)

  Table 2   all_standard    1,269 x 405   11,097 cells   2.16 %   (was 1,310 x 455 / 13,888 / 2.33 %)
            all_aggressive    337 x 381    4,478 cells   3.49 %   (was   350 x 431 /  5,358 / 3.55 %)

  Table 3 (MIN_OBS = 2, matching how the current tables were built):
            C all_standard    757 x  78   12.6 %  retained 67 %   (was 735 x  90 / 13.08 % / 62.3 %)
            C all_aggressive  225 x 101   12.5 %  retained 63 %   (was 226 x 115 / 12.58 % / 61.0 %)
            S all_standard    669 x 124   10.0 %  retained 75 %   (was 652 x 164 / 10.01 % / 77.1 %)
            S all_aggressive  124 x 293   10.0 %  retained 81 %   (was 131 x 344 / 10.01 % / 84.2 %)
            R all_standard    175 x 323   11.0 %  retained 56 %   (was 227 x 382 / 10.85 % / 67.8 %)
            R all_aggressive   96 x 353   10.6 %  retained 80 %   (was 106 x 404 / 10.50 % / 83.9 %)

Note R/all_standard: 227 -> 174 models. Removing the MultiLoKo splits changes the
peel path materially, not just the column count — worth a sentence in Results if
it survives the re-run.

Do NOT paste these in yet: the imputation and factoring results are still from the
old matrices, so swapping the tables alone would make the paper internally
inconsistent. Swap all of them together once the pipeline re-runs. %%

**Table 2.** Aggregated model × benchmark matrices, text-only corpus. *Provisional — these matrices predate the score-redundancy pruning and the canonical-metric filter, and are superseded by the recomputed values recorded above; they are retained only until the imputation and factoring results are re-run against the current corpus, so that Tables 2, 3 and the Results tables can be replaced together ([[Appendix-Methods#L Known limitations and deviations|Appendix L.3a]]).*

| Collapse strategy | Models | Benchmarks | Observed cells | Density |
|---|---:|---:|---:|---:|
| `all_standard` (variant-level) | 1,310 | 455 | 13,888 | 2.33 % |
| `all_aggressive` (family-level) | 350 | 431 | 5,358 | 3.55 % |

#### Sparsity Handling

At 2–4 % observed, neither matrix admits a classical factor analysis: the correlation matrix cannot be estimated by listwise deletion, since there are no complete cases, and pairwise-complete estimation leaves many benchmark pairs with zero or near-zero co-observation. The missingness is moreover **not at random** — a benchmark is missing for a model precisely because that model was not considered interesting enough to evaluate on it, which is itself a function of the latent ability we are trying to measure.

##### Densification

We therefore construct **densified sub-matrices**, and we construct several of them with deliberately opposed biases rather than one "best" one. All three densifiers greedily peel the matrix toward a common target density (10 %), differing only in which axis they sacrifice:

- **C (column-primary)** — repeatedly drop the least-observed *benchmark*, then any model left empty. Retains famous benchmarks with wide model coverage.
- **R (row-primary)** — repeatedly drop the least-observed *model*, then any benchmark left empty. Retains a broad benchmark set, including obscure ones, over a small set of heavily-evaluated models.
- **S (symmetric)** — at each step drop whichever marginal has the lowest *fill-rate*, privileging neither axis.

After peeling, a floor is enforced on both axes so that every retained model and benchmark has at least two observed scores; columns with zero variance among observed values are also dropped, since they carry no correlational signal. The peel targets density only. We deliberately do **not** optimise pairwise overlap or positive-definiteness, because those are the success criteria of particular downstream estimators — optimising them here would tilt the comparison in [[#Matrix completion]] toward the methods that need them. The algorithm is given in [[Appendix-Methods#G Densification algorithm|Appendix G]].

**Table 3.** Densified matrices (text-only corpus). "Retained" is the fraction of observed cells surviving the peel.

| Densifier | Strategy | Shape | Density | Retained |
|---|---|---|---:|---:|
| C | `all_standard` | 735 × 90 | 13.08 % | 62.3 % |
| C | `all_aggressive` | 226 × 115 | 12.58 % | 61.0 % |
| S | `all_standard` | 652 × 164 | 10.01 % | 77.1 % |
| S | `all_aggressive` | 131 × 344 | 10.01 % | 84.2 % |
| R | `all_standard` | 227 × 382 | 10.85 % | 67.8 % |
| R | `all_aggressive` | 106 × 404 | 10.50 % | 83.9 % |

The three densifiers span the aspect-ratio space: C yields tall matrices (models ≫ benchmarks), R yields wide ones (benchmarks ≫ models), and S sits between. Since the identifiability of a factor solution depends strongly on that ratio, disagreement between C, S, and R is itself a diagnostic, and we report it as one. The undensified matrix is additionally carried through the pipeline as a `raw` contrast level, analysed without imputation.

%% Open item: the shipped densified tables were built with a minimum-observation floor of 2,
but the constant in the current pipeline source is 3. Regenerating without pinning it changes
every shape in Table 3. Decide which value the paper commits to and regenerate if needed.
See [[Appendix-Methods#L Known limitations and deviations|Appendix L]]. %%

##### Matrix completion

Every densified matrix is still ~90 % missing, so a completion step is required before factoring. We use **three families** of method with different — in places incompatible — assumptions, so that a structure recovered by all of them is unlikely to be an artefact of any one.

**Cell-level imputation** estimates the missing entries directly: **SoftImpute** (nuclear-norm-penalised low-rank completion by iterative soft-thresholded SVD; assumes a low-rank signal plus noise, and is our primary cell-level method); **k-NN** (each missing cell filled from the $k$ most similar models — an assumption-light baseline with no low-rank, linearity, or normality assumption); **missForest** (iterative random-forest imputation, nonparametric, able to capture nonlinear dependence the low-rank methods cannot represent); and **MICE** (multiple imputation by chained equations, where factoring receives the mean of the $m$ completions while the spread across completions is the only natively probabilistic uncertainty estimate available to us).

**Correlation-level recovery** exploits the fact that factor analysis needs a correlation matrix, not a data matrix. When observations are too sparse to complete cells reliably, the correlation structure may still be recoverable — a substantially weaker requirement. This family estimates the benchmark × benchmark correlation matrix directly and never claims to know individual cells: **OneSidedMC** (Cao, Liang & Valiant, 2023) recovers the benchmark-space right singular vectors from pairwise products of co-observed scores, yielding an estimate $\hat{\Theta}$ of the benchmark covariance; **SoftImpute-corr**, **OptSpace** (Keshavan, Montanari & Oh, 2010), and **USVT** (Chatterjee, 2015) apply matrix-completion estimators to the *observed pairwise correlation matrix*, whose missing entries are exactly the benchmark pairs that were never co-observed; and two structured completions target positive-definiteness directly — a **maximum-determinant** SDP completion, which maximises $\log\det\Sigma$ subject to $\Sigma \succeq 0$ and to each observed correlation lying within a per-pair Fisher-*z* confidence band scaled to that pair's co-observation count, and a **Gaussian graphical model** MLE completion over the observed-pair graph.

Because these methods produce a correlation matrix rather than data, two shared devices make them commensurable with the cell-level family. First, the completed correlation matrix is symmetrised and projected to the nearest valid (positive definite, unit-diagonal) correlation matrix, so every principal submatrix is invertible. Second, a **covariance-matched surrogate** data matrix is synthesised whose sample covariance equals the recovered correlation matrix, on the original column scale, and that surrogate is handed to the identical factoring code used for every other method. The surrogate is explicitly *not* an estimate of the real cells; it is a device for passing a covariance structure through a data-matrix interface, and no per-model quantity computed from it is interpretable ([[Appendix-Methods#H Completion methods|Appendix H]]).

**No-imputation baselines** bound how much of any recovered structure is manufactured by imputation. The undensified matrix is also factored with no completion at all, from a pairwise-complete correlation matrix. Because that matrix has undefined entries (never co-observed pairs) and is generally indefinite, two treatments are compared: filling with the mean off-diagonal correlation, and filling with zero (treating absent co-observation as absent association). Both are then PSD-smoothed before factoring ([[Appendix-Methods#H Completion methods|Appendix H]]).

##### Evaluating the completion

All methods, in all three families, are scored on **one held-out metric**, which is what makes them comparable at all. We mask ~20 % of the observed cells using a **column-stratified** split — sampling within each benchmark, so that no benchmark is absent from the evaluation set and high-frequency benchmarks cannot monopolise it — subject to leaving at least two training observations in every column. Columns are standardised using **training-cell moments only**; rows are never standardised, because rows are models and row-standardisation would remove exactly the between-model level differences that a general factor consists of.

Held-out cells are scored in standard-deviation units against a baseline that predicts each column's *training* mean:

$$\text{RMSE} = \sqrt{\overline{(\hat z - z)^2}}, \qquad R^2 = 1 - \frac{\text{MSE}}{\text{MSE}_{\text{baseline}}}$$

so $R^2 = 0$ is no-skill and $R^2 = 1$ is exact. Both quantities are **column-balanced** by default: per-column errors are aggregated with equal weight per benchmark rather than per cell, because cell-weighting lets a handful of densely-evaluated famous benchmarks dominate the score and renders it nearly insensitive to densification. $R^2$ is computed as a *single pooled ratio* of column-balanced error to column-balanced baseline, never as an average of per-column $R^2$ values, which is unstable when a thin column has a small baseline. Methods that do not natively predict cells still report this metric, by predicting each held-out cell from the row's surviving observed cells via the conditional-Gaussian (best linear) predictor implied by their recovered correlation matrix. Definitions and the exact estimator for each family are in [[Appendix-Methods#I Held-out metric|Appendix I]].

This metric is used for hyperparameter selection within each method (rank, $k$, number of trees, number of imputations), and as a **gate**: a completed matrix whose held-out $R^2$ falls below 0.4 is not factored at all, on the grounds that a factor structure extracted from predictions no better than a column mean is not interpretable. Gating is reported alongside the results, so that a method's failure to clear it is visible rather than silently absent.

#### Factor analysis

Factoring is **held identical across every completed matrix**, so that the imputation input is the only thing that varies. We use minimum-residual exploratory factor analysis with promax (oblique) rotation on the correlation matrix of the completed or surrogate data. Rotation is oblique by design: the whole question at issue is whether the first-order domain factors $F$ correlate strongly enough to imply a higher-order $G$, and an orthogonal rotation would answer that by assumption.

The number of factors is chosen by **Horn's parallel analysis**: the observed eigenvalues of the correlation matrix are compared position-by-position against the 95th percentile of eigenvalues from random Gaussian matrices of the same shape, and the factor count is the number of positions where the observed value exceeds the random cutoff. Because the random baseline depends only on the matrix shape and not on the data, it is computed once per shape and cached; it is emphatically *not* a global cutoff, and reusing one across shapes would be invalid. The retained count is capped at 20 for tractability and further capped at the numeric rank the matrix can actually support; where the estimator fails at the chosen count it is decremented until it succeeds, and the count actually used is reported ([[Appendix-Methods#J Factor analysis details|Appendix J]]).

Because the rotation is oblique the first-order factors are correlated, and that correlation is the object of interest. We therefore decompose the hierarchy with a **Schmid–Leiman bifactor transformation**, in which every benchmark loads directly on the global general factor $G$ and on its domain factor $F$ — an estimator of exactly the decomposition $B_i = F_i + G_i + U_i$ set out in [[Appendix#Definitions]]. This yields three reported quantities: $\omega_h$, the proportion of total score variance attributable to $G$; $\omega_{total}$, the proportion attributable to all common factors; and the vector $\omega_{hs}$ of domain-factor reliabilities. The ratio $\omega_h / \omega_{total}$ reads as "of the common variance, how much is general" — the direct analogue of the $g$-saturation question in human psychometrics, and the quantity on which our central claim turns. We note that this is an exploratory Schmid–Leiman solution, not a confirmatory bifactor model with cross-loadings constrained to zero, and we interpret it accordingly; the contrast with Ilica & Gignac's (2024) confirmatory approach is deliberate.

Every cell of the design is factored **twice**: once at the parallel-analysis factor count, and once **forced to two factors**. The forced-2 run exists because the parallel-analysis count is itself unstable under this data's sparsity — a finding we report rather than hide — and fixing the count makes the $G$-related quantities comparable across cells whose data-driven counts differ, at the cost of certainly under-factoring some of them.

#### Implementation

Corpus construction, densification, and analysis scripts are implemented in Python; imputation and factor analysis in R, with the OneSidedMC estimator in Julia invoked as a subprocess and its output routed through the identical R factoring path. All results are persisted to a single relational store keyed by (method, dataset, run), so the full design is queryable rather than reconstructed from file names, and environments are pinned per language. [[Appendix-Methods#K Software environment and reproduction|Appendix K]] lists exact packages and the commands that reproduce every table above.

%% Open item: SoftImpute-corr, OptSpace, USVT, CVXR and GGM
were added most recently and have not yet been run across the full design; reported results
so far cover SoftImpute, k-NN, missForest and OneSidedMC. State per-table method coverage
in Results. See [[Appendix-Methods#L Known limitations and deviations|Appendix L]]. %%

# Analysis

#### Robustness and sensitivity analyses

The design is a cross-product of {3 densifiers + raw} × {2 collapse strategies} × {completion methods} ([[Methodology#Sparsity Handling]]), and its cells are compared along four axes:

1. **Across densifiers and collapse strategies.** Since C, S, and R embody different selection biases over the same underlying corpus, and the two collapse strategies embody different model-identity assumptions, systematic variation across them is the closest available proxy for sensitivity to the MNAR mechanism itself.
2. **Across completion methods.** Where two solutions have the same number of factors, we compute pairwise factor congruence (sign-invariant cosine similarity between loading vectors, matched after sorting by explained variance), grouped by dataset, solution type, and shape, so that only like-for-like solutions are compared ([[Appendix-Methods#J.6 Cross-method congruence|Appendix J.6]]).
3. **Across held-out splits.** An optional seed sweep refits each method across repeated random holdouts, reporting the distribution of held-out error, of the selected hyperparameter, and of $\omega_h$. We stress that this quantifies *split* variance under a fixed missingness pattern; it does **not** measure robustness to the MNAR mechanism, since every split inherits the same selection.
4. **Per-benchmark influence.** A leave-one-covariate-out analysis recomputes $\omega_h$ with each benchmark removed in turn, giving $\Delta\omega_h$ per benchmark ([[Appendix-Methods#J.5 Leave-one-covariate-out|Appendix J.5]]). Correlating $\Delta\omega_h$ with each benchmark's observation frequency tests directly whether the general factor is driven by capability structure or by evaluation volume — the concern raised by the highly unequal source composition in Table 1 of [[Methodology]], and the same common-investment bias we raise against prior work in the introduction.

Three commitments follow and constrain how we read our own results. First, **held-out accuracy is not evidence of factor validity**: a method can predict held-out cells well and still deliver an unstable rotation, so our findings rest on agreement across methods and stability across design cells, not on predictive fit. Second, **the factor count is weakly identified** on data this sparse, and we report that instability as a result rather than resolving it by fiat. Third, a factor that is dominated by a single benchmark family is a fact about the corpus, not about language models; the influence analysis above exists to make such cases visible.

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
