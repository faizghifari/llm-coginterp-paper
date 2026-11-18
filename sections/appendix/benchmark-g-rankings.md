# Benchmark $G$-rankings

## Frequency and $G$-ranking correlations

A pressing concern with regard to our findings on the top $g$ benchmarks in `\hyperref[tab:g-rankings]{Table~\ref*{tab:g-rankings}}`{=latex} of the main content is to what degree a benchmark's $g$ factor loading is correlated with its non-missing frequency. This is important to know, as our datasets can possess higher or lower correlations introduced as artifacts by our imputation methods.

Naively, as shown in `\hyperref[tab:g-rank-freq-corr]{Table~\ref*{tab:g-rank-freq-corr}}`{=latex} below, benchmark frequency *is* correlated with $g$ loadings. Unsigned averages suggest this correlation is modest ($r = 0.2740$), but the correlations are quite dispersed, and some dataset-imputation combinations can be as high as ~0.5. Thus, identifying benchmarks which proxy a supposed latent $g$ factor well requires adjusting the statistics with respect to their frequency.

```{=latex}
\begin{longtable}{@{}llrrr@{}}
\caption{Correlations between benchmark frequency and their $g$ loadings. $k$ = number of factors extracted. Only accepted imputations with $wR^2 > 0.4$ are shown.}\label{tab:g-rank-freq-corr}\\
\toprule
Method & Dataset & $k$ & $r$ & $N$ \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Method & Dataset & $k$ & $r$ & $N$ \\
\midrule
\endhead
\bottomrule
\endlastfoot
\multicolumn{5}{@{}l}{\textcolor{red}{[$k = 2$ rows removed]}} \\
k-NN & C Std. & 8 & +0.3447 & 78 \\
missForest & C Std. & 4 & +0.3200 & 78 \\
missForest & S Std. & 5 & +0.2845 & 124 \\
SoftImpute & C Std. & 10 & +0.4880 & 78 \\
SoftImpute & R Aggr. & 20 & -0.1257 & 310 \\
SoftImpute & S Std. & 8 & -0.0813 & 124 \\
\textbf{Average} & & & \textbf{+0.2050} & \textcolor{red}{6} (groups) \\
\textbf{Average $\lvert r\lvert$} & & & \textbf{+0.2740} & \\
\end{longtable}
```

## Frequency adjustment


Let $C$ denote a factor cell: a method and dataset combination for which factor loadings are available. Within each cell $C$, benchmarks are ranked by absolute loading $|g_i|$ ($i$ indexes benchmarks). The rank $r_i$ is normalized within the cell,

$$a_i = \frac{r_i - 1}{n - 1}, \qquad r_i \in \{1, \dots, n\},$$

so $a_i = 0$ at the top of the cell and $a_i = 1$ at the bottom. This makes cells with different numbers of benchmarks $n$ comparable. Each benchmark's raw score is the mean of its $a_i$ over the cells in which it appears. Benchmarks appearing in fewer than two cells are excluded.

For a dataset with $m$ models, the frequency of benchmark $i$ is the proportion of models with an observed score,

$$f_i = \frac{\#\{\text{models with non-missing score for } i\}}{m}.$$

Columns with fewer than two observations or zero variance are excluded before computing $f_i$. Where several datasets contribute, the benchmark's frequency is the mean of its per-dataset $f_i$.

As shown in `\hyperref[tab:g-rank-cellwise-corr]{Table~\ref*{tab:g-rank-cellwise-corr}}`{=latex} below, within most cells, frequently measured benchmarks obtain higher $|g_i|$ and lower (better) $a_i$. A benchmark may therefore rank highly partly because it is measured often rather than because it is a strong indicator of $g$.

The adjustment is applied within each cell rather than to the pooled averages. Within cell $C$, the normalized ranks are regressed on the cell's own frequencies by ordinary least squares,

$$a_i = \alpha + \beta f_i + \varepsilon_i, \qquad
\hat{\varepsilon}_i = (a_i - \bar{a}) - \hat{\beta}\,(f_i - \bar{f}),$$

and the residual $\hat{\varepsilon}_i$ replaces $a_i$. By construction the residuals are uncorrelated with $f_i$ within the cell, so $\hat{\beta}$ removes exactly the linear component of the within-cell rank–frequency association. A cell with fewer than three frequency–rank pairs, or with zero frequency variance, cannot be fitted. Its benchmarks receive centered raw ranks $(a_i - \bar{a})$, and such cells are counted and reported.

The adjusted score of benchmark $i$ is the mean of its residuals over the cells in which it appears. Rankings are reported on this scale, with the raw average rank retained for comparison.

## Diagnostics

We present two diagnostics that justify the method of adjustment. `\hyperref[tab:g-rank-cellwise-corr]{Table~\ref*{tab:g-rank-cellwise-corr}}`{=latex} below reports, within each cell, the Pearson correlation $r(f_i, a_i)$, with the mean $r$, the mean $|r|$, and the counts of negative and positive cells. Negative $r$ indicates that more frequently measured benchmarks load higher on $g$.

```{=latex}
\begin{longtable}{@{}llrr@{}}
\caption{Correlations between benchmark frequency and their $g$ rankings. Mean $r = \textcolor{red}{-0.151}$, mean $\lvert r \rvert = \textcolor{red}{0.306}$; \textcolor{red}{4} negative and \textcolor{red}{2} positive cells.}\label{tab:g-rank-cellwise-corr}\\
\toprule
Method & Dataset & $N$ & $r$ \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Method & Dataset & $N$ & $r$ \\
\midrule
\endhead
\bottomrule
\endlastfoot
\textcolor{red}{k-NN} & \textcolor{red}{C Std.} & \textcolor{red}{78} & \textcolor{red}{-0.413} \\
\textcolor{red}{missForest} & \textcolor{red}{C Std.} & \textcolor{red}{78} & \textcolor{red}{-0.234} \\
\textcolor{red}{missForest} & \textcolor{red}{S Std.} & \textcolor{red}{124} & \textcolor{red}{-0.318} \\
\textcolor{red}{SoftImpute} & \textcolor{red}{C Std.} & \textcolor{red}{78} & \textcolor{red}{-0.406} \\
\textcolor{red}{SoftImpute} & \textcolor{red}{R Aggr.} & \textcolor{red}{310} & \textcolor{red}{+0.072} \\
\textcolor{red}{SoftImpute} & \textcolor{red}{S Std.} & \textcolor{red}{124} & \textcolor{red}{+0.394} \\
\end{longtable}
```

Second, `\hyperref[tab:g-rank-pooled-corr]{Table~\ref*{tab:g-rank-pooled-corr}}`{=latex} reports the pooled correlation between mean frequency and mean rank before and after the adjustment, stratified by the number of cells $k$ in which a benchmark appears. The within-cell association does not survive pooling with a consistent sign: cells disagree in direction, so the pooled raw correlation is small even though the within-cell correlations are not.

```{=latex}
\begin{longtable}{@{}lrrr@{}}
\caption{Pooled correlation between mean frequency and mean rank.}\label{tab:g-rank-pooled-corr}\\
\toprule
$N$ cells & $N$ benchmarks & $r$ raw & $r$ adjusted \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
$N$ cells & $N$ benchmarks & $r$ raw & $r$ adjusted \\
\midrule
\endhead
\bottomrule
\endlastfoot
\textcolor{red}{3} & \textcolor{red}{46} & \textcolor{red}{-0.290} & \textcolor{red}{-0.298} \\
\textcolor{red}{6} & \textcolor{red}{78} & \textcolor{red}{-0.266} & \textcolor{red}{+0.113} \\
\textcolor{red}{Pooled} & \textcolor{red}{124} & \textcolor{red}{-0.135} & \textcolor{red}{+0.095} \\
\end{longtable}
```

%%The adjustment is therefore evaluated per stratum rather than by the pooled correlation alone. Because the stratum-level diagnostic correlates against the *mean* frequency across a benchmark's datasets while the adjustment orthogonalizes against each *cell's* frequency, a residual stratum-level correlation is expected and does not indicate a failure of the adjustment.%%

For this reason, we report the cellwise-frequency-adjusted average normalized rank as the primary ordering of benchmarks (`\hyperref[tab:g-rankings]{Table~\ref*{tab:g-rankings}}`{=latex} in the main text). This ordering removes the linear component of the within-cell rank–frequency association, which reaches $|r| \approx 0.3$ in the average cell, before averaging across cells. The raw average normalized rank is retained alongside it for comparison, as the two orderings agree closely. The adjustment mainly matters for benchmarks measured across many cells, where the within-cell association is strongest and where the adjusted ranking reorders the raw ranking.

The full ranking of all \textcolor{red}{124} benchmarks is given in `\hyperref[full-g-rankings]{Appendix~\ref*{full-g-rankings}}`{=latex}.

<!-- The "Full g rankings" subsection and its Table 4 moved to full-g-rankings.md on 2026-09-26. -->
