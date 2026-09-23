# Label cohesion results

## Task type

| Label | Median A | Significant | Median n |
|---|---:|---:|---:|
| `likelihood_probe` | +0.155 | 6/10 | 19 |
| `short_qa` | +0.103 | 2/16 | 15 |
| `interactive` | +0.078 | 1/10 | 16 |
| `long_reasoning` | +0.067 | 0/16 | 9 |
| `classification` | +0.067 | 2/16 | 15 |
| `multiple_choice` | +0.056 | 6/16 | 37 |
| `long_form_generation` | +0.024 | 4/16 | 32 |
| `ranking` | -0.072 | 0/2 | 10 |

## Language

| Label | Median A | Significant | Median n |
|---|---:|---:|---:|
| `monolingual_non_english` | +0.272 | 14/16 | 19 |
| `multilingual` | +0.204 | 6/14 | 9 |
| `crosslingual` | +0.137 | 1/10 | 12 |
| `english` | -0.024 | 0/16 | 85 |

## Subject

| Label | Median A | Significant | Median n |
|---|---:|---:|---:|
| `finance` | +0.871 | 9/10 | 4 |
| `professional_writing` | +0.631 | 4/6 | 5 |
| `commonsense` | +0.314 | 7/16 | 11 |
| `fact_verification` | +0.304 | 0/4 | 5 |
| `code` | +0.263 | 7/16 | 11 |
| `translation` | +0.249 | 5/10 | 16 |
| `language_understanding` | +0.247 | 4/6 | 10 |
| `linguistic_competence` | +0.228 | 0/10 | 6 |
| `social_media` | +0.225 | 2/10 | 6 |
| `sentiment` | +0.217 | 2/10 | 6 |
| `dialogue` | +0.202 | 0/6 | 5 |
| `industrial` | +0.185 | 0/2 | 4 |
| `cognitive` | +0.179 | 0/6 | 12 |
| `society_culture` | +0.171 | 2/6 | 14 |
| `agentic` | +0.170 | 0/10 | 10 |
| `factuality` | +0.153 | 1/14 | 7 |
| `recall` | +0.134 | 10/16 | 21 |
| `structured_data` | +0.110 | 0/6 | 15 |
| `language_modelling` | +0.100 | 0/6 | 5 |
| `generation` | +0.092 | 2/10 | 37 |
| `world_knowledge` | +0.092 | 0/16 | 7 |
| `logical_reasoning` | +0.090 | 1/16 | 6 |
| `encyclopedic` | +0.076 | 1/16 | 23 |
| `medical` | +0.067 | 1/6 | 40 |
| `legal` | +0.065 | 0/4 | 4 |
| `multi_subject` | +0.056 | 5/16 | 28 |
| `math` | +0.048 | 0/16 | 10 |
| `creativity` | +0.041 | 0/4 | 4 |
| `instruction_following` | +0.040 | 0/10 | 16 |
| `specialized_domain` | +0.024 | 1/16 | 13 |
| `games` | +0.019 | 0/6 | 6 |
| `science` | +0.018 | 0/16 | 11 |
| `natural_language_inference` | +0.017 | 0/6 | 9 |
| `safety` | +0.013 | 0/16 | 8 |
| `source_genre` | +0.006 | 1/16 | 39 |
| `alignment` | -0.005 | 0/16 | 26 |
| `text_classification` | -0.006 | 0/6 | 12 |
| `summarization` | -0.008 | 0/6 | 13 |
| `reasoning` | -0.011 | 0/16 | 19 |
| `retrieval` | -0.014 | 0/6 | 6 |
| `language_processing` | -0.018 | 0/16 | 26 |
| `temporal_reasoning` | -0.022 | 0/2 | 7 |
| `reading_comprehension` | -0.026 | 0/16 | 9 |
| `news` | -0.045 | 0/16 | 6 |
| `toxicity` | -0.053 | 1/14 | 6 |
| `bias_fairness` | -0.067 | 0/6 | 4 |
| `information_extraction` | -0.126 | 0/2 | 4 |
| `fiction` | -0.225 | 0/6 | 4 |

Cohesion of each subject label. A is the chance-corrected within-group agreement 1 - within/null_mean against a coverage-matched permutation null: 0 is chance, 1 is identical members, negative is over-dispersed. Cells are densifier x imputer re-analyses of one dataset, so the count is consistency across analysis choices, not independent replication.
