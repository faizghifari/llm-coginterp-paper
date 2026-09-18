# F Model-identity collapse {-}

Both strategies operate on the source-specific `results.model_id` field ([[A-data-sources-and-extraction#A.3 Schema|Appendix A.3]]), after canonicalising each identifier's `model_family` and `model_size` metadata to the first non-null value observed for it. Multiple evaluations of the same (identifier, benchmark) are averaged before collapsing, and rows sharing a collapse key are averaged again per benchmark.

## F.1 `all_standard` (variant-level) {-}

Applied in order to each identifier:

1. Strip the organisation prefix (everything before the first `/`).
2. Reduce parenthesised content to a parameter count if one is present, else drop it.
3. Strip trailing junk after `-&`, effort phrases (`medium effort`, `high reasoning`), all date formats (`YYYY-MM-DD`, `YYYYMMDD`, `MM-DD`), and any bare 4-digit number (release years, checkpoint stamps, context lengths).
4. Normalise version hyphens to dots (`3-5` → `3.5`).
5. Where a `model_family` is available and non-numeric, take it as the stem and tokenise the remaining suffix; otherwise tokenise the whole cleaned identifier.
6. Per token: drop generic training and serving tokens (`instruct`, `chat`, `base`, `sft`, `dpo`, `rlhf`, `thinking`, `reasoning`, `cot`, `greedy`, `api`, `abliterated`, …), language and region tokens, legacy engine names, and month names; preserve named tier tokens (`opus`, `sonnet`, `haiku`, `pro`, `mini`, `flash`, `maverick`, `scout`, …); drop context-length tokens (`32k`, `128k`, `1m`); recognise parameter counts either by a `B` suffix or by matching the identifier's own `model_size` metadata or a whitelist of common sizes; merge version numbers into the family stem when one extends the other.
7. Emit `family-<preserved tokens>-<size>B`.

The common-size whitelist is guarded against version-number collisions: a bare `3` or `4` in a Claude or GPT identifier is a version, not a parameter count.

## F.2 `all_aggressive` (family-level) {-}

Take the first alphabetic token of `model_family` if it is non-numeric; otherwise strip the organisation prefix, parentheses, and dates from the identifier and take its first alphabetic token. Everything else is discarded.

## F.3 Post-collapse filtering {-}

Benchmarks observed for only one collapse key are dropped, then collapse keys with no remaining benchmarks are dropped. This yields Table 2 of [[Methodology|the Methodology]] (1,310 × 455 at 2.33 %; 350 × 431 at 3.55 % — provisional, from matrices predating the score-redundancy pruning; recomputed on the current corpus these are 1,269 × 405 at 2.16 % and 337 × 381 at 3.49 %) from 2,297 distinct source-level model identifiers.
