# Discussion

## Uninterpretable hierarchical structure

Classically, cognitive sciences have approached intelligence from verbal, conceptual beginnings \citep{legg2007}. Intelligence is given a definition, then systems are developed according to the specs provided by the definition. This is not true in psychometric paradigms, which start by analyzing the covariance of performance measurements. Thus, adopting the psychometric approach for LLM benchmarks, our study has found that any substantially effective $g$ factor cannot be coherently approximated. Adding to this, tasks with similar contents, like mathematics and coding, do not necessarily cluster together. Machine intelligence does not follow any coherent structure or definition. 

Unlike theories of human psychology \citep{schneider2018} where intelligence is explicitly assumed to possess higher-order structure, with fluid intelligence as one higher-order factor that has theoretical causal effects \citep{vandermaas2014} on the performance of other cognitive abilities, abilities in LLMs like abstract reasoning, domain memorization, and agentic tool use, are more likely to be horizontal with respect to each other with no clear higher-order structure.

As factor analysis assumes a reflective data generating process, the next question is whether such causality can be observed and exploited in practice. One way is to follow psychological science, where training participants in one cognitive task leads to observable improvements in a different task (hence, generalization) \citep{simons2016}. For an LLM, this means measuring a model's performance in coding, fine-tuning it to be better at mathematics, and then measuring its coding performance again. If there is an improvement between pre- and post-training performance, a causal mechanism can be empirically verified. More generally, one can fine-tune models to be better at benchmarks which are (assumed to be) proxies of general intelligence, then compare the pre- and post-training performance in a wide array of tasks.


Establishing such causal mechanisms would be practically important. If there were no causal generalization, then no blanket improvement of abilities could be gained by improving one family of tasks. A generally-intelligent model can only be trained by including all relevant tasks in the training corpus, and there is no silver-bullet construct or ability that can be efficiently targeted in training that will causally improve aptitude in specific tasks. Such a model would require a brute-force, increasingly expansive training dataset until it covers the universe of all possible tasks.

## Why do abilities correlate?

If we accept the $g$ factor as a mixture of correlations, it remains to explain why these correlations appear in the first place. Explanations of multi-task learning suggest that cross-domain transfer occurs from a convergence to a representation shared by the trained tasks \citep{caruana1997}. Contemporary paradigms like reasoning \citep{tang2025} suggest that tasks are decomposable into semantic primitives subject to logical/symbolic manipulation in the representational layers. However, in line with our findings, \citet{meng2026} find that input-similarity measures identify the best transfer source for at most 2 of 8 target tasks, and that transfer is better predicted by the gradients a task induces than by its content. We therefore expect correlations between abilities to arise from highly unintuitive conditional token probabilities, which are not summarizable into human-like analogies.

## Training regimes to ascertain the hypothesis

TODO: explain training experiments that can be done in the future

## Alternative to a latent factor view

Through this paper we have shown that the implicitly causal model of intelligence yields an incoherent structure. However, factor analysis by itself is an analysis of correlations, and is merely compatible with a causal model. The formative paradigm, usually associated with PCA, makes no claim about the nature of the resultant components \citep{vandermaas2014}. Even so, generalizability would be impossible without a common factor to begin with, since two tasks sharing a dominant factor decompose into a similar lower-level representation \citep{caruana1997,menghi2025} that the network must discern. The mutualist paradigm \citep{borsboom2013}, which describes indicators as nodes in a graph of mutual causality, is harder to rule out, since a mutualist process reproduces a positive manifold without any common cause \citep{vandermaas2014}.

Mutualism \citep{van2017} models specific abilities as having mutual causal facilitation, with no higher-order, few-dimension causal factors. For example, agentic ability could improve tool use, which in turn improves coding. The output of this analysis is a graph of partial correlations between abilities (e.g., network analysis \citep{borsboom2013}).

This view is attractive, as it does not require a supposedly parsimonious \citep{van2016} single latent variable to explain the origins of correlations (which, per our findings, are mostly unintelligible). The caveat, if this mechanism is correct, is that the $g$-oriented research program is untenable, as $g$ is merely a summary scalar and not a real, targetable ability. It also leaves inter-task correlations unintuitive and not bound by domain similarity. It is a more informative model, but it does not explain the uninterpretability of the correlation structure.
