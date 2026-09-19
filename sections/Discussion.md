# Discussion

## There is no $G$-efficient training

Classically, cognitive sciences have approached intelligence from a verbal conceptual beginnings \citep{}. Intelligence is given a definition, then systems are developed to according to the specs provided by the definition. This is not true in psychometric paradigms, which starts by analyzing the covariance of performance measurements. Thus, adopting the psychometric approach for LLM benchmarks, our study have found that any substantially effective $G$ factor cannot be coherently approximated. Adding to this, tasks with similar contents, like mathematics and coding, does not necessarily cluster together. Machine intelligence does not follow any coherent structure or definition. 

Unlike theories of human psychology \citep{schneider2018} where intelligence is explicitly assumed to possess higher-order structure, with fluid intelligence as one higher-order factor that have theoretical causal effects \citep{vandermaas2014} to the performance of other cognitive abilities, abilities in LLMs like abstract reasoning, domain memorization, and agentic tool use, are more likely to be horizontal with respect to each other with no clear higher-order structure.

The practical consequence of this finding is that no blanket improvement of abilities can be gained by improving one family of tasks. A generally-intelligent model can only be trained by including all relevant tasks in the training corpus, and there is no silver-bullet construct or ability that can be efficiently targeted in training that will causally improve aptitude in specific tasks. Such a model requires a brute-force, increasingly expansive training dataset until it covers the universe of all possible tasks.

## Why do abilities correlate?

One question that arise, if we accept the $G$ factor simply as a mish-mash of correlations, why do these correlations appear in the first place?

A principled answer here is the same reason why any neural network can generalize out-of-sample. 

But there is yet a less appealing, but plausible answer: the $G$ factor, or even all the latent factors, are merely quantifiers of investment effort.

## Alternative, nonlinear $G$ factor

In EFA, latent variables are modeled as linear regression predictors of the indicators. Let $x_i$ be an indicator, $\xi_1, ... \xi_k$ be latent variables, $\lambda_{1i}, ... \lambda_{ki}$  the loadings of $x_i$ for the respective factors, and $\epsilon$ a random noise. The indicator $x_i$ is predicted by the latent variables in a simple multiple linear regression:

$$x_i = \lambda_{1i}\xi_{1} + ... + \lambda_{ki}\xi_{k} + \epsilon$$
The factor loadings $\lambda$ are standardized regression coefficients from the factor $\xi$ to the indicator.



%% 
Note: many items have .99 loadings to the g-factor, mostly low-observations data.
If this is not
%%

%%## Bottom-up theories of LLM intelligence

Importantly what we find is that, unlike theories of human psychology \citep{schneider2018} where intelligence are explicitly assumed to possess higher-order structure, with fluid intelligence as a higher-order factor that have theoretical causal effects \citep{vandermaas2014} to the performance of other cognitive abilities, fluid intelligence, wikipedia memorization, agentic tool use, are more likely to be horizontal with respect to each other with no clear higher-order structure. 


This is also not to say that LLMs are not intelligent (in our private view, they very clearly are). But it is important to realize that just as humans and ants are differentially but equally "cognitive", LLMs are intelligent in a considerably different way to humans. This means that a theory of intelligence requires a blank-slate, bottom-up empirical approach without overfitting theories of human intelligence into systems that possess significant architectural and functional divergence from humans.%%

