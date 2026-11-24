# Imputation simulation

Held-out evaluation measures how well the masked cells are recovered, but the analysis reports factor-analytic quantities. To check the full pipeline (imputation, exploratory factor analysis and the Schmid–Leiman transformation), we simulate data with a known correlation matrix and factor structure, calibrated to resemble the real data. We do not expect the pipeline to recover the planted structure. Instead, we compare its output with the complete simulated data and with the generating structure.

## Synthetic data generation

Two real dataset tables, C (670 $\times$ 78) and S (667 $\times$ 124), supply the observation margins: expected per-row and per-column observation counts are calibrated to the real tables' counts, so the synthetic data reproduce the sparsity profile of the corpus under study.

For each table we simulate from a hybrid model: a dense cross-loading background plus suite clusters. Benchmark $j$'s score for model $i$ is

$$z_{ij} = \sum_{f=1}^{F} \lambda_{jf}\,\eta_{i,f} \;+\; \lambda^{s}_{j}\,\zeta_{i,\mathrm{suite}(j)} \;+\; \sqrt{\psi_j}\,\epsilon_{ij}, \qquad R = L L^\top + S S^\top,$$

with $F \in \{5, 10\}$ dense background factors whose loadings are drawn $U(0.1, 0.5)$ ("weak") or $U(0.5, 0.9)$ ("loud") and scaled down by factor rank; and $N_{\text{suites}}$ suite factors, each benchmark loading its own suite strongly, with a fixed decay per suite, so that the eigenvalues of the planted factors strictly decrease. All loadings are positive, so $R$ has only positive entries, matching the real tables. The planted suite membership is the benchmark's dominant factor.

The model has $1 + N_{\text{suites}}$ factors: one emergent dominant direction plus the suite factors. The $F$ background factors have smaller eigenvalues than the suite factors. They make imputation harder, but parallel analysis is not meant to count them. The weak profile ($U(0.1, 0.5)$) spreads each benchmark's variance thinly across many factors, and the loud profile ($U(0.5, 0.9)$) concentrates it in a few. Crossing the two profiles with $F \in \{5, 10\}$ covers a plausible range of dimensionality and cross-loading strength, and we report results per truth cell so that no single structure favors one method.

The truth contains no general-factor block and no $\omega_h$ target: the dominant common direction is emergent, and the only calibrated global quantity is the mean off-diagonal correlation, planted at $0.3$ or $0.5$ and realized exactly by two block scales. Truth cells are named accordingly: `f5_weak`, `f5_loud`, `f10_weak`, `f10_loud`, crossed with the mean-$r$ target (`r30`, `r50`), giving 8 planted truths per table.

The planted model is one fixed matrix per table, defined over the union of all density slices. Since the sequential imputation passes each denser slice's completions on to the sparser ones, the completions at every density have to be scored against the same complete matrix.

Observation probability follows

$$\mathrm{logit}\, P(\mathrm{obs}_{ij}) = a_i + b_j + s_{ij},$$

where $(a_i, b_j)$ are fit by damped iterated bisection so expected row and column observation counts match the real table's margins. The $s_{ij}$ term is the missingness mechanism:

| Mechanism | $s_{ij}$ | Interpretation |
|---|---|---|
| mcar | $0$ | calibrated missing-completely-at-random control |
| cell | $\gamma \cdot z_{ij}$ | good cells are more likely observed |
| popularity | $\kappa \cdot \hat\rho_j \, g_i$ | observability tied to a benchmark's expected correlation, interacting with model ability |

When a mechanism is too strong for the real margins to be met, we halve its strength until calibration converges and record the final scale. We use a single mask seed, and for a given table the random draws behind the masks are the same across truth cells and mechanisms, so all comparisons between conditions are paired. In total the grid is 8 truths $\times$ 3 mechanisms $\times$ 2 tables = 48 masked datasets.

As in the real corpus, the masks are nested across density slices: each sparser slice keeps the observed cells of the denser slice and reveals more cells, in priority order, until its own margins are met. For every mechanism and truth, we check that the slices are nested (in both their rows and columns and their observed cells) and that each planted correlation matrix is symmetric, has a unit diagonal, is positive semi-definite, has strictly decreasing eigenvalues over the planted factors, and hits its mean-$r$ target.

## Protocol

Each generated dataset directory is a drop-in data root containing only the C and S `all_standard` cells, and the hierarchical imputation descent of `\hyperref[imputation-evaluation]{Appendix~\ref*{imputation-evaluation}}`{=latex} runs over its density slices exactly as on the real corpus: seeded at the densest slice, descending to the sparsest, each step training on the union grid with observed cells taking precedence and holdouts restricted to the columns the step introduces.

Two levels of scoring follow:

- **Cell level.** Each step's completions are scored against the simulation's complete matrix on the introduced columns' missing cells, column-balanced; the step's planted-truth $R^2$ replaces the held-out $R^2$, and the weighted $R^2$ is the introduced-column-weighted mean of those values — based on the simulated complete matrix rather than held-out cells.
- **Factor level.** The exact factor-analysis recipe (parallel analysis factor count, minimum-residual/promax EFA, Schmid–Leiman transformation) runs on each completed matrix. A **fullset** arm runs the identical recipe on the complete, unmasked simulated matrix, which separates estimator bias from missingness damage. No quality filter is applied at factoring time; the filter is applied at scoring so that its effect can be reported.

## Metrics

Let $\omega_{h}^{\text{full}}$ be the fullset arm's general-factor coefficient for a given (densifier, truth cell) and $\omega_{h}^{\text{est}}$ the estimate from a completed matrix. Since no $\omega$ target is planted, the fullset arm is the attainable reference, and the reported bias is $\Delta\omega_h = |\omega_{h}^{\text{est}} - \omega_{h}^{\text{full}}|$. Runs enter the comparison only if their final weighted $R^2$ is at least $0.4$.

## Results

\hyperref[tab:synth-factors]{Table~\ref*{tab:synth-factors}} lists the runs that pass the weighted $R^2 \geq 0.4$ quality filter on the hierarchical end result, sorted by weighted $R^2$.

```{=latex}
\begin{longtable}{@{}>{\raggedright\arraybackslash}p{0.13\textwidth}>{\raggedright\arraybackslash}p{0.15\textwidth}>{\raggedright\arraybackslash}p{0.11\textwidth}>{\raggedright\arraybackslash}p{0.15\textwidth}rrrr@{}}
\caption{Factor-level scoring on the synthetic corpus, hierarchical end result: runs with weighted $R^2 \geq 0.4$. $\Delta\omega_h$ is bias against the fullset arm.}\label{tab:synth-factors}\\
\toprule
Method & ds & Mask & Truth cell & $\omega_h^{\text{full}}$ & $\omega_h^{\text{est}}$ & $\Delta\omega_h$ & Weighted $R^2$ \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Method & ds & Mask & Truth cell & $\omega_h^{\text{full}}$ & $\omega_h^{\text{est}}$ & $\Delta\omega_h$ & Weighted $R^2$ \\
\midrule
\endhead
\bottomrule
\endlastfoot
missForest & C\_all\_standard & popularity & f5\_weak\_r50 & 0.7397 & 0.8057 & 0.0660 & 0.4961 \\*
missForest & S\_all\_standard & popularity & f10\_weak\_r50 & 0.7068 & 0.8484 & 0.1416 & 0.4563 \\*
missForest & C\_all\_standard & popularity & f10\_weak\_r50 & 0.7302 & 0.8562 & 0.1260 & 0.4499 \\*
SoftImpute & C\_all\_standard & mcar & f5\_weak\_r50 & 0.7397 & 0.7017 & $-$0.0380 & 0.4491 \\*
missForest & S\_all\_standard & popularity & f5\_loud\_r50 & 0.7750 & 0.8622 & 0.0871 & 0.4477 \\*
missForest & S\_all\_standard & mcar & f10\_weak\_r50 & 0.7068 & 0.8862 & 0.1794 & 0.4244 \\*
missForest & S\_all\_standard & popularity & f5\_weak\_r50 & 0.6925 & 0.8036 & 0.1110 & 0.4145 \\*
missForest & C\_all\_standard & popularity & f10\_loud\_r50 & 0.7748 & 0.8385 & 0.0637 & 0.4109 \\*
missForest & C\_all\_standard & popularity & f5\_loud\_r50 & 0.7415 & 0.8353 & 0.0938 & 0.4091 \\*
SoftImpute & C\_all\_standard & cell & f5\_weak\_r50 & 0.7397 & 0.7178 & $-$0.0219 & 0.4021 \\*
missForest & C\_all\_standard & mcar & f5\_weak\_r50 & 0.7397 & 0.8359 & 0.0962 & 0.4006 \\
\end{longtable}
```

All surviving runs are generated with mean-$r$ $0.5$; no run generated with mean-$r$ $0.3$ passes the quality filter. missForest accounts for nine of the eleven surviving runs, spanning both tables and two of the three mechanisms (no missForest run passes under the cell mechanism); SoftImpute accounts for the remaining two, both on the C table. Estimated $\omega_h$ exceeds the fullset arm's estimate in all nine missForest runs ($\Delta\omega_h$ between $0.064$ and $0.179$) and falls slightly below it in both SoftImpute runs ($-0.022$ and $-0.038$): under missingness, missForest overestimates the general-factor share relative to the full-data reference, while SoftImpute slightly underestimates it. The largest bias occurs for missForest on the `f10_weak` cells ($0.142$ and $0.179$ under the popularity and mcar mechanisms respectively), while SoftImpute shows the smallest ($0.022$--$0.038$).

## All runs {#synth-all-runs-section}

The table above shows only the runs that pass the quality filter. To show what the filter selects, \hyperref[tab:synth-summary]{Table~\ref*{tab:synth-summary}} summarises all 96 runs (2 methods $\times$ 2 tables $\times$ 8 truth cells $\times$ 3 mechanisms), and \hyperref[tab:synth-all-runs]{Table~\ref*{tab:synth-all-runs}} lists each run. One mask seed is used per condition, so the spread reported here is across conditions, not across repetitions.

```{=latex}
\begin{longtable}{@{}llrrr@{}}
\caption{All 96 simulation runs summarised by method and missingness mechanism, split by whether the run passes the weighted $R^2 \geq 0.4$ quality filter. $|\Delta\omega_h|$ = mean absolute difference from the fullset $\omega_h$. Each cell is 16 runs (8 truth cells $\times$ 2 tables), one seed each.}\label{tab:synth-summary}\\
\toprule
Method & Mask & Pass & $|\Delta\omega_h|$ pass & $|\Delta\omega_h|$ fail \\
\midrule
\endhead
\bottomrule
\endlastfoot
missForest & cell & 0/16 & -- & 0.19 \\
missForest & mcar & 2/16 & 0.14 & 0.13 \\
missForest & popularity & 7/16 & 0.10 & 0.11 \\
SoftImpute & cell & 1/16 & 0.02 & 0.05 \\
SoftImpute & mcar & 1/16 & 0.04 & 0.11 \\
SoftImpute & popularity & 0/16 & -- & 0.23 \\
\end{longtable}
```

The quality filter does not reduce the missForest $\omega_h$ bias within a mechanism: missForest overestimates $\omega_h$ in every passing run. SoftImpute passing runs have a small $\omega_h$ error, but SoftImpute never passes on the S table or under the popularity mechanism, so the simulation does not directly validate the SoftImpute solution on the real S table. For these reasons we do not interpret any single real-data $\omega_h$ value as the strength of the general factor.

```{=latex}
{\footnotesize\setlength{\tabcolsep}{3.5pt}
\begin{longtable}{@{}llllrrrrc@{}}
\caption{Every simulation run. $\Delta\omega_h$ is signed (estimate minus fullset). Pass = weighted $R^2 \geq 0.4$.}\label{tab:synth-all-runs}\\
\toprule
Method & Table & Mask & Truth cell & $\omega_h^{\text{full}}$ & $\omega_h^{\text{est}}$ & $\Delta\omega_h$ & $wR^2$ & Pass \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Method & Table & Mask & Truth cell & $\omega_h^{\text{full}}$ & $\omega_h^{\text{est}}$ & $\Delta\omega_h$ & $wR^2$ & Pass \\
\midrule
\endhead
\bottomrule
\endlastfoot
missForest & C & cell & f10\_loud\_r30 & 0.615 & 0.828 & +0.214 & 0.087 & \\
missForest & C & cell & f10\_loud\_r50 & 0.775 & 0.942 & +0.168 & 0.329 & \\
missForest & C & cell & f10\_weak\_r30 & 0.644 & 0.808 & +0.164 & 0.240 & \\
missForest & C & cell & f10\_weak\_r50 & 0.730 & 0.888 & +0.158 & 0.305 & \\
missForest & C & cell & f5\_loud\_r30 & 0.617 & 0.789 & +0.173 & 0.158 & \\
missForest & C & cell & f5\_loud\_r50 & 0.741 & 0.893 & +0.152 & 0.358 & \\
missForest & C & cell & f5\_weak\_r30 & 0.603 & 0.774 & +0.171 & 0.161 & \\
missForest & C & cell & f5\_weak\_r50 & 0.740 & 0.856 & +0.116 & 0.367 & \\
missForest & C & mcar & f10\_loud\_r30 & 0.615 & 0.796 & +0.181 & 0.105 & \\
missForest & C & mcar & f10\_loud\_r50 & 0.775 & 0.908 & +0.133 & 0.349 & \\
missForest & C & mcar & f10\_weak\_r30 & 0.644 & 0.731 & +0.087 & 0.191 & \\
missForest & C & mcar & f10\_weak\_r50 & 0.730 & 0.910 & +0.180 & 0.362 & \\
missForest & C & mcar & f5\_loud\_r30 & 0.617 & 0.637 & +0.021 & 0.161 & \\
missForest & C & mcar & f5\_loud\_r50 & 0.741 & 0.890 & +0.149 & 0.335 & \\
missForest & C & mcar & f5\_weak\_r30 & 0.603 & 0.700 & +0.097 & 0.171 & \\
missForest & C & mcar & f5\_weak\_r50 & 0.740 & 0.836 & +0.096 & 0.401 & yes \\
missForest & C & popularity & f10\_loud\_r30 & 0.615 & 0.774 & +0.159 & 0.220 & \\
missForest & C & popularity & f10\_loud\_r50 & 0.775 & 0.839 & +0.064 & 0.411 & yes \\
missForest & C & popularity & f10\_weak\_r30 & 0.644 & 0.723 & +0.080 & 0.248 & \\
missForest & C & popularity & f10\_weak\_r50 & 0.730 & 0.856 & +0.126 & 0.450 & yes \\
missForest & C & popularity & f5\_loud\_r30 & 0.617 & 0.443 & -0.174 & 0.187 & \\
missForest & C & popularity & f5\_loud\_r50 & 0.741 & 0.835 & +0.094 & 0.409 & yes \\
missForest & C & popularity & f5\_weak\_r30 & 0.603 & 0.561 & -0.042 & 0.221 & \\
missForest & C & popularity & f5\_weak\_r50 & 0.740 & 0.806 & +0.066 & 0.496 & yes \\
missForest & S & cell & f10\_loud\_r30 & 0.593 & 0.816 & +0.223 & 0.099 & \\
missForest & S & cell & f10\_loud\_r50 & 0.746 & 0.946 & +0.199 & 0.271 & \\
missForest & S & cell & f10\_weak\_r30 & 0.582 & 0.934 & +0.351 & 0.118 & \\
missForest & S & cell & f10\_weak\_r50 & 0.707 & 0.891 & +0.184 & 0.399 & \\
missForest & S & cell & f5\_loud\_r30 & 0.606 & 0.824 & +0.218 & 0.065 & \\
missForest & S & cell & f5\_loud\_r50 & 0.775 & 0.930 & +0.155 & 0.335 & \\
missForest & S & cell & f5\_weak\_r30 & 0.637 & 0.842 & +0.205 & 0.126 & \\
missForest & S & cell & f5\_weak\_r50 & 0.693 & 0.871 & +0.178 & 0.325 & \\
missForest & S & mcar & f10\_loud\_r30 & 0.593 & 0.769 & +0.176 & 0.133 & \\
missForest & S & mcar & f10\_loud\_r50 & 0.746 & 0.863 & +0.117 & 0.345 & \\
missForest & S & mcar & f10\_weak\_r30 & 0.582 & 0.780 & +0.198 & 0.168 & \\
missForest & S & mcar & f10\_weak\_r50 & 0.707 & 0.886 & +0.179 & 0.424 & yes \\
missForest & S & mcar & f5\_loud\_r30 & 0.606 & 0.701 & +0.095 & 0.147 & \\
missForest & S & mcar & f5\_loud\_r50 & 0.775 & 0.905 & +0.130 & 0.361 & \\
missForest & S & mcar & f5\_weak\_r30 & 0.637 & 0.760 & +0.123 & 0.158 & \\
missForest & S & mcar & f5\_weak\_r50 & 0.693 & 0.846 & +0.154 & 0.374 & \\
missForest & S & popularity & f10\_loud\_r30 & 0.593 & 0.751 & +0.157 & 0.175 & \\
missForest & S & popularity & f10\_loud\_r50 & 0.746 & 0.864 & +0.118 & 0.389 & \\
missForest & S & popularity & f10\_weak\_r30 & 0.582 & 0.735 & +0.152 & 0.229 & \\
missForest & S & popularity & f10\_weak\_r50 & 0.707 & 0.848 & +0.142 & 0.456 & yes \\
missForest & S & popularity & f5\_loud\_r30 & 0.606 & 0.618 & +0.012 & 0.220 & \\
missForest & S & popularity & f5\_loud\_r50 & 0.775 & 0.862 & +0.087 & 0.448 & yes \\
missForest & S & popularity & f5\_weak\_r30 & 0.637 & 0.725 & +0.087 & 0.230 & \\
missForest & S & popularity & f5\_weak\_r50 & 0.693 & 0.804 & +0.111 & 0.415 & yes \\
SoftImpute & C & cell & f10\_loud\_r30 & 0.615 & 0.628 & +0.013 & 0.179 & \\
SoftImpute & C & cell & f10\_loud\_r50 & 0.775 & 0.685 & -0.090 & 0.315 & \\
SoftImpute & C & cell & f10\_weak\_r30 & 0.644 & 0.635 & -0.009 & 0.220 & \\
SoftImpute & C & cell & f10\_weak\_r50 & 0.730 & 0.685 & -0.045 & 0.277 & \\
SoftImpute & C & cell & f5\_loud\_r30 & 0.617 & 0.543 & -0.074 & 0.208 & \\
SoftImpute & C & cell & f5\_loud\_r50 & 0.741 & 0.703 & -0.039 & 0.322 & \\
SoftImpute & C & cell & f5\_weak\_r30 & 0.603 & 0.631 & +0.028 & 0.192 & \\
SoftImpute & C & cell & f5\_weak\_r50 & 0.740 & 0.718 & -0.022 & 0.402 & yes \\
SoftImpute & C & mcar & f10\_loud\_r30 & 0.615 & 0.549 & -0.066 & 0.160 & \\
SoftImpute & C & mcar & f10\_loud\_r50 & 0.775 & 0.635 & -0.140 & 0.371 & \\
SoftImpute & C & mcar & f10\_weak\_r30 & 0.644 & 0.546 & -0.097 & 0.284 & \\
SoftImpute & C & mcar & f10\_weak\_r50 & 0.730 & 0.631 & -0.099 & 0.297 & \\
SoftImpute & C & mcar & f5\_loud\_r30 & 0.617 & 0.348 & -0.269 & 0.183 & \\
SoftImpute & C & mcar & f5\_loud\_r50 & 0.741 & 0.628 & -0.113 & 0.249 & \\
SoftImpute & C & mcar & f5\_weak\_r30 & 0.603 & 0.473 & -0.130 & 0.276 & \\
SoftImpute & C & mcar & f5\_weak\_r50 & 0.740 & 0.702 & -0.038 & 0.449 & yes \\
SoftImpute & C & popularity & f10\_loud\_r30 & 0.615 & 0.382 & -0.233 & 0.139 & \\
SoftImpute & C & popularity & f10\_loud\_r50 & 0.775 & 0.567 & -0.208 & 0.270 & \\
SoftImpute & C & popularity & f10\_weak\_r30 & 0.644 & 0.445 & -0.199 & 0.130 & \\
SoftImpute & C & popularity & f10\_weak\_r50 & 0.730 & 0.615 & -0.115 & 0.290 & \\
SoftImpute & C & popularity & f5\_loud\_r30 & 0.617 & 0.164 & -0.453 & 0.161 & \\
SoftImpute & C & popularity & f5\_loud\_r50 & 0.741 & 0.531 & -0.210 & 0.359 & \\
SoftImpute & C & popularity & f5\_weak\_r30 & 0.603 & 0.238 & -0.365 & 0.200 & \\
SoftImpute & C & popularity & f5\_weak\_r50 & 0.740 & 0.625 & -0.115 & 0.318 & \\
SoftImpute & S & cell & f10\_loud\_r30 & 0.593 & 0.544 & -0.049 & 0.160 & \\
SoftImpute & S & cell & f10\_loud\_r50 & 0.746 & 0.698 & -0.049 & 0.277 & \\
SoftImpute & S & cell & f10\_weak\_r30 & 0.582 & 0.665 & +0.083 & 0.193 & \\
SoftImpute & S & cell & f10\_weak\_r50 & 0.707 & 0.720 & +0.013 & 0.264 & \\
SoftImpute & S & cell & f5\_loud\_r30 & 0.606 & 0.557 & -0.049 & 0.170 & \\
SoftImpute & S & cell & f5\_loud\_r50 & 0.775 & 0.657 & -0.118 & 0.253 & \\
SoftImpute & S & cell & f5\_weak\_r30 & 0.637 & 0.555 & -0.082 & 0.167 & \\
SoftImpute & S & cell & f5\_weak\_r50 & 0.693 & 0.737 & +0.044 & 0.255 & \\
SoftImpute & S & mcar & f10\_loud\_r30 & 0.593 & 0.494 & -0.100 & 0.213 & \\
SoftImpute & S & mcar & f10\_loud\_r50 & 0.746 & 0.651 & -0.095 & 0.302 & \\
SoftImpute & S & mcar & f10\_weak\_r30 & 0.582 & 0.535 & -0.047 & 0.250 & \\
SoftImpute & S & mcar & f10\_weak\_r50 & 0.707 & 0.629 & -0.078 & 0.309 & \\
SoftImpute & S & mcar & f5\_loud\_r30 & 0.606 & 0.463 & -0.143 & 0.249 & \\
SoftImpute & S & mcar & f5\_loud\_r50 & 0.775 & 0.666 & -0.109 & 0.358 & \\
SoftImpute & S & mcar & f5\_weak\_r30 & 0.637 & 0.489 & -0.148 & 0.259 & \\
SoftImpute & S & mcar & f5\_weak\_r50 & 0.693 & 0.670 & -0.022 & 0.382 & \\
SoftImpute & S & popularity & f10\_loud\_r30 & 0.593 & 0.175 & -0.418 & 0.166 & \\
SoftImpute & S & popularity & f10\_loud\_r50 & 0.746 & 0.485 & -0.262 & 0.252 & \\
SoftImpute & S & popularity & f10\_weak\_r30 & 0.582 & 0.349 & -0.233 & 0.194 & \\
SoftImpute & S & popularity & f10\_weak\_r50 & 0.707 & 0.627 & -0.080 & 0.280 & \\
SoftImpute & S & popularity & f5\_loud\_r30 & 0.606 & 0.526 & -0.080 & 0.196 & \\
SoftImpute & S & popularity & f5\_loud\_r50 & 0.775 & 0.472 & -0.303 & 0.245 & \\
SoftImpute & S & popularity & f5\_weak\_r30 & 0.637 & 0.368 & -0.269 & 0.187 & \\
SoftImpute & S & popularity & f5\_weak\_r50 & 0.693 & 0.573 & -0.119 & 0.226 & \\
\end{longtable}}
```
