# Omega sensitivity


To quantify to what degree missing observations affect our results, we run leave-one-covariate-out (LOCO) factor analyses for each valid dataset. For each benchmark in the dataset, we run factor analysis with the benchmark left out, and store the difference in $\omega_h$ as a measure of sensitivity. `\hyperref[tab:omega-sensitivity]{Table~\ref*{tab:omega-sensitivity}}`{=latex} shows the correlations between benchmark frequency (normalized within the dataset) and the deltas. Signed averages of $r$ show a smaller correlation at $r=0.157$, but this may simply be because signed correlations cancel out to 0. Average of unsigned, absolute $r$ yielded a larger but still modest correlation of $r=0.241$.

```{=latex}
\begin{longtable}{@{}llrrr@{}}
\caption{Correlations between benchmark observation and their $\Delta\omega_h$. $k$ = number of factors extracted. Only accepted imputations with $wR^2 > 0.4$ are shown.}\label{tab:omega-sensitivity}\\
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
\multicolumn{5}{@{}l}{[$k = 2$ rows removed]} \\
k-NN & C Std. & 8 & +0.3251 & 78 \\
missForest & C Std. & 4 & -0.0222 & 78 \\
missForest & S Std. & 5 & +0.4566 & 124 \\
SoftImpute & C Std. & 10 & +0.3287 & 78 \\
SoftImpute & R Aggr. & 20 & -0.2289 & 310 \\
SoftImpute & S Std. & 8 & +0.0841 & 124 \\
\textbf{Average $r$} & & & \textbf{+0.1572} & 6 (groups) \\
\textbf{Average $\lvert r \lvert$} & & & \textbf{+0.2409} & \\
\end{longtable}
```
