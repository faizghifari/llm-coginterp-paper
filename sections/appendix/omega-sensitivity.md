# Omega sensitivity


To quantify to what degree missing observations affect our results, we run leave-one-covariate-out (LOCO) factor analyses for each valid dataset. For each benchmark in the dataset, we run factor analysis with the benchmark left out, and store the difference in $\omega_h$ as a measure of sensitivity. `\hyperref[tab:omega-sensitivity]{Table~\ref*{tab:omega-sensitivity}}`{=latex} shows the correlations between benchmark frequency (normalized within the dataset) and the deltas. Signed averages of $r$ show negligible correlation at $r=0.054$, but this may simply be because signed correlations cancel out to 0. Average of unsigned, absolute $r$ yielded a larger but still modest correlation of $r=0.184$.

```{=latex}
\begin{longtable}{@{}llrrr@{}}
\caption{Correlations between benchmark observation and their $\Delta\omega_h$. $k$ = number of factors extracted.}\label{tab:omega-sensitivity}\\
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
Mean fill & C Std. & 2 & +0.0701 & 78 \\
Mean fill & C Std. & 14 & +0.1316 & 78 \\
k-NN & C Std. & 2 & +0.0268 & 78 \\
k-NN & C Std. & 7 & +0.3205 & 78 \\
k-NN & S Std. & 2 & +0.1765 & 124 \\
k-NN & S Std. & 11 & +0.2069 & 124 \\
missForest & C Aggr. & 2 & +0.0173 & 102 \\
missForest & C Aggr. & 4 & +0.2315 & 102 \\
missForest & C Std. & 2 & +0.0318 & 78 \\
missForest & C Std. & 4 & +0.0100 & 78 \\
missForest & S Std. & 2 & -0.3363 & 124 \\
missForest & S Std. & 4 & -0.2933 & 124 \\
OneSidedMC & C Aggr. & 2 & -0.4256 & 102 \\
OneSidedMC & C Std. & 2 & +0.3207 & 78 \\
OneSidedMC & S Std. & 2 & +0.3462 & 124 \\
SoftImpute & C Aggr. & 2 & -0.0747 & 102 \\
SoftImpute & C Aggr. & 5 & +0.1804 & 102 \\
SoftImpute & C Std. & 2 & +0.4196 & 78 \\
SoftImpute & C Std. & 9 & +0.3245 & 78 \\
SoftImpute & R Aggr. & 2 & +0.1227 & 310 \\
SoftImpute & R Aggr. & 20 & -0.0677 & 310 \\
SoftImpute & R Std. & 2 & +0.0164 & 298 \\
SoftImpute & R Std. & 20 & -0.1719 & 298 \\
SoftImpute & S Aggr. & 2 & -0.2156 & 293 \\
SoftImpute & S Aggr. & 20 & -0.0837 & 293 \\
SoftImpute & S Std. & 2 & +0.2324 & 124 \\
SoftImpute & S Std. & 5 & +0.0361 & 124 \\
SoftImpute & raw Aggr. & 2 & -0.2083 & 380 \\
SoftImpute & raw Aggr. & 10 & -0.3003 & 380 \\
SoftImpute & raw Std. & 2 & +0.2880 & 404 \\
SoftImpute & raw Std. & 10 & +0.0528 & 404 \\
SoftImpute (corr.) & C Std. & 2 & -0.0565 & 78 \\
SoftImpute (corr.) & C Std. & 4 & +0.0917 & 78 \\
SoftImpute (corr.) & S Std. & 2 & -0.1664 & 124 \\
SoftImpute (corr.) & S Std. & 5 & +0.2068 & 124 \\
Zero fill & C Std. & 2 & +0.2965 & 78 \\
Zero fill & C Std. & 14 & +0.2493 & 78 \\
\textbf{Average $r$} & & & \textbf{+0.0542} & 37 (groups) \\
\textbf{Average $\lvert r \lvert$} & & & \textbf{0.1840} & \\
\end{longtable}
```
