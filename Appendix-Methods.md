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

---

### B Inclusion and exclusion criteria

#### B.1 Models

**Included:** general-purpose generative LLMs; domain- or task-adapted models (code, medical, legal) that still accept arbitrary prompts; multimodal models built by adding an encoder to an LLM backbone, provided the backbone still handles arbitrary text prompts.

**Excluded:** encoder-only or classification-only architectures (BERT, RoBERTa, BigBird); narrow single-purpose systems that cannot be prompted generally (dedicated MT systems such as NLLB, speech systems such as SeamlessM4T, TTS/ASR); bare embedding or vision encoders (CLIP variants, ST5, monoT5); research systems that are architectures-with-a-name rather than deployable models; evaluation *metrics* misfiled as models (e.g. YiSi-1); and undocumented community uploads without reliable provenance.

**Not a separate model:** a different *setup* of the same model — context-length variant, reasoning or thinking mode, effort level, prompting scheme. These are recorded in the `setup` and `reasoning_enabled` fields on the result row.

Borderline cases are reviewed individually rather than by keyword. Documented outcomes include: T5/mT5/FLAN-T5 **kept** (encoder–decoder, but instruction-followable and generative); three genuine vision-language models whose names happened to match an exclusion keyword **kept**; and a model flagged only because a metadata bug had leaked its HuggingFace namespace into its developer field **kept**, with the metadata fixed.

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

#### C.4 Duplicate detection and integrity checks

The duplicate identity key is the tuple (model, benchmark, metric, setup, source, model identifier, language). Duplicates are reported in two classes: **pure redundancy** (identical score reported twice) and **conflicts** (different scores under one identity). Conflicts are resolved by source-trust tier ([[#A.1 Source inventory]]) and recency, and the report is always reviewed before any automated resolution runs.

The integrity pass asserts: zero foreign-key violations in both directions; zero models with no result rows; zero benchmarks with no result rows; and flags benchmarks with fewer than five rows for manual review. It is run after every write, including after each of the pruning passes in [[#E Score-redundancy pruning]].

Link validity was checked by a multi-threaded URL sweep across both metadata tables, ignoring anti-bot 403s, repairing moved repositories, and filling 53 previously-blank benchmark source links.

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
| Benchmarks | 627 | 506 |
| Models | 2,028 | 1,682 |
| Result rows | 19,078 | 17,054 |

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

Two of the eight audited families were thus deliberately left partially or fully intact, which is the point of auditing by correlation rather than by name. Resulting corpus: **459 benchmarks, 1,682 models, 14,838 result rows**.

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

Benchmarks observed for only one collapse key are dropped, then collapse keys with no remaining benchmarks are dropped. This yields Table 2 of [[Methodology]] (1,310 × 455 at 2.33 %; 350 × 431 at 3.55 %) from 2,294 distinct source-level model identifiers.

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

| Method | Package | Swept parameter | Grid |
|---|---|---|---|
| SoftImpute | `softImpute` | rank | 1…10 (capped at $\min(n,p)-1$); at each rank, a 30-point geometric $\lambda$ grid from $\lambda_0$ down to $\lambda_0/100$, ALS with warm starts |
| k-NN | `VIM` | $k$ | 1…10 (capped below $n$), Gower distance over benchmarks, weighted-mean aggregation |
| missForest | `missForest` | `ntree` | {50, 100, 200, 400}, `maxiter = 10` |
| MICE | `mice` | $m$ | {5, 10, 20}, `method = "pmm"`, `maxit = 5` |

SoftImpute selects $\lambda$ within a rank by cell-weighted held-out RMSE (an internal minimisation only) and *reports* the column-balanced score; the completed matrix returned is a refit on the full data at the selected $(\text{rank}, \lambda)$, while the reported score comes from the masked-train fit's predictions. The two must not be conflated, or the metric leaks.

MICE requires two departures from its defaults on this matrix, which is wide and highly collinear: per-column ridge regularisation ($10^{-3}$) so the normal equations are solvable, and `remove.collinear = FALSE` so that collinear columns are imputed rather than silently skipped and left `NA`. Any cell MICE still cannot fill is backfilled with the column mean, so the completed matrix is never silently incomplete. Factoring receives the mean of the $m$ completions.

**Deferred.** `iterativepca` (`missMDA` regularised EM-PCA) is implemented but not validated: its built-in dimensionality cross-validation is prohibitively slow at this matrix size and its sensitivity path was never migrated to the shared held-out metric. It is excluded from all reported results.

#### H.2 OneSidedMC

Implemented in Julia (Cao, Liang & Valiant, 2023). The premise is that when observations are too sparse to complete cells, the **right singular vectors** — the benchmark-space factors — may still be recoverable. The estimator forms $\hat{\Theta} = \frac{1}{m}X^\top X$ from pairwise products of co-observed standardised scores and fits $\hat{\Theta} = \hat V \hat V^\top$.

Adaptations required for this data:

- **Ragged observations.** Real rows have a variable number of observed benchmarks, so the observation format is a ragged `Vector{(columns, values)}` rather than the paper's fixed-$k$ rectangular layout. The estimator consumes observed cells only — never a dense matrix plus a mask.
- **Rank selection.** OSMC has no built-in rank selector; $r$ is chosen by a held-out sweep over $r = 1\ldots10$.
- **Cell-level metric.** Its native error is defined on pairwise products, which is not comparable to the other methods, so each held-out cell is additionally predicted from the recovered covariance by the conditional-Gaussian (best linear) predictor $\hat z_j = V_j^\top V_S^{+} z_S$, solved in the $r$-dimensional factor space rather than by inverting the rank-deficient $|S| \times |S|$ covariance block, which is numerically unstable on richly-observed rows. The native pairwise metric is retained as a disabled branch.
- **Leakage control.** The holdout split is taken *before* column moments are computed, so standardisation is fit on training cells only. Column-stratified holdout matches the R implementation, with the additional row constraint that a cell is held out only if its row retains at least 2 training cells — the predictor needs them to condition on.

The output handed to factoring is a synthesised surrogate ([[#H.3 Correlation-matrix completion and surrogate synthesis]]), not an imputation of the real cells.

#### H.3 Correlation-matrix completion and surrogate synthesis

Shared machinery for SoftImpute-corr, OptSpace, and USVT:

1. Split the holdout, then standardise columns by **training-cell** moments.
2. Compute the observed pairwise-complete correlation matrix. Entries for pairs never co-observed are `NA`; these are exactly the completion target. No minimum co-observation threshold is applied here, because the floor is already enforced upstream by the densifier and the degenerate-column guard.
3. Complete the correlation matrix with the method's estimator.
4. Symmetrise, then project to the nearest valid correlation matrix (`nearPD` with unit diagonal and a final eigenvalue projection), guaranteeing positive definiteness rather than near-definiteness — so every principal submatrix $R_{SS}$ is invertible.
5. Predict each held-out cell from the row's surviving observed cells by the conditional-Gaussian predictor $\hat z_j = R_{jS} R_{SS}^{-1} z_S$ (an empty conditioning set degenerates to the z-mean, 0), and score with the shared metric ([[#I Held-out metric]]).
6. Refit on the **full** correlation matrix and synthesise an $n \times p$ surrogate $X = ZW^\top$ with $Z \sim N(0, I_p)$ and $W = Q\Lambda^{1/2}$ from the eigendecomposition, then un-standardise to the original column scale by the observed-cell moments — so $\operatorname{cov}(X) = R$ by construction.

Estimators: **SoftImpute-corr** sweeps rank 1…10 with the same nested $\lambda$ grid as [[#H.1 Cell-level methods]]; **OptSpace** (`filling::fill.OptSpace`) uses automatic rank estimation with `niter = 50`, `tol = 1e-6`, so no rank sweep; **USVT** (`filling::fill.USVT`) uses a fixed singular-value threshold $\eta = 0.01$. Because the latter two take a single fixed configuration, their reported "sweep" is a single point.

#### H.4 No-imputation (raw) variants

Applied to the undensified matrix, factoring a pairwise-complete correlation matrix with four treatments of the undefined entries:

| Variant | Undefined-entry treatment |
|---|---|
| `default` | Fill with the mean observed off-diagonal correlation |
| `zeros` | Fill with 0 (absent co-observation ⇒ assumed no association) |
| `cvxr` | Maximum-determinant PSD completion: maximise $\log\det\Sigma$ subject to $\Sigma \succeq 0$, exact match on the diagonal, and a per-pair Fisher-*z* band $\tanh(z \pm 2/\sqrt{n_{ij}-3})$ on each trusted entry ($n_{ij} \geq 10$ co-observations). Solved with SCS via `CVXR` |
| `ggm` | Gaussian graphical model MLE (`ggm::fitConGraph`) with the trusted-entry mask as the graph; handles non-chordal patterns; no fallback — infeasibility is reported as failure |

The per-pair confidence band exists because a single flat tolerance cannot serve both a correlation estimated from $n = 10$ and one from $n = 200$. Infeasibility in the `cvxr` variant is a genuine finding — the trusted pairwise correlations are not jointly PSD-consistent even at their sampling uncertainty — not a solver bug.

All four apply `psych::cor.smooth` afterwards as a numerical safety net. Effective sample size is taken as the raw row count $n$, **not** the harmonic mean of pairwise complete-case counts: with sparse data a single zero-overlap pair sends the harmonic mean to zero and collapses the whole estimate.

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

`psych::fa` with `fm = "minres"` (minimum residual) and `rotate = "promax"` when $nf > 1$, else no rotation. Where the default (SMC communality start) errors on a singular correlation matrix, the fit is retried with `SMC = FALSE` (unity diagonal); only hard errors trigger the fallback — `psych`'s benign warnings still return a usable fit.

#### J.2 Factor count

Horn's parallel analysis in its PC flavour: the observed eigenvalues of the correlation matrix are compared position-by-position against the 95th percentile of eigenvalues from 100 random $n \times p$ standard-normal matrices' correlation matrices, and

$$nf = \#\{i : \lambda_i^{\text{obs}} > \lambda_i^{\text{cut}}\},\quad nf \geq 2.$$

Because the random baseline depends only on $(n, p, \text{iterations}, \text{quantile})$, it is computed once per shape and cached as JSON keyed by that tuple. The cache is **shape-keyed and never global**: two datasets share cutoffs only if their shapes are identical.

The count is then capped: at 20 (tractability — beyond that the bifactor fits become prohibitively slow), and at $\min(p-1,\, n-1,\, \operatorname{rank}(R) - 1)$, since the completed and surrogate matrices are frequently rank-deficient or have $p \gg n$ and `fa` would otherwise error. If the fit still fails, the count is decremented until it succeeds; the count actually used is what is recorded.

#### J.3 Bifactor decomposition

`psych::omega` with `fm = "minres"`, `flip = FALSE`, Schmid–Leiman transformation. Recorded per cell: the full SL loading matrix (general factor plus domain factors, per benchmark), $\omega_h$, its asymptotic variant, $\omega_{total}$, and the per-group $\omega_{hs}$ vector. Also recorded from the first-order solution: cumulative variance explained, per-factor proportions, and the inter-factor correlation matrix $\Phi$ with its mean off-diagonal.

Two runs per cell: `pa` (at the parallel-analysis count) and `forced2f` (at exactly 2 factors). This is an exploratory Schmid–Leiman solution — cross-loadings are not constrained to zero — and is not equivalent to a confirmatory bifactor CFA.

#### J.4 Gating

For imputed matrices, factoring proceeds only if the imputation's held-out $R^2 \geq 0.4$, read from the results store. The raw (no-imputation) variants are exempt, since they have no imputation step to gate on.

#### J.5 Leave-one-covariate-out

For each benchmark $i$: delete row and column $i$ from the correlation matrix, refit the EFA and the bifactor at the same factor count, and record $\Delta\omega_h^{(i)} = \omega_h^{\text{full}} - \omega_h^{(-i)}$. Run at both the parallel-analysis count and the forced 2-factor count, parallelised across benchmarks. The resulting $\Delta\omega_h$ vector is then correlated against each benchmark's observation frequency in the corresponding *sparse* (pre-imputation) matrix.

#### J.6 Cross-method congruence

Pairwise factor congruence between solutions is the absolute cosine similarity between loading vectors, computed after sorting factors by sum of squared loadings and taken sign-invariantly. Solutions are compared only within the same dataset, the same solution type, and the same shape — and therefore only when two methods happen to agree on the factor count, which on this data is rare enough to be a reportable limitation in itself.

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

**L.1 Metric heterogeneity.** The corpus spans 238 distinct metric names, and aggregation averages scores within a (model, benchmark) pair across whatever metrics that benchmark's sources reported. Direction is recorded but not applied, so a lower-is-better benchmark contributes a sign-flipped column; in a correlation-based analysis this manifests as a negative loading rather than as a bias, but it is a nuisance that ideally would be handled by orienting all columns before analysis. Scale differences are absorbed by column standardisation.

**L.2 `iterativepca` deferred.** Implemented but excluded from all results ([[#H.1 Cell-level methods]]); its cross-validation is intractable at this size and its sensitivity path was never migrated to the shared metric.

**L.3 Densifier floor constant.** The matrices analysed here were produced with `MIN_OBS = 2` ([[#G Densification algorithm]]), which is what the shipped densified tables and their summary record. The constant currently in the repository source is 3; regenerating the densified tables without pinning it would change every shape in Table 3 of [[Methodology]]. The value should be fixed and stated in the final paper, and the tables regenerated if 3 is chosen.

**L.4 Coverage of the newest completion methods.** SoftImpute-corr, OptSpace, USVT, and the `cvxr` and `ggm` raw variants were added most recently and have not yet been run across the full design; the reported results cover SoftImpute, k-NN, missForest, and OneSidedMC. The paper should state explicitly which methods each reported table covers.

**L.5 Seed sweep measures split variance only.** The sensitivity sweep varies the holdout split under a fixed missingness pattern. It is not a test of MNAR robustness; the cross-densifier comparison is the closest available proxy, and even that varies the *induced* pattern rather than the underlying selection mechanism.

**L.6 Surrogate matrices are not data.** For OneSidedMC and the correlation-level methods, what reaches the factoring stage is a covariance-matched synthetic matrix ([[#H.3 Correlation-matrix completion and surrogate synthesis]]). Any per-model statistic computed from those matrices is meaningless; only benchmark-space (loading) quantities are interpretable.

**L.7 Score provenance is transcribed, not re-run.** All scores are as published. Where two sources disagree about the same evaluation, we resolve by trust tier and recency rather than by re-evaluation, and we do not attempt to correct for differences in undocumented evaluation setup between sources.
