# Score-redundancy pruning

Applied to the text-only copy only, after the scope filter of `\hyperref[benchmarks]{Appendix~\ref*{benchmarks}}`{=latex}. Each family was audited by computing the full pairwise Pearson correlation among its columns over the models evaluated on both columns. The removal decision was taken per family, on the evidence, and we verified that the resulting cascades orphan no models.

`\label{tab:a3}`{=latex}**Table A3.** Benchmark families audited for score redundancy, with the correlation evidence and decision for each.

| Family | Correlation evidence | Decision | Rows removed |
|----------------|--------------|------------|--------|
| LiveCodeBench release windows v1–v6 (Kaggle) | mean pairwise $r = 0.995$, worst pair $0.987$, over 45 shared models | Keep the aggregate, drop 6 per-version identifiers | 270 |
| TwitterAAE dialect splits (African-American and White English) | $r = 0.993$–$0.999$ with each other and the parent, over 32 shared models | Keep the parent, drop both dialect splits | 64 |
| GPQA variants (few/zero-shot × diamond/main, Kaggle) | mean $r = 0.944$, worst pair $0.915$, over 46–47 shared models, with the better-populated canonical GPQA and GPQA Diamond already present | Drop all 4 Kaggle variants | 185 |
| MultiLoKo per-language splits (31 languages, Kaggle) | mean pairwise $r = 0.82$, near-duplicate for well-resourced pairs (Simplified/Traditional Mandarin $0.989$, Italian/Swedish $0.983$) and noisy for low-resource pairs on small overlap | Keep the paper-sourced MultiLoKo across-language aggregate, drop all 31 per-language identifiers | 1,523 |
| A Kaggle re-import of MMLU | Cross-source re-import (44 rows) of the canonical MMLU column (468 rows) | Drop the re-import | 44 |
| A Kaggle re-import of SciCode | Not a third metric. Per-model value matching shows it splices main-problem scores for 30 of 46 models and sub-problem scores for the other 13, which is a scraping artefact | Drop as a data-integrity fix. The 4 explicit split variants ($r = 0.71$–$0.96$) are **kept**, as their correlations are not uniform enough to treat as duplicates | 46 |
| Stanford HELM ThaiExam sub-splits | Two clusters, not uniform redundancy: {ONET, IC, A-Level} at $r = 0.92$–$0.95$, while {TGAT, TPAT1} correlate weakly with that cluster ($r = 0.70$–$0.88$). The TGAT/A-Level gap was verified as systematic, not noise (several multilingual models score 35–45 points higher on TGAT) | Drop ONET and IC, and **keep** A-Level as the knowledge-cluster representative and keep TGAT and TPAT1, which carry distinct variance | 84 |
| | | **Total** | **2,216** |

Two of the seven audited families were thus deliberately left partially or fully intact, which is the point of auditing by correlation rather than by name. This pass leaves 456 benchmarks. The canonical-metric filter (`\hyperref[canonical-metric-selection]{Appendix~\ref*{canonical-metric-selection}}`{=latex}), the source-scale fix and the single-row anomaly removal then drop a further 1,463 result rows<!-- Pointer to Appendix known-limitations-and-deviations removed: that appendix is now Limitations and no longer describes the anomaly, and this sentence states the outcome on its own. -->, for a final corpus of **456 benchmarks, 1,618 models, 13,251 result rows**.
