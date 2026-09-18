# Data source and normalization

## Source inventory

The corpus is assembled from published evaluation records. Sources fall into four tiers, used along with recency to resolve duplicate scores from different sources.

**Tier 1 — curated evaluation suites** (standardised harness, documented setup, one evaluator across many models):

| Suite | Sub-leaderboards used |
|---|---|
| Stanford HELM (CRFM) | Classic, Lite, Safety, Reasoning, MedHELM, SEA-HELM, Arabic, ThaiExam, EWoK, TORR, Finance |
| HuggingFace Open LLM Leaderboard | v1, v2 |

**Tier 2 — aggregators and result trackers**: Papers With Code evaluation tables, Kaggle AI Benchmarks, llm-stats.com, Artificial Analysis, Vellum, LiveBench, Chatbot Arena / LMArena, pricepertoken.com.

**Tier 3 — benchmark-specific leaderboards**: e.g. BigCodeBench, CRUXEval, SWE-bench, BFCL (Gorilla, UC Berkeley), VMLU, SEA-LION, PubMedQA, AlpacaEval, etc.

**Tier 4 — primary papers**: arXiv, ACL Anthology, OpenReview, and journal articles reporting original evaluations (e.g. ELEPHANT, SI-Bench, Swiss-Bench), used both as the source of record for benchmark metadata and, where no leaderboard exists, as the source of scores.

`\label{tab:a1}`{=latex}**Table A1.** Composition of the text-only corpus by source family (13,251 result rows over 456 benchmarks and 1,618 models).

| Source family | Result rows | Distinct benchmarks |
|---|---:|---:|
| Stanford HELM | 4,942 | 138 |
| HF Open LLM Leaderboard | 4,529 | 12 |
| Papers With Code | 1,378 | 151 |
| Kaggle AI Benchmarks | 844 | 26 |
| Primary papers | 587 | 95 |
| Other named leaderboards | 420 | 45 |
| Chatbot Arena / LMArena | 202 | 1 |
| llm-stats.com | 121 | 11 |
| Vellum | 96 | 7 |
| Artificial Analysis | 77 | 2 |
| LiveBench | 55 | 1 |

## Extraction routes

- **Papers With Code.** The public API is defunct (the domain redirects to HuggingFace). Evaluation tables are instead read from the daily-published parquet dataset `pwc-archive/evaluation-tables` (4 shards). Each parquet row is one *task* with nested datasets, each carrying its own leaderboard; extraction flattens task → dataset → leaderboard row into result rows, generating benchmark identifiers under a `pwc_` namespace and applying the scope filter (`\hyperref[benchmarks]{Appendix~\ref*{benchmarks}}`{=latex}) to exclude non-LLM tasks.
- **Kaggle AI Benchmarks.** Community-maintained leaderboard datasets, extracted per dataset owner and namespaced `kaggle_<owner>_<benchmark>`; the owner namespace is retained precisely so that cross-source duplicates remain detectable — and several were subsequently detected (`\hyperref[score-redundancy-pruning]{Appendix~\ref*{score-redundancy-pruning}}`{=latex}).
- **Stanford HELM.** Extracted per sub-project into staging files, then merged; the staging→merge pattern exists so that a partial or malformed extraction can be discarded without touching the canonical tables.
- **Papers and repositories.** ArXiv PDFs and abstracts converted to HTML for methodology extraction; GitHub READMEs and evaluation scripts read directly from `raw.githubusercontent.com` (both default-branch names); HuggingFace dataset cards via the Hub API.

## Inclusion and exclusion criteria

### Models

**Included:** general-purpose generative LLMs; domain- or task-adapted models (code, medical, legal) that still accept arbitrary prompts; multimodal models built by adding an encoder to an LLM backbone, provided the backbone still handles arbitrary text prompts.

**Excluded:** encoder-only or classification-only architectures (BERT, RoBERTa, BigBird); narrow single-purpose systems that cannot be prompted generally (dedicated MT systems such as NLLB, speech systems such as SeamlessM4T, TTS/ASR); bare embedding or vision encoders (CLIP variants, ST5, monoT5); non-deployable research systems; and undocumented community uploads without reliable provenance.

### Benchmarks

We remove benchmarks that has zero results after filtering models. We further select for benchmarks that do not require multimodal capabilities such as XXX

### Benchmark translation duplicates

- *Removed* (literal translations of an original already in the corpus; 28 identifiers, 992 rows): MGSM per-language variants (250 GSM8K problems manually translated into 10 languages — English variant kept), Global MMLU Lite per-language variants (machine-translated and post-edited MMLU — English variant kept), a human-translated Arabic MMLU, OpenAI's Multilingual MMLU aggregate, Global MMLU aggregates, and IndicXNLI (machine-translated from XNLI).
- *Consolidated* (translated, but no original present in our import to prefer — merged into the parent identifier with the `language` field backfilled; 8 identifiers, 168 rows relabelled, zero rows lost): XCOPA, XNLI, XQuAD per-language splits.
- *Left intact* (verified independently sourced per language, not parallel translations): MultiLoKo (locally-sourced Wikipedia content per language), ArabicMMLU (natively sourced from Arabic school exams), FLORES translation directions (each direction is a distinct task), LINDSEA, Thai national exams, and Papers With Code WMT and CoNLL language-pair benchmarks.

## Duplicate detection and integrity checks

The duplicate identity key is the tuple (model, benchmark, metric, setup, source, model identifier, language). Duplicates are reported in two classes: **pure redundancy** (identical score reported twice) and **conflicts** (different scores under one identity). Conflicts are resolved by source-trust tier (`\hyperref[source-inventory]{Appendix~\ref*{source-inventory}}`{=latex}) and recency, and the report is always reviewed before any automated resolution runs.

The integrity pass asserts: zero foreign-key violations in both directions; zero models with no result rows; zero benchmarks with no result rows; and flags benchmarks with fewer than five rows for manual review. It is run after every write, including after each of the pruning passes in `\hyperref[score-redundancy-pruning]{Appendix~\ref*{score-redundancy-pruning}}`{=latex}.

Link validity was checked by a multi-threaded URL sweep across both metadata tables, ignoring anti-bot 403s, repairing moved repositories, and filling 53 previously-blank benchmark source links.

## Score Normalization

Scores are normalised to a 0–100 scale: a raw value in $[0,1]$ is multiplied by 100; a value above 1 is kept as-is; results are capped at 100 to absorb floating-point noise. Exempt metrics, kept on their native scale, are perplexity, bits-per-byte, BLEURT, BERTScore, Elo, and count-type metrics ("# eval").

## Canonical metric selection

Applied to the derived copy after the benchmark removals, so coverage is counted over the surviving population. Selection proceeds in four steps, first match wins:

1. **Normalise** — strip, casefold, collapse internal whitespace. This alone resolves `gsm8k`, `fever`, `humaneval` and `winogrande`, whose only "conflict" was `Accuracy` vs `accuracy`; skipping it would have discarded 149 `gsm8k` rows.
2. **Alias** — a curated map merges verified spelling variants of one measurement: `bits per byte` → `bpb` (`the_pile`, recovering 23 models), `equivalent (chain of thought)` → `equivalent (cot)` (`math_chain_of_thought`; 13 models carry both, mean within-model difference +0.16, sd 1.82 — the same measurement typed twice by two importers, and treating them as rivals would have cost 56 models), `acc` → `accuracy`, and RACE's own `race-h`/`race-m` shorthand.
3. **Override** — a per-benchmark pin for cases where coverage chooses badly.
4. **Coverage** — otherwise the metric covering the most distinct **models** (not rows: one leaderboard can contribute many rows for few models), tie-broken by row count then by name for determinism.
