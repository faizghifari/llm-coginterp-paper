# C Normalisation rules {-}

## C.1 Scores {-}

Scores are normalised to a 0–100 scale: a raw value in $[0,1]$ is multiplied by 100; a value above 1 is kept as-is; results are capped at 100 to absorb floating-point noise. Exempt metrics, kept on their native scale, are perplexity, bits-per-byte, BLEURT, BERTScore, Elo, and count-type metrics ("# eval").

Metric direction is **recorded, not applied**: lower-is-better metrics (WER, perplexity) are stored with `metric_lower_is_better = True` and normalised identically. See [[L-known-limitations-and-deviations#L Known limitations and deviations|Appendix L]] for the consequence this has for the covariance analysis.

## C.2 Model identity {-}

- **Organisation prefixes stripped** (`meta-llama/Llama-3-8B` → `Llama-3-8B`); the one pre-existing collision this would have created was resolved by hand before stripping.
- **Reasoning and effort tags merged** into the base name (`claude-3-7-sonnet-thinking`, `o3 high`), with the affected result rows marked `reasoning_enabled = True`.
- **Context-length variants merged** (`gpt-4-32k`, `gpt-4-128k` → `GPT-4`): context length is an evaluation setup, not a model identity.
- **Family disambiguation** where a bare name is ambiguous, using parameter count and evaluation year (e.g. Llama 7B/13B/70B → Llama 2; 405B → Llama 3.1); named variants (Llama 4 Scout/Maverick) stay distinct.
- **Status markers stripped** at extraction (skull, warning, dagger, star, cross, check, and circled-digit pictographs used by some sources to annotate rows).
- **No blanket case normalisation.** The corpus uses mixed Title-Case (`GPT-4`, `Claude 3 Opus`); a wholesale relabel would rewrite hundreds of already-correct rows for no integrity gain. Only genuine same-model-two-spellings pairs are renamed, discovered by a fuzzy-match report over result rows whose `model_name` has no matching `model_id`.

## C.3 Benchmark identity and translation duplicates {-}

Benchmark identifiers are lowercase and serve as the primary key; identifier collisions across sources are resolved by adding result rows to the existing benchmark rather than creating a second benchmark row.

A dedicated pass distinguished **translation duplicates** from **natively multilingual benchmarks**, decided case-by-case against each benchmark's source paper:

- *Removed* (literal translations of an original already in the corpus; 28 identifiers, 992 rows): MGSM per-language variants (250 GSM8K problems manually translated into 10 languages — English variant kept), Global MMLU Lite per-language variants (machine-translated and post-edited MMLU — English variant kept), a human-translated Arabic MMLU, OpenAI's Multilingual MMLU aggregate, Global MMLU aggregates, and IndicXNLI (machine-translated from XNLI).
- *Consolidated* (translated, but no original present in our import to prefer — merged into the parent identifier with the `language` field backfilled; 8 identifiers, 168 rows relabelled, zero rows lost): XCOPA, XNLI, XQuAD per-language splits.
- *Left intact* (verified independently sourced per language, not parallel translations): MultiLoKo (locally-sourced Wikipedia content per language), ArabicMMLU (natively sourced from Arabic school exams), FLORES translation directions (each direction is a distinct task), LINDSEA, Thai national exams, and Papers With Code WMT and CoNLL language-pair benchmarks.

A later pass resolved the cases the first had left open. `humaneval_xl` was **removed**: HumanEval-X/XL is HumanEval's problem set re-prompted in 23 natural languages and the original `humaneval` is in the corpus, which is exactly the condition the rule targets. The three models scored on both correlate at $r = 0.993$ — corroboration only, since three shared models cannot carry such a decision; the construct is the basis.

`mgsm` and `belebele` were **kept**, and the reason is worth stating because it looks like an inconsistency. Both are cross-language *aggregates*, and neither duplicates any column we hold: `mgsm` shares **zero** models with `gsm8k`, and `belebele` has no in-corpus original at all (its 122 languages are internally parallel, but there is no English Belebele here for it to duplicate). A redundancy claim is a claim that two columns track each other; columns that never co-occur cannot track each other. Both also measure multilingual transfer alongside the underlying skill, which the monolingual originals do not. This matches the treatment of `multiloko`, whose paper-sourced across-language aggregate was likewise kept while its per-language splits were dropped. Excluding cross-language aggregates would be a defensible alternative, but it is a single policy choice covering `mgsm`, `belebele` and `multiloko` together — not a per-benchmark judgement.

## C.4 Duplicate detection and integrity checks {-}

The duplicate identity key is the tuple (model, benchmark, metric, setup, source, model identifier, language). Duplicates are reported in two classes: **pure redundancy** (identical score reported twice) and **conflicts** (different scores under one identity). Conflicts are resolved by source-trust tier ([[A-data-sources-and-extraction#A.1 Source inventory|Appendix A.1]]) and recency, and the report is always reviewed before any automated resolution runs.

The integrity pass asserts: zero foreign-key violations in both directions; zero models with no result rows; zero benchmarks with no result rows; and flags benchmarks with fewer than five rows for manual review. It is run after every write, including after each of the pruning passes in [[E-score-redundancy-pruning#E Score-redundancy pruning|Appendix E]].

Link validity was checked by a multi-threaded URL sweep across both metadata tables, ignoring anti-bot 403s, repairing moved repositories, and filling 53 previously-blank benchmark source links.

## C.5 Canonical metric selection {-}

Applied to the derived copy after the benchmark removals, so coverage is counted over the surviving population. Selection proceeds in four steps, first match wins:

1. **Normalise** — strip, casefold, collapse internal whitespace. This alone resolves `gsm8k`, `fever`, `humaneval` and `winogrande`, whose only "conflict" was `Accuracy` vs `accuracy`; skipping it would have discarded 149 `gsm8k` rows.
2. **Alias** — a curated map merges verified spelling variants of one measurement: `bits per byte` → `bpb` (`the_pile`, recovering 23 models), `equivalent (chain of thought)` → `equivalent (cot)` (`math_chain_of_thought`; 13 models carry both, mean within-model difference +0.16, sd 1.82 — the same measurement typed twice by two importers, and treating them as rivals would have cost 56 models), `acc` → `accuracy`, and RACE's own `race-h`/`race-m` shorthand.
3. **Override** — a per-benchmark pin for cases where coverage chooses badly.
4. **Coverage** — otherwise the metric covering the most distinct **models** (not rows: one leaderboard can contribute many rows for few models), tie-broken by row count then by name for determinism.

The alias map is curated, never inferred. Deriving it from small within-model score differences was tried and rejected: it mislabels task *facets* as aliases (`sibench`'s "cause"/"motivation"/"social intention" and `sotopia`'s "secret"/"social rules" all sit within a point of each other on a compressed scale) and misfiled *configuration* names as aliases (`elephant`).

Net effect: 92 contested benchmarks, 1,420 rows dropped and 706 model-cells lost, roughly half of the contested benchmarks resolving without losing any model.

**`accuracy` versus `em`.** Sixteen benchmarks carry both, and they account for most of the cost — `mmlu` alone gives up 144 models. On multiple-choice tasks the two look like one construct (`mmlu`'s means differ by 1.0 point, 50.3 vs 51.3; `hellaswag`'s by 0.5), so aliasing them is tempting and would recover roughly 450 model-cells. We deliberately do not, for two reasons.

First, the names are effectively **source labels rather than measurement labels**: `em` is Stanford HELM's metric name — HELM is the top `em` source on 13 of the 16 — while `accuracy` comes from the Open LLM Leaderboard, Papers With Code and primary papers. Merging them would not merge two metrics; it would merge two evaluation regimes.

Second, those regimes score **near-disjoint model populations**. A merged column would therefore be bimodal by source, with an offset that cannot be estimated: no model in the corpus is scored both ways on any of the sixteen, so there is no overlap to calibrate against, and the sparse overlap that exists elsewhere is inconsistent (`boolq` +18.4 across 2 models, `openbookqa` +6.2 across 1). Because HELM owns 138 columns, the same bias would recur corpus-wide as a source factor — and it would present as an *improvement*, since the matrix would appear better connected while the new bridges rested on an unverifiable assumption.

<!-- The parenthetical here used to read "(see the co-observation table in
[[Methodology#Sources partition the matrix]])". That pointer went to the old
root-level Methodology.md, which is not embedded in Main.md, so it rendered in
the PDF as a raw URL to a section the paper does not contain. The table it
referred to (HELM x HELM median 4 shared models, OLL x OLL 160, HELM x OLL 0
with 87% of pairs not estimable) is still in Methodology.md under "Sources
partition the matrix", but was condensed out of sections/Methodology.md. Move it
into sections/Methodology.md and restore the cross-reference if the claim needs
the support. -->

For the same reason we do not pin `accuracy` globally. The coverage rule already selects it where it genuinely dominates (`mmlu`, `truthfulqa`, `hellaswag`, `pubmedqa`) and selects `em` on the other twelve; forcing `accuracy` everywhere would cost 449 further model-cells (`openbookqa` 120 → 22, `legalbench` 90 → 5, `imdb` 67 → 6, `medqa` 99 → 42) and would systematically evict the most methodologically controlled source in the corpus. `accuracy` is the more conventional name; here it is not a quality signal.

## C.6 Defects below the metric name {-}

Two problems survive metric selection because they are not distinguishable by metric name at all.

**Source-level scale conflict (`gpqa`).** One metric name, two incompatible conventions, told apart only by source: 447 of 454 rows are Open LLM Leaderboard v2 **normalised** accuracy — the random-chance baseline mapped to zero, negatives clamped there — spanning 0.00–24.94 with median 4.36, while the other 7 are raw accuracy from papers and llm-stats spanning 39.0–94.1. The ranges do not overlap. We keep the 447 and drop the 7. The reasoning is that correlations are invariant under a linear rescaling of an entire column, so a normalised column is fully usable provided every row shares the convention; back-transforming instead ($\text{raw} = 0.75\,\text{norm} + 25$) would assume the leaderboard's formula and would still not undo the clamp, for the sake of 7 models out of 454. The documented caveat is that 56 of the 447 (13 %) sit exactly at 0.00, tied at the clamp, so the column under-discriminates among weak models.

The same detector — benchmarks whose sources have strictly non-overlapping score ranges — flags three others (`wildbench`, `sea_exam`, `multipl_e`), all on small $n$. We do not act on those: a gap alone is not evidence of a scale conflict, because frontier-model trackers such as llm-stats legitimately show higher ranges than broad leaderboards by evaluating better models. `gpqa` is the only case with a known mechanism.

**Structurally defective column (`elephant`).** Its `metric_name` field holds model *configurations* (`DPO-All-Llama-8B`, `iti-llama-70b`, `perspective-gpt-4o`), not metrics, so selecting a canonical metric keeps one arbitrary configuration, which measures nothing. The benchmark is removed from the derived copy (9 models) and recorded for re-extraction.

Two further columns that appear in earlier drafts as defects — `vectara`, whose two metrics are complements differing by +86.5 across 7 shared models, and `pwc_lambada`, which mixed accuracy with perplexity — are **resolved by the metric filter itself** and need no special handling.
