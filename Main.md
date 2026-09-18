---
title: The dimensionality of machine intelligence is only partially interpretable
abstract: 'A common assumption in language model development is that cognitive abilities are organized around a general, domain-free intelligence factor, much like fluid intelligence in humans. This assumption is rarely tested directly, and prior attempts have done so only at a much smaller scale. We take a multi-order latent variable approach to intelligence in language models, similar to how psychometricians formulate psychological traits. Performance in every specific problem set is influenced by a domain-specific and a domain-agnostic latent factor. Using factor analysis as a dimension-reduction technique, we analyse 13,251 published evaluation scores covering 1,618 language models across 456 different text-only benchmarks. Due to the super-sparse nature of the dataset, we triangulate our analysis across different data densifiers and imputation methods. A robust pattern across different modes of bias is that 1. factor patterns are only partially interpretable and often incoherent, 2. no silver-bullet "general intelligence" factor exists. Our findings goes against current endeavors of defining, identifying, and targeting general intelligence in language model development. It is not possible to develop a generally-intelligent language model by targeting single conceptual ability: general intelligence is only achievable by training on the first-order intelligence domains, but these are often partially idiosyncratic and not identifiable in practice.'
---

%% NOTE ON NUMBERS: the abstract and §Introduction now quote the CORPUS
(456 benchmarks / 1,618 models / 13,251 rows), which is settled and independent of the
pipeline. The aggregated MATRIX dimensions in Methodology Table 2 (1,310 x 455) are a
different object and are still provisional -- they were read off matrices predating the
score-redundancy pruning, and must be swapped together with Table 3 and the Results
tables once the pipeline re-runs. See Appendix-Methods L.3a. Do not mix the two: 14,838
was a corpus row count and 1310 x 455 were matrix dimensions, and the previous abstract
presented them as one figure. %%

%% contoh judul
 The covariance structure of machine intelligence
 On the degree of generality in machine intelligence
 A statistical analysis of "general" machine intelligence
 The dimensionality of machine intelligence is only partially interpretable
 Machine intelligence is idiosyncratic and uninterpretably structured 
%%

![[sections/Introduction]]

![[sections/Background]]

![[sections/Methodology]]

![[sections/Results]]

![[sections/Discussion]]

```{=latex}
\bibliography{iclr2027_conference}
\bibliographystyle{iclr2027_conference}

\appendix
```

![[sections/appendix/A-data-sources-and-extraction]]

![[sections/appendix/B-inclusion-and-exclusion-criteria]]

![[sections/appendix/C-normalisation-rules]]

![[sections/appendix/D-text-only-classifier]]

![[sections/appendix/E-score-redundancy-pruning]]

![[sections/appendix/F-model-identity-collapse]]

![[sections/appendix/G-densification-algorithm]]

![[sections/appendix/H-completion-methods]]

![[sections/appendix/I-held-out-metric]]

![[sections/appendix/J-factor-analysis-details]]

![[sections/appendix/K-software-environment-and-reproduction]]

![[sections/appendix/L-known-limitations-and-deviations]]
