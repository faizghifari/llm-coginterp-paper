# Methodology

In this study we investigate the low-dimensional structure of model benchmark scores, which comprises distinct but correlated latent factors that each dominantly affects different clusters of benchmarks, and a $g$ factor that accounts for the variances of all benchmarks. Our raw $1{,}618 \times 456$ matrix is super-sparse (~1.8% density) and missing not at random (MNAR) \citep{rubin1976}, since popular models and popular benchmarks are observed far more often. We therefore apply several densification and imputation methods, each with its own biases and assumptions, and triangulate their results to find a common characteristic.


## Data Collection

**Scope.** We limit this study to the evaluation of generative language models on a set of text-only benchmarks. We define generative language models as those that accept arbitrary prompts and produce text completions. Encoder-only classifiers, narrow task-specific systems (dedicated MT/ASR/TTS models), and undocumented community uploads are excluded. Benchmarks are included if they have at least one in-scope result row. For each row, we follow the schema from EveryEvalEver \citep{everyevalever2026} to unify the evaluation results. Full inclusion and exclusion criteria are given in `\hyperref[inclusion-and-exclusion-criteria]{Appendix~\ref*{inclusion-and-exclusion-criteria}}`{=latex}.


**Sources.** `\hyperref[tab:sources]{Table~\ref*{tab:sources}}`{=latex} gives the composition of the text-only corpus by source family. `\hyperref[data-source-and-normalization]{Appendix~\ref*{data-source-and-normalization}}`{=latex} lists every named source and the extraction route used for each.

```{=latex}
\begin{center}\small\setlength{\tabcolsep}{4pt}
\begin{minipage}[t]{0.47\textwidth}
\refstepcounter{table}\label{tab:sources}\textbf{Table~\thetable.} Composition of the text-only corpus by source family.\par\vspace{4pt}
\centering
\begin{tabular}{@{}lrr@{}}
\toprule
Source family & Rows & Benchmarks \\
\midrule
Stanford HELM & 4,942 & 138 \\
HF Open LLM Leaderboard & 4,529 & 12 \\
Papers With Code & 1,378 & 151 \\
Other online leaderboards & \textcolor{red}{953} & \textcolor{red}{65} \\
Kaggle AI Benchmarks & 844 & 26 \\
Primary papers & \textcolor{red}{584} & \textcolor{red}{94} \\
\bottomrule
\end{tabular}
\end{minipage}\hfill
\begin{minipage}[t]{0.49\textwidth}\setlength{\tabcolsep}{3pt}
\refstepcounter{table}\label{tab:matrices}\textbf{Table~\thetable.} Aggregated model $\times$ benchmark matrices, text-only corpus. ``Retained'' is the fraction of observed cells surviving the densifier peel.\par\vspace{4pt}
\centering
\begin{tabular}{@{}llrrr@{}}
\toprule
Densifier & Strategy & Shape & Density & Retained \\
\midrule
raw & Std. & 1,266 $\times$ 404 & 2.2\% & \\
raw & Aggr. & 334 $\times$ 380 & 3.5\% & \\
C & Std. & \textcolor{red}{670} $\times$ 78 & 13.8\% & 65\% \\
C & Aggr. & 201 $\times$ 102 & 13.6\% & \textcolor{red}{62\%} \\
S & Std. & \textcolor{red}{667} $\times$ 124 & 10.0\% & 75\% \\
S & Aggr. & \textcolor{red}{123} $\times$ 293 & \textcolor{red}{10.1\%} & 81\% \\
R & Std. & \textcolor{red}{174} $\times$ 298 & 11.8\% & 55\% \\
R & Aggr. & 97 $\times$ 310 & 11.7\% & 78\% \\
\bottomrule
\end{tabular}
\end{minipage}
\end{center}
```



**Protocol.** Given the large number of fields from the EveryEvalEver schema, we follow a strict source-verification protocol, meaning each field is populated only if the verified source explicitly documented it. As an exception, some fields can be inferred from the record itself using deductive rules with small risk of error (see `\hyperref[inferred-fields]{Appendix~\ref*{inferred-fields}}`{=latex}). In particular, we put some focus on obtaining the release date field for both models and benchmarks, and only accept a release date if it is explicitly documented in the source (`\hyperref[release-dates]{Appendix~\ref*{release-dates}}`{=latex}). 


We also handle redundancy at two levels. Redundant duplicate rows are removed (`\hyperref[duplicate-detection-and-integrity-checks]{Appendix~\ref*{duplicate-detection-and-integrity-checks}}`{=latex}), and near-perfectly correlated benchmark identifiers (version, dialect, or language splits of one benchmark) are collapsed to one representative, which removes 47 identifiers and 2,216 rows (`\hyperref[score-redundancy-pruning]{Appendix~\ref*{score-redundancy-pruning}}`{=latex}).


## Data Processing



**Deduplication.** Rows surviving duplicate removal for the same (model, benchmark) pair are averaged into a single score. To keep near-duplicate results from the same models under different conditions (e.g. reasoning effort) from breaking the IID assumption, and to further densify the data, we average rows under two collapse strategies. The **standard** strategy is variant-level. It keeps different version numbers and parameter counts, while collapsing reasoning effort, knowledge cutoff, etc. The **aggressive** strategy is family-level. Every model is collapsed to its base family token (Claude, Llama, etc.), so all sizes and generations of a family form one row.


**Metric selection.** 92 of our collected benchmarks were reported under several metrics. As different metrics are not comparable, we keep one metric covering the most distinct models, so the widest comparable population survives. A per-benchmark override list handles cases where coverage alone chooses badly. Finally, benchmarks observed for only one model are dropped.

**Densification.** We further improve the data density by greedily peeling the matrix towards a common target density. We feature three densifiers, differing by the axis they sacrifice: **C (column-primary)** drops the least-observed benchmarks, then any model left empty, retaining famous benchmarks with wide model coverage. **R (row-primary)** drops the least-observed models, then any benchmark left empty, retaining a broad benchmark set over a small set of heavily-evaluated models, which leaves fewer models than benchmarks. **S (symmetric)** drops whichever marginal has the lowest fill-rate, privileging neither axis. After peeling, models and benchmarks that have fewer than 3 observed scores are dropped. Columns with zero variance among observed values are also dropped, since they carry no correlational signal. The algorithm is given in `\hyperref[densification-algorithm]{Appendix~\ref*{densification-algorithm}}`{=latex}. We run the peel towards a ladder of target densities from 50% down to 10%, so that the final, sparsest slice still includes as many different benchmarks as possible.


**Imputation.** We applied two families of missing data imputers: **full-dataset** algorithms (SoftImpute \citep{mazumder2010}, k-NN, and missForest \citep{stekhoven2012}) and **correlation recovery** which includes one-sided matrix completion \citep{cao2023}, USVT \citep{chatterjee2015}, and SoftImpute on the correlation matrix. For the correlation recovery we also use a simple filling method, where missing entries are either filled with zeros or the mean, followed by PSD smoothing. Method-level descriptions and implementation details for all of the above are given in `\hyperref[imputation-methods]{Appendix~\ref*{imputation-methods}}`{=latex}. Each imputer runs down a density ladder of 50\%, 40\%, \dots, 10\%: it is seeded by the densification algorithm at the densest slice (`\hyperref[densification-algorithm]{Appendix~\ref*{densification-algorithm}}`{=latex}), and each sparser slice is imputed on the union of its own observations and the previous slice's completed matrix, with observed cells taking precedence.

**Evaluating the imputations.** At each step of the chain, we mask ~20% of the observed cells as an evaluation set. The mask is column-stratified, so each benchmark is masked at least once and keeps at least two training observations. Held-out cells are drawn only from benchmarks that the step introduces (absent from all denser slices), so each benchmark is graded exactly once across the chain, and are scored by $R^2 = 1 - \text{MSE}/\text{MSE}_{\text{baseline}}$, where the baseline predicts each column's training mean (`\hyperref[imputation-evaluation]{Appendix~\ref*{imputation-evaluation}}`{=latex}). $R^2$ selects the hyperparameters within each method (rank, $k$, number of trees, etc.). We report the weighted $R^2$ ($\mathrm{wr2}$): the introduced-benchmark-weighted mean of the per-step held-out $R^2$, i.e. the exact benchmark-balanced mean held-out $R^2$ of the final matrix; imputations whose $\mathrm{wr2}$ falls below 0.4 are not factored.


## Factor analysis

To perform our dimension reduction, we use exploratory factor analysis (EFA) with the minimum residual estimator and the oblique promax rotation[^2], followed by the Schmid-Leiman bifactor transformation \citep{schmidleiman1957}. This runs factor analysis hierarchically, yielding one additional factor that influences the rest of the extracted factors, and is widely used in psychometric research on the $g$ factor of intelligence \citep{johnson2004,johnson2008}. The hierarchical step makes it a more principled choice than interpreting the highest-eigenvalue solution (e.g., \citealp{krakauer2026}) as the $g$ factor.


\textcolor{red}{From the bifactor solution we report two statistics for the $g$ factor. The first, $\omega_h$, is the share of variance in the summed score over all benchmarks that is due to $g$. The second, the explained common variance (ECV), is the share of the common variance, excluding error, that is due to $g$ \citep{reise2010}.}


**Definition 3**. Let $T$ be a matrix of test scores that can be decomposed into independent additive components due to a **general factor** (g), **specific factors** (s)[^3], and **error** ($\epsilon$). Then $\omega_h$ is the estimand
$$\omega_h = \frac{\sigma^2_{\mathrm{g}}}{\sigma_T^2}, \qquad \sigma_T^2 = \sigma^2_{\mathrm{g}} + \sigma^2_{\mathrm{s}} + \sigma^2_{\epsilon}.$$

\textcolor{red}{In practice, with $\lambda_{g,j}$ the loading of benchmark $j$ on $g$, $h_j^2$ its communality and $R$ the benchmark correlation matrix, we compute}
$$\color{red}\omega_h = \frac{(\sum_j \lambda_{g,j})^2}{\mathbf{1}^\top R\,\mathbf{1}}, \qquad \mathrm{ECV} = \frac{\sum_j \lambda_{g,j}^2}{\sum_j h_j^2}$$
\textcolor{red}{with \texttt{psych::omega} \citep{revelle2009,revelle2024}. $\omega_h$ describes the summed score, not any single benchmark: the share of one benchmark's variance due to $g$ is $\lambda_{g,j}^2$, which can be much lower.}

[^2]: Rotation gives an interpretable "simple structure". Oblique rotations allow the factors to correlate, while default eigendecomposition yields orthogonal solutions.
[^3]: Usually called "group factors". We avoid the term to prevent confusion with observation grouping.

One additional step we do is parallel analysis \citep{horn1965} to select the number of factor analysis dimensions. To keep wall-clock time tractable we cap the number of factors extracted at 20. 



## Label Cohesion Analysis

We measure benchmark similarity as cosine distance between benchmarks' factor-analytic loading vectors, described further in `\hyperref[benchmark-embedding]{Appendix~\ref*{benchmark-embedding}}`{=latex}. Given this benchmark–benchmark distance matrix, we ask whether each label's members sit closer together than chance. For a label, let **within** be their mean pairwise distance. We compare this to the **null_mean**: benchmarks are binned into quartiles of $\log_{10}(\text{model coverage})$, and the null redraws, 2,000 times, a random same-size set matched to the label's members' coverage-quartile composition, recomputing the same mean-pairwise-distance statistic each draw. Coverage stratification matters because coverage is itself correlated with tightness in this factor space. Labels with fewer than four members, or comprising the entire benchmark set, are not scored. The reported effect size is:

$$A = 1 − \frac{\text{within}}{\text{null\_mean}}$$

0 means the label's members are no tighter than a random draw, 1 means effectively identical members, and negative values mean the members are more spread out than chance. 


**Significance.** The p-value is computed empirically from the same 2,000 permutation draws:

$$p = (1 + \#\{\text{null draws at least as tight as observed}\}) / (1 + 2000)$$

Within each cell, we control the false discovery rate across the labels of one axis via Benjamini–Hochberg at q = 0.05. A label's reported significant count (e.g. "6/9") is the number of cells in which it passed this FDR-corrected threshold, out of the cells where it could be scored.
