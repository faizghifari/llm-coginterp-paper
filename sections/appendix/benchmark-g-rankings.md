# Benchmark $g$-rankings

## Frequency and $g$-ranking corrlations

A pressing concern with regards to our findings on the top $g$ benchmarks in `\hyperref[tab:g-rankings]{Table~\ref*{tab:g-rankings}}`{=latex} of the main content, is to what degree a benchmark's $g$-factor loading is correlated with their non-missing frequency. This is important to know, as our datasets can possess higher or lower correlations introduced as artifacts by our imputation methods.

Naively, as shown in `\hyperref[tab:g-rank-freq-corr]{Table~\ref*{tab:g-rank-freq-corr}}`{=latex} below, benchmark frequency *is* correlated with $g$ loadings. Unsigned averages suggest this correlation is ignorable ($r = 0.3432$), but the range of the correlations are quite dispersed, and some dataset-imputation combination can be as high as ~0.5. Thus, identifying benchmarks which proxy a supposed latent $g$ factor well requires adjusting the statistics with respect to their frequency.

```{=latex}
\begin{longtable}{@{}llrrr@{}}
\caption{Correlations between benchmark frequency and their $g$ loadings. $k$ = number of factors extracted.}\label{tab:g-rank-freq-corr}\\
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
fill-mean & C Std. & 2 & +0.4192 & 78 \\
fill-mean & C Std. & 14 & +0.4192 & 78 \\
knn & C Std. & 2 & +0.4065 & 78 \\
knn & C Std. & 7 & +0.4065 & 78 \\
knn & S Std. & 2 & +0.2335 & 124 \\
knn & S Std. & 11 & +0.2335 & 124 \\
missforest & C Aggr. & 2 & +0.3251 & 102 \\
missforest & C Aggr. & 4 & +0.3251 & 102 \\
missforest & C Std. & 2 & +0.2203 & 78 \\
missforest & C Std. & 4 & +0.2203 & 78 \\
missforest & S Std. & 2 & -0.2462 & 124 \\
missforest & S Std. & 4 & -0.2462 & 124 \\
onesidedmc & C Aggr. & 2 & -0.4090 & 102 \\
onesidedmc & C Std. & 2 & +0.4786 & 78 \\
onesidedmc & S Std. & 2 & +0.3609 & 124 \\
softimpute & C Aggr. & 2 & +0.5763 & 102 \\
softimpute & C Aggr. & 5 & +0.5763 & 102 \\
softimpute & C Std. & 2 & +0.5513 & 78 \\
softimpute & C Std. & 9 & +0.5513 & 78 \\
softimpute & R Aggr. & 2 & -0.3041 & 310 \\
softimpute & R Aggr. & 20 & -0.3041 & 310 \\
softimpute & R Std. & 2 & -0.2140 & 298 \\
softimpute & R Std. & 20 & -0.2140 & 298 \\
softimpute & S Aggr. & 2 & -0.3161 & 293 \\
softimpute & S Aggr. & 20 & -0.3161 & 293 \\
softimpute & S Std. & 2 & +0.1885 & 124 \\
softimpute & S Std. & 5 & +0.1885 & 124 \\
softimpute & raw Aggr. & 2 & -0.2404 & 380 \\
softimpute & raw Aggr. & 10 & -0.2404 & 380 \\
softimpute & raw Std. & 2 & +0.1815 & 404 \\
softimpute & raw Std. & 10 & +0.1815 & 404 \\
softimpute\_corr & C Std. & 2 & +0.3788 & 78 \\
softimpute\_corr & C Std. & 4 & +0.3788 & 78 \\
softimpute\_corr & S Std. & 2 & +0.3890 & 124 \\
softimpute\_corr & S Std. & 5 & +0.3890 & 124 \\
fill-zeros & C Std. & 2 & +0.5343 & 78 \\
fill-zeros & C Std. & 14 & +0.5343 & 78 \\
\textbf{Average} & & & \textbf{+0.1783} & 37 (groups) \\
\textbf{Average $\lvert r\lvert$} & & & \textbf{0.3432} & \\
\end{longtable}
```

## Frequency adjustment


Let $C$ denote a factor cell: a method and dataset combination for which factor loadings are available. Within each cell $C$, benchmarks are ranked by absolute loading $|g_i|$ ($i$ indexes benchmarks). The rank $r_i$ is normalized within the cell,

$$a_i = \frac{r_i - 1}{n - 1}, \qquad r_i \in \{1, \dots, n\},$$

so $a_i = 0$ at the top of the cell and $a_i = 1$ at the bottom. This makes cells with different numbers of benchmarks $n$ comparable. Each benchmark's raw score is the mean of its $a_i$ over the cells in which it appears. Benchmarks appearing in fewer than two cells are excluded.

For a dataset with $m$ models, the frequency of benchmark $i$ is the proportion of models with an observed score,

$$f_i = \frac{\#\{\text{models with non-missing score for } i\}}{m}.$$

Columns with fewer than two observations or zero variance are excluded before computing $f_i$. Where several datasets contribute, the benchmark's frequency is the mean of its per-dataset $f_i$.

As shown in `\hyperref[tab:g-rank-cellwise-corr]{Table~\ref*{tab:g-rank-cellwise-corr}}`{=latex} above, within most cells, frequently measured benchmarks obtain higher $|g_i|$ and lower (better) $a_i$. A benchmark may therefore rank highly partly because it is measured often rather than because it is a strong indicator of $g$.

The adjustment is applied within each cell rather than to the pooled averages. Within cell $C$, the normalized ranks are regressed on the cell's own frequencies by ordinary least squares,

$$a_i = \alpha + \beta f_i + \varepsilon_i, \qquad
\hat{\varepsilon}_i = (a_i - \bar{a}) - \hat{\beta}\,(f_i - \bar{f}),$$

and the residual $\hat{\varepsilon}_i$ replaces $a_i$. By construction the residuals are uncorrelated with $f_i$ within the cell, so $\hat{\beta}$ removes exactly the linear component of the within-cell rank–frequency association. A cell with fewer than three frequency–rank pairs, or with zero frequency variance, cannot be fitted; its benchmarks receive centered raw ranks $(a_i - \bar{a})$, and such cells are counted and reported.

The adjusted score of benchmark $i$ is the mean of its residuals over the cells in which it appears; rankings are reported on this scale, with the raw average rank retained for comparison.

## Diagnostics

We present 2 diagnostics that justify the method of adjustment. `\hyperref[tab:g-rank-cellwise-corr]{Table~\ref*{tab:g-rank-cellwise-corr}}`{=latex} below shows, within each cell, the Pearson correlation $r(f_i, a_i)$ is reported, with the mean $r$, the mean $|r|$, and the counts of negative and positive cells. Negative $r$ indicates that more frequently measured benchmarks load higher on $g$.

```{=latex}
\begin{longtable}{@{}llrr@{}}
\caption{Correlations between benchmark frequency and their $g$ rankings. Mean $r = -0.173$, mean $\lvert r \rvert = 0.273$; 13 negative and 7 positive cells.}\label{tab:g-rank-cellwise-corr}\\
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
default & C Std. & 78 & -0.429 \\
knn & C Std. & 78 & -0.429 \\
knn & S Std. & 124 & +0.020 \\
missforest & C Aggr. & 102 & -0.342 \\
missforest & C Std. & 78 & -0.106 \\
missforest & S Std. & 124 & +0.261 \\
onesidedmc & C Aggr. & 102 & +0.383 \\
onesidedmc & C Std. & 78 & -0.242 \\
onesidedmc & S Std. & 124 & -0.271 \\
softimpute & C Aggr. & 102 & -0.470 \\
softimpute & C Std. & 78 & -0.497 \\
softimpute & R Aggr. & 310 & +0.006 \\
softimpute & R Std. & 298 & +0.222 \\
softimpute & S Aggr. & 293 & +0.094 \\
softimpute & S Std. & 124 & -0.162 \\
softimpute & raw Aggr. & 380 & +0.012 \\
softimpute & raw Std. & 404 & -0.091 \\
softimpute\_corr & C Std. & 78 & -0.425 \\
softimpute\_corr & S Std. & 124 & -0.431 \\
fill-zeros & C Std. & 78 & -0.572 \\
\end{longtable}
```

Second, `\hyperref[tab:g-rank-pooled-corr]{Table~\ref*{tab:g-rank-pooled-corr}}`{=latex} reports the the pooled correlation between mean frequency and mean rank is before and after the adjustment, stratified by the number of cells $k$ in which a benchmark appears. The within-cell association does not survive pooling with a consistent sign: cells disagree in direction, so the pooled raw correlation is small even though the within-cell correlations are not.

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
2 & 54 & -0.023 & -0.021 \\
3 & 26 & -0.024 & -0.049 \\
4 & 24 & -0.214 & -0.232 \\
5 & 141 & +0.061 & +0.046 \\
8 & 10 & +0.040 & +0.038 \\
10 & 33 & +0.518 & +0.516 \\
13 & 13 & -0.538 & -0.539 \\
20 & 78 & -0.382 & +0.073 \\
Pooled & 380 & -0.128 & -0.039 \\
\end{longtable}
```

%%The adjustment is therefore evaluated per stratum rather than by the pooled correlation alone. Because the stratum-level diagnostic correlates against the *mean* frequency across a benchmark's datasets while the adjustment orthogonalizes against each *cell's* frequency, a residual stratum-level correlation is expected and does not indicate a failure of the adjustment.%%

For this reason, we report the cellwise-frequency-adjusted average normalized rank as the primary ordering of benchmarks (`\hyperref[tab:g-rankings]{Table~\ref*{tab:g-rankings}}`{=latex} in the main content): it removes the linear component of the within-cell rank–frequency association, which reaches $|r| \approx 0.3$ in the average cell, before averaging across cells. The raw average normalized rank is retained alongside it for comparison, as the two orderings agree closely. The adjustment mainly matters for benchmarks measured across many cells, where the within-cell association is strongest and where the adjusted ranking reorders the raw ranking.

The full ranking of all 380 benchmarks is given in `\hyperref[full-g-rankings]{Appendix~\ref*{full-g-rankings}}`{=latex}.

<!-- The "Full g rankings" subsection and its Table 4 moved to full-g-rankings.md on 2026-09-26. -->
