# Imputation simulation

Held-out evaluation measures recovery of the masked cells, but the analysis ultimately reports factor-analytic quantities. To validate the full pipeline—imputation, exploratory factor analysis, and the Schmid–Leiman bifactor transformation—we simulate corpora from a data-generating process calibrated to be a plausible model of the real data: a known correlation matrix and a known factor structure. The planted structure is not a recovery target and the pipeline is not expected to reproduce it; it fixes the simulation's composition so that pipeline behavior can be compared against full-data and generating-structure references.

## Synthetic data generation

Two real dataset tables, C (671 $\times$ 78) and S (669 $\times$ 124), supply the observation margins: expected per-row and per-column observation counts are calibrated to the real tables' counts, so the synthetic data reproduce the sparsity profile of the corpus under study.

For each table we simulate from a hybrid model: a dense cross-loading background plus suite clusters. Benchmark $j$'s score for model $i$ is

$$z_{ij} = \sum_{f=1}^{F} \lambda_{jf}\,\eta_{i,f} \;+\; \lambda^{s}_{j}\,\zeta_{i,\mathrm{suite}(j)} \;+\; \sqrt{\psi_j}\,\epsilon_{ij}, \qquad R = L L^\top + S S^\top,$$

with $F \in \{5, 10\}$ dense background factors whose loadings are drawn $U(0.1, 0.5)$ ("weak") or $U(0.5, 0.9)$ ("loud") and scaled down by factor rank; and $N_{\text{suites}}$ suite factors, each benchmark loading its own suite strongly, with a deterministic per-suite decay so the planted factors' eigenvalues decrease strictly by construction. All loadings are positive, so $R$ has only positive entries, matching the real tables. The planted suite membership is the benchmark's dominant factor.

The factor count the model fixes is $1 + N_{\text{suites}}$: one emergent dominant direction plus the suite factors. The dense background's $F$ factors sit below the suite eigenvalues by construction — they add weak dimensions that make imputation hard, not dimensions parallel analysis is meant to count. The weak/loud labels set the background loading range: weak ($U(0.1, 0.5)$) spreads each benchmark's variance thinly across many factors, loud ($U(0.5, 0.9)$) concentrates it in few. Crossing the two profiles with $F \in \{5, 10\}$ spans the plausible range of dimensionality and cross-loading strength; rankings are reported per truth cell so no method's inductive bias is favored.

The truth contains no general-factor block and no $\omega_h$ target: the dominant common direction is emergent, and the only calibrated global quantity is the mean off-diagonal correlation, planted at $0.3$ or $0.5$ and realized exactly by two block scales. This is deliberate — the PA/SL estimator tracks the overall correlation level and cannot identify a planted $\omega$ split, so a planted general factor would carry no scoring information. Truth cells are named accordingly: `f5_weak`, `f5_loud`, `f10_weak`, `f10_loud`, crossed with the mean-$r$ target (`r30`, `r50`), giving 8 planted truths per table.

The planted model is a single fixed matrix per table, defined on the union of every density slice's source grid. This is what makes the hierarchical descent scoreable: the descent chains a denser slice's completions into sparser ones, so the complete matrix those completions are scored against must be one fixed matrix at every density.

Observation probability follows

$$\mathrm{logit}\, P(\mathrm{obs}_{ij}) = a_i + b_j + s_{ij},$$

where $(a_i, b_j)$ are fit by damped iterated bisection so expected row and column observation counts match the real table's margins. The $s_{ij}$ term is the missingness mechanism:

| Mechanism | $s_{ij}$ | Interpretation |
|---|---|---|
| mcar | $0$ | calibrated missing-completely-at-random control |
| cell | $\gamma \cdot z_{ij}$ | good cells are more likely observed |
| popularity | $\kappa \cdot \hat\rho_j \, g_i$ | observability tied to a benchmark's expected correlation, interacting with model ability |

When a mechanism is too strong for the real margins to be jointly feasible, it is halved until calibration converges; the surviving scale is recorded. A single mask seed is used, and the uniform behind the Bernoulli draw is identical across truth cells and masks for a fixed table, so every cross-condition comparison is paired by construction. In total the grid is 8 truths $\times$ 3 mechanisms $\times$ 2 tables = 48 masked datasets.

As with the real corpus, the masks are nested across density slices by construction: each sparser slice carries the denser slice's observed cells and reveals additional ones in prioritized order until its own margins are met. A verification script walks every (mechanism, truth) chain densest-to-sparsest and asserts grid nesting, cell nesting, and that each planted correlation is symmetric, unit-diagonal, positive semi-definite, strictly spectrum-decreasing over the planted factors, and hits its mean-$r$ target.

## Protocol

Each generated dataset directory is a drop-in data root containing only the C and S `all_standard` cells, and the hierarchical imputation descent of `\hyperref[imputation-evaluation]{Appendix~\ref*{imputation-evaluation}}`{=latex} runs over its density slices exactly as on the real corpus: seeded at the densest slice, descending to the sparsest, each step training on the union grid with observed cells taking precedence and holdouts restricted to the columns the step introduces.

Two levels of scoring follow:

- **Cell level.** Each step's completions are scored against the simulation's complete matrix on the introduced columns' missing cells, column-balanced; the step's planted-truth $R^2$ replaces the held-out $R^2$, and the weighted $R^2$ is the introduced-column-weighted mean of those values — based on the simulated complete matrix rather than held-out cells.
- **Factor level.** The exact factor-analysis recipe (parallel analysis factor count, minimum-residual/promax EFA, Schmid–Leiman transformation) runs on each completed matrix. A **fullset** arm runs the identical recipe on the complete, unmasked simulated matrix, which separates estimator bias from missingness damage. No quality gate is applied at factoring time; the gate is applied at scoring so that its effect can be reported.

## Metrics

Let $\omega_{h}^{\text{full}}$ be the fullset arm's general-factor coefficient for a given (densifier, truth cell) and $\omega_{h}^{\text{est}}$ the estimate from a completed matrix. Since no $\omega$ target is planted, the fullset arm is the attainable reference, and the reported bias is $\Delta\omega_h = |\omega_{h}^{\text{est}} - \omega_{h}^{\text{full}}|$. Runs enter the comparison only if their final weighted $R^2$ is at least $0.4$.

## Results

`\hyperref[tab:synth-factors]{Table~\ref*{tab:synth-factors}}`{=latex} lists the runs that pass the weighted $R^2 \geq 0.4$ gate on the hierarchical end result, sorted by weighted $R^2$.

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
missForest & C\_all\_standard & popularity & f5\_weak\_r50   & 0.7397 & 0.8057 & 0.0660 & 0.4961 \\*
missForest & S\_all\_standard & popularity & f10\_weak\_r50  & 0.7068 & 0.8484 & 0.1416 & 0.4563 \\*
missForest & C\_all\_standard & popularity & f10\_weak\_r50  & 0.7302 & 0.8562 & 0.1260 & 0.4499 \\*
SoftImpute & C\_all\_standard & mcar       & f5\_weak\_r50   & 0.7397 & 0.7017 & 0.0380 & 0.4491 \\*
missForest & S\_all\_standard & popularity & f5\_loud\_r50   & 0.7750 & 0.8622 & 0.0871 & 0.4477 \\*
missForest & S\_all\_standard & mcar       & f10\_weak\_r50  & 0.7068 & 0.8862 & 0.1794 & 0.4244 \\*
missForest & S\_all\_standard & popularity & f5\_weak\_r50   & 0.6925 & 0.8036 & 0.1110 & 0.4145 \\*
missForest & C\_all\_standard & popularity & f10\_loud\_r50  & 0.7748 & 0.8385 & 0.0637 & 0.4109 \\*
missForest & C\_all\_standard & popularity & f5\_loud\_r50   & 0.7415 & 0.8353 & 0.0938 & 0.4091 \\*
SoftImpute & C\_all\_standard & cell       & f5\_weak\_r50   & 0.7397 & 0.7178 & 0.0219 & 0.4021 \\*
missForest & C\_all\_standard & mcar       & f5\_weak\_r50   & 0.7397 & 0.8359 & 0.0962 & 0.4006 \\
\end{longtable}
```

All surviving runs are generated with mean-$r$ $0.5$; no run generated with mean-$r$ $0.3$ passes the gate. missForest accounts for nine of the eleven surviving runs, spanning both tables and all three mechanisms; SoftImpute accounts for the remaining two, both on the C table. Estimated $\omega_h$ exceeds the fullset arm's estimate in every surviving run ($\Delta\omega_h$ between $0.022$ and $0.179$): under missingness the pipeline mildly overestimates the general-factor share relative to the full-data reference. The largest bias occurs for missForest on the `f10_weak` cells ($0.142$ and $0.179$ under the popularity and mcar mechanisms respectively), while SoftImpute shows the smallest ($0.022$--$0.038$).
