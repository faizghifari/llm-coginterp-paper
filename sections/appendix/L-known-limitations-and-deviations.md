# L Known limitations and deviations {-}

## L.1 Metric heterogeneity — resolved for metric choice, open for direction and scale. {-}

The corpus spans 238 distinct metric names. Averaging them within a (model, benchmark) pair is now prevented by the canonical-metric filter ([[C-normalisation-rules#C.5 Canonical metric selection|Appendix C.5]]), which was not a tidying exercise: 92 benchmarks were affected, and because metric assignment tracks the evaluating leaderboard, the mixed columns carried source-determined variance that a factor analysis would have reported as capability structure.

Three residues remain. (i) **Direction** is recorded but not applied, so a lower-is-better benchmark contributes a sign-flipped column; in a correlation-based analysis that shows up as a negative loading rather than a bias, but orienting all columns before analysis would be cleaner. Three benchmarks (`xstest`, `DarkBench`, `SpiralBench`) previously mixed both directions within a single column; the metric filter resolves these incidentally, by keeping only one metric. (ii) **Scale**: one row remains negative, `pwc_lidirus` at MCC −0.013, because MCC is natively −1…1 and sits in a 0–100 column — legitimate at source, wrong for this column. (iii) **Twelve columns sit on a 0–1 scale** rather than the documented 0–100 (`cogbench`, `creativityprism`, `engibench`, `litbench`, `rpgbench`, `workplacehumor`, `ProphetArena`, `StrongREJECT`, `FlashInfer-Bench`, `MoralMachine`, and two others). Each is internally consistent, so column standardisation absorbs it and no correlation is affected — a schema violation rather than an analysis defect, but worth normalising for tidiness. Scale contamination that standardisation could *not* absorb, because it varies within a column, is handled separately in [[C-normalisation-rules#C.6 Defects below the metric name|Appendix C.6]].

## L.1a Single-row anomaly, removed. {-}

`kaggle_jonlipovetz_game_arena` recorded DeepSeek V3.2 at 3114.0 while every other model on that benchmark falls between 2.97 and 363.72 — 8.5× the next-highest value, almost certainly a unit error at source. It is not repairable: the Kaggle benchmark page serves no leaderboard data without authentication, and 3114 is equally consistent with a mis-scaled 311.4 or 31.14, so the intended value cannot be recovered from the column either. The row is dropped from the derived copy and retained in the canonical tables, which archive what sources published.

## L.2 `iterativepca` deferred. {-}

Implemented but excluded from all results ([[H-completion-methods#H.1 Cell-level methods|Appendix H.1]]); its cross-validation is intractable at this size and its sensitivity path was never migrated to the shared metric.

## L.3 Densifier floor constant. {-}

The matrices analysed here were produced with `MIN_OBS = 2` ([[G-densification-algorithm#G Densification algorithm|Appendix G]]), which is what the shipped densified tables and their summary record. The constant currently in the repository source is 3. The difference is not cosmetic — recomputed on the pruned corpus, moving 2 → 3 costs about an eighth of the models on the column-primary peel (C/all_standard 786 → 689, C/all_aggressive 232 → 205) and trims the benchmark axis on the row-primary peel (R/all_standard 333 → 300 columns, R/all_aggressive 356 → 320), while leaving the symmetric peel untouched at 682 × 130 and 128 × 296. The value must be pinned and stated in the paper, and Table 3 regenerated to match whichever is chosen.

## L.3a Tables 2 and 3 are provisional. {-}

Both were read off matrices generated before the score-redundancy pruning and still contain all 47 pruned columns. Recomputed values are recorded in a comment beside Table 2 in [[Methodology|the Methodology]]. They must be replaced together with the Results tables, not before, or the paper becomes internally inconsistent.

## L.4 Coverage of the newest completion methods. {-}

SoftImpute-corr, OptSpace, USVT, CVXR, and GGM were added most recently and have not yet been run across the full design; the reported results cover SoftImpute, k-NN, missForest, and OneSidedMC. The paper should state explicitly which methods each reported table covers.

## L.4a Trust threshold dropped from CVXR and GGM. {-}

These two began as no-imputation variants that constrained only pairs with at least 10 co-observations, leaving thinner pairs for the completion to determine. When they were reclassified as correlation-level imputers, that filter was not carried over: every computable pairwise correlation now enters as a constraint. A `min_n` argument survives on both functions but is unused by CVXR and, for GGM, is recorded as the reported hyperparameter without being applied. Either restore the threshold or drop the vestigial argument and state plainly that no threshold is used — the current state records a parameter that does nothing.

## L.4b Band widths use full-data co-observation counts. {-}

CVXR derives its per-pair Fisher-*z* band from co-observation counts computed on the complete matrix, including cells that are held out for scoring. The effect is small — it changes constraint widths, not correlation values — but it means the held-out score is very slightly optimistic, and it should be computed on the training split for strictness.

## L.5 Seed sweep measures split variance only. {-}

The sensitivity sweep varies the holdout split under a fixed missingness pattern. It is not a test of MNAR robustness; the cross-densifier comparison is the closest available proxy, and even that varies the *induced* pattern rather than the underlying selection mechanism.

## L.6 Surrogate matrices are not data. {-}

For OneSidedMC and the correlation-level methods, what reaches the factoring stage is a covariance-matched synthetic matrix ([[H-completion-methods#H.3 Correlation-matrix completion and surrogate synthesis|Appendix H.3]]). Any per-model statistic computed from those matrices is meaningless; only benchmark-space (loading) quantities are interpretable.

## L.7 Score provenance is transcribed, not re-run. {-}

All scores are as published. Where two sources disagree about the same evaluation, we resolve by trust tier and recency rather than by re-evaluation, and we do not attempt to correct for differences in undocumented evaluation setup between sources.

## L.8 Benchmark dates are much weaker than model dates. {-}

Coverage on the two axes is almost identical (99.7 % of models, 99.8 % of benchmarks) and the similarity is misleading. The model axis was repaired to the point where 78 % of rows rest on an exact identifier, a repository timestamp, or a verified announcement; the benchmark axis has had no equivalent pass, and 85 % of its rows remain on `existing` (302) or `corroborated_year` (162). A quarter of benchmark dates are year-only, against 2.3 % of model dates. Any temporal analysis should therefore run on the model axis; benchmark dates are usable for coarse ordering at best. The repair should be cheaper on this axis than it was on the other, because nearly every benchmark has a paper and an arXiv identifier decodes to an exact month with no fetching at all — the `arxiv_id` tier currently contains a single row.

## L.9 Release date is metadata, not an analysis input. {-}

No stage of the pipeline reads `release_date`: densification, completion and factoring operate on the score matrix alone. The field exists for cohort and temporal analyses and for the corpus's value as a standalone artefact, and none of the results reported here depend on it. This also means the dating work described in [[A-data-sources-and-extraction#A.5 Release-date provenance|Appendix A.5]] cannot have influenced any reported factor structure.
