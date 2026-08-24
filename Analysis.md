%% Standalone draft of the analysis section, to be merged into [[Main]] later.
Heading levels are already set to slot in directly under Main.md's `### Analysis`
stub: paste the body below in place of that stub and nothing needs re-levelling.
Method definitions live in [[Methodology]]; implementation detail in [[Appendix-Methods]].
Notation follows [[Appendix#Definitions]]: $G$ is the global (second-order) general
factor, $F$ the first-order domain factors, $U$ benchmark-specific unique variance. %%

### Analysis

#### Robustness and sensitivity analyses

The design is a cross-product of {3 densifiers + raw} × {2 collapse strategies} × {completion methods} ([[Methodology#Sparsity Handling]]), and its cells are compared along four axes:

1. **Across densifiers and collapse strategies.** Since C, S, and R embody different selection biases over the same underlying corpus, and the two collapse strategies embody different model-identity assumptions, systematic variation across them is the closest available proxy for sensitivity to the MNAR mechanism itself.
2. **Across completion methods.** Where two solutions have the same number of factors, we compute pairwise factor congruence (sign-invariant cosine similarity between loading vectors, matched after sorting by explained variance), grouped by dataset, solution type, and shape, so that only like-for-like solutions are compared ([[Appendix-Methods#J.6 Cross-method congruence|Appendix J.6]]).
3. **Across held-out splits.** An optional seed sweep refits each method across repeated random holdouts, reporting the distribution of held-out error, of the selected hyperparameter, and of $\omega_h$. We stress that this quantifies *split* variance under a fixed missingness pattern; it does **not** measure robustness to the MNAR mechanism, since every split inherits the same selection.
4. **Per-benchmark influence.** A leave-one-covariate-out analysis recomputes $\omega_h$ with each benchmark removed in turn, giving $\Delta\omega_h$ per benchmark ([[Appendix-Methods#J.5 Leave-one-covariate-out|Appendix J.5]]). Correlating $\Delta\omega_h$ with each benchmark's observation frequency tests directly whether the general factor is driven by capability structure or by evaluation volume — the concern raised by the highly unequal source composition in Table 1 of [[Methodology]], and the same common-investment bias we raise against prior work in the introduction.

Three commitments follow and constrain how we read our own results. First, **held-out accuracy is not evidence of factor validity**: a method can predict held-out cells well and still deliver an unstable rotation, so our findings rest on agreement across methods and stability across design cells, not on predictive fit. Second, **the factor count is weakly identified** on data this sparse, and we report that instability as a result rather than resolving it by fiat. Third, a factor that is dominated by a single benchmark family is a fact about the corpus, not about language models; the influence analysis above exists to make such cases visible.
