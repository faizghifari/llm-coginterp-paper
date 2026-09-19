# Model-identity collapse

Both strategies operate on the source-specific model identifier, which each result row carries exactly as its source spelled it, alongside the canonical model it resolves to. Keeping both is what makes cross-source duplicate detection possible after canonicalisation. Each identifier's family and parameter-count metadata is first canonicalised to the first non-null value observed for it.<!-- The second sentence is the one fact worth keeping from the Schema section of the unembedded sections/appendix/unused/data-sources-and-extraction.md, which otherwise documents table joins and column counts and stays out. Without it, the paper never says why a source-specific identifier is retained at all. The three code field names here were also written out. --> Multiple evaluations of the same (identifier, benchmark) are averaged before collapsing, and rows sharing a collapse key are averaged again per benchmark.

## Standard (variant-level)

We apply the following steps in order to each identifier.

1. Strip the organisation prefix, meaning everything before the first slash.
2. Reduce parenthesised content to a parameter count where one is present, and drop it otherwise.
3. Strip trailing separators and any text after them, reasoning-effort phrases such as "medium effort" or "high reasoning", every date format we encountered, and any bare four-digit number, which in this corpus is a release year, a checkpoint stamp, or a context length.
4. Normalise version numbers written with hyphens so that they read as decimals.
5. Where a model family is recorded and is not itself numeric, take it as the stem and tokenise the remaining suffix. Otherwise tokenise the whole cleaned identifier.
6. Then, token by token, drop generic training and serving tokens (instruction tuning, chat, base, the preference-optimisation family, thinking and reasoning markers, greedy decoding, and API markers), language and region tokens, legacy engine names, and month names. Preserve named tier tokens, since Opus, Sonnet, Haiku, Pro, Mini, Flash, Maverick and Scout each denote a distinct released model rather than a serving option. Drop context-length tokens. Recognise a parameter count either from a billions suffix or by matching the identifier's own recorded size, falling back to a whitelist of common sizes. Merge a version number into the family stem when one extends the other.
7. Emit the family stem, the preserved tokens, and the parameter count.

The common-size whitelist is guarded against version-number collisions, since a bare 3 or 4 in a Claude or GPT identifier is a version rather than a parameter count.

## Aggressive (family-level)

Take the first alphabetic token of the recorded model family where it is not numeric. Otherwise strip the organisation prefix, the parentheses and the dates from the identifier, and take its first alphabetic token. Everything else is discarded.

<!-- Pass 5. Steps 3, 6 and 7 were literal token dumps: the full drop-list
(instruct, chat, base, sft, dpo, rlhf, thinking, reasoning, cot, greedy, api,
abliterated), the full keep-list, the context-length literals (32k, 128k, 1m),
the date format strings (YYYY-MM-DD, YYYYMMDD, MM-DD), the separator "-&", the
emit template family-<preserved tokens>-<size>B, and the field names model_family
and model_size. They are now described by category with the tier tokens named,
since those are real model names a reader recognises rather than code. The two
section titles carried the strategy names in code font and are now plain. -->

## Post-collapse filtering

Benchmarks observed for only one collapse key are dropped, then collapse keys with no remaining benchmarks are dropped. This yields the two raw matrices of `\hyperref[tab:matrices]{Table~2}`{=latex}, 1,266 × 404 at 2.2 % and 334 × 380 at 3.5 %, from 2,183 distinct source-level model identifiers.

<!-- The parenthetical here gave two pairs of shapes, and all four were wrong:
"(1,310 x 455 at 2.33 %; 350 x 431 at 3.55 % -- provisional, from matrices
predating the score-redundancy pruning; recomputed on the current corpus these
are 1,269 x 405 at 2.16 % and 337 x 381 at 3.49 %)", and the identifier count
was 2,297. Re-running collapse_results.py on the current corpus on 2026-09-19
gives 1,266 x 404 at 2.169 % and 334 x 380 at 3.525 %, which is what Table 2
already reports, and results.csv carries 2,183 distinct model_id values (2,174
survive the pre-collapse filter that drops benchmarks seen by fewer than two
models). The "provisional" hedge is dropped with them.

The wikilink [[Methodology|the Methodology]] was also removed: Main.md does not
embed the root-level Methodology.md, so it rendered as a bare link rather than a
cross-reference. Methodology Table 2 now carries the label tab:matrices, added in
pass 7, and this sentence points at it. -->

