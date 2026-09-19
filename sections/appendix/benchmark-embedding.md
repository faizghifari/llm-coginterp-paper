# Benchmark embedding

Figure 1 places each benchmark in two dimensions using a composite distance computed from the factor loadings rather than from the score matrix. This appendix describes how that distance is built and how the figure is coloured.

**Vectors.** Every bifactor solution assigns each benchmark a row of loadings, consisting of its loading on the general factor followed by its loadings on each specific factor. We take that row as the benchmark's vector within that solution. A benchmark absent from a given solution does not contribute to it.

**Composite distance.** Within a single solution we compute the cosine distance between every pair of benchmark vectors, which is one minus their cosine similarity, clipped to the range 0 to 2. Cosine distance is invariant to the rotation and to the sign of the factors, so per-solution distances remain comparable even though the factors themselves are not. We then average each pair's distance across every solution in which both benchmarks appear. This average is the composite distance, and it is what the figure embeds.

**Pairs that never co-occur.** Two benchmarks that never appear together in any solution have no measured distance between them. We fill each such entry with the mean of the distances that one of the two benchmarks does have, falling back to the global mean when neither has any. These filled values are indistinguishable from measured ones once the figure is drawn, which is worth keeping in mind when reading isolated points.

**Embedding.** The composite distance matrix is passed to UMAP \citep{mcinnes2018} as a precomputed metric, with two components, ten neighbours, a minimum distance of 0.15, and a fixed random seed. Nothing is re-standardised at this stage, since the distances already share a common scale.

**Colours.** We label all 456 benchmarks by hand on three axes: subject (what the benchmark is about), task (how the test is administered), and language. The labels are multi-label, so a reading-comprehension benchmark on medical text carries both labels. The subject axis has 46 distinct labels and is the one used to colour Figure 1. Labels are authored from each benchmark's own documentation, and we never tune them against the embedding or against any factor solution.

**Reading the figure.** It must be stressed, however, that UMAP preserves neither density nor global distance. Groups that appear tight or far apart in two dimensions are partly an artefact of the embedding. We therefore read the figure as a visual summary, and any claim we make about clustering rests on the composite distance matrix itself.

<!-- New appendix, written 2026-09-19. Figure 1 was previously undocumented: no
part of the paper said what the composite distance was, how loadings were
aggregated across solutions, what UMAP parameters were used, or where the
subject-matter colours came from. Every value here is read off
viewer/compute_positions.py in the analysis repository (cosine distance clipped
to [0,2], per-cell averaging over the benchmark union, NaN fill from the row
mean then the global mean, symmetrisation, then UMAP with n_components=2,
metric="precomputed", n_neighbors=10, min_dist=0.15, random_state=42) and off
data/text_only/benchmark_labels.csv (456 rows, axes subject / task_labels /
language, 46 distinct subject labels).

Two things deliberately left out, both worth a decision:

(1) The same script runs a label-cohesion permutation test (2,000 permutations),
which asks whether each label's members sit closer together in the composite
distance matrix than a coverage-matched random set, tested one-vs-rest so it
handles multi-label rows. That is a direct quantitative version of the Results
claim that "benchmarks with common subject only occasionally cluster together",
which the paper currently supports by eye from the figure alone. Reporting it
would materially strengthen Results, but its numbers are not in the paper, so
describing the test here would document a method whose results we do not show.

(2) The script also emits HAC (average linkage) and HDBSCAN clusterings of the
same matrix, run on the distance matrix rather than on the 2D coordinates. None
of that reaches the paper either.

I could not locate the script that renders the four-panel aggregate3.png itself.
compute_positions.py writes viewer/positions.json for the interactive viewer,
not the figure, so the panel-to-solution mapping stated in the Figure 1 caption
is taken from the caption and has not been verified against code. -->
