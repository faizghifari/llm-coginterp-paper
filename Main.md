%% contoh judul
 The covariance structure of machine intelligence
 On the degree of generality in machine intelligence
 A statistical analysis of "general" machine intelligence
 The dimensionality of machine intelligence is only partially interpretable
 Machine intelligence is idiosyncratic and uninterpretably structured 
%%
## The dimensional organization of machine intelligence
###  Abstract

We take a multi-order latent variable approach to intelligence in language models, similar to how psychometricians formulate psychological traits. Performance in every specific problem set is influenced by a domain-specific and a domain-agnostic latent factor. Using factor analysis as a dimension-reduction technique, we analyse the scores of 3476 language models across 841 different benchmarks. Due to the super-sparse nature of the dataset, we triangulate our analysis across different data densifiers and imputation methods. A robust pattern across different modes of bias is that 1. factor patterns are only partially interpretable and often incoherent, 2. no silver-bullet "general intelligence" factor exists. Our findings goes against current endeavors of defining, identifying, and targeting general intelligence in language model development. It is not possible to develop a generally-intelligent language model by targeting single conceptual ability: general intelligence is only achievable by training on the first-order intelligence domains, but these are often partially idiosyncratic and not identifiable in practice.

### Introduction

Artificial general intelligence (AGI) is fabled as the holy grail of AI research, defined as artificial intelligence that exceeds humans in virtually all cognitive tasks. High-level research in this field has formulated many criteria or measurement of general intelligence, such as statistically outperforming humans (deepmind paper), performance in a fluid intelligence task (arc agi). The former would be an operational criteria agnostic to the machine's cognitive mechanism, while the latter sought to give general intelligence a definitional framework proper that model developers can directly aim to work on.

% something...

No matter what one's stance on the cognitive nature of AI is--whether or not they are conscious, intelligent, or if they have internal representations proper--it is reasonable to assert that AI are not humans. Their inferential substrate is in no way similar to humans. As such, the application of top-down, human-based theories of intelligence to neural network models are a category error. This is less of a problem in operationalistic approaches, where the nature of intelligence is sufficiently summarized by the outcome in question without an appeal to cognitive structure.

A prime example of this mistake is (paper), where the authors fit a structural equation model (SEM) to understand the ability structure of language models. Like what we did below, the authors analysed benchmark scores of a large number of models. We believe that this approach is correct in spirit, but it is problematic because their specific SEM method is a hypothesis testing procedure. This approach to analyze multidimensional data by foregoing exploratory analysis is highly criticized by methodologists in psychometrics (e.g., the confirmatory vs. exploratory factor analysis distinction).

The point is that *we cannot describe what machine intelligence is like by overfitting theories of human intelligence on neural networks*. This is not to say that such theories have no scientific value for the study of language models. Conceptual borrowing is very useful to describe systems with analogous forms and functions, and we do the same below regarding our concept of general intelligence. But--and we emphasize again--understanding of machine intelligence require a strongly bottom-up approach.

### Definitions

In this study we take a latent variable approach to intelligence, similar to how psychometricians formulate psychological constructs. Per the name, latent variables are not unobservable, but the existence can be inferred by analyzing the covariance structure of observed scores.

Let $B_i$ be a specific benchmark in some problem domain, such Rust programming, for some model $M_i$. Let $F_i$ be the model's latent general factor causally influences various abilities in the same domain (in this case, a general "programming" ability). Then, let $G_i$ be the model's globally general latent factor that influences virtually all abilities in all domains. $F_i$ is considered a first-order general factor, while $G_i$ is a second order general factor. Adding a unique, task-specific unique variance, $U_i$:

$$B_i = F_i + G_i + U_i$$

The model's scores on the benchmark is a linear model of it's domain factor, general factor, and specific unique ability. A maximally specific ability has $F_i$ and $G_i$ as 0 (all variance explained by the model's benchmark-specific ability), while a maximally general ability has $F_i$ and $U_i$ set as 0.

In a multidimensional latent factor model, there are > 1 latent factors. Each factor regress on the benchmark score with different coefficient sizes (including those approaching or equal to 0). So in a 3-factor model where each factors indicate general programming, mathematical reasoning, and linguistic ability, you can expect Rust programming to be influenced the most by general programming, then mathematical reasoning, and then linguistic ability.

In reality, and as is often the case in psychological scale validation, to what degree each factor influence an item is often not predictable by the researcher. In a typical research workflow, the psychological scientist develop a set of questionnaire item designed to measure a theoretical concept. After administering the item to an initial sample, the researcher conducted a dimension-reduction technique (often using exploratory factor analysis; more later) to see 1. how many factors (dimensions) optimally summarize the item set, 2. to what degree each factor regress on each item. Items with low factor loadings are discarded from the final scale with the reasoning that it is a poor proxy of the latent factor in question.

Importantly, and this can be a lesson for AI research: virtually no scale validation occurs without discarding an item, and it is straight-up impossible to reason which items would be a great proxy of the target latent factor. No matter how reasonable, common-sensical, or carefully an item set is designed, every psychological scale must undergo rigorous statistical validation to be acceptable.

%% footnote ?
The word "causal" is meaningful here: in psychology, this is a realist view (borsboom) where psychological traits truly "exist", as opposed to an operationalist view where scores in psychological scales have no external meaning (e.g., "intelligence is defined as the score in an intelligence test"). In deep neural networks, first-order factors can be interpreted as a subnetwork with common activation pattern across same-domain problems, while the second-order $G$ factor is one with common activation patterns across all problems (e.g., a "winning network" in the lottery ticket hypothesis).
%%


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

### References