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

## Deductive fills

Two rules are applied, both entailed by the record rather than inferred from it:

1. **Closed models accessed by API.** A model whose type is `closed` cannot have been run locally; its inference platform is set to `api` and its engine to `api (unspecified)`. No engine is ever guessed for open-weights models.
2. **`lm-eval-harness` decoding.** For benchmarks *verified* to use EleutherAI's `lm-eval-harness`, generative tasks default to greedy decoding, so `generation_temperature = 0.0` is recorded. This is applied only where harness usage is documented, never inferred from the benchmark being open-source.

Everything else — inference stack for open models, decoding parameters for benchmarks whose papers omit them, and all fields for "bring your own predictions" benchmarks — is left blank. Aggregator sources that do not publish their engineering stack contribute no inference metadata at all.

## Release-date provenance

`release_date` is recorded as year-month, and `release_date_source` records the evidence class it came from. The tiers are ordered, and the ordering is the point: a filter on this column is the only way to use the field responsibly.

| tier | evidence | models | benchmarks |
|-----------|------------------------|------|---------|
| `arxiv_id` | an arXiv identifier already in the record; `YYMM.NNNNN` decodes to the month exactly | 0 | 1 |
| `hf_createdat` | `createdAt` of a HuggingFace repository whose name *is* the model | 921 | 0 |
| `verified_arxiv` | the model's own paper, confirmed by reading its title | 39 | 2 |
| `name_stamp` | the identifier carries its own date (`gpt-4-1106-preview`) | 1 | 0 |
| `web_verified` | a page fetched and confirmed to name this model *and* carry this date | 605 | 0 |
| `sourced_evidence` | a citation exists but could not be re-read by a non-browser client | 129 | 86 |
| `corroborated_month` | two independent systems agreed to the month | 9 | 5 |
| `web_cited` | a real citation whose page is bot-blocked, paywalled, or JS-only | 135 | 0 |
| `corroborated_year` | two systems agreed to the year only | 36 | 162 |
| `base_model_date` | an eval/method variant inheriting its base model's date | 2 | — |
| `single_hermes`, `single_haiku` | one uncorroborated model answer; measured error ≈ 30 % | 103 | 65 |
| `existing` | a date already present before this pass, of unrecorded origin | 27 | 302 |
| (blank) | undated | 7 | 1 |

Grouping the first five as *strong*: **1,566 of 2,014 model rows (78 %)** against **3 of 624 benchmark rows (0.5 %)**.

### Verification is three-way, not binary.

Every dated answer carrying a citation was re-checked by fetching the cited page and asking two questions: does it name this model, and does it carry this date. The outcomes are **verified**, **unverifiable** (the page is bot-blocked, paywalled, or JavaScript-only — no evidence either way), and **contradicted** (the page read cleanly and did not support the claim). Only the third is evidence of an error. Of 565 dated answers, 404 verified (72 %), 96 were unverifiable and 65 contradicted.

The distinction that matters is that **a contradicted verdict impugns the citation, not necessarily the date**, and in this corpus the two came apart in both directions. `starcoder2-15b` answered 2023-05 and cited the StarCoder *2* paper, which is 2024-02: the citation is right and the answer wrong. `starcoderbase` answered 2023-05 and cited an unrelated paper: the answer is right and only the citation wrong. Because the same verdict demanded opposite handling, the bucket could not be applied or discarded wholesale, and all 65 rows were re-checked individually against evidence independent of the original citation. 61 were resolved and are recorded with their per-row evidence in the repository's `notes/release_date_hand_resolutions.md`; four were left at their existing values because no identity-given source could be found.

### Two lower bounds, and only one of them is sound.

A repository cannot postdate the model it distributes, so `createdAt` is a genuine lower bound — but it can sit well below the release: `bigcode/starcoder2-3b` was created 2023-11-29 for a model that became public in 2024-02. A paper date is *not* a lower bound, because papers routinely trail the release: `EleutherAI/pythia-12b` had a public, archived model page on 2023-02-03, two months before the Pythia paper. We built a guard taking the later of the two, and discarded it after measuring it — of the seven rows it moved, one was right and at least five were wrong. `hf_createdat` is therefore used unmodified and documented as a lower bound, with individual cases corrected by hand rather than by rule.

### Failure modes that recur.

Three are worth naming because each produced errors that survived an earlier pass. (i) *Family attribution*: a page about the family, or about a later version, supplies a real date for the wrong artefact. (ii) *Staged releases*, which are family attribution inside a single model line — GPT-2 shipped in four tranches (124M 2019-02, 355M 2019-05, 774M 2019-08, 1.5B 2019-11, each datable from the publisher's own commits), and six corpus rows had collapsed them onto one date. (iii) *Name collision*: `SGPT-2.7B-msmarco` was dated 2019-02 as though it were a GPT-2 variant; it is SGPT, 2022-02.

### The known bias is toward being early.

Dates produced by asking a language model run systematically early for models released after that model's training cutoff. Correcting the weak tiers moved 119 model dates, 85 of them later — the bias being paid down where it was concentrated. Twenty rows moved by a year or more, several by two (`GPT-4.1` 2023-03 → 2025-04, `Gemini 3 Pro` 2023-12 → 2025-11).

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

## Defects below the metric name

Two problems survive metric selection because they are not distinguishable by metric name at all.

**Source-level scale conflict (`gpqa`).** One metric name, two incompatible conventions, told apart only by source: 447 of 454 rows are Open LLM Leaderboard v2 **normalised** accuracy — the random-chance baseline mapped to zero, negatives clamped there — spanning 0.00–24.94 with median 4.36, while the other 7 are raw accuracy from papers and llm-stats spanning 39.0–94.1. The ranges do not overlap. We keep the 447 and drop the 7. The reasoning is that correlations are invariant under a linear rescaling of an entire column, so a normalised column is fully usable provided every row shares the convention; back-transforming instead ($\text{raw} = 0.75\,\text{norm} + 25$) would assume the leaderboard's formula and would still not undo the clamp, for the sake of 7 models out of 454. The documented caveat is that 56 of the 447 (13 %) sit exactly at 0.00, tied at the clamp, so the column under-discriminates among weak models.

The same detector — benchmarks whose sources have strictly non-overlapping score ranges — flags three others (`wildbench`, `sea_exam`, `multipl_e`), all on small $n$. We do not act on those: a gap alone is not evidence of a scale conflict, because frontier-model trackers such as llm-stats legitimately show higher ranges than broad leaderboards by evaluating better models. `gpqa` is the only case with a known mechanism.

**Structurally defective column (`elephant`).** Its `metric_name` field holds model *configurations* (`DPO-All-Llama-8B`, `iti-llama-70b`, `perspective-gpt-4o`), not metrics, so selecting a canonical metric keeps one arbitrary configuration, which measures nothing. The benchmark is removed from the derived copy (9 models) and recorded for re-extraction.

Two further columns that appear in earlier drafts as defects — `vectara`, whose two metrics are complements differing by +86.5 across 7 shared models, and `pwc_lambada`, which mixed accuracy with perplexity — are **resolved by the metric filter itself** and need no special handling.
