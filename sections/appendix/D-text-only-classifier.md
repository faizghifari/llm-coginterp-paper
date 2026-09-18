# D Text-only classifier {-}

## D.1 Pattern vocabulary {-}

A benchmark is classified `NON_TEXT` if any of the following terms matches, as a **whole word**, in the concatenation of its identifier (with `_` and `-` replaced by spaces) and its `category`, `subcategory`, `task_type`, `task_types`, `domain`, `benchmark_name`, `description`, and `title` fields:

```
vision, visual, image, video, multimodal, vqa, audio, speech, spoken,
acoustic, ocr, asr, tts, photo, diagram, chart, screenshot, music, song, sound
```

Word-boundary matching is required, not optional: substring matching false-positives on e.g. *vision* inside "Historical Revisionism Detection". The identifier is included in the match text because several sparse-metadata imports carry their only modality signal in the identifier itself (`..._video_qa`).

## D.2 Allow-list (text-only despite a matching pattern) {-}

Checked **before** the pattern match:

| Benchmark | Justification |
|---|---|
| `abceval` | Evaluates text-based ABC notation only; no audio input despite `category = audio/speech` |
| `ziqi_eval` | Pure text-QA music-knowledge benchmark; no audio input |
| `aci_bench` | HELM MedHELM task is transcript-to-clinical-note summarisation; the model never receives audio despite the description mentioning "spoken medical dialogue" |

## D.3 Deny-list (non-text despite absent or misleading metadata) {-}

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

## D.4 Cascade and counts {-}

Removal is transitive: benchmark → its result rows → any model with zero remaining results. The integrity pass ([[C-normalisation-rules#C.4 Duplicate detection and integrity checks|Appendix C.4]]) is re-run afterwards, and the per-model aggregate columns recomputed.

| | Canonical | After modality filter |
|---|---:|---:|
| Benchmarks | 624 | 503 |
| Models | 2,014 | 1,669 |
| Result rows | 19,030 | 16,930 |

The 121 removed benchmarks by declared category: Visual QA 29 + 3, Multimodal 13 + 7 + 2, vision/multimodal 12, Audio/Speech 6 + 6, multilingual 6, general knowledge 4 + 3, alignment and safety 4 + 2, chart and figure tasks 3 + 2, and a tail of single-entry categories.
