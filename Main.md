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

The field of artificial intelligence is rife with theories and conceptualization about what intelligence "is" \citep{chollet2019,morris2023,waterhouse2023}. With neural network specifically, a longstanding issue is how the models are "overfitting" their training set, and thus their performance in various tasks ("intelligence", so to say) lack powerful generalizability that cognitive entities like humans have. Thus, the development of advanced intelligent systems rely on a working notion of intelligence as adaptive and effective across diverse tasks: a singular notion of "generalizability."

There is, in this endeavor, an implicit and subtle assumption: it is that in neural networks, much like humans, cognitive abilities are structured according to a causal hierarchy. The word causal is important here. A popular notion of general intelligence in the field is the concept "fluid intelligence" borrowed from psychometric research, defined loosely as the ability to perform well in any tasks regardless of the content (i.e., a "domain-free" cognitive capacity). By definition this construct holds a causal relation, where an increase of fluid intelligence leads to an increase in the mastery of every other cognitive task. In other words, domain-general ability *precedes and builds* domain-specific abilities.

## Hierarchical Causal Structure of Psychometric Measurements

A common theoretical ground in psychometric measurement is that observable human behaviors are **causally** influenced by latent variables internal to an individual \citep{borsboom2004}, a distinction now also drawn explicitly in the design of LLM benchmarks \citep{federiakin2025}. This assumption applies to all sorts of measurements, from arbitrary attitudinal surveys to psychological primitives like personality and intelligence.

The two is worth discussing as background. In the early days of personality research, the pioneering psychometrician \citet{allport1936} ran an ingenious idea: extract all or most of words from the English dictionary that can describe someone's personality, and then have a large sample of test takers to self-report how well the word describe themselves. The exhaustive dictionary search effectively allows researchers to measure as much of "the universe of all possible personalities". Following this, keyword self-reports are subject dimensional-reduction techniques like factor analysis, and the resulting low-dimensional latent factor is interpreted as a latent variable that causally influence the variance of all possible personality traits \citep{john1988}.

The same is true for research of human intelligence. In the early days, \citet{spearman1904} collected the scores of students in several different school subjects, like mathematics and language. He subjected this data to principal components analysis (PCA), and found that the variance of different subjects overwhelmingly load to a single principal component. Although the dataset is hardly exhaustive in modern standards, he led to the conclusion that human intelligence is at least partly founded on a single, wide-breadth latent variable called the $G$ factor \citep{jensen2002}. This idea continues to grow, but is generally accepted by modern scholarship \citep{johnson2004,johnson2008}.

Personality and intelligence research are prime examples of the psychometric paradigm. Exhaustively measure observable behaviors or reports, subject the data to dimensional-reduction techniques, and draw theories from interpreting the resulting latent factor. Subsequent research aims to decompose the causal hierarchy further. Personality research are concerned with dimensions and facets \citep{lee2018,deyoung2007}, while intelligence research with abstract but specific cognitive abilities, like quantitative knowledge, long-term retrieval, etc. \citep{schneider2018}.

It must be stressed, however, that the theories in question largely depend on a causal interpretation. Succinctly, \citet{borsboom2004} spoke against a purely operational psychometric paradigm. Individuals differ in some latent factor; hence, individuals differ in some observable outcomes. If there is no causal latent factors, then observable behavior would have emerged *ex nihilo*, which made little sense. Everything has a cause, including human behavior.

## Machine Intelligence Theories Are Implicitly Causal

Whether or not intelligence theories are causal concerns, as \citet{borsboom2004} described for psychometrics, the need to explain the origins of indicator covariance. It is evident that various LLM benchmarks are intercorrelated. Where does this correlation originate?  We argue that benchmark correlations are causally originated from latent variables, and add that existing paradigms of machine intelligence are implicitly causal.

Theoretically, in improving the capabilities of neural networks, the notion of a "general intelligence" has permeated the field. A common sentiment \citep{chollet2019} is that intelligence is an abstract, higher-order ability that contrasts performance like memorization or domain-specific abilities. It is "content-free", analogous to human fluid intelligence, and precedes performance across the universe of all possible cognitive tasks.

By itself this precedence already implies a causal assumption, but there is a more concrete example. In aiming to achieve "general intelligence", model developers are searching for efficient and parsimonious ways to train smarter models. Crucially these developments tend to be *targeted*: improve the model's reasoning trace, increase their ability in "pure" logical tasks, and we will see models with better tool-calling, agentic long-horizon tasks, coding, etc \citep{deepseekai2025}. If you can improve the model's ability in this one or few specific, supposedly "content-free" task, you will see an improvement generalized to other tasks. This is a direct causal relation!

**Definition 1**: Let $G \in \mathbb{R}$ be a scalar, and let $T$ be the set of performance scores for all possible tasks,
$$T = \{\, t_i \mid i \in \mathcal{I} \,\}, \qquad G \longrightarrow T \;\;\text{but}\;\; T \not\longrightarrow G,$$
i.e., changes in $G$ lead to changes in $T$, but not the other way around.

Nevertheless, a causal view is only one way to understand the origins of a covariance matrix. Alternatives to the causal view above is the formative and mutualist paradigm \citep{vandermaas2014}. The formative paradigm, usually associated with PCA (because it does not try to partition out error variance), makes no claim about the nature of the resultant principal components. It is sometimes described that the indicator variables collectively "cause" variation of the principal component, instead of a latent factor causing variation among all indicators. On the other hand, the relatively new mutualist paradigm, usually associated with network analysis \citep{borsboom2013}, describe indicator variables as nodes in a graph of mutual causality. In this sense there is no single derived variable that explains or needs explaining.

Under the formative model, generalizability would be impossible if there is no common factor to begin with. In the most abstract sense, two tasks sharing a common dominant factor means that the tasks are decomposable into a similar lower-level representation \citep{caruana1997,menghi2025}. The ability of the network to discern similar features is hence the latent variable that causally affects performance on the tasks.

On the other hand the mutualist model does not make much sense regarding correlations of different abilities. A successful application of the mutualist view is in recent theories on psychological disorders \citep{borsboom2013}. In this view, symptoms of psychological disorders have a cyclical mutual causality, e.g., rumination leads to loneliness leads to rumination, and so on. In practical terms these are modeled using a graph of partial correlations between variables, i.e. network analysis \citep{borsboom2013}. It does not make much sense to say that, for example, coding improves reasoning improves coding. There are no temporal precedence within a static neural network weights or a plausible mechanism for online cyclical learning. 

## Why Study Machine Intelligence Structure?

Understanding the patterns of benchmark correlation (which is what factor analysis do) is theoretically relevant to cognitive science. First off, this relevance does not regard any one specific factor loading pattern. Under a small number of benchmarks (which is true to prior works), the discovered patterns are dependent on the specifically sampled benchmarks, i.e. not generalizable or exhaustive \citep{major2011}. Under a large number of benchmarks (which is true to this paper), the missingness pattern becomes too large and unreliable to trust and interpret any single solution. Thus, the correct approach to interpret this kind of data is by examining recurring and large-scale patterns. It is almost never productive to interpret what each individual factors denote from a 5, 7, or 20 factor solution, nor are those solutions trustworthy to be consistent.

One insight we can gain is the explanatory power[^1] of a general intelligence factor, especially relative to the average or individual factors. When a general factor dominates the explained variance of an EFA result, we can say that variance in an LLM's capability is dominantly caused by variation of a latent $G$ factor. Findings of this manner will support the idea that a flexible, "raw" intelligence is a substantial component of an LLM's performance, and that the research program in targeting this specific factor is a potentially fruitful endeavor. On the other hand, a weak $G$ factor means that LLM abilities are strongly specific, be it specific to task clusters or specific tasks. In other words, improvements in LLM abilities require a brute-force training in as much task diversity as possible, and there is no single silver-bullet construct that parsimoniously describes "general intelligence".

[^1]We use the phrase "explanatory power" over "existence", as $G$ is modeled rather than discovered

The second reason is that factor analysis is a bottom-up, theoriless approach. An issue with pre-existing theories is that authors tend to impose theories of human intelligence on artificial neural networks. The motivation is understandable, as we know of no better model of intelligence than our own, and it makes for a good starting point. But this is fundamentally problematic because artificial neural networks present us with an entirely different form of cognitive process than that of biological minds. Imposing our understanding of our own mind to an LLM, while possibly productive, limits the extent to which we can understand this entirely novel form of cognition. It is also a little ironic, as theories of human intelligence begins with factor analysis \citep{spearman1904}, and modern day psychometric research continues to apply bottom-up dimension reduction even though the theories are well-established for decades. If we truly want to take inspiration from human intelligence research, then we should follow suit and start with a bottom-up, exploratory approach without overfitting human theories on LLMs.

One crucial consequence in taking this theoriless approach is that we do not assume that any general factor is comprehensible. For one, a latent $G$ factor that substantially causes variation of benchmark scores can be entirely arbitrary and idiosyncratic. We do not assume, except in counterfactual terms, that a benchmark like ARC-AGI \citep{chollet2025} or GPQA is more representative of a global latent factor of intelligence than something like fluency in a low-resource language or operating a fictional company. Relatedly, even human intelligence research have found innocuous correlations between the $G$ factor and trivial cognitive observations \citep{kranzler1989}. Consequently, we do not discriminate in which benchmarks matter and which doesn't. Our aim is to sample as much of the set of all possible tasks, which in practical terms include very popular and very obscure benchmarks. While this may appear extreme, we argue that it is a reasonable position to expect that LLMs work in ways entirely unintuitive to the human mind, and having no priors whatsoever is the correct way to start our inquiry.

## Prior works and their caveats

Prior work has tried applying factor analysis to benchmark scores. \citet{ilicagignac2024} have applied factor analysis to hundreds of models and found that the models' performance fits a human-informed causal structure. However, the study is flawed by their use of confirmatory factor analysis, which is a hypothesis-testing procedure, and follows the mistake of fitting a human-informed theory rather than understanding model intelligence from the bottom-up. It is also severely flawed in that a large proportion of their benchmarks are simply variants of the popular MMLU benchmark \citep{hendrycks2021}, heightens the risk of common-method bias polluting the model fit.

Another relevant work is \citet{burnell2023}, which correctly applied EFA to model benchmark scores. They found that LLM abilities are hierarchically structured under three major factors. However, they did not do higher-order factor analysis, where EFA is run on the resulting factor loadings, thus allowing us to understand to what extent are latent factors influenced by a presumable g-factor.

A third relevant work is \citet{krakauer2026}, which applies PCA to 39 models and 14 benchmarks spanning 2019-2025 and finds a strong positive manifold, with a first principal component explaining as much as 90% of variance early on but declining to 64% by 2024. This is interpreted as a "rotation" in the $G$ factor as models increasingly outsource reasoning to external tools. Like \citet{ilicagignac2024}, this work relies on PCA rather than EFA, which, as we discuss in the Methodology, does not partition out systematic from error variance and so cannot be trusted to isolate a genuine $G$ factor from noise; a declining PC1 is equally consistent with the benchmark composition simply becoming less homogeneous over time. A fourth is \citet{haznitrama2026}, who run factor analysis across 156 models and 10 benchmarks and likewise report a unified general factor, before showing that a neuropsychologically-grounded benchmark battery reveals cognitive gaps that this general factor otherwise masks. A fifth, \citet{federiakin2025}, fits a single-factor confirmatory factor analysis (CFA) to the HuggingFace Open LLM Leaderboard to re-rank models by a psychometrically-derived score; like \citet{ilicagignac2024}, imposing a single-factor structure by construction forecloses the question of whether the data actually supports one, which only EFA can answer.

A common weakness of these papers, though, are the relatively few number of benchmarks or variables derived thereof. \citet{ilicagignac2024} fit a model with 20 variables, \citet{burnell2023} uses 23 variables, \citet{krakauer2026} uses only 14, and \citet{haznitrama2026} uses only 10; \citet{federiakin2025} is narrower still, fitting to the handful of aggregate tasks on a single leaderboard. Most of these benchmarks are popular benchmarks measuring "smartness" for a lack of better term, like mathematics, academic knowledge, and common-sense reasoning (an even more extreme case is \citep{holm2024}, where a single factor explains 95% of variance across just 8 scenarios in one language).

A related methodological concern is raised by \citet{kearns2026}, who show that latent factor models fit to LLM benchmark scores can conflate the extracted capability factor with model scale unless scaling relationships are explicitly modeled.

## The present study

Within the context of prior work, our study presents an unprecedentedly large factor analysis of benchmark scores. The collection comprises 1,618 models and 456 benchmarks over 13,251 evaluation scores. Crucially, our pool of benchmarks covers a highly diverse set of tasks, including those quite outside of the mainstream. Covering only few popular benchmarks like prior work does is problematic. First, given their popularity, these benchmarks may well be correlated due to what we call a common-investment bias: there is a high chance their correlations substantially polluted by the fact that organizations expend more efforts to perform well in said benchmarks. Second, there should be no discrimination as to what tasks are important and which aren't: whether a task appears miscellaneous is also no reason to exclude them. A useful analogy is that reaction time in humans is correlated to intelligence \citep{kranzler1989}: no matter how seemingly unimportant a task may be, it may provide useful information that is entirely unintuitive to our subjective understanding.


# Methodology

In this study we investigate the low-dimensional structure of model benchmark scores, which comprise of distinct but correlated latent factors that each dominantly affects different clusters of benchmarks, and a $G$ factor that accounts for the variances of all benchmarks. To this end we collect a raw data matrix with size $1,618 \times 456$. One challenge in analyzing this dataset is that the raw matrix is supersparse (~1.8% density). Both benchmarks and models differ in popularity, so famous benchmarks and models have considerably higher observations. To handle this issue, we implement multiple peeling strategy to drop columns and/or rows to improve the matrix density, and applied several missing data imputation strategy. Given the dataset's difficult conditions we prefer a collection or aggregate of results from different densification and imputation methods (wherein each introduce their own biases and assumptions), with the goal to triangulate each of their results to find a common characteristic.

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

The collected datasets contain same models evaluated under different conditions, e.g., chain-of-thought vs. no chain-of-thought. Since including the same models would lead to a violation of independence of distribution, multiple evaluation rows retained at collection time are averaged within each (model, benchmark) pair. Averaging is done after identity cleanup, so that it never masks a duplicate that should have been removed. Model identity is then resolved at two granularities, run as parallel conditions throughout the rest of the pipeline:

- **`all_standard`** — variant-level. Source-specific model identifiers are normalised (organisation prefixes stripped, release dates and checkpoint stamps removed, context-length and reasoning-effort tags dropped, parameter counts canonicalised) so that different spellings of the same released variant collapse together, while genuinely different variants (sizes, generations, named tiers) stay distinct.
- **`all_aggressive`** — family-level. Every model is collapsed to its base family token, so all sizes and generations of a family form one row.

The two strategies trade sample size against row homogeneity: the standard collapse preserves more rows but leaves each row thinly observed; the aggressive collapse produces far fewer, much better-observed rows at the cost of treating a 7B and a 405B model of one family as one entity. Neither is correct a priori, which is why both are carried forward. The token-level rules are given in [[Appendix-Methods#F Model-identity collapse|Appendix F]].

### Metric selection

About 92 of our collected benchmarks were reported under several metrics. As different metrics are not comparable, we kept exactly one metric per benchmark. Given a choice between several metrics, we keep the metric covering the most distinct models, so the widest comparable population survives; a per-benchmark override list handles cases where coverage alone chooses badly. This drops 1,420 result rows and 706 model-cells. Finally, benchmarks observed for only one model are dropped.

### Densification

At 2–4 % observed, the raw data is ineligible for virtually any data analysis. We therefore improve the dataset density by applying several additional steps that discard missing data, described below. All three densifiers greedily peel the matrix toward a common target density (10 %), differing only in which axis they sacrifice:

- **C (column-primary)** — repeatedly drop the least-observed benchmark, then any model left empty. Retains famous benchmarks with wide model coverage.
- **R (row-primary)** — repeatedly drop the least-observed model, then any benchmark left empty. Retains a broad benchmark set, including obscure ones, over a small set of heavily-evaluated models. This densifier leads to having more observations than variables. 
- **S (symmetric)** — at each step drop whichever marginal has the lowest fill-rate, privileging neither axis.

After peeling, a floor is enforced on both axes so that every retained model and benchmark has at least 3 observed scores. columns with zero variance among observed values are also dropped, since they carry no correlational signal. The algorithm is given in [[Appendix-Methods#G Densification algorithm|Appendix G]]. Note also that we select a still relatively low target density at 10%, so that we can include as much different benchmarks as possible.

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


### Matrix completion

As mentioned before, the densifier leaves only around 10% density for each dataset. This number is still far from being usable for any analysis. Moreover, the dataset exhibits a missing not at random (MNAR) pattern \citep{rubin1976}. Popular models are more likely to be benchmarked, and popular benchmarks are more likely to be administered. Our solution to this problem is to instead run multiple different imputations, comparing the performance of each, and aggregating the results. The core idea is, since the distribution of the missing data is impossible to recover, it is better to triangulate results from different densifiers and different imputers, each with their own biases and assumptions, and recover common patterns as the kernel of truth. There are 2 families of imputers we use: full dataset imputers, and correlation/reduced matrix imputers.

%%TODO: shorten this section into a table%%
Full dataset imputers estimates the missing entries of the dataset directly: **SoftImpute** \citep{mazumder2010} (nuclear-norm-penalised low-rank completion by iterative soft-thresholded SVD; assumes a low-rank signal plus noise, and is our primary cell-level method); **k-NN** (each missing cell filled from the $k$ most similar models — an assumption-light baseline with no low-rank, linearity, or normality assumption); **missForest** \citep{stekhoven2012} (iterative random-forest imputation, nonparametric, able to capture nonlinear dependence the low-rank methods cannot represent).

**Correlation-level recovery** exploits the fact that factor analysis needs a correlation matrix, not a data matrix. When observations are too sparse to complete cells reliably, the correlation structure may still be recoverable — a substantially weaker requirement. This family estimates the benchmark × benchmark correlation matrix directly and never claims to know individual cells: **OneSidedMC** \citep{cao2023} recovers the benchmark-space right singular vectors from pairwise products of co-observed scores, yielding an estimate $\hat{\Theta}$ of the benchmark covariance; **SoftImpute-corr**, **OptSpace** \citep{keshavan2010}, and **USVT** \citep{chatterjee2015} apply matrix-completion estimators to the *observed pairwise correlation matrix*, whose missing entries are exactly the benchmark pairs that were never co-observed; and two structured completions target positive-definiteness directly — a **maximum-determinant** SDP completion, which maximises $\log\det\Sigma$ subject to $\Sigma \succeq 0$ and to each observed correlation lying within a per-pair Fisher-*z* confidence band scaled to that pair's co-observation count, and a **Gaussian graphical model** MLE completion over the observed-pair graph.


### Evaluating the completion
Given the challenging nature of our dataset's missingness pattern, we need a way to measure the quality of our data imputation. As such, at each stage of the imputation, we masked ~20% of the observed cells as an evaluation set. This mask is column-stratified, such that each benchmark is masked at least once, leaving at least two training observations in every column. Without this column stratification, our evaluation score is inflated by the fact that high-observation benchmarks (which are the least difficult to impute) are sampled more often than low-observation ones. Columns are standardised using training-cell moments only.

Held-out cells are scored in standard-deviation units against a baseline that predicts each column's training mean:

$$\text{RMSE} = \sqrt{\overline{(\hat z - z)^2}}, \qquad R^2 = 1 - \frac{\text{MSE}}{\text{MSE}_{\text{baseline}}}$$

Here, $\text{RMSE}$ provides a single scalar for prediction error. However, it is difficult to interpret $\text{RMSE}$s at face value as to how well the imputer performs. As such, we use the $\text{R}^2$ as a relative measure to compare how well the imputer predicts held-out values compared to the the expected value of the training cells. Intuitively, by the $\text{MSE}$ division, the $\text{R}^2$ measures the proportion of errors reduced from using a model relative to the baseline. Notably, both measures are column-balanced, so the final $\text{RMSE}$ is an average of column-wise $\text{RMSE}$, and the $\text{MSE}$ used in $\text{RMSE}^2$ are also averages of column-wise $\text{MSE}$s.

This metric is used for hyperparameter selection within each method (rank, $k$, number of trees, etc.), and as a gate for factor analysis. Imputation results whose held-out $\text{R}^2$ falls below 0.4 is not factored at all, as it indicates that data-fill is not trustworthy.

## Factor analysis

We dedicate this section to be a little longer, as we use methodologies that are standard in psychometric research, but critically lacking in LLM intelligence research \citep{ilicagignac2024,burnell2023,ye2025}. There are 3 issues common in LLM intelligence research: 1. The use of principal components analysis (PCA) over exploratory factor analysis (EFA), 2. Not rotating factor solutions, 3. Not using bifactor transformation and reporting $\omega$ coefficients.

First, the use of EFA over PCA is informed by the causal effect of the latent variables over the benchmark scores. As described in the introduction, an abstract, "raw" intelligence is assumed, by existing literature, to precedes performance in domain-specific skills \citep{schneider2018}, correlations between benchmarks are directly and causally influenced by variance of the lower-dimensional latent variables. Crucially, direct eigendecomposition does not try to exclude or partition any variance, so principal components captures both systematic and error/random variance. The same is not true for EFA's multi-step algorithm. Psychometricians would call this this distinction between PCA and EFA to be formative vs. causal \citep{vandermaas2014}.

Another important step, also standard in psychometrics but rarely done in ML, is the rotation of the resulting loading matrix. The matrix results of PCA and EFA are rotation-invariant, which tends to group all variances in the first latent factor. However, this means that the result of factor analysis tends to be difficult to interpret. Factor rotation means to find an alternative solution that rearranges loadings to be more cleanly partitioned (a "simple structure"; \citealp{gorsuch1983}%% could not confirm "Gorsuch, 2004" -- swap for \citealp{gorsuch2015} (Routledge "Classic Edition" reprint) if that's the intended source %%) between all of the extracted factors. Factor rotation can be thought of as improving the "cluster" of the variables to group closer to their cluster centroid. Another advantage of factor rotation is that it allows the loadings vectors to be positively correlated, while bare eigendecomposition yields orthogonal factors.

The last important step, particularly with respect to the inquiries about a $G$ factor, is the use of Schmid-Leiman \citep{schmidleiman1957} bifactor transformation. In essence, this technique ran factor analysis hierarchically, yielding one additional factor that causally affects the rest of the extracted factor. Yet again, this technique is quite well-used in psychometric research explicitly about a $G$ factor of intelligence \citep{johnson2004,johnson2008} that have been missing in LLM research. 

This yields three reported quantities \citep{revelle2009}: $\omega_h$, the proportion of total score variance attributable to $G$; $\omega_{total}$, the proportion attributable to all common factors; and the vector $\omega_{hs}$ of domain-factor reliabilities. The ratio $\omega_h / \omega_{total}$ reads as "of the common variance, how much is general" — the direct analogue of the $g$-saturation question in human psychometrics

One additional step we do is parallel analysis \citep{horn1965} to select the number of factor analysis dimensions. It uses simulated random values to determine eigenvalue cutoffs to discard low-variance factors. To keep wall-clock time tractable we limit the number of factors extracted to 20. 

We ran 2 factor analysis for each dataset: once using the parallel analysis-derived number of factors, and once by forcing the number of factors to 2 (not including the bifactor $G$ factor). The forced-2 run exists because the parallel-analysis count is itself unstable under different imputation algorithms.

# Results

# Discussion

## The g-factor is only partially coherent
%% 
Note: many items have .99 loadings to the g-factor, mostly low-observations data.
If this is not
%%
## Bottom-up theories of LLM intelligence

Importantly what we find is that, unlike theories of human psychology \citep{schneider2018} where intelligence are explicitly assumed to possess higher-order structure, with fluid intelligence as a higher-order factor that have theoretical causal effects \citep{vandermaas2014} to the performance of other cognitive abilities, fluid intelligence, wikipedia memorization, agentic tool use, are more likely to be horizontal with respect to each other with no clear higher-order structure. Ablation studies provide experimental evidence to this point: ...

This is also not to say that LLMs are not intelligent (in our private view, they very clearly are). But it is important to realize that just as humans and ants are differentially but equally "cognitive", LLMs are intelligent in a considerably different way to humans. This means that a theory of intelligence requires a blank-slate, bottom-up empirical approach without overfitting theories of human intelligence into systems that possess significant architectural and functional divergence from humans.

## Mechanisms for a possible g-factor

