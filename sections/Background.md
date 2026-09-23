# Background and Related Work

## The Psychometric Paradigm

A common theoretical ground in psychometric measurement is that observable human behaviors are **causally** influenced by latent variables internal to an individual \citep{borsboom2004}, a distinction now also drawn explicitly in the design of LLM benchmarks \citep{federiakin2025}. Individuals differ in some latent factor, hence individuals differ in some observable outcomes. If there are no causal latent factors, then the covariance among observed behaviors would have no source at all, which makes little sense.

Personality and intelligence research are prime examples. \citet{allport1936} extracted all or most of the words from the English dictionary that can describe someone's personality, and had a large sample self-report how well each word describes themselves, hence measuring as much of as much of the set of all possible personalities \citep{john1988}. \citet{spearman1904} did much the same for intelligence, collecting the scores of students across school subjects and finding that their variance overwhelmingly loads to a single wide-breadth latent variable called the $g$ factor \citep{jensen2002}, which remains generally accepted \citep{johnson2004,johnson2008}. Both follow the same paradigm. Exhaustively measure observable behaviors, subject them to dimensional-reduction techniques, and draw theories from the resulting latent factor. Subsequent research decomposes the hierarchy further, into facets for personality \citep{lee2018,deyoung2007} and into specific cognitive abilities for intelligence \citep{schneider2018}.

<!-- ---------- ORIGINAL (pre-revision) TEXT, kept for reference ----------

A common theoretical ground in psychometric measurement is that observable human behaviors are **causally** influenced by latent variables internal to an individual \citep{borsboom2004}, a distinction now also drawn explicitly in the design of LLM benchmarks \citep{federiakin2025}. This assumption applies to all sorts of measurements, from arbitrary attitudinal surveys to psychological primitives like personality and intelligence.

The two is worth discussing as background. In the early days of personality research, the pioneering psychometrician \citet{allport1936} ran an ingenious idea: extract all or most of words from the English dictionary that can describe someone's personality, and then have a large sample of test takers to self-report how well the word describe themselves. The exhaustive dictionary search effectively allows researchers to measure as much of "the universe of all possible personalities". Following this, keyword self-reports are subject dimensional-reduction techniques like factor analysis, and the resulting low-dimensional latent factor is interpreted as a latent variable that causally influence the variance of all possible personality traits \citep{john1988}.

The same is true for research of human intelligence. In the early days, \citet{spearman1904} collected the scores of students in several different school subjects, like mathematics and language. He subjected this data to principal components analysis (PCA), and found that the variance of different subjects overwhelmingly load to a single principal component. Although the dataset is hardly exhaustive in modern standards, he led to the conclusion that human intelligence is at least partly founded on a single, wide-breadth latent variable called the $g$ factor \citep{jensen2002}. This idea continues to grow, but is generally accepted by modern scholarship \citep{johnson2004,johnson2008}.

Personality and intelligence research are prime examples of the psychometric paradigm. Exhaustively measure observable behaviors or reports, subject the data to dimensional-reduction techniques, and draw theories from interpreting the resulting latent factor. Subsequent research aims to decompose the causal hierarchy further. Personality research are concerned with dimensions and facets \citep{lee2018,deyoung2007}, while intelligence research with abstract but specific cognitive abilities, like quantitative knowledge, long-term retrieval, etc. \citep{schneider2018}.

It must be stressed, however, that the theories in question largely depend on a causal interpretation. Succinctly, \citet{borsboom2004} spoke against a purely operational psychometric paradigm. Individuals differ in some latent factor; hence, individuals differ in some observable outcomes. If there is no causal latent factors, then observable behavior would have emerged *ex nihilo*, which made little sense. Everything has a cause, including human behavior.

---------- END ORIGINAL ---------- -->


## Causal Assumptions in Machine Intelligence

Various LLM benchmarks are known to be intercorrelated, though the origin of this covariance is rarely stated explicitly. We argue that benchmark correlations are causally originated from latent variables, and add that existing paradigms of machine intelligence are implicitly causal. The precedence assumed of a content-free intelligence \citep{chollet2019} already implies such a relation, but model development makes it concrete. In aiming to achieve "general intelligence", developers tend to train in a *targeted* manner. Reasoning-oriented post-training, for instance, is motivated by the expectation that improvements on "pure" logical tasks will transfer to tool-calling, long-horizon agentic tasks, and coding \citep{deepseekai2025}. Such an expectation is coherent only if the targeted ability stands in a causal relation to the rest, which we state as follows.

**Definition 1.** Let $F$ be a set of latent factors and $T$ the set of performance scores over all possible tasks:
$$F = \{\, f_i \mid i \in \mathcal{I} \,\}, \qquad g \longrightarrow F \longrightarrow T, \quad F \not\longrightarrow g.$$
That is, $g$ is a first-order factor that causally affects the set of latent factors $F$, through which it in turn influences task performance. No causal path runs from $F$ back to $g$.

There is a growing assumption in the field that a subset of $T$, mostly assumed to be reasoning, mathematics, and coding, measures $g$ better than the rest. When a model is fine-tuned to perform better on such tasks, the implicitly expected transfer happens because training improves $g$ and, through it, the factors $F$:

**Definition 2.** Let $F$ be a set of latent factors and $T$ the set of performance scores over all possible tasks. Task performance $t_i$ is given by a linear predictor:
$$t_i = \lambda_gg + \lambda_1 f_1 + \dots + \lambda_n f_n, \qquad i \in \mathcal{I},$$
where the $\lambda_i$ are the task's factor loadings (standardized regression coefficients).

%%Definition 1 only describes how scores are produced and interpreted, not how the model is trained. There is also a growing assumption in the community that a subset of $T$, mostly assumed to be reasoning, mathematics, and coding, measures $g$ better than the rest.
%%
<!-- ADDED in response to the Google PAT review, point 2 and weakness 6. The
review reads Definition 1 as contradicting the transfer story that motivates it:
if T does not cause G, then training on reasoning tasks cannot raise G, so it
cannot transfer to coding.

The inference fails because it treats "training on task A" as intervening on the
score t_A. Training intervenes on the model. Whether that change lands on G, on a
group factor, or on t_A alone is an empirical question, and Definition 1 governs
none of it, since it describes the data generating process for observed scores.
Transfer is consistent with three structures (the intervention reached G, the
intervention reached a group factor A and B share, or the score on A causes the
score on B) and only the third violates Definition 1. That third one is the
mutualist picture, which the next paragraph already handles.

The second sentence names an assumption the paper had left implicit until now.
Targeted training needs both (a) that a G exists with G -> T, which Definition 1
states, and (b) that a chosen subset of T measures it best. Our results attack
them separately: the variance estimates go at (a), and Results 4.3 (the
top-loading benchmarks are not the standard reasoning ones) goes at (b). Without
(b) stated here, 4.3 lands a point the Background never set up.

(b) is deliberately stated as a measurement claim and nothing more. An earlier
draft read "measures G closely enough that improving those benchmarks counts as
improving G", which smuggles a claim about training into the sentence directly
after we say Definition 1 makes no claim about training. We never study training,
and the same review warns elsewhere against drawing causal training conclusions
from cross-sectional data, so the operative half was cut. Whether developers are
right to train on this subset does not arise here. Whether the subset measures G
best is a question about loadings, which Table 4 answers.

The concrete list (reasoning, mathematics, coding) is deliberate. It gives 4.3 a
named target and connects the definition to benchmaxxing. Cut it and "a subset of
T" is abstract enough that 4.3 no longer reads as the test of anything stated.

Layer two of this argument, that task training largely fails to raise g in humans,
belongs in Discussion 5.1 where Afrizal cites simons2016, so it is not made here. -->
%%
The causal view is also called the reflective paradigm in psychometrics \citep{borsboom2004} that asserts psychological traits are latent, but real, higher-order causal variable. This ontological position is methodologically significant, as this rules out the use of PCA over EFA (which can partition out error from systematic variance).

Nevertheless, a causal view is only one way to understand the origins of a covariance matrix. The formative paradigm, usually associated with PCA, makes no claim about the nature of the resultant components \citep{vandermaas2014}. Even so, generalizability would be impossible without a common factor to begin with, since two tasks sharing a dominant factor decompose into a similar lower-level representation \citep{caruana1997,menghi2025} that the network must discern. 
%%
%%
The mutualist paradigm \citep{borsboom2013}, which describes indicators as nodes in a graph of mutual causality, is harder to rule out, since a mutualist process reproduces a positive manifold without any common cause \citep{vandermaas2014}. However, since we observe scores only after training, our data cannot separate it from the causal view.
%%
<!-- REVISED in response to the Google PAT review, point 3. The superseded text read:

The mutualist paradigm \citep{borsboom2013}, which describes indicators as nodes
in a graph of mutual causality, fits even worse. We cannot say that coding
improves reasoning improves coding, as static network weights afford no temporal
precedence nor any mechanism for online cyclical learning.

The reviewer was right and this is worth conceding rather than defending. The
rejection conflated inference (weights static) with training (weights not
static), and mutualism in humans is a developmental theory, so pre-training and
post-training are its analogue, not inference. Rejecting it on static weights
overlooks the phase where the abilities actually form.

Conceding costs nothing. Mutualist processes generate a positive manifold and a
g-like factor from reciprocal causation with no common cause, so the two accounts
are underdetermined by cross-sectional data of the kind we have. Our finding, a
weak and incoherent factor structure, is a problem for the mutualist account as
much as for the reflective one. So the concession removes an attack surface
without weakening any claim we make later. -->


<!-- ---------- ORIGINAL (pre-revision) TEXT, kept for reference ----------

Whether or not intelligence theories are causal concerns, as \citet{borsboom2004} described for psychometrics, the need to explain the origins of indicator covariance. It is evident that various LLM benchmarks are intercorrelated. Where does this correlation originate?  We argue that benchmark correlations are causally originated from latent variables, and add that existing paradigms of machine intelligence are implicitly causal.

Theoretically, in improving the capabilities of neural networks, the notion of a "general intelligence" has permeated the field. A common sentiment \citep{chollet2019} is that intelligence is an abstract, higher-order ability that contrasts performance like memorization or domain-specific abilities. It is "content-free", analogous to human fluid intelligence, and precedes performance across the universe of all possible cognitive tasks.

By itself this precedence already implies a causal assumption, but there is a more concrete example. In aiming to achieve "general intelligence", model developers are searching for efficient and parsimonious ways to train smarter models. Crucially these developments tend to be *targeted*: improve the model's reasoning trace, increase their ability in "pure" logical tasks, and we will see models with better tool-calling, agentic long-horizon tasks, coding, etc \citep{deepseekai2025}. If you can improve the model's ability in this one or few specific, supposedly "content-free" task, you will see an improvement generalized to other tasks. This is a direct causal relation!

**Definition 1**: Let $G \in \mathbb{R}$ be a scalar, and let $T$ be the set of performance scores for all possible tasks,
$$T = \{\, t_i \mid i \in \mathcal{I} \,\}, \qquad G \longrightarrow T \;\;\text{but}\;\; T \not\longrightarrow G,$$
i.e., changes in $g$ lead to changes in $T$, but not the other way around.

Nevertheless, a causal view is only one way to understand the origins of a covariance matrix. Alternatives to the causal view above is the formative and mutualist paradigm \citep{vandermaas2014}. The formative paradigm, usually associated with PCA (because it does not try to partition out error variance), makes no claim about the nature of the resultant principal components. It is sometimes described that the indicator variables collectively "cause" variation of the principal component, instead of a latent factor causing variation among all indicators. On the other hand, the relatively new mutualist paradigm, usually associated with network analysis \citep{borsboom2013}, describe indicator variables as nodes in a graph of mutual causality. In this sense there is no single derived variable that explains or needs explaining.

Under the formative model, generalizability would be impossible if there is no common factor to begin with. In the most abstract sense, two tasks sharing a common dominant factor means that the tasks are decomposable into a similar lower-level representation \citep{caruana1997,menghi2025}. The ability of the network to discern similar features is hence the latent variable that causally affects performance on the tasks.

On the other hand the mutualist model does not make much sense regarding correlations of different abilities. A successful application of the mutualist view is in recent theories on psychological disorders \citep{borsboom2013}. In this view, symptoms of psychological disorders have a cyclical mutual causality, e.g., rumination leads to loneliness leads to rumination, and so on. In practical terms these are modeled using a graph of partial correlations between variables, i.e. network analysis \citep{borsboom2013}. It does not make much sense to say that, for example, coding improves reasoning improves coding. There are no temporal precedence within a static neural network weights or a plausible mechanism for online cyclical learning.

---------- END ORIGINAL ---------- -->


## Interpreting Structural Patterns

Understanding the patterns of benchmark correlation is theoretically relevant to cognitive science, though this relevance does not concern any one specific factor loading pattern. Under a small number of benchmarks the discovered patterns depend on which benchmarks were sampled \citep{major2011}, and under a large number the missingness pattern becomes too large to trust any single solution.  The correct approach is therefore to examine recurring and large-scale patterns.
<!-- since it is almost never productive to interpret what each individual factors denote from a 5, 7, or 20 factor solution.  -->
One such pattern is the explanatory power[^1] of a general intelligence factor. When a general factor dominates the explained variance of an EFA result, variance in an LLM's capability is predominantly caused by a latent $g$, supporting the idea that a flexible, "raw" intelligence is a substantial component of performance and that targeting it is a fruitful research program. A weak $g$ factor instead means that LLM abilities are strongly specific, so improvements require brute-force training in as much task diversity as possible, with no silver-bullet construct that parsimoniously describes "general intelligence". A second pattern is which benchmarks load highest. Under the indifference of the indicator \citep{spearman1904}, content does not determine loading, so the test is whether a factor recovered from a small battery survives a wider one.

<!-- ADDED in response to the Google PAT review, weakness 4 and Results point 3,
which object that a semantically diverse set of high-loading benchmarks is what
classical theory predicts (Spearman's indifference of the indicator) and so is
not evidence against a general factor.

The objection is correct and is conceded here rather than fought. It reaches
exactly one inference in Results 4.3, the step from "the top 20 are semantically
diverse" to "the G factor is arbitrary, incoherent, and uninterpretable". It does
not reach 4.1 (variance share) or 4.2 (content-similar benchmarks not
clustering), since indifference concerns g-loadings and 4.2 is about group
factors, which should be content-organised.

An earlier draft answered it with Jensen's complexity ordering: g-loadings are
indifferent to content but still track task complexity, so reasoning and
mathematics should top the ranking and do not. That argument was dropped. Our
loading ranking is not stable enough to carry it. The same review notes that
Table 4's top two rows have N = 2 of about 19 pipeline configurations and that
the CIs span negative values, so the ranking cannot establish that a prediction
fails.

What replaces it is survival under breadth, which rests on major2011 (cited four
lines above, hence not repeated here): small single-factor models do not
adequately represent g, so the strong general factor that prior work recovers
from 6 to 23 benchmarks is the expected behaviour of a narrow battery. Both
regimes have a dependability problem. A small dense battery is dependable in
estimation and undependable in construct coverage, and our corpus is the reverse.
Ours is addressable by triangulating across densifiers and imputers. Theirs is
not addressable at all, since the variance is not in the data.

IMPORTANT: this sentence only works if Results 4.3 changes to match. As written,
4.3 still infers incoherence from diversity, which is the inference conceded
here. Leaving 4.3 alone means the Background states the reviewer's objection and
the Results contradict it four pages later, which is worse than not adding this.

The sentence is deliberately neutral between the two routes discussed: arguing
survival-under-breadth from the existing results, or demonstrating it with a new
prior-work regime condition (peel to about 25 benchmarks at high density, show a
strong reasoning-flavoured G there, then show it dissolving as breadth
increases). It sets up either. -->


[^1]: We use the phrase "explanatory power" over "existence", as $g$ is a construct of the factor model we fit.

We read these patterns without assuming what a general factor should look like, since factor analysis is a bottom-up, theoriless approach. Authors tend to impose theories of human intelligence on artificial neural networks, as we know of no better model of intelligence than our own. However, it is problematic because these networks present an entirely different form of cognitive process than that of biological minds. Human intelligence research itself began with factor analysis \citep{spearman1904} and continues to apply bottom-up dimension reduction even though its theories have been well established for decades. Therefore, we do not assume any general factor to have a tidy definition, and so we do not discriminate between benchmarks and try to sample as much of the set of all possible tasks as we can. We argue that it is a reasonable position to expect that LLMs work in ways entirely unintuitive to the human mind, and having no priors whatsoever is the correct way to start our inquiry. Purpose-built diversity suites such as BIG-bench \citep{srivastava2022} are denser but sample one team's construction of task diversity, where our interest is in the benchmarks the field actually uses.

<!-- ADDED in response to the Google PAT review, weakness 2, which asks why the
paper does not validate against dense or diversity-designed suites.

BIG-bench is the obvious challenge to the sampling claim two sentences above,
since it is 204 tasks built expressly for task diversity and it is dense, so it
needs no imputation at all. The answer is that its diversity is authored rather
than revealed, and thin on models. Our question is whether general intelligence
as the field actually measures it has structure, which a purpose-built suite
cannot answer whatever its coverage.

The review names OpenCompass alongside BIG-bench, and it is deliberately not
cited here. OpenCompass is an evaluation platform that runs 100+ existing
datasets, not a benchmark suite, so it belongs in the same class as HELM, the
Open LLM Leaderboard, and Papers With Code, which is to say it is a source we did
not collect from rather than a method we declined to use. Citing the two together
as diversity suites would repeat the category error the review itself made.

If OpenCompass is added later, the honest placement is Appendix A as a source
family not covered. Note that it was not possible to verify whether CompassRank
publishes per-model by per-benchmark scores in an ingestible form (the homepage
is JS-rendered and search did not surface the score tables), so any limitation
written about it must not assert that the data was available to us. -->

<!-- Following suit means we do not assume any general factor to be comprehensible, and so we do not discriminate between benchmarks, sampling ARC-AGI \citep{chollet2025} and GPQA alongside fluency in a low-resource language or operating a fictional company. -->

<!-- ---------- ORIGINAL (pre-revision) TEXT, kept for reference ----------

Understanding the patterns of benchmark correlation (which is what factor analysis do) is theoretically relevant to cognitive science. First off, this relevance does not regard any one specific factor loading pattern. Under a small number of benchmarks (which is true to prior works), the discovered patterns are dependent on the specifically sampled benchmarks, i.e. not generalizable or exhaustive \citep{major2011}. Under a large number of benchmarks (which is true to this paper), the missingness pattern becomes too large and unreliable to trust and interpret any single solution. Thus, the correct approach to interpret this kind of data is by examining recurring and large-scale patterns. It is almost never productive to interpret what each individual factors denote from a 5, 7, or 20 factor solution, nor are those solutions trustworthy to be consistent.

One insight we can gain is the explanatory power[^1] of a general intelligence factor, especially relative to the average or individual factors. When a general factor dominates the explained variance of an EFA result, we can say that variance in an LLM's capability is dominantly caused by variation of a latent $g$ factor. Findings of this manner will support the idea that a flexible, "raw" intelligence is a substantial component of an LLM's performance, and that the research program in targeting this specific factor is a potentially fruitful endeavor. On the other hand, a weak $g$ factor means that LLM abilities are strongly specific, be it specific to task clusters or specific tasks. In other words, improvements in LLM abilities require a brute-force training in as much task diversity as possible, and there is no single silver-bullet construct that parsimoniously describes "general intelligence".

[^1]: We use the phrase "explanatory power" over "existence", as $g$ is modeled rather than discovered

The second reason is that factor analysis is a bottom-up, theoriless approach. An issue with pre-existing theories is that authors tend to impose theories of human intelligence on artificial neural networks. The motivation is understandable, as we know of no better model of intelligence than our own, and it makes for a good starting point. But this is fundamentally problematic because artificial neural networks present us with an entirely different form of cognitive process than that of biological minds. Imposing our understanding of our own mind to an LLM, while possibly productive, limits the extent to which we can understand this entirely novel form of cognition. It is also a little ironic, as theories of human intelligence begins with factor analysis \citep{spearman1904}, and modern day psychometric research continues to apply bottom-up dimension reduction even though the theories are well-established for decades. If we truly want to take inspiration from human intelligence research, then we should follow suit and start with a bottom-up, exploratory approach without overfitting human theories on LLMs.

One crucial consequence in taking this theoriless approach is that we do not assume that any general factor is comprehensible. For one, a latent $g$ factor that substantially causes variation of benchmark scores can be entirely arbitrary and idiosyncratic. We do not assume, except in counterfactual terms, that a benchmark like ARC-AGI \citep{chollet2025} or GPQA is more representative of a global latent factor of intelligence than something like fluency in a low-resource language or operating a fictional company. Relatedly, even human intelligence research have found innocuous correlations between the $g$ factor and trivial cognitive observations \citep{kranzler1989}. Consequently, we do not discriminate in which benchmarks matter and which doesn't. Our aim is to sample as much of the set of all possible tasks, which in practical terms include very popular and very obscure benchmarks. While this may appear extreme, we argue that it is a reasonable position to expect that LLMs work in ways entirely unintuitive to the human mind, and having no priors whatsoever is the correct way to start our inquiry.

---------- END ORIGINAL ---------- -->


## Related Work

Prior work applying factor analysis to benchmark scores is smaller in scale, and mostly confirmatory. \citet{ilicagignac2024} applied confirmatory factor analysis to hundreds of models and found that their performance fits a human-informed causal structure, which repeats the mistake of fitting an existing theory instead of understanding model intelligence from the bottom-up. A large proportion of their benchmarks are also variants of MMLU \citep{hendrycks2021}, posing the risk of common-method bias polluting the model fit. \citet{federiakin2025} likewise fits a single-factor CFA to the HuggingFace Open LLM Leaderboard. A confirmatory fit tests the one structure its authors specify in advance, and says nothing about the structures they did not fit. \citet{hardy2026} fits CFA and generalizability theory to over 4,000 models on the same leaderboard, and finds local dependence among its items, which is the common-method bias we raise above.

<!-- REVISED in response to the Google PAT review, point 1. The superseded clause read:

... and imposing that structure by construction forecloses the question of whether
the data actually supports one, which only EFA can answer.

"Forecloses" was indefensible. Fit indices are exactly a test of whether the data
support the hypothesised structure, and a poor fit rejects it. The reviewer's own
suggested citation (Hardy et al. 2026, ICML) makes the point by example: CFA on
the Open LLM Leaderboard rejects the assumed structure and finds local dependence
among items. Leaving the sentence as it was would have read as not knowing what
CFA does.

The real objection survives and is now stated properly. CFA tests one structure
against alternatives that were never written down, so it can reject but cannot
discover. That is a claim about the hypothesis space, not about testability.

The \citet{ilicagignac2024} sentence above is left alone. Its critique is
theory-importing, not testability, and that one is correct as written. -->


\citet{krakauer2026} instead applies PCA and finds a first principal component declining from 90% of variance to 64% by 2024, interpreted as a "rotation" in the $g$ factor as models outsource reasoning to external tools. PCA, as we discuss in the Methodology, does not partition out systematic from error variance and so cannot be trusted to isolate a genuine $g$ factor from noise. Only two studies run EFA. \citet{burnell2023} found three major factors, but did not do higher-order factor analysis on the resulting loadings, so cannot say to what extent those factors are influenced by a presumable g-factor. \citet{haznitrama2026} report a unified general factor before showing that a neuropsychologically-grounded battery reveals cognitive gaps that it otherwise masks. Narrower still is \citet{holm2024}, where a single factor explains 95% of variance across just 8 scenarios in one language. \citet{kearns2026} adds that latent factor models fit to LLM benchmark scores can conflate the extracted capability factor with model scale unless scaling relationships are explicitly modeled. Item response theory, recently applied to LLM benchmarks \citep{polo2024,zhou2025}, and full-information maximum likelihood both handle incomplete data natively. IRT requires per-item responses, which published scores do not report, and FIML requires every benchmark pair to share observed models, which many pairs at our sparsity do not.

<!-- ADDED in response to the Google PAT review, point 4 and weakness 1, which
ask why the paper never mentions IRT or FIML.

Kept to two sentences at the user's direction. The fuller argument, if a rebuttal
needs it:

IRT models P(correct | model ability, item difficulty) over individual test
questions. Our unit of observation is a published aggregate score. Obtaining
item-level responses for 1,618 models x 456 benchmarks means re-running every
evaluation ourselves, which is the one thing this study's design exists to avoid.
Note the scale inversion in the cited work: Zhou et al. get item-level fidelity
across 12 models and 11 benchmarks. We trade that fidelity for three orders of
magnitude more models and two more benchmarks.

FIML is the stronger objection of the two, since it works on continuous aggregate
data. It fails on identification instead. At 1.8 % density a large share of
benchmark pairs have zero co-observed models, so those covariance elements are
not identified by the observed-data likelihood at all. Densification is what buys
identification, and FIML would not.

Placed at the end of Related Work because that is where the review looked for it
("the absence of IRT in the related work"), and because it keeps 2.3 untouched
ahead of the indifference-of-the-indicator pass. -->


<!-- ---------- ORIGINAL (pre-revision) TEXT, kept for reference ----------

Prior work has tried applying factor analysis to benchmark scores, but always at a much smaller scale. \citet{ilicagignac2024} applied factor analysis to hundreds of models and found that the models' performance fits a human-informed causal structure. However, their use of confirmatory factor analysis repeats the mistake of fitting a human-informed theory rather than understanding model intelligence from the bottom-up. Also, a large proportion of their benchmarks are simply variants of the popular MMLU benchmark \citep{hendrycks2021}, posing the risk of common-method bias polluting the model fit. \citet{burnell2023} applied EFA to model benchmark scores and found that LLM abilities are hierarchically structured under three major factors. However, they did not do higher-order factor analysis, where EFA is run on the resulting factor loadings, so cannot say to what extent latent factors are influenced by a presumable g-factor.

Three more recent studies extend this line of work at similarly small scale. \citet{krakauer2026} applies PCA to 39 models and 14 benchmarks spanning 2019-2025 and finds a strong positive manifold, with a first principal component explaining as much as 90% of variance early on but declining to 64% by 2024 — interpreted as a "rotation" in the $g$ factor as models increasingly outsource reasoning to external tools. Similar to \citet{ilicagignac2024}, this work relies on PCA rather than EFA, which, as we discuss in the Methodology, does not partition out systematic from error variance and so cannot be trusted to isolate a genuine $g$ factor from noise. \citet{haznitrama2026} run factor analysis across 156 models and 10 benchmarks and likewise report a unified general factor, before showing that a neuropsychologically-grounded benchmark battery reveals cognitive gaps that this general factor otherwise masks. \citet{federiakin2025} fits a single-factor confirmatory factor analysis (CFA) to the HuggingFace Open LLM Leaderboard to re-rank models by a psychometrically-derived score. However, similar to \citet{ilicagignac2024}, imposing a single-factor structure by construction forecloses the question of whether the data actually supports one, which only EFA can answer.

A common weakness of all five papers, though, is the relatively few number of benchmarks or variables derived thereof: \citet{ilicagignac2024} fit a model with 20 variables, \citet{burnell2023} uses 23, \citet{krakauer2026} only 14, and \citet{haznitrama2026} only 10. \citet{federiakin2025} is narrower still, fitting to the handful of aggregate tasks on a single leaderboard. Most of these benchmarks measure "smartness" for a lack of better term, like mathematics, academic knowledge, and common-sense reasoning (an even more extreme case is \citep{holm2024}, where a single factor explains 95% of variance across just 8 scenarios in one language). A related methodological concern, raised by \citet{kearns2026}, is that latent factor models fit to LLM benchmark scores can conflate the extracted capability factor with model scale unless scaling relationships are explicitly modeled.

---------- END ORIGINAL ---------- -->
