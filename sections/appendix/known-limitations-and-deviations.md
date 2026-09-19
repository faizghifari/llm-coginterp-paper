# Limitations

All scores in the corpus are as published, and we evaluate no model ourselves. This means we do not control the evaluation conditions behind any score, and we make no attempt to correct for differences in undocumented evaluation setup between sources. Where two sources disagree about the same evaluation, we resolve by trust tier and recency rather than by re-evaluation. Release dates are recorded as corpus metadata rather than as an analysis input, and no result reported here depends on them.

Metric direction is recorded but not applied, so a lower-is-better benchmark contributes a sign-flipped column. In a correlation-based analysis this shows up as a negative loading rather than as a bias, though orienting every column before analysis would be cleaner.

Not every completion method we implement is carried through the full design. The results reported here cover SoftImpute, k-NN, missForest and OneSidedMC. The correlation-level estimators added most recently have not been run across every densifier and collapse strategy, and regularised EM-PCA is excluded entirely because its built-in cross-validation is intractable at this matrix size.

<!-- Pass 4, second cut, 2026-09-19. Twelve worklog subsections became seven
paragraphs, and seven paragraphs are now three. Title shortened to "Limitations",
which changes the pandoc label from known-limitations-and-deviations to
limitations; the two incoming cross-references were removed rather than
repointed, for the reasons below.

Only four facts survive, each checked against the rest of the paper first and
each unstated anywhere else:

1. Scores are transcribed, not re-run, and undocumented setup differences go
   uncorrected. The data appendix says the corpus is "assembled from published
   evaluation records", which implies the transcription but never states the
   consequence. This is the strongest limitation the paper has and it had been
   sitting tenth out of twelve.
2. Metric direction is recorded but not applied. Stated nowhere embedded. The
   only other copy is in normalisation-rules.md, which Main.md does not embed.
3. Which completion methods the reported results actually cover. The Methodology
   introduces nine or so, Results shows a subset, and nothing reconciled the two.
4. Release dates are metadata. Methodology spends a sentence on collecting them
   and the data appendix spends a section on their provenance, so a reader is
   owed one line saying no result depends on them.

CUT, each already stated or implied elsewhere:

- Scale residues (one negative Matthews row, twelve columns on a 0-to-1 scale).
  Both are absorbed by column standardisation and neither affects a correlation,
  so they are schema trivia rather than limitations.
- The single-row anomaly. The Score-redundancy pruning appendix already states
  that a single-row anomaly removal contributes to the 1,463 dropped rows, which
  is as much as a reader needs.
- The missing co-observation threshold on the two correlation-level estimators.
  The Completion methods appendix states it in full at the end of its
  correlation-completion section.
- Band widths computed on full-data co-observation counts. A caveat on a method
  that paragraph 3 says is not in the reported results.
- Surrogate matrices are not data. The Completion methods appendix already says
  the surrogate is "not an imputation of the real cells".
- The sensitivity sweep measuring split variance only. The sweep itself is not
  reported anywhere in the paper, so a caveat on it has nothing to attach to.
- The benchmark-versus-model date quality gap (78 %, 79 %, three in ten, 1.9 %).
  Relevant only to a temporal analysis, which this paper does not contain. The
  numbers are still in the Release-date provenance section of the data appendix.

TWO CROSS-REFERENCES REMOVED, both of which pointed here for content now cut:
completion-methods.md pointed here after stating the co-observation threshold
issue itself, and score-redundancy-pruning.md pointed here for the single-row
anomaly. Both sentences read correctly without the pointer.

STILL TRUE AND NO LONGER ANYWHERE IN THE PDF: Results Table 3 and Tables 4 to 7
come from factor analyses run 2026-09-10 against matrices densified 2026-07-20,
predating the 2026-09-16 corpus update. Recorded in the NOTE ON NUMBERS block at
the top of Main.md. Re-running them is the only thing between this draft and an
unflagged internal inconsistency.

Full superseded text of every cut section is in git at c05e4d5. -->
