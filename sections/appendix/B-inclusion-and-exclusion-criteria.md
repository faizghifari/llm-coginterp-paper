# B Inclusion and exclusion criteria {-}

## B.1 Models {-}

**Included:** general-purpose generative LLMs; domain- or task-adapted models (code, medical, legal) that still accept arbitrary prompts; multimodal models built by adding an encoder to an LLM backbone, provided the backbone still handles arbitrary text prompts.

**Excluded:** encoder-only or classification-only architectures (BERT, RoBERTa, BigBird); narrow single-purpose systems that cannot be prompted generally (dedicated MT systems such as NLLB, speech systems such as SeamlessM4T, TTS/ASR); bare embedding or vision encoders (CLIP variants, ST5, monoT5); research systems that are architectures-with-a-name rather than deployable models; evaluation *metrics* misfiled as models (e.g. YiSi-1); and undocumented community uploads without reliable provenance.

**Not a separate model:** a different *setup* of the same model — context-length variant, reasoning or thinking mode, effort level, prompting scheme. These are recorded in the `setup` and `reasoning_enabled` fields on the result row.

Borderline cases are reviewed individually rather than by keyword. Documented outcomes include: T5/mT5/FLAN-T5 **kept** (encoder–decoder, but instruction-followable and generative); three genuine vision-language models whose names happened to match an exclusion keyword **kept**; and a model flagged only because a metadata bug had leaked its HuggingFace namespace into its developer field **kept**, with the metadata fixed.

`BigBird-Pegasus` was **removed**, which sharpens where the boundary sits. Pegasus is pretrained with gap-sentence generation *specifically for summarisation* and cannot be given an arbitrary instruction, so it fails the criterion that T5 passes; the data agrees, in that both of its benchmarks were summarisation tasks. The plain encoder-only BigBird variants had already been removed, and `pegasus` has since been added to the narrow-task pattern set so the classifier catches the family rather than relying on case-by-case review.

## B.2 Benchmarks {-}

A benchmark is included if it has at least one in-scope result row after model filtering. Zero-result stubs are removed from the benchmark table and logged for future collection. Removing non-LLM models therefore cascades: benchmarks whose entire evaluated population was out of scope (pure NER and MT leaderboards from Papers With Code, a vision-only task whose sole model was an image encoder) are removed as zero-result stubs.

No relevance or "is this really intelligence" filter is applied to benchmark content.

## B.3 Multiple scores per model–benchmark pair {-}

Rows differing in `setup`, `source_url`, or `language` are **legitimately distinct evaluations**, not duplicates, and are retained. A benchmark with few rows is flagged for review as a possible interrupted extraction, but the flag is never satisfied by averaging rows to hit a count.
