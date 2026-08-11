%% contoh judul
 The covariance structure of machine intelligence
 On the degree of generality in machine intelligence
 A statistical analysis of "general" machine intelligence
 The dimensionality of machine intelligence is only partially interpretable
 Machine intelligence is idiosyncratic and uninterpretably structured 
%%
##  Machine intelligence is idiosyncratic and incoherently structured
###  Abstract

We take a multi-order latent variable approach to intelligence in language models, similar to how psychometricians formulate psychological traits. Performance in every specific problem set is influenced by a domain-specific and a domain-agnostic latent factor. Using factor analysis as a dimension-reduction technique, we analyse the scores of 3476 language models across 841 different benchmarks. Due to the super-sparse nature of the dataset, we triangulate our analysis across different data densifiers and imputation methods. A robust pattern across different modes of bias is that 1. factor patterns are only partially interpretable and often incoherent, 2. no silver-bullet "general intelligence" factor exists. Our findings goes against current endeavors of defining, identifying, and targeting general intelligence in language model development. It is not possible to develop a generally-intelligent language model by targeting single conceptual ability: general intelligence is only achievable by training on the first-order intelligence domains, but these are often partially idiosyncratic and not identifiable in practice.

### Introduction

The field of artificial intelligence is rife with theories and conceptualization about what intelligence "is" (). With neural network specifically, a longstanding issue is how the models are "overfitting" their training set, and thus their performance in various tasks ("intelligence", so to say) lack powerful generalizability that cognitive entities like humans have. Thus, the development of advanced intelligent systems rely on a working notion of intelligence as adaptive and effective across diverse tasks: a singular notion of "generalizability."

There is, in this endeavor, an implicit and subtle assumption: it is that in neural networks, much like humans, cognitive abilities are structured according to a causal hierarchy. The word causal is important here. A popular notion of general intelligence in the field is the concept "fluid intelligence" borrowed from psychometric research, defined loosely as the ability to perform well in any tasks regardless of the content (i.e., a "domain-free" cognitive capacity). By definition this construct holds a causal relation, where an increase of fluid intelligence leads to an increase in the mastery of every other cognitive task. In other words, domain-general ability *precedes and builds* domain-specific abilities. 

It is, therefore, useful to ascertain whether it is plausible that cognitive abilities in neural networks follow a coherent hierarchical causal structure. An important implication is that if such structures prove to be incoherent or idiosyncratic, then the entire program of general intelligence as a silver bullet construct (e.g., "AGI") falls apart and is entirely impossible: there is no efficient way to achieve perfect-general intelligence without brute-forcing the training set to cover the universe of all possible tasks, as there are no coherent higher-order facets that researchers can target.

Why this causal hierarchy assumption is so rife in the first place is, in our view, the application of both our theories and common sense about our own intelligences to neural networks. No matter what one's stance on the cognitive nature of AI is--whether or not they are conscious, intelligent, or if they have internal representations proper--it is reasonable to assert that AI are not humans. As such, the application of top-down, human-based theories of intelligence to neural network models are a category error. We cannot describe what machine intelligence is like by overfitting theories of human intelligence on neural networks.

For this reason it is important to study the structure of machine intelligence in a bottom-up manner. Borrowing from psychometrics yet again, the application of exploratory factor analysis, a dimension-reduction statistical method, allows us to summarize performance in a series of abilities (measured through benchmarks) as influenced by a higher-order latent variable in a plausibly causal manner.

Prior work has tried applying factor analysis to benchmark scores. Ilica & Gignac (2024) have applied factor analysis to hundreds of models and found that the models' performance fits a human-informed causal structure. However, the study is flawed by their use of confirmatory factor analysis, which is a hypothesis-testing procedure, and follows the mistake of fitting a human-informed theory rather than understanding model intelligence from the bottom-up. It is also severely flawed in that a large proportion of their benchmarks are simply variants of the popular MMLU benchmark (), heightens the risk of common-method bias polluting the model fit.

Another relevant work is Burnell et al. (2023), which correctly applied EFA to model benchmark scores. They found that LLM abilities are hierarchically structured under three major factors. However, they did not do higher-order factor analysis, where EFA is run on the resulting factor loadings, thus allowing us to understand to what extent are latent factors influenced by a presumable g-factor.

A common weakness of both papers, though, are the relatively few number of benchmarks or variables derived thereof. Ilica & Gignac (2024) fit a model with 20 variables, while Burnell et al. (2023) uses 23 variables. Most of these benchmarks are popular benchmarks measuring "smartness" for a lack of better term, like mathematics, academic knowledge, and common-sense reasoning.

Within the context of prior work, our study presents an unprecedentedly large factor analysis of benchmark scores, with our raw data comprising up to 1310 models and 455 benchmarks. Crucially, our pool of benchmarks covers a highly diverse set of tasks, including those quite outside of the mainstream. Covering only few popular benchmarks like prior work does is problematic. First, given their popularity, these benchmarks may well be correlated due to what we call a common-investment bias: there is a high chance their correlations substantially polluted by the fact that organizations expend more efforts to perform well in said benchmarks. Second, there should be no discrimination as to what tasks are important and which aren't: whether a task appears miscellaneous is also no reason to exclude them. A useful analogy is that reaction time in humans is correlated to intelligence (Kranzler & Jensen, 1989): no matter how seemingly unimportant a task may be, it may provide useful information that is entirely unintuitive to our subjective understanding.


### Methodology

%% benchmark and model inclusion criteria
 main sources: papers (arxiv, acl, openreview, google scholar, dblp, orcid, semantic scholar), pwc, kaggle, stanford helm, hf leaderboard, artificial analysis, lmsys arena, lmstats, etc.
 must be general-purpose model able to do arbitrary task
 etc2. %%

#### Dataset


#### Sparsity Handling

### Analysis

### Results

### Discussion

#### The g-factor is only partially coherent
%% 
Note: many items ahve .99 loadings to the g-factor, mostly low-observations data.
If this is not
%%
#### Bottom-up theories of LLM intelligence

Importantly what we find is that, unlike theories of human psychology () where intelligence are explicitly assumed to possess higher-order structure, with fluid intelligence as a higher-order factor that have theoretical causal effects () to the performance of other cognitive abilities, fluid intelligence, wikipedia memorization, agentic tool use, are more likely to be horizontal with respect to each other with no clear higher-order structure. Ablation studies provide experimental evidence to this point: ...

This is also not to say that LLMs are not intelligent (in our private view, they very clearly are). But it is important to realize that just as humans and ants are differentially but equally "cognitive", LLMs are intelligent in a considerably different way to humans. This means that a theory of intelligence requires a blank-slate, bottom-up empirical approach without overfitting theories of human intelligence into systems that possess significant architectural and functional divergence from humans.

#### Mechanisms for a possible g-factor

### References
