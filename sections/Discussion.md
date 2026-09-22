# Discussion

## Uninterpretable hierarchical structure

Classically, cognitive sciences have approached intelligence from a verbal conceptual beginnings \citep{legg2007}. Intelligence is given a definition, then systems are developed to according to the specs provided by the definition. This is not true in psychometric paradigms, which starts by analyzing the covariance of performance measurements. Thus, adopting the psychometric approach for LLM benchmarks, our study have found that any substantially effective $g$ factor cannot be coherently approximated. Adding to this, tasks with similar contents, like mathematics and coding, does not necessarily cluster together. Machine intelligence does not follow any coherent structure or definition. 

Unlike theories of human psychology \citep{schneider2018} where intelligence is explicitly assumed to possess higher-order structure, with fluid intelligence as one higher-order factor that have theoretical causal effects \citep{vandermaas2014} to the performance of other cognitive abilities, abilities in LLMs like abstract reasoning, domain memorization, and agentic tool use, are more likely to be horizontal with respect to each other with no clear higher-order structure.

As factor analysis assumes a reflective data generating process, one might wonder whether such causality cna be observed and exploited in practice. One such way is to follow similar line of work in psychological science: training participants in certain cognitive tasks leads to observable improvements in a different task (hence, generalization) \citep{simons2016}. It is easy to imagine implementing this for an LLM: measure a model's performance in coding, fine-tune it to be better at mathematics, and then measure it's coding performance again. If there is an improvement between pre and post-training performance, a causal mechanism can be empirically verified. More generally, fine-tune models to be better at benchmarks which are (assumed to be) proxies of general intelligence, then compare the pre and post training performance in a wide array of tasks.

Establishing such causal mechanisms would be practically important. If there were no causal generalization, then no blanket improvement of abilities can be gained by improving one family of tasks. A generally-intelligent model can only be trained by including all relevant tasks in the training corpus, and there is no silver-bullet construct or ability that can be efficiently targeted in training that will causally improve aptitude in specific tasks. Such a model would require a brute-force, increasingly expansive training dataset until it covers the universe of all possible tasks.

## Why do abilities correlate?

One question that arise, if we accept the $g$ factor simply as a mish-mash of correlations, why do these correlations appear in the first place?

Explanations of multi-task learning suggests that cross-domain transfer occurs from a convergence to a representation shared by the trained tasks \citep{caruana1997}. Contemporary paradigms like reasoning \citep{tang2025} suggests that tasks are decomposable into semantic primitives subject to logical/symbolic manipulation in the representational layers. However, an important prior work aligning to our findings \citep{meng2026} demonstrates that trivial features like syntactic cues and attention to mathematical operator tokens intercede transfer learning improvements. Another important result from \citep{meng2026} is that, much like our findings, it is difficult to predict task transfer by analyzing semantic or content similarity, as they found that training to optimize one math benchmark degrades performance in another math benchmark. Thus, correlation between abilities are suggested to arise from a highly unintuitive conditional token probabilities which are not summarizable into human-like analogies.

But there is yet a disappointing, but plausible alternative answer: the $g$ factor, or even all the latent factors, are merely quantifiers of investment effort. Models that perform well in MMLU tend to perform well in the ARC Challenge because investment in both of those tasks are correlated. The same can be true for correlation between agentic tool use and agentic coding (in this sense, there would be no common "agentic ability" factor). A $g$ factor that improves all abilities would then just be a correlate of the size of the training corpus, where a larger corpus includes a more diverse set of tasks.

## Alternative 

%%## Alternative, nonlinear $g$ factor

In EFA, latent variables are modeled as linear regression predictors of the indicators. Let $x_i$ be an indicator, $\xi_1, ... \xi_k$ be latent variables, $\lambda_{1i}, ... \lambda_{ki}$  the loadings of $x_i$ for the respective factors, and $\epsilon$ a random noise. The indicator $x_i$ is predicted by the latent variables in a simple multiple linear regression:

$$x_i = \lambda_{1i}\xi_{1} + ... + \lambda_{ki}\xi_{k} + \epsilon$$
The factor loadings $\lambda$ are standardized regression coefficients from the factor $\xi$ to the indicator. 

%%

%% 
Note: many items have .99 loadings to the g-factor, mostly low-observations data.
If this is not
%%

%%## Bottom-up theories of LLM intelligence

Importantly what we find is that, unlike theories of human psychology \citep{schneider2018} where intelligence are explicitly assumed to possess higher-order structure, with fluid intelligence as a higher-order factor that have theoretical causal effects \citep{vandermaas2014} to the performance of other cognitive abilities, fluid intelligence, wikipedia memorization, agentic tool use, are more likely to be horizontal with respect to each other with no clear higher-order structure. 


This is also not to say that LLMs are not intelligent (in our private view, they very clearly are). But it is important to realize that just as humans and ants are differentially but equally "cognitive", LLMs are intelligent in a considerably different way to humans. This means that a theory of intelligence requires a blank-slate, bottom-up empirical approach without overfitting theories of human intelligence into systems that possess significant architectural and functional divergence from humans.%%
