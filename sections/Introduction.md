# Introduction

The field of artificial intelligence is full of theories about what intelligence "is" \citep{chollet2019,morris2023,waterhouse2023}. This is partly because neural networks tend to overfit their training data, such that their performance across tasks lacks the generalizability of human cognition \citep{zhang2021}. In pursuit of this generalizability, models are often implicitly assumed to organize cognitive abilities according to a causal hierarchy, much like humans, where a general-purpose, "content-free" capability underlies and transfers across many specific downstream tasks \citep{bommasani2021}. A popular label for this hierarchy, borrowed from psychometric research, is "fluid intelligence", defined as the ability to perform well on any task regardless of content \citep{cattell1963}. By definition this construct holds a causal relation, where an increase of fluid intelligence leads to an increase in the mastery of every other cognitive task.

The concept of general fluid intelligence is borrowed from human intelligence psychometrics, which discovers the higher-order structure of cognitive abilities by applying dimension reduction techniques to a large set of cognitive measures. A growing body of work in machine learning follows this step by analyzing LLM benchmark scores to ascertain the nature of "general intelligence" in machines. However, a common weakness across these studies is the relatively small number of benchmarks or variables, ranging from 6 to 23, most of which measure "smartness" narrowly (mathematics, academic knowledge, common-sense reasoning) and which risk conflating the extracted capability factor with model scale \citep{kearns2026}. These studies also tend to fit a human-informed structure, and do not look for bottom-up patterns specific to LLMs.

<!-- Style pass 2026-09-23 (rather-than contrast). The sentence read: These studies also tend to fit a human-informed structure rather than discovering bottom-up patterns specific to LLMs. -->

<!-- Cut to save space (2026-09-23), since Related Work covers each of these papers in more detail. It read: \citet{ilicagignac2024} fit confirmatory factor analysis to a human-informed causal structure, \citet{burnell2023} found three major factors via EFA without testing for a higher-order $g$, and \citet{krakauer2026,federiakin2025,haznitrama2026} each report a unified general factor at similarly small scale. -->

Within the context of prior work, our study presents factor analysis of 13,251 evaluation scores from 1,618 models and 456 benchmarks, the widest benchmark coverage to date, to the best of our knowledge. Our pool of benchmarks, unlike previous work, covers a highly diverse set of tasks, including those quite outside of the mainstream. A useful analogy is that reaction time in humans is correlated with intelligence \citep{kranzler1989}, showing that no matter how seemingly unimportant a task may be, it may provide information entirely unintuitive to our subjective understanding. Across this analysis, we find that factor patterns are only partially interpretable and often incoherent, and that the evidence for a "general intelligence" factor proxied by commonly-targeted "reasoning" benchmarks is limited, with the highest loadings more often going to miscellaneous tasks with no common theme.

<!-- Cut to save space (2026-09-23), since the last two sentences of the Abstract say the same. It read: This means the strategy of targeting a single conceptual ability rests on an assumption our analysis does not support. The note below explains how this sentence replaced an earlier one. -->

<!-- SOFTENED in response to the Google PAT review, first weakness of the
Results/Discussion block, which asks that causal claims about training be
softened to reflect the correlational nature of the findings. The superseded
sentence read:

This means a generally-intelligent language model cannot be reached by targeting
a single conceptual ability alone.

The review is right. EFA models the covariance of static post-training scores and
gives no evidence about learning dynamics or causal transfer during training. We
cannot distinguish a world with no common cause from a world with one that does
not surface as a coherent factor in sparse cross-sectional score covariance.

By the time this was changed the sentence had also become an internal
contradiction. Discussion 5.1 now states the same claim as a conditional ("If
there were no causal generalization, then...") and proposes a fine-tune and
remeasure experiment to settle it, so the paper was asserting on page 1 what it
called an open question on page 8.

What replaces it is a claim about warrant rather than about possibility, which is
what the data actually shows. The Conclusion needed no change, since the trim
already removed the targeting passage and what remains ("we find no support for
the assumption that...") is already a claim about evidence. -->
