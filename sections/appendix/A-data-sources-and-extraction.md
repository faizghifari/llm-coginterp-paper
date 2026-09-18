# A Data sources and extraction {-}

## A.1 Source inventory {-}

The corpus is assembled from published evaluation records. Sources fall into four tiers, which also define the trust ordering used for conflict resolution ([[C-normalisation-rules#C.4 Duplicate detection and integrity checks|Appendix C.4]]).

**Tier 1 — curated evaluation suites** (standardised harness, documented setup, one evaluator across many models):

| Suite | Sub-leaderboards used |
|---|---|
| Stanford HELM (CRFM) | Classic, Lite, Safety, Reasoning, MedHELM, SEA-HELM, Arabic, ThaiExam, EWoK, TORR, Finance |
| HuggingFace Open LLM Leaderboard | v1, v2 |

Two further HELM leaderboards (Audio, Image2Struct) were collected but are removed in full by the text-only restriction ([[D-text-only-classifier#D Text-only classifier|Appendix D]]).

**Tier 2 — aggregators and result trackers**: Papers With Code evaluation tables, Kaggle AI Benchmarks, llm-stats.com, Artificial Analysis, Vellum, LiveBench, Chatbot Arena / LMArena, pricepertoken.com.

**Tier 3 — benchmark-specific leaderboards**: e.g. BigCodeBench, CRUXEval, SWE-bench, BFCL (Gorilla, UC Berkeley), VMLU, SEA-LION, PubMedQA, AlpacaEval, Video-MME (multimodal; removed by [[D-text-only-classifier#D Text-only classifier|Appendix D]]), plus ~35 further named sources each contributing a single benchmark's leaderboard.

**Tier 4 — primary papers**: arXiv, ACL Anthology, OpenReview, and journal articles reporting original evaluations (e.g. ELEPHANT, SI-Bench, Swiss-Bench), used both as the source of record for benchmark metadata and, where no leaderboard exists, as the source of scores.

By URL host, the text-only corpus resolves to: `crfm.stanford.edu` (HELM), `huggingface.co` (Open LLM Leaderboard and dataset cards), `kaggle.com`, `paperswithcode.com`, `arxiv.org`, `chat.lmsys.org`, `llm-stats.com`, `raw.githubusercontent.com`, `vellum.ai`, `artificialanalysis.ai`, `livebench.ai`, `aclanthology.org`, and a long tail of benchmark-specific domains.

Table 1 in the main text reports each tier/family's row and benchmark counts, read off the recorded `source_organization` field. That field was blank or literally `Unknown` on 295 rows (2.2 %), spread across nearly every family rather than forming a family of its own; each was reattributed by source name and URL host instead of left uncategorised — GitHub-hosted benchmark READMEs (`raw.githubusercontent.com`, `vmlu.ai`, `swebench.com`, and similar) to Tier 3, and arXiv, ACL Anthology, OpenReview, ACM Digital Library and journal hosts to Tier 4. This moved 157 rows into Tier 4 and 120 into Tier 3, and gave Vellum and Artificial Analysis 12 and 6 rows respectively that had been recorded under their correct source name but not their organisation. Tier 3 in Table 1 ("Other named leaderboards") spans 30-odd single-benchmark leaderboards, e.g. BigCodeBench, CRUXEval, SWE-bench, BFCL/Gorilla, VMLU, SEA-LION, PubMedQA and AlpacaEval; Tier 4 ("Primary papers") spans arXiv preprints, ACL Anthology, OpenReview, ACM Digital Library, and journals such as *Nature* and *Frontiers*.

## A.2 Extraction routes {-}

- **Papers With Code.** The public API is defunct (the domain redirects to HuggingFace). Evaluation tables are instead read from the daily-published parquet dataset `pwc-archive/evaluation-tables` (4 shards). Each parquet row is one *task* with nested datasets, each carrying its own leaderboard; extraction flattens task → dataset → leaderboard row into result rows, generating benchmark identifiers under a `pwc_` namespace and applying the scope filter ([[B-inclusion-and-exclusion-criteria#B.2 Benchmarks|Appendix B.2]]) to exclude non-LLM tasks.
- **Kaggle AI Benchmarks.** Community-maintained leaderboard datasets, extracted per dataset owner and namespaced `kaggle_<owner>_<benchmark>`; the owner namespace is retained precisely so that cross-source duplicates remain detectable — and several were subsequently detected ([[E-score-redundancy-pruning#E Score-redundancy pruning|Appendix E]]).
- **Stanford HELM.** Extracted per sub-project into staging files, then merged; the staging→merge pattern exists so that a partial or malformed extraction can be discarded without touching the canonical tables.
- **Papers and repositories.** ArXiv PDFs and abstracts converted to HTML for methodology extraction; GitHub READMEs and evaluation scripts read directly from `raw.githubusercontent.com` (both default-branch names); HuggingFace dataset cards via the Hub API.

## A.3 Schema {-}

Three CSV tables with a deliberate non-obvious join: `results` links to `models` via the **`model_name`** column, matched against `models.model_id`. The `results.model_id` field is a *denormalised, source-specific* convenience field carrying the identifier as the source spelled it, and is **not** the foreign key. This is what makes cross-source duplicate detection possible after canonicalisation, and it is also the field that the aggregation step ([[F-model-identity-collapse#F Model-identity collapse|Appendix F]]) groups on.

`benchmarks` carries 37 columns (identity, category and subcategory, task type, domain, description, source links, metric metadata); `models` carries 24 (identity, developer, family, parameter and active-parameter counts, type, release metadata, and three denormalised aggregate columns); `results` carries 38 (the score and its metric metadata, evaluation setup, shot count, language, source attribution, inference environment, generation configuration, and provenance). The three aggregate columns in `models` (`benchmark_count`, `total_results`, `avg_score`) do not auto-update and are recomputed by an explicit pass after any edit to `results`.

## A.4 Deductive fills (the only non-verbatim values) {-}

Two rules are applied, both entailed by the record rather than inferred from it:

1. **Closed models accessed by API.** A model whose type is `closed` cannot have been run locally; its inference platform is set to `api` and its engine to `api (unspecified)`. No engine is ever guessed for open-weights models.
2. **`lm-eval-harness` decoding.** For benchmarks *verified* to use EleutherAI's `lm-eval-harness`, generative tasks default to greedy decoding, so `generation_temperature = 0.0` is recorded. This is applied only where harness usage is documented, never inferred from the benchmark being open-source.

Everything else — inference stack for open models, decoding parameters for benchmarks whose papers omit them, and all fields for "bring your own predictions" benchmarks — is left blank. Aggregator sources that do not publish their engineering stack contribute no inference metadata at all.

## A.5 Release-date provenance {-}

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

### A.5.1 Verification is three-way, not binary. {-}

Every dated answer carrying a citation was re-checked by fetching the cited page and asking two questions: does it name this model, and does it carry this date. The outcomes are **verified**, **unverifiable** (the page is bot-blocked, paywalled, or JavaScript-only — no evidence either way), and **contradicted** (the page read cleanly and did not support the claim). Only the third is evidence of an error. Of 565 dated answers, 404 verified (72 %), 96 were unverifiable and 65 contradicted.

The distinction that matters is that **a contradicted verdict impugns the citation, not necessarily the date**, and in this corpus the two came apart in both directions. `starcoder2-15b` answered 2023-05 and cited the StarCoder *2* paper, which is 2024-02: the citation is right and the answer wrong. `starcoderbase` answered 2023-05 and cited an unrelated paper: the answer is right and only the citation wrong. Because the same verdict demanded opposite handling, the bucket could not be applied or discarded wholesale, and all 65 rows were re-checked individually against evidence independent of the original citation. 61 were resolved and are recorded with their per-row evidence in the repository's `notes/release_date_hand_resolutions.md`; four were left at their existing values because no identity-given source could be found.

### A.5.2 Two lower bounds, and only one of them is sound. {-}

A repository cannot postdate the model it distributes, so `createdAt` is a genuine lower bound — but it can sit well below the release: `bigcode/starcoder2-3b` was created 2023-11-29 for a model that became public in 2024-02. A paper date is *not* a lower bound, because papers routinely trail the release: `EleutherAI/pythia-12b` had a public, archived model page on 2023-02-03, two months before the Pythia paper. We built a guard taking the later of the two, and discarded it after measuring it — of the seven rows it moved, one was right and at least five were wrong. `hf_createdat` is therefore used unmodified and documented as a lower bound, with individual cases corrected by hand rather than by rule.

### A.5.3 Failure modes that recur. {-}

Three are worth naming because each produced errors that survived an earlier pass. (i) *Family attribution*: a page about the family, or about a later version, supplies a real date for the wrong artefact. (ii) *Staged releases*, which are family attribution inside a single model line — GPT-2 shipped in four tranches (124M 2019-02, 355M 2019-05, 774M 2019-08, 1.5B 2019-11, each datable from the publisher's own commits), and six corpus rows had collapsed them onto one date. (iii) *Name collision*: `SGPT-2.7B-msmarco` was dated 2019-02 as though it were a GPT-2 variant; it is SGPT, 2022-02.

### A.5.4 The known bias is toward being early. {-}

Dates produced by asking a language model run systematically early for models released after that model's training cutoff. Correcting the weak tiers moved 119 model dates, 85 of them later — the bias being paid down where it was concentrated. Twenty rows moved by a year or more, several by two (`GPT-4.1` 2023-03 → 2025-04, `Gemini 3 Pro` 2023-12 → 2025-11).
