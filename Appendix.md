### Definitions

In this study we take a latent variable approach to intelligence, similar to how psychometricians formulate psychological constructs. Per the name, latent variables are not unobservable, but the existence can be inferred by analyzing the covariance structure of observed scores.

Let $B_i$ be a specific benchmark in some problem domain, such Rust programming, for some model $M_i$. Let $F_i$ be the model's latent general factor causally influences various abilities in the same domain (in this case, a general "programming" ability). Then, let $G_i$ be the model's globally general latent factor that influences virtually all abilities in all domains. $F_i$ is considered a first-order general factor, while $G_i$ is a second order general factor. Adding a unique, task-specific unique variance, $U_i$:

$$B_i = F_i + G_i + U_i$$

The model's scores on the benchmark is a linear model of it's domain factor, general factor, and specific unique ability. A maximally specific ability has $F_i$ and $G_i$ as 0 (all variance explained by the model's benchmark-specific ability), while a maximally general ability has $F_i$ and $U_i$ set as 0.

In a multidimensional latent factor model, there are > 1 latent factors. Each factor regress on the benchmark score with different coefficient sizes (including those approaching or equal to 0). So in a 3-factor model where each factors indicate general programming, mathematical reasoning, and linguistic ability, you can expect Rust programming to be influenced the most by general programming, then mathematical reasoning, and then linguistic ability.

In reality, and as is often the case in psychological scale validation, to what degree each factor influence an item is often not predictable by the researcher. In a typical research workflow, the psychological scientist develop a set of questionnaire item designed to measure a theoretical concept. After administering the item to an initial sample, the researcher conducted a dimension-reduction technique (often using exploratory factor analysis; more later) to see 1. how many factors (dimensions) optimally summarize the item set, 2. to what degree each factor regress on each item. Items with low factor loadings are discarded from the final scale with the reasoning that it is a poor proxy of the latent factor in question.

Importantly, and this can be a lesson for AI research: virtually no scale validation occurs without discarding an item, and it is straight-up impossible to reason which items would be a great proxy of the target latent factor. No matter how reasonable, common-sensical, or carefully an item set is designed, every psychological scale must undergo rigorous statistical validation to be acceptable.