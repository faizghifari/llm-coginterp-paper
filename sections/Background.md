# Background and Related Work

## The Psychometric Paradigm

A common theoretical ground in psychometric measurement is that observable human behaviors are **causally** influenced by latent variables internal to an individual \citep{borsboom2003,borsboom2004}, and \citet{federiakin2025} applies the same distinction to the design of LLM benchmarks. Individuals differ in some latent factor, hence individuals differ in some observable outcomes. If there are no causal latent factors, then the covariance among observed behaviors would have no source at all, which makes little sense.

Personality and intelligence research are prime examples. \citet{allport1936} extracted all or most of the words from the English dictionary that can describe someone's personality, and had a large sample self-report how well each word describes themselves, hence measuring as much of the set of all possible personalities \citep{john1988}. \citet{spearman1904} did much the same for intelligence, collecting the scores of students across school subjects and finding that their variance overwhelmingly loads on a single wide-breadth latent variable called the $g$ factor \citep{jensen2002}, which remains generally accepted \citep{johnson2004,johnson2008}. Both follow the same paradigm. Exhaustively measure observable behaviors, subject them to dimension reduction techniques, and draw theories from the resulting latent factor. Subsequent research decomposes the hierarchy further, into facets for personality \citep{lee2018,deyoung2007} and into specific cognitive abilities for intelligence \citep{schneider2018}.


## Causal Assumptions in Machine Intelligence

Various LLM benchmarks are known to be intercorrelated, though the origin of this covariance is rarely stated explicitly. We test the implicit assumption that benchmark correlations originate causally from latent variables, and add that existing paradigms of machine intelligence are implicitly causal. The assumed precedence of a content-free intelligence \citep{chollet2019} already implies such a relation, and model development relies on it. In aiming to achieve "general intelligence", developers tend to train in a *targeted* manner. Reasoning-oriented post-training, for instance, is motivated by the expectation that improvements on "pure" logical tasks will transfer to tool-calling, long-horizon agentic tasks, and coding \citep{deepseekai2025}. Such an expectation is coherent only if the targeted ability stands in a causal relation to the rest, which we state as follows.

<!-- Style pass 2026-09-23 (already-X-but-Y-makes-it-concrete construction). The sentence read: The precedence assumed of a content-free intelligence \citep{chollet2019} already implies such a relation, but model development makes it concrete. -->

**Definition 1.** `{\fulldisplayskips{}`{=latex}Let $F$ be a set of latent factors and $T$ the set of performance scores over all possible tasks:
$$F = \{\, f_i \mid i \in \mathcal{I} \,\}, \qquad g \longrightarrow F \longrightarrow T, \quad F \not\longrightarrow g.$$
That is, $g$ is a higher-order factor that causally affects the set of latent factors $F$, through which it in turn influences task performance. No causal path runs from $F$ back to $g$.`}`{=latex}

There is a growing assumption in the field that a subset of $T$, mostly assumed to be reasoning, mathematics, and coding, measures $g$ better than the rest. When a model is fine-tuned to perform better on such tasks, the implicitly expected transfer happens because training improves $g$ and, through it, the factors $F$:

**Definition 2.** `{\fulldisplayskips{}`{=latex}Let $F$ be a set of latent factors and $T$ the set of performance scores over all possible tasks. Task performance $t_i$ is given by a linear predictor:
$$t_i = \lambda_gg + \lambda_1 f_1 + \dots + \lambda_k f_k + \epsilon_i, \qquad i \in \mathcal{I},$$
where $\lambda_g, \lambda_1, \dots, \lambda_k$ are the task's factor loadings (standardized regression coefficients) and $\epsilon_i$ is the task's unique variance.`}`{=latex}



## Interpreting Structural Patterns

Understanding the patterns of benchmark correlation is theoretically relevant to cognitive science, though this relevance does not concern any one specific factor loading pattern. Under a small number of benchmarks the discovered patterns depend on which benchmarks were sampled \citep{major2011}, and under a large number the missingness pattern becomes too large to trust any single solution.  The correct approach is therefore to examine recurring and large-scale patterns.


One such pattern is the explanatory power[^1] of a general intelligence factor. When a general factor dominates the explained variance of an EFA result, variance in an LLM's capability is predominantly caused by a latent $g$, supporting the idea that a flexible, "raw" intelligence is a substantial component of performance and that targeting it is a fruitful research program. A weak $g$ factor instead means that LLM abilities are strongly specific, so improvements require brute-force training in as much task diversity as possible, with no silver-bullet construct that parsimoniously describes "general intelligence". A second pattern is which benchmarks load highest. Under the indifference of the indicator \citep{spearman1904}, content does not determine loading, so the test is whether a factor recovered from a small battery survives a wider one.



[^1]: We use the phrase "explanatory power" over "existence", as $g$ is a construct of the factor model we fit.

We read these patterns without assuming what a general factor should look like, since factor analysis is a bottom-up, theory-free approach. Authors tend to impose theories of human intelligence on artificial neural networks, as we know of no better model of intelligence than our own. However, it is problematic because these networks present an entirely different form of cognitive process than that of biological minds. Human intelligence research itself began with factor analysis \citep{spearman1904} and continues to apply bottom-up dimension reduction even though its theories have been well established for decades. Therefore, we do not assume any general factor to have a tidy definition, and so we do not discriminate between benchmarks and try to sample as much of the set of all possible tasks as we can. We argue that it is a reasonable position to expect that LLMs work in ways entirely unintuitive to the human mind, and having no priors whatsoever is the correct way to start our inquiry. Purpose-built diversity suites such as BIG-bench \citep{srivastava2022} are denser, but they sample one team's construction of task diversity. We are interested in the benchmarks the field uses.


## Related Work

Prior work applying factor analysis to benchmark scores is smaller in scale, and mostly confirmatory. \citet{ilicagignac2024} applied confirmatory factor analysis to hundreds of models and found that their performance fits a human-informed causal structure, which repeats the mistake of fitting an existing theory to model intelligence. A large proportion of their benchmarks are also variants of MMLU \citep{hendrycks2021}, posing the risk of common-method bias polluting the model fit. \citet{federiakin2025} likewise fits a single-factor CFA to the HuggingFace Open LLM Leaderboard. A confirmatory fit can only test the structure its authors specify in advance. \citet{hardy2026} fit CFA and generalizability theory to over 4,000 models on the same leaderboard, and find local dependence among its items, which is the common-method bias we raise above.

\citet{krakauer2026} instead applies PCA and finds a first principal component declining from 90% of variance to 64% by 2024, interpreted as a "rotation" in the $g$ factor as models outsource reasoning to external tools. PCA does not partition out systematic from error variance and so cannot be trusted to isolate a genuine $g$ factor from noise. Only two studies run EFA. \citet{burnell2023} found three major factors, but did not do higher-order factor analysis on the resulting loadings, so they cannot say to what extent those factors are influenced by a presumable $g$ factor. \citet{haznitrama2026} report a unified general factor before showing that a neuropsychologically-grounded battery reveals cognitive gaps that it otherwise masks. Narrower still is \citet{holm2024}, where a single factor explains 95% of variance across just 8 scenarios in one language. Item response theory, recently applied to LLM benchmarks \citep{polo2024,zhou2025}, and full-information maximum likelihood both handle incomplete data natively. IRT requires per-item responses, which published scores do not report, and FIML requires every benchmark pair to share observed models, which many pairs at our sparsity do not.
