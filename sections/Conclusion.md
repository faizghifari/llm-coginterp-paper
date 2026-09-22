# Conclusion

We asked whether the cognitive abilities of language models are organized around a general factor. Our answer comes from factor analyses of 13,251 published evaluation scores covering 1,618 models and 456 benchmarks, triangulated so that no single treatment of the missing data carries the finding.

At best, a general latent factor accounts for 74.7% of variance in model performance, but most of our solutions put it well below that. Domain-similar benchmarks are only occasionally located close together in vector space, and benchmarks with high $g$-loading do not share a common theme, and far different from benchmarks the field treated as standard measures of intelligence.

We conclude that a hierarchical causal order of machine intelligence, as commonly but only implicitly assumed in the field, are untenable in practice given the uninterpretable factor structure. Correlations arise from unintuitive and unpredictable common features, and a non-hierarchical networks of abilities are possibly better models for machine intelligence. 

%%
We therefore find no support for the assumption that a single content-free capability underlies performance across tasks in language models. Succinctly, a theory of machine intelligence has to be built from the bottom up, out of the abilities models actually have, rather than borrowed from the structure human intelligence happens to take.
%%
<!-- Trimmed 2026-09-19 from 300 to 175 words. Four things came out, each because
it is already made elsewhere and a conclusion should not re-argue:

1. The framing clause "in the way psychometric research organizes human abilities
   around fluid intelligence". The Introduction and Background 2.1 both open on it.
2. The method recap "across several densifiers, imputers, and model-collapse
   strategies". Methodology 3.2 is three pages on exactly this.
3. The limitation sentence, "It must be stressed, however, that this is a statement
   about the structure we can recover from published scores, and the corpus we
   recover it from is sparse and assembled from evaluations we did not run
   ourselves." This is Appendix A in full.
4. The targeting sentence, "What our results do rule out is the development
   strategy that assumption licenses. A generally-intelligent language model cannot
   be reached by targeting one conceptual ability and expecting the rest to follow,
   because the first-order abilities a general factor would have to sit above are
   partially idiosyncratic and, on this evidence, not identifiable in practice."
   The Discussion's closing paragraph now makes this point at length (no blanket
   improvement, no silver-bullet construct, brute-force expansive training set),
   and with 5.1's heading removed the two sit adjacent, so the duplication was
   visible on the page.

Also dropped: "so capability on one task does not reliably carry to another task
of the same kind", which restates the bolded sentence ending Results 4.2.

The closing bottom-up sentence is kept and now carries a point the Discussion no
longer makes anywhere, since the "Bottom-up theories of LLM intelligence" section
was commented out in 1892b55. If that section comes back, this sentence and it
need reconciling. -->
