# Data source and normalization

## Source inventory

The corpus is assembled from published evaluation records. Sources fall into four tiers, used along with recency to resolve duplicate scores from different sources.

**Tier 1, curated evaluation suites** (standardised harness, documented setup, one evaluator across many models):

| Suite | Sub-leaderboards used |
|---|---|
| Stanford HELM (CRFM) | Classic, Lite, Safety, Reasoning, MedHELM, SEA-HELM, Arabic, ThaiExam, EWoK, TORR, Finance |
| HuggingFace Open LLM Leaderboard | v1, v2 |

**Tier 2, aggregators and result trackers.** Papers With Code evaluation tables, Kaggle AI Benchmarks, llm-stats.com, Artificial Analysis, Vellum, LiveBench, Chatbot Arena / LMArena, pricepertoken.com.

**Tier 3, benchmark-specific leaderboards.** e.g. BigCodeBench, CRUXEval, SWE-bench, BFCL (Gorilla, UC Berkeley), VMLU, SEA-LION, PubMedQA, AlpacaEval, etc.

**Tier 4, primary papers.** arXiv, ACL Anthology, OpenReview, and journal articles reporting original evaluations (e.g. ELEPHANT, SI-Bench, Swiss-Bench), used both as the source of record for benchmark metadata and, where no leaderboard exists, as the source of scores.

Table 1 in the main text reports each tier and family's row and benchmark counts, read off the recorded source-organisation field. That field was blank or literally unknown on 295 rows (2.2 %), spread across nearly every family rather than forming a family of its own, and each was reattributed by source name and URL host instead of left uncategorised. GitHub-hosted benchmark READMEs went to Tier 3, and arXiv, ACL Anthology, OpenReview, ACM Digital Library and journal hosts to Tier 4. This moved 157 rows into Tier 4 and 120 into Tier 3, and gave Vellum and Artificial Analysis 12 and 6 rows respectively that had been recorded under their correct source name but not their organisation. Tier 3 in Table 1 ("Other online leaderboards") spans 30-odd single-benchmark leaderboards, and Tier 4 ("Primary papers") spans arXiv preprints, ACL Anthology, OpenReview, ACM Digital Library, and journals such as *Nature* and *Frontiers*.

Table 1 collapses the five smallest source families into a single "Other online leaderboards" row. Table A1 gives the uncollapsed breakdown behind that row.

<!-- Both paragraphs merged in from the unembedded
sections/appendix/unused/data-sources-and-extraction.md. The first is what makes
Table 1's counts checkable: they are tallied over source_organization after a
reattribution pass, not over source_name, which is why a naive recount of Vellum
and Artificial Analysis by source name returns 84 and 71 rather than 96 and 77.
The second explains why Table 1 and Table A1 are not duplicates of each other.
The URL-host inventory that sat between them in the source file was left out as
repository detail. -->

`\label{tab:a1}`{=latex}**Table A1.** Composition of the text-only corpus by source family, uncollapsed (13,251 result rows over 456 benchmarks and 1,618 models).

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

- **Papers With Code.** The public API is defunct (the domain redirects to HuggingFace). Evaluation tables are instead read from a daily-published archive of the evaluation tables, in four shards. Each row is one *task* with nested datasets, each carrying its own leaderboard. Extraction flattens task → dataset → leaderboard row into result rows, generating benchmark identifiers under their own namespace and applying the scope filter (`\hyperref[benchmarks]{Appendix~\ref*{benchmarks}}`{=latex}) to exclude non-LLM tasks.
- **Kaggle AI Benchmarks.** Community-maintained leaderboard datasets, extracted per dataset owner and namespaced by owner as well as by benchmark. We retain the owner namespace precisely so that cross-source duplicates remain detectable, and several were subsequently detected (`\hyperref[score-redundancy-pruning]{Appendix~\ref*{score-redundancy-pruning}}`{=latex}).
- **Stanford HELM.** Extracted per sub-project into staging files, then merged. We stage before merging so that a partial or malformed extraction can be discarded without touching the canonical tables.
- **Papers and repositories.** ArXiv PDFs and abstracts converted to HTML for methodology extraction. GitHub READMEs and evaluation scripts read directly from the raw file host, under both default-branch names, and HuggingFace dataset cards through the Hub API.

## Deductive fills

Two rules are applied, both entailed by the record rather than inferred from it:

1. **Closed models accessed by API.** A model recorded as closed-weights cannot have been run locally, so we set its inference platform to a vendor API and leave the engine unspecified. No engine is ever guessed for open-weights models.
2. **Harness decoding.** For benchmarks *verified* to use EleutherAI's evaluation harness, generative tasks default to greedy decoding, so we record a sampling temperature of zero. This is applied only where harness usage is documented, never inferred from the benchmark being open-source.

Everything else is left blank, including the inference stack for open models, the decoding parameters for benchmarks whose papers omit them, and all fields for "bring your own predictions" benchmarks. Aggregator sources that do not publish their engineering stack contribute no inference metadata at all.

## Release-date provenance

Release dates are recorded to year and month, alongside the class of evidence each came from. The tiers are ordered, and the ordering is the point: a filter on this column is the only way to use the field responsibly.

| Tier | Evidence | Models | Benchmarks |
|-----------|------------------------|------|---------|
| arXiv identifier in the record | the identifier decodes to the month exactly | 0 | 1 |
| Repository creation timestamp | the creation date of a HuggingFace repository whose name *is* the model | 801 | 0 |
| The model's own paper | confirmed by reading the paper's title | 25 | 0 |
| Date stamped in the name | the identifier carries its own release date | 1 | 0 |
| Verified web page | a page fetched and confirmed to name this model *and* carry this date | 434 | 0 |
| Citation present, not re-readable | a citation exists but could not be re-read by a non-browser client | 93 | 61 |
| Corroborated to the month | two independent systems agreed to the month | 8 | 5 |
| Citation present, page inaccessible | a real citation whose page is bot-blocked, paywalled, or script-only | 117 | 0 |
| Corroborated to the year only | two systems agreed to the year but not the month | 20 | 136 |
| Inherited from the base model | an evaluation or method variant taking its base model's date | 1 | 0 |
| Single uncorroborated answer | one language model's answer, with no corroboration and a measured error of roughly 30 % | 89 | 29 |
| Pre-existing, origin unrecorded | a date already present before this pass | 24 | 223 |
| (blank) | undated | 5 | 1 |

Grouping the first five as *strong*: **1,261 of 1,618 model rows (78 %)** against **1 of 456 benchmark rows (0.2 %)**.

<!-- Every count in this table was recomputed from data/text_only/models.csv and
benchmarks.csv on 2026-09-19. The previous version was tallied over 2,014 model
rows and 624 benchmark rows, which is the pre-filter corpus, not the 1,618
models and 456 benchmarks the paper actually analyses. The superseded column
pairs, in table order: 0/1, 921/0, 39/2, 1/0, 605/0, 129/86, 9/5, 135/0, 36/162,
2/-, 103/65, 27/302, 7/1, and "1,566 of 2,014 model rows (78 %) against 3 of 624
benchmark rows (0.5 %)". The strong-tier share of models is unchanged at 78 %.

The tier labels are still the pipeline's own enum values and are due to be
rewritten as English in the appendix tidy-up; only the counts changed here. -->


### Verification is three-way, not binary.

Every dated answer carrying a citation was re-checked by fetching the cited page and asking two questions: does it name this model, and does it carry this date. The outcomes are **verified**, **unverifiable** (the page is bot-blocked, paywalled, or script-only, giving no evidence either way), and **contradicted** (the page read cleanly and did not support the claim). Only the third is evidence of an error. Of 565 dated answers, 404 verified (72 %), 96 were unverifiable and 65 contradicted.

The distinction that matters is that **a contradicted verdict impugns the citation, not necessarily the date**, and in this corpus the two came apart in both directions. StarCoder2-15B was answered 2023-05 and cited the StarCoder *2* paper, which is 2024-02: the citation is right and the answer wrong. StarCoderBase was answered 2023-05 and cited an unrelated paper: the answer is right and only the citation wrong. Because the same verdict demanded opposite handling, the bucket could not be applied or discarded wholesale, and all 65 rows were re-checked individually against evidence independent of the original citation. 61 were resolved, each with its own recorded evidence, and four were left at their existing values because no identity-given source could be found.

### Two lower bounds, and only one of them is sound.

A repository cannot postdate the model it distributes, so a repository creation date is a genuine lower bound. However, since it can sit well below the release, that bound is often loose. The StarCoder2-3B repository was created 2023-11-29 for a model that became public in 2024-02. A paper date is *not* a lower bound, because papers routinely trail the release: Pythia-12B had a public, archived model page on 2023-02-03, two months before the Pythia paper. We built a guard taking the later of the two, and discarded it after measuring it. Of the seven rows it moved, one was right and at least five were wrong. Repository creation dates are therefore used unmodified and documented as a lower bound, with individual cases corrected by hand rather than by rule.

### Failure modes that recur.

Three are worth naming because each produced errors that survived an earlier pass. (i) *Family attribution*: a page about the family, or about a later version, supplies a real date for the wrong artefact. (ii) *Staged releases*, which are family attribution inside a single model line. GPT-2 shipped in four tranches (124M 2019-02, 355M 2019-05, 774M 2019-08, 1.5B 2019-11, each datable from the publisher's own commits), and six corpus rows had collapsed them onto one date. (iii) *Name collision*, where SGPT-2.7B-msmarco was dated 2019-02 as though it were a GPT-2 variant when it is in fact SGPT, 2022-02.

### The known bias is toward being early.

Dates produced by asking a language model run systematically early for models released after that model's training cutoff. Correcting the weak tiers moved 119 model dates, 85 of them later, which is the bias being paid down where it was concentrated. Twenty rows moved by a year or more, several by two (GPT-4.1 from 2023-03 to 2025-04, and Gemini 3 Pro from 2023-12 to 2025-11).

## Inclusion and exclusion criteria

### Models

**Included.** General-purpose generative LLMs. Domain- or task-adapted models (code, medical, legal) that still accept arbitrary prompts. Multimodal models built by adding an encoder to an LLM backbone, provided the backbone still handles arbitrary text prompts.

**Excluded.** Encoder-only or classification-only architectures (BERT, RoBERTa, BigBird). Narrow single-purpose systems that cannot be prompted generally, such as dedicated translation systems like NLLB and speech systems like SeamlessM4T. Bare embedding or vision encoders (CLIP variants, ST5, monoT5). Non-deployable research systems. Evaluation *metrics* misfiled as models, such as YiSi-1. Undocumented community uploads without reliable provenance.

**Not a separate model:** a different *setup* of the same model, such as a context-length variant, a reasoning or thinking mode, an effort level, or a prompting scheme. These are recorded on the result row instead.

Borderline cases are reviewed individually rather than by keyword. Documented outcomes include three of note. T5, mT5 and FLAN-T5 were **kept**, being encoder-decoder models that are nonetheless instruction-followable and generative. Three genuine vision-language models whose names happened to match an exclusion keyword were **kept**. So was a model flagged only because a metadata bug had leaked its HuggingFace namespace into its developer field, with the metadata fixed.

BigBird-Pegasus was **removed**, which sharpens where the boundary sits. Pegasus is pretrained with gap-sentence generation *specifically for summarisation* and cannot be given an arbitrary instruction, so it fails the criterion that T5 passes. The data agrees, in that both of its benchmarks were summarisation tasks. The plain encoder-only BigBird variants had already been removed, and Pegasus has since been added to the narrow-task pattern set so the classifier catches the family rather than relying on case-by-case review.

Rows differing in evaluation setup, source, or language are **legitimately distinct evaluations**, not duplicates, and are retained. A benchmark with few rows is flagged for review as a possible interrupted extraction, but the flag is never satisfied by averaging rows to hit a count.

<!-- Merged in from sections/appendix/unused/inclusion-and-exclusion-criteria.md,
which Main.md does not embed: "evaluation metrics misfiled as models", the
"Not a separate model" paragraph, the borderline-cases paragraph, the
BigBird-Pegasus paragraph, and the former "Multiple scores per model-benchmark
pair" section (the last paragraph above). The three field names this text used to
quote as code (setup, reasoning_enabled, source_url) are written out in words;
the code-stripping pass would have done that anyway. -->

### Benchmarks

We remove benchmarks that has zero results after filtering models. Removing out-of-scope models cascades here, since benchmarks whose entire evaluated population was out of scope (pure NER and machine-translation leaderboards from Papers With Code, a vision-only task whose sole model was an image encoder) are left with no rows at all. We further select for benchmarks that do not require multimodal capabilities such as image, audio, video, or speech understanding. No relevance or "is this really intelligence" filter is applied to benchmark content.

<!-- The second sentence was a literal placeholder, "benchmarks that do not
require multimodal capabilities such as XXX", and it reached the built PDF. The
completion and the cascade sentence come from the unembedded twin of this
section, sections/appendix/unused/inclusion-and-exclusion-criteria.md, which
carries the finished text. The opening sentence is kept as written.

The procedure that actually performs the modality filter (pattern vocabulary,
allow-list, deny-list, cascade counts) is still unembedded, in
sections/appendix/unused/text-only-classifier.md. It is held back until the
code-stripping pass, and a cross-reference should be added here once it goes in. -->


### Benchmark translation duplicates

A dedicated pass distinguished **translation duplicates** from **natively multilingual benchmarks**, decided case-by-case against each benchmark's source paper:

- *Removed* (literal translations of an original already in the corpus, covering 28 identifiers and 992 rows): MGSM per-language variants (250 GSM8K problems manually translated into 10 languages, with the English variant kept), Global MMLU Lite per-language variants (machine-translated and post-edited MMLU, again with the English variant kept), a human-translated Arabic MMLU, OpenAI's Multilingual MMLU aggregate, Global MMLU aggregates, and IndicXNLI (machine-translated from XNLI).
- *Consolidated* (translated, but with no original present in our import to prefer, so merged into the parent identifier with the language recorded, covering 8 identifiers and 168 relabelled rows with zero rows lost): XCOPA, XNLI, XQuAD per-language splits.
- *Left intact* (verified independently sourced per language, not parallel translations): MultiLoKo (locally-sourced Wikipedia content per language), ArabicMMLU (natively sourced from Arabic school exams), FLORES translation directions (each direction is a distinct task), LINDSEA, Thai national exams, and Papers With Code WMT and CoNLL language-pair benchmarks.

A later pass resolved the cases the first had left open. HumanEval-XL was **removed**, since it is HumanEval's problem set re-prompted in 23 natural languages and the original HumanEval is in the corpus, which is exactly the condition the rule targets. The three models scored on both correlate at $r = 0.993$, which is corroboration only, since three shared models cannot carry such a decision. The construct is the basis.

MGSM and Belebele were **kept**, and the reason is worth stating because it looks like an inconsistency. Both are cross-language *aggregates*, and neither duplicates any column we hold. MGSM shares **zero** models with GSM8K, and Belebele has no in-corpus original at all (its 122 languages are internally parallel, but there is no English Belebele here for it to duplicate). A redundancy claim is a claim that two columns track each other, and columns that never co-occur cannot track each other. Both also measure multilingual transfer alongside the underlying skill, which the monolingual originals do not. This matches the treatment of MultiLoKo, whose paper-sourced across-language aggregate was likewise kept while its per-language splits were dropped. Excluding cross-language aggregates would be a defensible alternative, but it is a single policy choice covering MGSM, Belebele and MultiLoKo together, not a per-benchmark judgement.

<!-- The opening sentence and the two paragraphs above are merged in from the
unembedded sections/appendix/normalisation-rules.md. They are what makes the
"Left intact" bullet defensible: without them the appendix drops MGSM
per-language variants and keeps the MGSM aggregate with no stated reason, which
reads as an inconsistency. Benchmark names are written as prose rather than as
code identifiers, matching the main text. The sentence about lowercase
identifiers serving as the primary key was left out as repository detail. -->


## Duplicate detection and integrity checks

The duplicate identity key is the tuple (model, benchmark, metric, setup, source, model identifier, language). Duplicates are reported in two classes: **pure redundancy** (identical score reported twice) and **conflicts** (different scores under one identity). Conflicts are resolved by source-trust tier (`\hyperref[source-inventory]{Appendix~\ref*{source-inventory}}`{=latex}) and recency, and the report is always reviewed before any automated resolution runs.

The integrity pass asserts zero foreign-key violations in both directions, zero models with no result rows, and zero benchmarks with no result rows. It also flags benchmarks with fewer than five rows for manual review. It is run after every write, including after each of the pruning passes in `\hyperref[score-redundancy-pruning]{Appendix~\ref*{score-redundancy-pruning}}`{=latex}.

Link validity was checked by a multi-threaded URL sweep across both metadata tables, ignoring anti-bot 403s, repairing moved repositories, and filling 53 previously-blank benchmark source links.

## Score Normalization

Scores are normalised to a 0 to 100 scale. A raw value in $[0,1]$ is multiplied by 100, a value above 1 is kept as it is, and results are capped at 100 to absorb floating-point noise. Exempt metrics, kept on their native scale, are perplexity, bits-per-byte, BLEURT, BERTScore, Elo, and count-type metrics ("# eval").

## Canonical metric selection

Applied to the derived copy after the benchmark removals, so coverage is counted over the surviving population. Selection proceeds in four steps, first match wins:

1. **Normalise.** Strip, casefold, and collapse internal whitespace. This alone resolves GSM8K, FEVER, HumanEval and WinoGrande, whose only "conflict" was a capitalised against a lowercase spelling of accuracy. Skipping it would have discarded 149 GSM8K rows.
2. **Alias.** A curated map merges verified spelling variants of one measurement. Bits per byte written out and abbreviated are merged on The Pile, recovering 23 models. Chain-of-thought equivalence written out and abbreviated are merged on the chain-of-thought mathematics benchmark, where 13 models carry both spellings at a mean within-model difference of +0.16 and a standard deviation of 1.82. That is the same measurement typed twice by two importers, and treating the two as rivals would have cost 56 models. Abbreviated and written-out accuracy are merged, as are RACE's own high-school and middle-school shorthands.
3. **Override.** A per-benchmark pin for cases where coverage chooses badly.
4. **Coverage.** Otherwise the metric covering the most distinct **models**, rather than the most rows, since one leaderboard can contribute many rows for few models. Ties are broken by row count and then by name, for determinism.

The alias map is curated, never inferred. Deriving it from small within-model score differences was tried and rejected, because it mislabels task *facets* as aliases (SI-Bench's "cause", "motivation" and "social intention", and SOTOPIA's "secret" and "social rules", all sit within a point of each other on a compressed scale) and misfiles *configuration* names as aliases, as ELEPHANT does.

Net effect: 92 contested benchmarks, 1,420 rows dropped and 706 model-cells lost, with roughly half of the contested benchmarks resolving without losing any model.

**Accuracy versus exact match.** Sixteen benchmarks carry both, and they account for most of the cost, with MMLU alone giving up 144 models. On multiple-choice tasks the two look like one construct (MMLU's means differ by 1.0 point, 50.3 against 51.3, and HellaSwag's by 0.5), so aliasing them is tempting and would recover roughly 450 model-cells. We deliberately do not, for two reasons.

First, the names are effectively **source labels rather than measurement labels**. Exact match is Stanford HELM's metric name, and HELM is the top exact-match source on 13 of the 16, while accuracy comes from the Open LLM Leaderboard, Papers With Code and primary papers. Merging them would not merge two metrics, it would merge two evaluation regimes.

Second, those regimes score **near-disjoint model populations**. A merged column would therefore be bimodal by source, with an offset that cannot be estimated. No model in the corpus is scored both ways on any of the sixteen, so there is no overlap to calibrate against, and the sparse overlap that exists elsewhere is inconsistent (BoolQ differs by +18.4 across 2 models, OpenBookQA by +6.2 across 1). Because HELM owns 138 columns, the same bias would recur corpus-wide as a source factor, and it would present as an *improvement*, since the matrix would appear better connected while the new bridges rested on an unverifiable assumption.

For the same reason we do not pin accuracy globally. The coverage rule already selects it where it genuinely dominates (MMLU, TruthfulQA, HellaSwag, PubMedQA) and selects exact match on the other twelve. Forcing accuracy everywhere would cost 449 further model-cells (OpenBookQA 120 to 22, LegalBench 90 to 5, IMDB 67 to 6, MedQA 99 to 42) and would systematically evict the most methodologically controlled source in the corpus. Accuracy is the more conventional name. Here it is not a quality signal.

<!-- Merged in from the unembedded sections/appendix/normalisation-rules.md: the
curated-alias-map paragraph, the net-effect line, and the four-paragraph accuracy
versus exact-match argument. This is the substantive defence of the metric filter
and the paper had no version of it that reached the PDF.

Changed on the way in: metric names are written out ("exact match" for em) and
benchmark names are set as prose rather than as code identifiers, matching the
main text. One clause was dropped from the "near-disjoint populations" paragraph,
"(see the co-observation table in [[Methodology#Sources partition the matrix]])",
because that table lives in the root-level Methodology.md, which Main.md does not
embed. The table itself (HELM x HELM median 4 shared models, OLL x OLL 160,
HELM x OLL 0, with 87 % of pairs not estimable) is worth moving into
sections/Methodology.md, and the cross-reference restored, if the claim needs the
support. That is still open. -->

## Defects below the metric name

Two problems survive metric selection because they are not distinguishable by metric name at all.

**Source-level scale conflict on GPQA.** One metric name, two incompatible conventions, told apart only by source. 447 of 454 rows are Open LLM Leaderboard v2 **normalised** accuracy, which maps the random-chance baseline to zero and clamps negatives there, spanning 0.00 to 24.94 with median 4.36, while the other 7 are raw accuracy from papers and llm-stats spanning 39.0–94.1. The ranges do not overlap. We keep the 447 and drop the 7. The reasoning is that correlations are invariant under a linear rescaling of an entire column, so a normalised column is fully usable provided every row shares the convention. Back-transforming instead ($\text{raw} = 0.75\,\text{norm} + 25$) would assume the leaderboard's formula and would still not undo the clamp, for the sake of 7 models out of 454. The documented caveat is that 56 of the 447 (13 %) sit exactly at 0.00, tied at the clamp, so the column under-discriminates among weak models.

The same detector, which looks for benchmarks whose sources have strictly non-overlapping score ranges, flags three others (WildBench, SEA-Exam and MultiPL-E), all on small $n$. We do not act on those, since a gap alone is not evidence of a scale conflict, because frontier-model trackers such as llm-stats legitimately show higher ranges than broad leaderboards by evaluating better models. GPQA is the only case with a known mechanism.

**Structurally defective column on ELEPHANT.** Its metric field holds model *configurations* rather than metrics, so selecting a canonical metric keeps one arbitrary configuration, which measures nothing. The benchmark is removed from the derived copy (9 models) and recorded for re-extraction.

Two further columns that appear in earlier drafts as defects are **resolved by the metric filter itself** and need no special handling. Those are Vectara, whose two metrics are complements differing by +86.5 across 7 shared models, and LAMBADA, which mixed accuracy with perplexity.
