---
title: Large-scale factor analysis shows machine intelligence is only partially interpretable
abstract: A common assumption in language model development is that cognitive abilities are organized around a general, domain-free intelligence factor, much like fluid intelligence in humans. This assumption is rarely tested directly, and prior attempts have done so only at a much smaller scale. We take a latent variable approach to intelligence in language models, similar to how psychometricians study psychological constructs. Performance in every specific problem set is influenced by a domain-specific and a domain-agnostic latent factor. Using factor analysis as a dimension-reduction technique, we analysed 13,251 published evaluation scores covering 1,618 language models across 456 different text-only benchmarks. Due to the super-sparse nature of the dataset, we triangulate our analysis across different data densifiers and imputation methods. A robust pattern across different modes of bias is that 1. A general intelligence factor accounts for 70.8% of variance in model performance at our most generous estimate, and far less than that in most of our solutions, 2. Content-similar benchmarks do not necessarily cluster together, and 3. The $g$ factor is not dominated by any common theme, and there is a lack of evidence that it is well-proxied by standard "intelligence" benchmarks. Our findings go against current endeavors of defining, identifying, and targeting general intelligence as a tangible construct in language model development. This leaves the strategy of targeting a single conceptual ability without support, since the first-order abilities it would have to reach are often partially idiosyncratic and not identifiable in practice.
---

%% NOTE ON NUMBERS (updated 2026-09-23): the canonical run is
~/llm-coginterp/results/10perc.canon.zip (extracted to
results/text_only/10perc.canon), 10% target density, R2 gate 0.2. The mean and
zeros baselines are dropped, since the canon run does not factor them. The
abstract's 74.7% was the mean-imputation C_standard omega_h. It is now 69.5%, the
missForest C_standard solution, the highest omega_h among the 36 canon solutions.
The canon data matrices are byte-identical to the older 10perc run, so the corpus
counts and Table 2 below are unaffected.

Older note (2026-09-19, verified against ~/llm-coginterp):
The CORPUS is 456 benchmarks / 1,618 models / 13,251 rows, quoted by the abstract and
§Introduction, and it is settled.

Methodology Table 2 is a different object, the aggregated MATRIX dimensions, and it is
now CURRENT, not provisional. All eight rows reproduce exactly by re-running
collapse_results.py and densify.py on the present corpus. The raw pair is 1,266 x 404 at
2.2 % and 334 x 380 at 3.5 %. The observation floor is 3, matching the Methodology text.
Do not mix the two objects: 14,838 was a corpus row count and 1,310 x 455 were matrix
dimensions from a run predating the score-redundancy pruning. Neither is current.

What IS still provisional is Results Table 3 and Tables 4 to 7. The factor analyses
behind them were run on 2026-09-10 against matrices densified on 2026-07-20, both of
which predate the corpus update of 2026-09-16. Those tables must be regenerated
together.

This note previously pointed at "Appendix-Methods L.3a", which no longer exists. The
current appendix runs A to I and Main.md embeds sections/appendix/, not the root-level
Appendix-Methods.md. %%

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

<!-- Merged to data section -->
<!-- ![[sections/appendix/inclusion-and-exclusion-criteria]] -->
<!-- ![[sections/appendix/normalisation-rules]] -->

<!-- Dont think this is needed -->
<!-- ![[sections/appendix/text-only-classifier]] -->

![[sections/appendix/score-redundancy-pruning]]

![[sections/appendix/model-identity-collapse]]

![[sections/appendix/densification-algorithm]]

![[sections/appendix/imputation-methods]]

![[sections/appendix/imputation-evaluation]]

![[sections/appendix/factor-analysis-details]]

![[sections/appendix/benchmark-embedding]]

<!-- Supplementary results, in the order Results cites them. Reordered
2026-09-26 (was: label cohesion, common-subject UMAP, imputation results,
omega sensitivity, g-rankings, release date). Label cohesion is last here at
the authors' request, since its long tables come after its explanation. -->

![[sections/appendix/release-date-analysis]]

![[sections/appendix/benchmark-g-rankings.md]]

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

![[sections/appendix/common-subject-distances]]

<!-- Software environment and reproduction was deleted in pass 5. It was a
repository README (shell commands, output paths, SQLite table names, package
lists). The two facts worth keeping moved into the Implementation paragraph at
the end of sections/Methodology.md, which also carries a TODO for the code and
data availability statement. -->
