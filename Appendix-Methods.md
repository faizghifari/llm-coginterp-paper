%% Methodological appendix supporting [[Methodology]]. Section letters A–L are
referenced from the methodology text as `Appendix A`, `Appendix B`, … Everything
here is implementation detail: it should be reproducible from this document plus
the analysis repository, and none of it is required to follow the argument. %%

# Methodological appendix

Companion to [[Methodology]]. Conceptual definitions of the latent-variable model
are in [[Appendix#Definitions]].

### A Data sources and extraction

#### A.1 Source inventory

The corpus is assembled from published evaluation records. Sources fall into four tiers, which also define the trust ordering used for conflict resolution ([[#C.4 Duplicate detection and integrity checks]]).

**Tier 1 — curated evaluation suites** (standardised harness, documented setup, one evaluator across many models):

| Suite | Sub-leaderboards used |
|---|---|
| Stanford HELM (CRFM) | Classic, Lite, Safety, Reasoning, MedHELM, SEA-HELM, Arabic, ThaiExam, EWoK, TORR, Finance |
| HuggingFace Open LLM Leaderboard | v1, v2 |

Two further HELM leaderboards (Audio, Image2Struct) were collected but are removed in full by the text-only restriction ([[#D Text-only classifier]]).

**Tier 2 — aggregators and result trackers**: Papers With Code evaluation tables, Kaggle AI Benchmarks, llm-stats.com, Artificial Analysis, Vellum, LiveBench, Chatbot Arena / LMArena, pricepertoken.com.

**Tier 3 — benchmark-specific leaderboards**: e.g. BigCodeBench, CRUXEval, SWE-bench, BFCL (Gorilla, UC Berkeley), VMLU, SEA-LION, PubMedQA, AlpacaEval, Video-MME (multimodal; removed by [[#D Text-only classifier]]), plus ~35 further named sources each contributing a single benchmark's leaderboard.

**Tier 4 — primary papers**: arXiv, ACL Anthology, OpenReview, and journal articles reporting original evaluations (e.g. ELEPHANT, SI-Bench, Swiss-Bench), used both as the source of record for benchmark metadata and, where no leaderboard exists, as the source of scores.

By URL host, the text-only corpus resolves to: `crfm.stanford.edu` (HELM), `huggingface.co` (Open LLM Leaderboard and dataset cards), `kaggle.com`, `paperswithcode.com`, `arxiv.org`, `chat.lmsys.org`, `llm-stats.com`, `raw.githubusercontent.com`, `vellum.ai`, `artificialanalysis.ai`, `livebench.ai`, `aclanthology.org`, and a long tail of benchmark-specific domains.

Table 1 in the main text reports each tier/family's row and benchmark counts, read off the recorded `source_organization` field. That field was blank or literally `Unknown` on 295 rows (2.2 %), spread across nearly every family rather than forming a family of its own; each was reattributed by source name and URL host instead of left uncategorised — GitHub-hosted benchmark READMEs (`raw.githubusercontent.com`, `vmlu.ai`, `swebench.com`, and similar) to Tier 3, and arXiv, ACL Anthology, OpenReview, ACM Digital Library and journal hosts to Tier 4. This moved 157 rows into Tier 4 and 120 into Tier 3, and gave Vellum and Artificial Analysis 12 and 6 rows respectively that had been recorded under their correct source name but not their organisation. Tier 3 in Table 1 ("Other named leaderboards") spans 30-odd single-benchmark leaderboards, e.g. BigCodeBench, CRUXEval, SWE-bench, BFCL/Gorilla, VMLU, SEA-LION, PubMedQA and AlpacaEval; Tier 4 ("Primary papers") spans arXiv preprints, ACL Anthology, OpenReview, ACM Digital Library, and journals such as *Nature* and *Frontiers*.

#### A.2 Extraction routes

- **Papers With Code.** The public API is defunct (the domain redirects to HuggingFace). Evaluation tables are instead read from the daily-published parquet dataset `pwc-archive/evaluation-tables` (4 shards). Each parquet row is one *task* with nested datasets, each carrying its own leaderboard; extraction flattens task → dataset → leaderboard row into result rows, generating benchmark identifiers under a `pwc_` namespace and applying the scope filter ([[#B.2 Benchmarks]]) to exclude non-LLM tasks.
- **Kaggle AI Benchmarks.** Community-maintained leaderboard datasets, extracted per dataset owner and namespaced `kaggle_<owner>_<benchmark>`; the owner namespace is retained precisely so that cross-source duplicates remain detectable — and several were subsequently detected ([[#E Score-redundancy pruning]]).
- **Stanford HELM.** Extracted per sub-project into staging files, then merged; the staging→merge pattern exists so that a partial or malformed extraction can be discarded without touching the canonical tables.
- **Papers and repositories.** ArXiv PDFs and abstracts converted to HTML for methodology extraction; GitHub READMEs and evaluation scripts read directly from `raw.githubusercontent.com` (both default-branch names); HuggingFace dataset cards via the Hub API.

#### A.3 Schema

Three CSV tables with a deliberate non-obvious join: `results` links to `models` via the **`model_name`** column, matched against `models.model_id`. The `results.model_id` field is a *denormalised, source-specific* convenience field carrying the identifier as the source spelled it, and is **not** the foreign key. This is what makes cross-source duplicate detection possible after canonicalisation, and it is also the field that the aggregation step ([[#F Model-identity collapse]]) groups on.

`benchmarks` carries 37 columns (identity, category and subcategory, task type, domain, description, source links, metric metadata); `models` carries 24 (identity, developer, family, parameter and active-parameter counts, type, release metadata, and three denormalised aggregate columns); `results` carries 38 (the score and its metric metadata, evaluation setup, shot count, language, source attribution, inference environment, generation configuration, and provenance). The three aggregate columns in `models` (`benchmark_count`, `total_results`, `avg_score`) do not auto-update and are recomputed by an explicit pass after any edit to `results`.

#### A.4 Deductive fills (the only non-verbatim values)

Two rules are applied, both entailed by the record rather than inferred from it:

1. **Closed models accessed by API.** A model whose type is `closed` cannot have been run locally; its inference platform is set to `api` and its engine to `api (unspecified)`. No engine is ever guessed for open-weights models.
2. **`lm-eval-harness` decoding.** For benchmarks *verified* to use EleutherAI's `lm-eval-harness`, generative tasks default to greedy decoding, so `generation_temperature = 0.0` is recorded. This is applied only where harness usage is documented, never inferred from the benchmark being open-source.

Everything else — inference stack for open models, decoding parameters for benchmarks whose papers omit them, and all fields for "bring your own predictions" benchmarks — is left blank. Aggregator sources that do not publish their engineering stack contribute no inference metadata at all.

#### A.5 Release-date provenance

`release_date` is recorded as year-month, and `release_date_source` records the evidence class it came from. The tiers are ordered, and the ordering is the point: a filter on this column is the only way to use the field responsibly.

| tier | evidence | models | benchmarks |
|---|---|---:|---:|
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

**A.5.1 Verification is three-way, not binary.** Every dated answer carrying a citation was re-checked by fetching the cited page and asking two questions: does it name this model, and does it carry this date. The outcomes are **verified**, **unverifiable** (the page is bot-blocked, paywalled, or JavaScript-only — no evidence either way), and **contradicted** (the page read cleanly and did not support the claim). Only the third is evidence of an error. Of 565 dated answers, 404 verified (72 %), 96 were unverifiable and 65 contradicted.

The distinction that matters is that **a contradicted verdict impugns the citation, not necessarily the date**, and in this corpus the two came apart in both directions. `starcoder2-15b` answered 2023-05 and cited the StarCoder *2* paper, which is 2024-02: the citation is right and the answer wrong. `starcoderbase` answered 2023-05 and cited an unrelated paper: the answer is right and only the citation wrong. Because the same verdict demanded opposite handling, the bucket could not be applied or discarded wholesale, and all 65 rows were re-checked individually against evidence independent of the original citation. 61 were resolved and are recorded with their per-row evidence in the repository's `notes/release_date_hand_resolutions.md`; four were left at their existing values because no identity-given source could be found.

**A.5.2 Two lower bounds, and only one of them is sound.** A repository cannot postdate the model it distributes, so `createdAt` is a genuine lower bound — but it can sit well below the release: `bigcode/starcoder2-3b` was created 2023-11-29 for a model that became public in 2024-02. A paper date is *not* a lower bound, because papers routinely trail the release: `EleutherAI/pythia-12b` had a public, archived model page on 2023-02-03, two months before the Pythia paper. We built a guard taking the later of the two, and discarded it after measuring it — of the seven rows it moved, one was right and at least five were wrong. `hf_createdat` is therefore used unmodified and documented as a lower bound, with individual cases corrected by hand rather than by rule.

**A.5.3 Failure modes that recur.** Three are worth naming because each produced errors that survived an earlier pass. (i) *Family attribution*: a page about the family, or about a later version, supplies a real date for the wrong artefact. (ii) *Staged releases*, which are family attribution inside a single model line — GPT-2 shipped in four tranches (124M 2019-02, 355M 2019-05, 774M 2019-08, 1.5B 2019-11, each datable from the publisher's own commits), and six corpus rows had collapsed them onto one date. (iii) *Name collision*: `SGPT-2.7B-msmarco` was dated 2019-02 as though it were a GPT-2 variant; it is SGPT, 2022-02.

**A.5.4 The known bias is toward being early.** Dates produced by asking a language model run systematically early for models released after that model's training cutoff. Correcting the weak tiers moved 119 model dates, 85 of them later — the bias being paid down where it was concentrated. Twenty rows moved by a year or more, several by two (`GPT-4.1` 2023-03 → 2025-04, `Gemini 3 Pro` 2023-12 → 2025-11).

---

### B Inclusion and exclusion criteria

#### B.1 Models

**Included:** general-purpose generative LLMs; domain- or task-adapted models (code, medical, legal) that still accept arbitrary prompts; multimodal models built by adding an encoder to an LLM backbone, provided the backbone still handles arbitrary text prompts.

**Excluded:** encoder-only or classification-only architectures (BERT, RoBERTa, BigBird); narrow single-purpose systems that cannot be prompted generally (dedicated MT systems such as NLLB, speech systems such as SeamlessM4T, TTS/ASR); bare embedding or vision encoders (CLIP variants, ST5, monoT5); research systems that are architectures-with-a-name rather than deployable models; evaluation *metrics* misfiled as models (e.g. YiSi-1); and undocumented community uploads without reliable provenance.

**Not a separate model:** a different *setup* of the same model — context-length variant, reasoning or thinking mode, effort level, prompting scheme. These are recorded in the `setup` and `reasoning_enabled` fields on the result row.

Borderline cases are reviewed individually rather than by keyword. Documented outcomes include: T5/mT5/FLAN-T5 **kept** (encoder–decoder, but instruction-followable and generative); three genuine vision-language models whose names happened to match an exclusion keyword **kept**; and a model flagged only because a metadata bug had leaked its HuggingFace namespace into its developer field **kept**, with the metadata fixed.

`BigBird-Pegasus` was **removed**, which sharpens where the boundary sits. Pegasus is pretrained with gap-sentence generation *specifically for summarisation* and cannot be given an arbitrary instruction, so it fails the criterion that T5 passes; the data agrees, in that both of its benchmarks were summarisation tasks. The plain encoder-only BigBird variants had already been removed, and `pegasus` has since been added to the narrow-task pattern set so the classifier catches the family rather than relying on case-by-case review.

#### B.2 Benchmarks

A benchmark is included if it has at least one in-scope result row after model filtering. Zero-result stubs are removed from the benchmark table and logged for future collection. Removing non-LLM models therefore cascades: benchmarks whose entire evaluated population was out of scope (pure NER and MT leaderboards from Papers With Code, a vision-only task whose sole model was an image encoder) are removed as zero-result stubs.

No relevance or "is this really intelligence" filter is applied to benchmark content.

#### B.3 Multiple scores per model–benchmark pair

Rows differing in `setup`, `source_url`, or `language` are **legitimately distinct evaluations**, not duplicates, and are retained. A benchmark with few rows is flagged for review as a possible interrupted extraction, but the flag is never satisfied by averaging rows to hit a count.

---

### C Normalisation rules

#### C.1 Scores

Scores are normalised to a 0–100 scale: a raw value in $[0,1]$ is multiplied by 100; a value above 1 is kept as-is; results are capped at 100 to absorb floating-point noise. Exempt metrics, kept on their native scale, are perplexity, bits-per-byte, BLEURT, BERTScore, Elo, and count-type metrics ("# eval").

Metric direction is **recorded, not applied**: lower-is-better metrics (WER, perplexity) are stored with `metric_lower_is_better = True` and normalised identically. See [[#L Known limitations and deviations]] for the consequence this has for the covariance analysis.

#### C.2 Model identity

- **Organisation prefixes stripped** (`meta-llama/Llama-3-8B` → `Llama-3-8B`); the one pre-existing collision this would have created was resolved by hand before stripping.
- **Reasoning and effort tags merged** into the base name (`claude-3-7-sonnet-thinking`, `o3 high`), with the affected result rows marked `reasoning_enabled = True`.
- **Context-length variants merged** (`gpt-4-32k`, `gpt-4-128k` → `GPT-4`): context length is an evaluation setup, not a model identity.
- **Family disambiguation** where a bare name is ambiguous, using parameter count and evaluation year (e.g. Llama 7B/13B/70B → Llama 2; 405B → Llama 3.1); named variants (Llama 4 Scout/Maverick) stay distinct.
- **Status markers stripped** at extraction (`☠ ⚠ † ★ ✗ ✓ ⓪①②③④⑤`).
- **No blanket case normalisation.** The corpus uses mixed Title-Case (`GPT-4`, `Claude 3 Opus`); a wholesale relabel would rewrite hundreds of already-correct rows for no integrity gain. Only genuine same-model-two-spellings pairs are renamed, discovered by a fuzzy-match report over result rows whose `model_name` has no matching `model_id`.

#### C.3 Benchmark identity and translation duplicates

Benchmark identifiers are lowercase and serve as the primary key; identifier collisions across sources are resolved by adding result rows to the existing benchmark rather than creating a second benchmark row.

A dedicated pass distinguished **translation duplicates** from **natively multilingual benchmarks**, decided case-by-case against each benchmark's source paper:

- *Removed* (literal translations of an original already in the corpus; 28 identifiers, 992 rows): MGSM per-language variants (250 GSM8K problems manually translated into 10 languages — English variant kept), Global MMLU Lite per-language variants (machine-translated and post-edited MMLU — English variant kept), a human-translated Arabic MMLU, OpenAI's Multilingual MMLU aggregate, Global MMLU aggregates, and IndicXNLI (machine-translated from XNLI).
- *Consolidated* (translated, but no original present in our import to prefer — merged into the parent identifier with the `language` field backfilled; 8 identifiers, 168 rows relabelled, zero rows lost): XCOPA, XNLI, XQuAD per-language splits.
- *Left intact* (verified independently sourced per language, not parallel translations): MultiLoKo (locally-sourced Wikipedia content per language), ArabicMMLU (natively sourced from Arabic school exams), FLORES translation directions (each direction is a distinct task), LINDSEA, Thai national exams, and Papers With Code WMT and CoNLL language-pair benchmarks.

A later pass resolved the cases the first had left open. `humaneval_xl` was **removed**: HumanEval-X/XL is HumanEval's problem set re-prompted in 23 natural languages and the original `humaneval` is in the corpus, which is exactly the condition the rule targets. The three models scored on both correlate at $r = 0.993$ — corroboration only, since three shared models cannot carry such a decision; the construct is the basis.

`mgsm` and `belebele` were **kept**, and the reason is worth stating because it looks like an inconsistency. Both are cross-language *aggregates*, and neither duplicates any column we hold: `mgsm` shares **zero** models with `gsm8k`, and `belebele` has no in-corpus original at all (its 122 languages are internally parallel, but there is no English Belebele here for it to duplicate). A redundancy claim is a claim that two columns track each other; columns that never co-occur cannot track each other. Both also measure multilingual transfer alongside the underlying skill, which the monolingual originals do not. This matches the treatment of `multiloko`, whose paper-sourced across-language aggregate was likewise kept while its per-language splits were dropped. Excluding cross-language aggregates would be a defensible alternative, but it is a single policy choice covering `mgsm`, `belebele` and `multiloko` together — not a per-benchmark judgement.

#### C.4 Duplicate detection and integrity checks

The duplicate identity key is the tuple (model, benchmark, metric, setup, source, model identifier, language). Duplicates are reported in two classes: **pure redundancy** (identical score reported twice) and **conflicts** (different scores under one identity). Conflicts are resolved by source-trust tier ([[#A.1 Source inventory]]) and recency, and the report is always reviewed before any automated resolution runs.

The integrity pass asserts: zero foreign-key violations in both directions; zero models with no result rows; zero benchmarks with no result rows; and flags benchmarks with fewer than five rows for manual review. It is run after every write, including after each of the pruning passes in [[#E Score-redundancy pruning]].

Link validity was checked by a multi-threaded URL sweep across both metadata tables, ignoring anti-bot 403s, repairing moved repositories, and filling 53 previously-blank benchmark source links.

#### C.5 Canonical metric selection

Applied to the derived copy after the benchmark removals, so coverage is counted over the surviving population. Selection proceeds in four steps, first match wins:

1. **Normalise** — strip, casefold, collapse internal whitespace. This alone resolves `gsm8k`, `fever`, `humaneval` and `winogrande`, whose only "conflict" was `Accuracy` vs `accuracy`; skipping it would have discarded 149 `gsm8k` rows.
2. **Alias** — a curated map merges verified spelling variants of one measurement: `bits per byte` → `bpb` (`the_pile`, recovering 23 models), `equivalent (chain of thought)` → `equivalent (cot)` (`math_chain_of_thought`; 13 models carry both, mean within-model difference +0.16, sd 1.82 — the same measurement typed twice by two importers, and treating them as rivals would have cost 56 models), `acc` → `accuracy`, and RACE's own `race-h`/`race-m` shorthand.
3. **Override** — a per-benchmark pin for cases where coverage chooses badly.
4. **Coverage** — otherwise the metric covering the most distinct **models** (not rows: one leaderboard can contribute many rows for few models), tie-broken by row count then by name for determinism.

The alias map is curated, never inferred. Deriving it from small within-model score differences was tried and rejected: it mislabels task *facets* as aliases (`sibench`'s "cause"/"motivation"/"social intention" and `sotopia`'s "secret"/"social rules" all sit within a point of each other on a compressed scale) and misfiled *configuration* names as aliases (`elephant`).

Net effect: 92 contested benchmarks, 1,420 rows dropped and 706 model-cells lost, roughly half of the contested benchmarks resolving without losing any model.

**`accuracy` versus `em`.** Sixteen benchmarks carry both, and they account for most of the cost — `mmlu` alone gives up 144 models. On multiple-choice tasks the two look like one construct (`mmlu`'s means differ by 1.0 point, 50.3 vs 51.3; `hellaswag`'s by 0.5), so aliasing them is tempting and would recover roughly 450 model-cells. We deliberately do not, for two reasons.

First, the names are effectively **source labels rather than measurement labels**: `em` is Stanford HELM's metric name — HELM is the top `em` source on 13 of the 16 — while `accuracy` comes from the Open LLM Leaderboard, Papers With Code and primary papers. Merging them would not merge two metrics; it would merge two evaluation regimes.

Second, those regimes score **near-disjoint model populations** (see the co-observation table in [[Methodology#Sources partition the matrix]]). A merged column would therefore be bimodal by source, with an offset that cannot be estimated: no model in the corpus is scored both ways on any of the sixteen, so there is no overlap to calibrate against, and the sparse overlap that exists elsewhere is inconsistent (`boolq` +18.4 across 2 models, `openbookqa` +6.2 across 1). Because HELM owns 138 columns, the same bias would recur corpus-wide as a source factor — and it would present as an *improvement*, since the matrix would appear better connected while the new bridges rested on an unverifiable assumption.

For the same reason we do not pin `accuracy` globally. The coverage rule already selects it where it genuinely dominates (`mmlu`, `truthfulqa`, `hellaswag`, `pubmedqa`) and selects `em` on the other twelve; forcing `accuracy` everywhere would cost 449 further model-cells (`openbookqa` 120 → 22, `legalbench` 90 → 5, `imdb` 67 → 6, `medqa` 99 → 42) and would systematically evict the most methodologically controlled source in the corpus. `accuracy` is the more conventional name; here it is not a quality signal.

#### C.6 Defects below the metric name

Two problems survive metric selection because they are not distinguishable by metric name at all.

**Source-level scale conflict (`gpqa`).** One metric name, two incompatible conventions, told apart only by source: 447 of 454 rows are Open LLM Leaderboard v2 **normalised** accuracy — the random-chance baseline mapped to zero, negatives clamped there — spanning 0.00–24.94 with median 4.36, while the other 7 are raw accuracy from papers and llm-stats spanning 39.0–94.1. The ranges do not overlap. We keep the 447 and drop the 7. The reasoning is that correlations are invariant under a linear rescaling of an entire column, so a normalised column is fully usable provided every row shares the convention; back-transforming instead ($\text{raw} = 0.75\,\text{norm} + 25$) would assume the leaderboard's formula and would still not undo the clamp, for the sake of 7 models out of 454. The documented caveat is that 56 of the 447 (13 %) sit exactly at 0.00, tied at the clamp, so the column under-discriminates among weak models.

The same detector — benchmarks whose sources have strictly non-overlapping score ranges — flags three others (`wildbench`, `sea_exam`, `multipl_e`), all on small $n$. We do not act on those: a gap alone is not evidence of a scale conflict, because frontier-model trackers such as llm-stats legitimately show higher ranges than broad leaderboards by evaluating better models. `gpqa` is the only case with a known mechanism.

**Structurally defective column (`elephant`).** Its `metric_name` field holds model *configurations* (`DPO-All-Llama-8B`, `iti-llama-70b`, `perspective-gpt-4o`), not metrics, so selecting a canonical metric keeps one arbitrary configuration, which measures nothing. The benchmark is removed from the derived copy (9 models) and recorded for re-extraction.

Two further columns that appear in earlier drafts as defects — `vectara`, whose two metrics are complements differing by +86.5 across 7 shared models, and `pwc_lambada`, which mixed accuracy with perplexity — are **resolved by the metric filter itself** and need no special handling.

---

### D Text-only classifier

#### D.1 Pattern vocabulary

A benchmark is classified `NON_TEXT` if any of the following terms matches, as a **whole word**, in the concatenation of its identifier (with `_` and `-` replaced by spaces) and its `category`, `subcategory`, `task_type`, `task_types`, `domain`, `benchmark_name`, `description`, and `title` fields:

```
vision, visual, image, video, multimodal, vqa, audio, speech, spoken,
acoustic, ocr, asr, tts, photo, diagram, chart, screenshot, music, song, sound
```

Word-boundary matching is required, not optional: substring matching false-positives on e.g. *vision* inside "Historical Revisionism Detection". The identifier is included in the match text because several sparse-metadata imports carry their only modality signal in the identifier itself (`..._video_qa`).

#### D.2 Allow-list (text-only despite a matching pattern)

Checked **before** the pattern match:

| Benchmark | Justification |
|---|---|
| `abceval` | Evaluates text-based ABC notation only; no audio input despite `category = audio/speech` |
| `ziqi_eval` | Pure text-QA music-knowledge benchmark; no audio input |
| `aci_bench` | HELM MedHELM task is transcript-to-clinical-note summarisation; the model never receives audio despite the description mentioning "spoken medical dialogue" |

#### D.3 Deny-list (non-text despite absent or misleading metadata)

Checked before the pattern match and disjoint from the allow-list. Found by an audit that cross-referenced each surviving benchmark's evaluated models and source papers — the tell being that the evaluated population consisted of vision-language or audio models:

| Benchmark | Evidence |
|---|---|
| `alm_bench` | arXiv:2411.16508 — image-based cultural VQA; rows are VLMs (GLM-4V, InternVL2); metadata says only "alignment" |
| `exams_v` | arXiv:2403.10378 — multimodal multilingual exams with images; rows include GPT-4V, Gemini Pro Vision |
| `mmau` | arXiv:2410.19168 — Massive Multi-Task *Audio* Understanding; rows are audio LMs; subcategory mislabelled "australian-languages" |
| `mmt_bench` | arXiv:2404.16006 — massive multitask *multimodal* benchmark; category mislabelled "machine-translation" |
| `cmmMU` | Actually CMMMU (arXiv:2401.11944), Chinese multimodal understanding; `benchmark_name` mislabelled "Chinese Multilingual MMLU" |
| `temporalbench` | arXiv:2410.10818 — temporal understanding for video models |
| `voice_jailbreak_attacks` | HELM Audio; voice-mode (audio-input) jailbreaks; "voice" is not in the pattern set |
| `pwc_next_qa_open_ended_videoqa` | NExT-QA open-ended VideoQA; "VideoQA" is a single token, so no word-boundary match fires |
| `pwc_salmon` | SALMon acoustic and speech LM suite; PwC task mislabelled plain "Language Modelling" |
| `kaggle_aminmohamedmohami_video_qa` | Kaggle VideoQA leaderboard; same single-token problem |
| `kaggle_sjmikler_mathvista_testmini` | MathVista (arXiv:2310.02255) image-based math VQA; the curated twin was already pattern-removed |
| `kaggle_andrewmingwang_parsebench` | Document-image parsing and OCR for agents; metadata otherwise blank |
| `longshot` | LongShOTBench (arXiv:2512.16978) — omni-modal reasoning over long video; subcategory misleadingly says "long document reasoning" |

#### D.4 Cascade and counts

Removal is transitive: benchmark → its result rows → any model with zero remaining results. The integrity pass ([[#C.4 Duplicate detection and integrity checks]]) is re-run afterwards, and the per-model aggregate columns recomputed.

| | Canonical | After modality filter |
|---|---:|---:|
| Benchmarks | 624 | 503 |
| Models | 2,014 | 1,669 |
| Result rows | 19,030 | 16,930 |

The 121 removed benchmarks by declared category: Visual QA 29 + 3, Multimodal 13 + 7 + 2, vision/multimodal 12, Audio/Speech 6 + 6, multilingual 6, general knowledge 4 + 3, alignment and safety 4 + 2, chart and figure tasks 3 + 2, and a tail of single-entry categories.

---

### E Score-redundancy pruning

Applied to the text-only copy only, after [[#D Text-only classifier]]. Each family was audited by computing the full pairwise Pearson correlation among its columns over the models evaluated on both columns; the removal decision was taken per family, on the evidence, and the resulting cascades were verified to orphan no models.

| Family | Correlation evidence | Decision | Rows removed |
|---|---|---|---:|
| LiveCodeBench release windows v1–v6 (Kaggle) | mean pairwise $r = 0.995$, worst pair $0.987$, over 45 shared models | Keep the aggregate, drop 6 per-version identifiers | 270 |
| TwitterAAE dialect splits (`_aa`, `_white`) | $r = 0.993$–$0.999$ with each other and the parent, over 32 shared models | Keep the parent, drop both dialect splits | 64 |
| GPQA variants (few/zero-shot × diamond/main, Kaggle) | mean $r = 0.944$, worst pair $0.915$, over 46–47 shared models; better-populated canonical `gpqa` and `gpqa_diamond` already present | Drop all 4 Kaggle variants | 185 |
| MultiLoKo per-language splits (31 languages, Kaggle) | mean pairwise $r = 0.82$; near-duplicate for well-resourced pairs (Simplified/Traditional Mandarin $0.989$, Italian/Swedish $0.983$); low-resource pairs noisy on small overlap | Keep the paper-sourced `multiloko` across-language aggregate, drop all 31 per-language identifiers | 1,523 |
| `kaggle_aminmohamedmohami_mmlu` | Cross-source re-import (44 rows) of canonical `mmlu` (468 rows) | Drop the re-import | 44 |
| `kaggle_andrewmingwang_scicode` | Not a third metric: per-model value matching shows it splices `scicode_main_standard` scores for 30 of 46 models and `scicode_subproblem_standard` for the other 13 — a scraping artefact | Drop as a data-integrity fix; the 4 explicit split variants ($r = 0.71$–$0.96$) are **kept**, as their correlations are not uniform enough to treat as duplicates | 46 |
| Stanford HELM ThaiExam sub-splits | Two clusters, not uniform redundancy: {ONET, IC, A-Level} at $r = 0.92$–$0.95$; {TGAT, TPAT1} correlate weakly with that cluster ($r = 0.70$–$0.88$). The TGAT/A-Level gap was verified as systematic, not noise (several multilingual models score 35–45 points higher on TGAT) | Drop ONET and IC; **keep** A-Level as the knowledge-cluster representative and keep TGAT and TPAT1, which carry distinct variance | 84 |
| | | **Total** | **2,216** |

Two of the eight audited families were thus deliberately left partially or fully intact, which is the point of auditing by correlation rather than by name. This pass leaves 456 benchmarks; the canonical-metric filter ([[#C.5 Canonical metric selection]]), the source-scale fix and the single-row anomaly removal ([[#L Known limitations and deviations|L.1a]]) then drop a further 1,463 result rows, for a final corpus of **456 benchmarks, 1,618 models, 13,251 result rows**.

---

### F Model-identity collapse

Both strategies operate on the source-specific `results.model_id` field ([[#A.3 Schema]]), after canonicalising each identifier's `model_family` and `model_size` metadata to the first non-null value observed for it. Multiple evaluations of the same (identifier, benchmark) are averaged before collapsing, and rows sharing a collapse key are averaged again per benchmark.

#### F.1 `all_standard` (variant-level)

Applied in order to each identifier:

1. Strip the organisation prefix (everything before the first `/`).
2. Reduce parenthesised content to a parameter count if one is present, else drop it.
3. Strip trailing junk after `-&`, effort phrases (`medium effort`, `high reasoning`), all date formats (`YYYY-MM-DD`, `YYYYMMDD`, `MM-DD`), and any bare 4-digit number (release years, checkpoint stamps, context lengths).
4. Normalise version hyphens to dots (`3-5` → `3.5`).
5. Where a `model_family` is available and non-numeric, take it as the stem and tokenise the remaining suffix; otherwise tokenise the whole cleaned identifier.
6. Per token: drop generic training and serving tokens (`instruct`, `chat`, `base`, `sft`, `dpo`, `rlhf`, `thinking`, `reasoning`, `cot`, `greedy`, `api`, `abliterated`, …), language and region tokens, legacy engine names, and month names; preserve named tier tokens (`opus`, `sonnet`, `haiku`, `pro`, `mini`, `flash`, `maverick`, `scout`, …); drop context-length tokens (`32k`, `128k`, `1m`); recognise parameter counts either by a `B` suffix or by matching the identifier's own `model_size` metadata or a whitelist of common sizes; merge version numbers into the family stem when one extends the other.
7. Emit `family-<preserved tokens>-<size>B`.

The common-size whitelist is guarded against version-number collisions: a bare `3` or `4` in a Claude or GPT identifier is a version, not a parameter count.

#### F.2 `all_aggressive` (family-level)

Take the first alphabetic token of `model_family` if it is non-numeric; otherwise strip the organisation prefix, parentheses, and dates from the identifier and take its first alphabetic token. Everything else is discarded.

#### F.3 Post-collapse filtering

Benchmarks observed for only one collapse key are dropped, then collapse keys with no remaining benchmarks are dropped. This yields Table 2 of [[Methodology]] (1,310 × 455 at 2.33 %; 350 × 431 at 3.55 % — provisional, from matrices predating the score-redundancy pruning; recomputed on the current corpus these are 1,269 × 405 at 2.16 % and 337 × 381 at 3.49 %) from 2,297 distinct source-level model identifiers.

---

### G Densification algorithm

Target density $\tau = 0.10$. Let $\mathbf{M}$ be the boolean observation mask.

**C (column-primary peel).** While density $< \tau$: drop the benchmark with the fewest observations among currently-kept rows, then drop any model left with zero observations.

**R (row-primary peel).** While density $< \tau$: drop the model with the fewest observations among currently-kept columns, then drop any benchmark left with zero observations.

**S (symmetric peel).** While density $< \tau$: compute each kept column's and each kept row's *fill rate* (observations ÷ current opposite-axis size) and drop whichever single marginal has the lowest rate; then clear emptied rows and columns on both axes.

**Minimum-observation floor.** After peeling, iterate to a fixed point: drop any kept row or column with fewer than `MIN_OBS` observations *within the currently kept submatrix*. The loop is required because dropping a sparse row can starve a column and vice versa.

**Degenerate-column guard.** Finally drop any column with fewer than 2 observed values or zero variance among its observed values, matching exactly what the downstream estimators would drop at runtime. This parity is deliberate: it keeps the reported matrix shape equal to the shape actually factored.

The tables analysed in this paper were generated with `MIN_OBS = 2`, verified against the shipped matrices — the minimum per-axis observation count is 2 on the R-densified matrices, whose peel is the binding one. See [[#L Known limitations and deviations]] regarding the current value of that constant in the analysis repository.

---

### H Completion methods

All R-side methods share one contract — sparse matrix in; completed matrix, swept-parameter grid, held-out RMSE and $R^2$ per parameter value, and a `complete_at(param)` closure out — and none of them factor. This is what allows the factoring stage to be literally identical across methods.

#### H.1 Cell-level methods

| Method | Description | Package | Swept parameter | Grid |
|---|---|---|---|---|
| SoftImpute \citep{mazumder2010} | Nuclear-norm-penalised low-rank completion by iterative soft-thresholded SVD; assumes a low-rank signal plus noise. Primary cell-level method. | `softImpute` | rank | 1…10 (capped at $\min(n,p)-1$); at each rank, a 30-point geometric $\lambda$ grid from $\lambda_0$ down to $\lambda_0/100$, ALS with warm starts |
| k-NN | Each missing cell filled from the $k$ most similar models; assumption-light baseline with no low-rank, linearity, or normality assumption. | `VIM` | $k$ | 1…10 (capped below $n$), Gower distance over benchmarks, weighted-mean aggregation |
| missForest \citep{stekhoven2012} | Iterative random-forest imputation, nonparametric, able to capture nonlinear dependence the low-rank methods cannot represent. | `missForest` | `ntree` | {50, 100, 200, 400}, `maxiter = 10` |
| MICE \citep{vanbuuren2011} | Multiple imputation by chained equations; produces $m$ completed datasets, averaged before factoring. | `mice` | $m$ | {5, 10, 20}, `method = "pmm"`, `maxit = 5` |

SoftImpute selects $\lambda$ within a rank by cell-weighted held-out RMSE (an internal minimisation only) and *reports* the column-balanced score; the completed matrix returned is a refit on the full data at the selected $(\text{rank}, \lambda)$, while the reported score comes from the masked-train fit's predictions. The two must not be conflated, or the metric leaks.

MICE requires two departures from its defaults on this matrix, which is wide and highly collinear: per-column ridge regularisation ($10^{-3}$) so the normal equations are solvable, and `remove.collinear = FALSE` so that collinear columns are imputed rather than silently skipped and left `NA`. Any cell MICE still cannot fill is backfilled with the column mean, so the completed matrix is never silently incomplete. Factoring receives the mean of the $m$ completions.

**Deferred.** `iterativepca` (`missMDA` regularised EM-PCA) is implemented but not validated: its built-in dimensionality cross-validation is prohibitively slow at this matrix size and its sensitivity path was never migrated to the shared held-out metric. It is excluded from all reported results.

#### H.2 OneSidedMC

Implemented in Julia \citep{cao2023}. The premise is that when observations are too sparse to complete cells, the **right singular vectors** — the benchmark-space factors — may still be recoverable. The estimator forms $\hat{\Theta} = \frac{1}{m}X^\top X$ from pairwise products of co-observed standardised scores and fits $\hat{\Theta} = \hat V \hat V^\top$.

Adaptations required for this data:

- **Ragged observations.** Real rows have a variable number of observed benchmarks, so the observation format is a ragged `Vector{(columns, values)}` rather than the paper's fixed-$k$ rectangular layout. The estimator consumes observed cells only — never a dense matrix plus a mask.
- **Rank selection.** OSMC has no built-in rank selector; $r$ is chosen by a held-out sweep over $r = 1\ldots10$.
- **Cell-level metric.** Its native error is defined on pairwise products, which is not comparable to the other methods, so each held-out cell is additionally predicted from the recovered covariance by the conditional-Gaussian (best linear) predictor $\hat z_j = V_j^\top V_S^{+} z_S$, solved in the $r$-dimensional factor space rather than by inverting the rank-deficient $|S| \times |S|$ covariance block, which is numerically unstable on richly-observed rows. The native pairwise metric is retained as a disabled branch.
- **Leakage control.** The holdout split is taken *before* column moments are computed, so standardisation is fit on training cells only. Column-stratified holdout matches the R implementation, with the additional row constraint that a cell is held out only if its row retains at least 2 training cells — the predictor needs them to condition on.

The output handed to factoring is a synthesised surrogate ([[#H.3 Correlation-matrix completion and surrogate synthesis]]), not an imputation of the real cells.

#### H.3 Correlation-matrix completion and surrogate synthesis

Shared machinery for SoftImpute-corr, OptSpace, USVT, CVXR, and GGM:

1. Split the holdout, then standardise columns by **training-cell** moments.
2. Compute the observed pairwise-complete correlation matrix. Entries for pairs never co-observed are `NA`; these are exactly the completion target. No minimum co-observation threshold is applied here, because the floor is already enforced upstream by the densifier and the degenerate-column guard.
3. Complete the correlation matrix with the method's estimator.
4. Symmetrise, then project to the nearest valid correlation matrix (`nearPD` \citep{higham2002} with unit diagonal and a final eigenvalue projection), guaranteeing positive definiteness rather than near-definiteness — so every principal submatrix $R_{SS}$ is invertible.
5. Predict each held-out cell from the row's surviving observed cells by the conditional-Gaussian predictor $\hat z_j = R_{jS} R_{SS}^{-1} z_S$ (an empty conditioning set degenerates to the z-mean, 0), and score with the shared metric ([[#I Held-out metric]]).
6. Refit on the **full** correlation matrix and synthesise an $n \times p$ surrogate $X = ZW^\top$ with $Z \sim N(0, I_p)$ and $W = Q\Lambda^{1/2}$ from the eigendecomposition, then un-standardise to the original column scale by the observed-cell moments — so $\operatorname{cov}(X) = R$ by construction.

Estimators:

| Estimator | Description | Implementation | Configuration |
|---|---|---|---|
| SoftImpute-corr \citep{mazumder2010} | Applies SoftImpute's low-rank completion to the observed pairwise correlation matrix rather than the data matrix, whose missing entries are exactly the benchmark pairs never co-observed. | `softImpute` | sweeps rank 1…10 with the same nested $\lambda$ grid as [[#H.1 Cell-level methods]] |
| OptSpace \citep{keshavan2010} | Manifold-optimisation low-rank completion of the correlation matrix, with automatic rank estimation. | `filling::fill.OptSpace` | automatic rank estimation, `niter = 50`, `tol = 1e-6`; no sweep |
| USVT \citep{chatterjee2015} | Universal singular value thresholding: completes the correlation matrix by hard-thresholding its singular values. | `filling::fill.USVT` | fixed singular-value threshold $\eta = 0.01$; no sweep |
| CVXR (maximum-determinant SDP) | Structured completion targeting positive-definiteness directly: maximises $\log\det\Sigma$ subject to $\Sigma \succeq 0$ and each observed correlation lying within a per-pair Fisher-*z* confidence band scaled to that pair's co-observation count. | `CVXR` + SCS | maximise $\log\det\Sigma$ s.t. $\Sigma \succeq 0$, diagonal matched exactly, each observed off-diagonal constrained to $\tanh(z_{ij} \pm c\,/\sqrt{n_{ij}-3})$ with $c = 2$; no sweep |
| GGM (Gaussian graphical model) | MLE completion over the observed-pair graph, treating it as the conditional-independence structure. | `ggm::fitConGraph` | graphical-model MLE with the observed-pair graph as the conditional-independence structure; handles non-chordal patterns; no sweep |

Only SoftImpute-corr sweeps a hyperparameter; the other four take a single fixed configuration, so their reported "sweep" is a single point.

The per-pair confidence band in CVXR exists because a single flat tolerance cannot serve both a correlation estimated from $n = 10$ and one from $n = 200$; the band widens automatically as $n_{ij}$ falls. Solver infeasibility is a genuine finding — the observed pairwise correlations are not jointly PSD-consistent even at their sampling uncertainty — not a bug; the remedy is a wider band, not a fallback. GGM has no fallback either: if `fitConGraph` fails to converge, the method fails.

Note that neither estimator applies a minimum co-observation threshold: every pair with a computable correlation enters as a constraint, including pairs resting on very few shared models. For CVXR this is partly self-correcting through the $n$-scaled band; for GGM it makes the conditional-independence graph denser than a trust-filtered version would be. See [[#L Known limitations and deviations]].

#### H.4 No-imputation (raw) variants

Applied to the undensified matrix, factoring a pairwise-complete correlation matrix with two treatments of the undefined entries:

| Variant | Undefined-entry treatment |
|---|---|
| `default` | Fill with the mean observed off-diagonal correlation |
| `zeros` | Fill with 0 (absent co-observation ⇒ assumed no association) |

The two encode opposite priors about an unobserved pair — "behaves like a typical pair" versus "is unrelated" — so the gap between them bounds how much the undefined entries alone can move the solution.

Both apply `psych::cor.smooth` afterwards as a numerical safety net. Effective sample size is taken as the raw row count $n$, **not** the harmonic mean of pairwise complete-case counts: with sparse data a single zero-overlap pair sends the harmonic mean to zero and collapses the whole estimate.

---

### I Held-out metric

#### I.1 Split

Column-stratified: within each benchmark $j$, sample $n_{\text{hold}} = \min(\lfloor 0.2\, n_{\text{obs}(j)} \rfloor,\; n_{\text{obs}(j)} - 2)$ observed cells, so at least 2 training observations remain in every column. Every column with more than 2 observations contributes **at least one** held-out cell, so no benchmark is unrepresented in the evaluation set.

#### I.2 Scoring

Let $z$ be the true standardised held-out value and $\hat z$ the prediction, with standardisation fit on training cells only. The baseline predicts each column's training mean, which is 0 in z-space, so the per-cell baseline error is $z^2$.

*Cell-weighted*:

$$\text{RMSE} = \sqrt{\overline{(\hat z - z)^2}}, \qquad R^2 = 1 - \frac{\sum (\hat z - z)^2}{\sum z^2}$$

*Column-balanced* (default): let $\text{MSE}_j$ and $\text{base}_j$ be the mean squared error and mean baseline within column $j$. Then

$$\text{RMSE} = \frac{1}{p}\sum_j \sqrt{\text{MSE}_j}, \qquad R^2 = 1 - \frac{\frac{1}{p}\sum_j \text{MSE}_j}{\frac{1}{p}\sum_j \text{base}_j}$$

Two properties are deliberate. The column-balanced RMSE is an **average of per-column RMSEs**, not a global RMSE, so it is not directly comparable to a pooled figure. And $R^2$ is a **single pooled ratio** of balanced quantities, not a mean of per-column $R^2$: a thin column with a small baseline yields $R^2$ in the range $-10$ to $-50$, and a handful of those destroys an average. Model selection uses $R^2$, which is invariant to the RMSE aggregation choice.

#### I.3 Rules that keep methods comparable

- Standardise columns, never rows.
- The baseline sees only training cells.
- The reported score must come from a fit that never saw the held-out cells; a full-data refit at the selected hyperparameter is used only to produce the matrix handed downstream.
- Methods whose native error is not cell-level must still derive a cell-level score ([[#H.2 OneSidedMC]], [[#H.3 Correlation-matrix completion and surrogate synthesis]]); the native metric may be retained but is never the headline.

---

### J Factor analysis details

#### J.1 Estimator

`psych::fa` \citep{revelle2024} with `fm = "minres"` (minimum residual) and `rotate = "promax"` when $nf > 1$, else no rotation. Where the default (SMC communality start) errors on a singular correlation matrix, the fit is retried with `SMC = FALSE` (unity diagonal); only hard errors trigger the fallback — `psych`'s benign warnings still return a usable fit.

#### J.2 Factor count

Horn's \citep{horn1965} parallel analysis in its PC flavour: the observed eigenvalues of the correlation matrix are compared position-by-position against the 95th percentile of eigenvalues from 100 random $n \times p$ standard-normal matrices' correlation matrices, and

$$nf = \#\{i : \lambda_i^{\text{obs}} > \lambda_i^{\text{cut}}\},\quad nf \geq 2.$$

Because the random baseline depends only on $(n, p, \text{iterations}, \text{quantile})$, it is computed once per shape and cached as JSON keyed by that tuple. The cache is **shape-keyed and never global**: two datasets share cutoffs only if their shapes are identical.

The count is then capped: at 20 (tractability — beyond that the bifactor fits become prohibitively slow), and at $\min(p-1,\, n-1,\, \operatorname{rank}(R) - 1)$, since the completed and surrogate matrices are frequently rank-deficient or have $p \gg n$ and `fa` would otherwise error. If the fit still fails, the count is decremented until it succeeds; the count actually used is what is recorded.

#### J.3 Bifactor decomposition

`psych::omega` \citep{revelle2009} with `fm = "minres"`, `flip = FALSE`, Schmid–Leiman \citep{schmidleiman1957} transformation. Recorded per cell: the full SL loading matrix (general factor plus domain factors, per benchmark), $\omega_h$, its asymptotic variant, $\omega_{total}$, and the per-group $\omega_{hs}$ vector. Also recorded from the first-order solution: cumulative variance explained, per-factor proportions, and the inter-factor correlation matrix $\Phi$ with its mean off-diagonal.

Two runs per cell: `pa` (at the parallel-analysis count) and `forced2f` (at exactly 2 factors). This is an exploratory Schmid–Leiman solution — cross-loadings are not constrained to zero — and is not equivalent to a confirmatory bifactor CFA.

#### J.4 Gating

For imputed matrices, factoring proceeds only if the imputation's held-out $R^2 \geq 0.4$, read from the results store. The raw (no-imputation) variants are exempt, since they have no imputation step to gate on.

#### J.5 Leave-one-covariate-out

For each benchmark $i$: delete row and column $i$ from the correlation matrix, refit the EFA and the bifactor at the same factor count, and record $\Delta\omega_h^{(i)} = \omega_h^{\text{full}} - \omega_h^{(-i)}$. Run at both the parallel-analysis count and the forced 2-factor count, parallelised across benchmarks. The resulting $\Delta\omega_h$ vector is then correlated against each benchmark's observation frequency in the corresponding *sparse* (pre-imputation) matrix.

#### J.6 Cross-method congruence

Pairwise factor congruence \citep{lorenzoseva2006} between solutions is the absolute cosine similarity between loading vectors, computed after sorting factors by sum of squared loadings and taken sign-invariantly. Solutions are compared only within the same dataset, the same solution type, and the same shape — and therefore only when two methods happen to agree on the factor count, which on this data is rare enough to be a reportable limitation in itself.

---

### K Software environment and reproduction

**Languages and dependency management.** Python (managed by `uv`; `pyproject.toml` + `uv.lock`, Python 3.14) for corpus construction, densification, and analysis scripts; R (managed by `renv`; `renv.lock`) for imputation and factor analysis; Julia (project-scoped `Project.toml` / `Manifest.toml`) for OneSidedMC.

**Key packages.** R: `softImpute`, `VIM`, `missForest`, `mice`, `missMDA`, `filling`, `psych`, `Matrix`, `CVXR`, `ggm`, `DBI`/`RSQLite`, `doParallel`/`foreach`. Python: `pandas`, `polars`, `numpy`, `scipy`, `matplotlib`.

**Reproduction.** In the analysis repository:

```bash
make deps && make env                         # system deps + all three environments

python3 scripts/verify_data.py                # corpus integrity
python3 scripts/make_text_only_copy.py        # derive data/text_only/ (Appendix D)

python3 scripts/collapse_results.py --data-root data/text_only   # Appendix F
python3 scripts/densify.py         --data-root data/text_only   # Appendix G

Rscript src/run/impute.R --method <m> --data-root data/text_only \
                         --results-root results/text_only [--raw] [--reimpute]
Rscript src/run/factor.R --method <m> --data-root data/text_only \
                         --results-root results/text_only [--raw] [--loco]

python3 scripts/compare_loadings.py           # Appendix J.6
python3 scripts/sensitivity.py                # Appendix J.5 correlation table + plots
python3 scripts/correlations.py               # omega_h vs imputation R²
```

**Conventions.** Every script resolves paths from its own file location, not the working directory, so any stage runs from anywhere. Imputed matrices are written to `data/<root>/imputed/<method>/<densifier>/<strategy>/`; all other outputs to `results/<root>/<method>/` under flat `<method>_<densifier>_<strategy>_<suffix>` names. Numeric results are persisted to a SQLite store with tables `imputation` (RMSE, $R^2$, chosen hyperparameter), `factoring` (factor count, variance explained, $\omega_t$, $\omega_h$, $\omega_{hs}$, $\Phi$), and `loco` ($\Delta\omega_h$ vectors), keyed by (dataset, method, run).

**Diagnostics.** `scripts/plot_missing.py` and `scripts/miss_corr.py` characterise the missingness itself — per benchmark, how many other benchmarks it has a computable pairwise correlation with (co-observation $\geq 4$ and non-degenerate variance) and the average co-observation count behind those correlations; per benchmark pair, the shared-observation count. Both are computed in closed form via matrix products over the observation mask rather than by looping over pairs.

---

### L Known limitations and deviations

**L.1 Metric heterogeneity — resolved for metric choice, open for direction and scale.** The corpus spans 238 distinct metric names. Averaging them within a (model, benchmark) pair is now prevented by the canonical-metric filter ([[#C.5 Canonical metric selection]]), which was not a tidying exercise: 92 benchmarks were affected, and because metric assignment tracks the evaluating leaderboard, the mixed columns carried source-determined variance that a factor analysis would have reported as capability structure.

Three residues remain. (i) **Direction** is recorded but not applied, so a lower-is-better benchmark contributes a sign-flipped column; in a correlation-based analysis that shows up as a negative loading rather than a bias, but orienting all columns before analysis would be cleaner. Three benchmarks (`xstest`, `DarkBench`, `SpiralBench`) previously mixed both directions within a single column; the metric filter resolves these incidentally, by keeping only one metric. (ii) **Scale**: one row remains negative, `pwc_lidirus` at MCC −0.013, because MCC is natively −1…1 and sits in a 0–100 column — legitimate at source, wrong for this column. (iii) **Twelve columns sit on a 0–1 scale** rather than the documented 0–100 (`cogbench`, `creativityprism`, `engibench`, `litbench`, `rpgbench`, `workplacehumor`, `ProphetArena`, `StrongREJECT`, `FlashInfer-Bench`, `MoralMachine`, and two others). Each is internally consistent, so column standardisation absorbs it and no correlation is affected — a schema violation rather than an analysis defect, but worth normalising for tidiness. Scale contamination that standardisation could *not* absorb, because it varies within a column, is handled separately in [[#C.6 Defects below the metric name]].

**L.1a Single-row anomaly, removed.** `kaggle_jonlipovetz_game_arena` recorded DeepSeek V3.2 at 3114.0 while every other model on that benchmark falls between 2.97 and 363.72 — 8.5× the next-highest value, almost certainly a unit error at source. It is not repairable: the Kaggle benchmark page serves no leaderboard data without authentication, and 3114 is equally consistent with a mis-scaled 311.4 or 31.14, so the intended value cannot be recovered from the column either. The row is dropped from the derived copy and retained in the canonical tables, which archive what sources published.

**L.2 `iterativepca` deferred.** Implemented but excluded from all results ([[#H.1 Cell-level methods]]); its cross-validation is intractable at this size and its sensitivity path was never migrated to the shared metric.

**L.3 Densifier floor constant.** The matrices analysed here were produced with `MIN_OBS = 2` ([[#G Densification algorithm]]), which is what the shipped densified tables and their summary record. The constant currently in the repository source is 3. The difference is not cosmetic — recomputed on the pruned corpus, moving 2 → 3 costs about an eighth of the models on the column-primary peel (C/all_standard 786 → 689, C/all_aggressive 232 → 205) and trims the benchmark axis on the row-primary peel (R/all_standard 333 → 300 columns, R/all_aggressive 356 → 320), while leaving the symmetric peel untouched at 682 × 130 and 128 × 296. The value must be pinned and stated in the paper, and Table 3 regenerated to match whichever is chosen.

**L.3a Tables 2 and 3 are provisional.** Both were read off matrices generated before the score-redundancy pruning and still contain all 47 pruned columns. Recomputed values are recorded in a comment beside Table 2 in [[Methodology]]. They must be replaced together with the Results tables, not before, or the paper becomes internally inconsistent.

**L.4 Coverage of the newest completion methods.** SoftImpute-corr, OptSpace, USVT, CVXR, and GGM were added most recently and have not yet been run across the full design; the reported results cover SoftImpute, k-NN, missForest, and OneSidedMC. The paper should state explicitly which methods each reported table covers.

**L.4a Trust threshold dropped from CVXR and GGM.** These two began as no-imputation variants that constrained only pairs with at least 10 co-observations, leaving thinner pairs for the completion to determine. When they were reclassified as correlation-level imputers, that filter was not carried over: every computable pairwise correlation now enters as a constraint. A `min_n` argument survives on both functions but is unused by CVXR and, for GGM, is recorded as the reported hyperparameter without being applied. Either restore the threshold or drop the vestigial argument and state plainly that no threshold is used — the current state records a parameter that does nothing.

**L.4b Band widths use full-data co-observation counts.** CVXR derives its per-pair Fisher-*z* band from co-observation counts computed on the complete matrix, including cells that are held out for scoring. The effect is small — it changes constraint widths, not correlation values — but it means the held-out score is very slightly optimistic, and it should be computed on the training split for strictness.

**L.5 Seed sweep measures split variance only.** The sensitivity sweep varies the holdout split under a fixed missingness pattern. It is not a test of MNAR robustness; the cross-densifier comparison is the closest available proxy, and even that varies the *induced* pattern rather than the underlying selection mechanism.

**L.6 Surrogate matrices are not data.** For OneSidedMC and the correlation-level methods, what reaches the factoring stage is a covariance-matched synthetic matrix ([[#H.3 Correlation-matrix completion and surrogate synthesis]]). Any per-model statistic computed from those matrices is meaningless; only benchmark-space (loading) quantities are interpretable.

**L.7 Score provenance is transcribed, not re-run.** All scores are as published. Where two sources disagree about the same evaluation, we resolve by trust tier and recency rather than by re-evaluation, and we do not attempt to correct for differences in undocumented evaluation setup between sources.

**L.8 Benchmark dates are much weaker than model dates.** Coverage on the two axes is almost identical (99.7 % of models, 99.8 % of benchmarks) and the similarity is misleading. The model axis was repaired to the point where 78 % of rows rest on an exact identifier, a repository timestamp, or a verified announcement; the benchmark axis has had no equivalent pass, and 85 % of its rows remain on `existing` (302) or `corroborated_year` (162). A quarter of benchmark dates are year-only, against 2.3 % of model dates. Any temporal analysis should therefore run on the model axis; benchmark dates are usable for coarse ordering at best. The repair should be cheaper on this axis than it was on the other, because nearly every benchmark has a paper and an arXiv identifier decodes to an exact month with no fetching at all — the `arxiv_id` tier currently contains a single row.

**L.9 Release date is metadata, not an analysis input.** No stage of the pipeline reads `release_date`: densification, completion and factoring operate on the score matrix alone. The field exists for cohort and temporal analyses and for the corpus's value as a standalone artefact, and none of the results reported here depend on it. This also means the dating work described in [[#A.5 Release-date provenance]] cannot have influenced any reported factor structure.
