---
title: Large-scale factor analysis shows machine intelligence is only partially interpretable
abstract: A common assumption in language model development is that cognitive abilities are organized around a general, domain-free intelligence factor, like fluid intelligence in humans. This assumption is rarely tested directly, and prior attempts have done so only at a much smaller scale. We take a latent variable approach to intelligence in language models, similar to how psychometricians study psychological constructs. Performance in every specific problem set is influenced by a domain-specific and a domain-agnostic latent factor. Using factor analysis as a dimension-reduction technique, we analyzed \textcolor{red}{13,230} published evaluation scores covering 1,618 language models across 456 different text-only benchmarks. Due to the sparse nature of the dataset, we triangulate our analysis across different data densifiers and imputation methods. \textcolor{red}{Across the imputations that pass our quality filter, the general factor's share of variance in the summed score ($\omega_h$) ranges from 0.04 to 0.76, and its share of the common variance (ECV) from 0.11 to 0.52.} A robust pattern across different modes of bias is that \textcolor{red}{1. Same-subject benchmarks is not guaranteed to place closely in vector space, with weak median label cohesion 2. Benchmarks loading highest on $G$ tends to be miscellaneous rather than thematically coherent, and 3. Standard "intelligence" benchmarks do not dominate the share of ability variance the general factor explains}, and there is a lack of evidence that $G$ is well-proxied by them. \textcolor{red}{We hypothesize that targeting a single conceptual ability has little support,} since the first-order abilities it would have to reach are often partially idiosyncratic and not identifiable in practice. \textcolor{red}{This would mean that, from public benchmark scores alone, general intelligence is hard to define, identify, and target as a single construct in language model development.} Future experiments should run training regimes that \textcolor{red}{target} both theoretically abstract general ability and tasks with semantic similarity and examine how abilities transfer across test sets of diverse formats.
---



![[sections/Introduction]]

![[sections/Background]]

![[sections/Methodology]]

![[sections/Results]]

![[sections/Discussion]]

![[sections/Conclusion]]

```{=latex}
\bibliography{iclr2027_conference}
\bibliographystyle{iclr2027_conference}

\appendix
% Match the paper's existing convention (previously hand-typed): main-text
% tables are numbered 1, 2, 3..., appendix tables restart at A1, A2, A3...
\renewcommand{\thetable}{A\arabic{table}}
\setcounter{table}{0}
% Figures follow the same scheme (added 2026-09-26, they ran on from the main text as 2, 3, 4...).
\renewcommand{\thefigure}{A\arabic{figure}}
\setcounter{figure}{0}
```

![[sections/appendix/known-limitations-and-deviations]]

![[sections/appendix/llm-usage]]

![[sections/appendix/data-source-and-normalization]]

![[sections/appendix/score-redundancy-pruning]]

![[sections/appendix/model-identity-collapse]]

![[sections/appendix/densification-algorithm]]

![[sections/appendix/imputation-methods]]

![[sections/appendix/imputation-evaluation]]

![[sections/appendix/imputation-simulation.md]]

![[sections/appendix/factor-analysis-details]]

![[sections/appendix/benchmark-embedding]]

<!-- Supplementary results, in the order Results cites them. Reordered
2026-09-26 (was: label cohesion, common-subject UMAP, imputation results,
omega sensitivity, g-rankings, release date). Label cohesion is last here at
the authors' request, since its long tables come after its explanation. -->

![[sections/appendix/release-date-analysis]]

![[sections/appendix/benchmark-g-rankings.md]]

![[sections/appendix/g-model-size]]

![[sections/appendix/label-cohesion]]

<!-- Table-heavy diagnostics after the explained results, shortest first.
Moved here 2026-09-26 (were right before release date). -->

![[sections/appendix/imputation-results]]

![[sections/appendix/omega-sensitivity]]

<!-- Full tables and figures at the very end, so no explanation sits behind
them. The UMAP plots come last because their figures float, and as the final
section they cannot drift into another section. -->

```{=latex}
\clearpage
```

![[sections/appendix/full-g-rankings]]

```{=latex}
\clearpage
```

![[sections/appendix/factor-top-benchmarks]]

```{=latex}
\clearpage
```

![[sections/appendix/common-subject-distances]]

<!-- Software environment and reproduction was deleted in pass 5. It was a
repository README (shell commands, output paths, SQLite table names, package
lists). The two facts worth keeping moved into the Implementation paragraph at
the end of sections/Methodology.md, which also carries a TODO for the code and
data availability statement. -->
