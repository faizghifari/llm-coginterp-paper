# E Score-redundancy pruning {-}

Applied to the text-only copy only, after [[D-text-only-classifier#D Text-only classifier|Appendix D]]. Each family was audited by computing the full pairwise Pearson correlation among its columns over the models evaluated on both columns; the removal decision was taken per family, on the evidence, and the resulting cascades were verified to orphan no models.

| Family | Correlation evidence | Decision | Rows removed |
|----------------|--------------|------------|--------|
| LiveCodeBench release windows v1–v6 (Kaggle) | mean pairwise $r = 0.995$, worst pair $0.987$, over 45 shared models | Keep the aggregate, drop 6 per-version identifiers | 270 |
| TwitterAAE dialect splits (`_aa`, `_white`) | $r = 0.993$–$0.999$ with each other and the parent, over 32 shared models | Keep the parent, drop both dialect splits | 64 |
| GPQA variants (few/zero-shot × diamond/main, Kaggle) | mean $r = 0.944$, worst pair $0.915$, over 46–47 shared models; better-populated canonical `gpqa` and `gpqa_diamond` already present | Drop all 4 Kaggle variants | 185 |
| MultiLoKo per-language splits (31 languages, Kaggle) | mean pairwise $r = 0.82$; near-duplicate for well-resourced pairs (Simplified/Traditional Mandarin $0.989$, Italian/Swedish $0.983$); low-resource pairs noisy on small overlap | Keep the paper-sourced `multiloko` across-language aggregate, drop all 31 per-language identifiers | 1,523 |
| `kaggle_aminmohamedmohami_mmlu` | Cross-source re-import (44 rows) of canonical `mmlu` (468 rows) | Drop the re-import | 44 |
| `kaggle_andrewmingwang_scicode` | Not a third metric: per-model value matching shows it splices `scicode_main_standard` scores for 30 of 46 models and `scicode_subproblem_standard` for the other 13 — a scraping artefact | Drop as a data-integrity fix; the 4 explicit split variants ($r = 0.71$–$0.96$) are **kept**, as their correlations are not uniform enough to treat as duplicates | 46 |
| Stanford HELM ThaiExam sub-splits | Two clusters, not uniform redundancy: {ONET, IC, A-Level} at $r = 0.92$–$0.95$; {TGAT, TPAT1} correlate weakly with that cluster ($r = 0.70$–$0.88$). The TGAT/A-Level gap was verified as systematic, not noise (several multilingual models score 35–45 points higher on TGAT) | Drop ONET and IC; **keep** A-Level as the knowledge-cluster representative and keep TGAT and TPAT1, which carry distinct variance | 84 |
| | | **Total** | **2,216** |

Two of the eight audited families were thus deliberately left partially or fully intact, which is the point of auditing by correlation rather than by name. This pass leaves 456 benchmarks; the canonical-metric filter ([[C-normalisation-rules#C.5 Canonical metric selection|Appendix C.5]]), the source-scale fix and the single-row anomaly removal ([[L-known-limitations-and-deviations#L Known limitations and deviations|Appendix L, L.1a]]) then drop a further 1,463 result rows, for a final corpus of **456 benchmarks, 1,618 models, 13,251 result rows**.
