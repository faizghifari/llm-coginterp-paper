# Omega sensitivity


To quantify to what degree missing observations affect our results, we run leave-one-covariate out (LOCO) factor analyses for each valid datasets. For each benchmarks in the dataset, we run factor analysis with the dataset left out, and store the difference in $\omega_h$ as a measure of sensitivity. `\hyperref[tab:omega-sensitivity]{Table~\ref*{tab:omega-sensitivity}}`{=latex} shows the correlations between benchmark frequency (normalized within the dataset) and the deltas. Signed averages of $r$ shows negligible correlation at $r=0.054$, but this may simply be because signed correlations cancel out to 0. Average of unsigned, absolute $r$ yielded a larger but still modest correlation of $r=0.184$.

```{=latex}
\begin{longtable}{@{}llrrr@{}}
\caption{Correlations between benchmark observation and their $\Delta\omega_h$. $k$ = number of factors extracted.}\label{tab:omega-sensitivity}\\
\toprule
Method & Dataset & $k$ & $r$ & $N$ \\
\midrule
\endfirsthead
\caption{Correlations between benchmark observation and their $\Delta\omega_h$. $k$ = number of factors extracted.}\\
\toprule
Method & Dataset & $k$ & $r$ & $N$ \\
\midrule
\endhead
\bottomrule
\endlastfoot
fill-mean & C\_all\_standard & 2 & +0.0701 & 78 \\
fill-mean & C\_all\_standard & 14 & +0.1316 & 78 \\
knn & C\_all\_standard & 2 & +0.0268 & 78 \\
knn & C\_all\_standard & 7 & +0.3205 & 78 \\
knn & S\_all\_standard & 2 & +0.1765 & 124 \\
knn & S\_all\_standard & 11 & +0.2069 & 124 \\
missforest & C\_all\_aggressive & 2 & +0.0173 & 102 \\
missforest & C\_all\_aggressive & 4 & +0.2315 & 102 \\
missforest & C\_all\_standard & 2 & +0.0318 & 78 \\
missforest & C\_all\_standard & 4 & +0.0100 & 78 \\
missforest & S\_all\_standard & 2 & -0.3363 & 124 \\
missforest & S\_all\_standard & 4 & -0.2933 & 124 \\
onesidedmc & C\_all\_aggressive & 2 & -0.4256 & 102 \\
onesidedmc & C\_all\_standard & 2 & +0.3207 & 78 \\
onesidedmc & S\_all\_standard & 2 & +0.3462 & 124 \\
softimpute & C\_all\_aggressive & 2 & -0.0747 & 102 \\
softimpute & C\_all\_aggressive & 5 & +0.1804 & 102 \\
softimpute & C\_all\_standard & 2 & +0.4196 & 78 \\
softimpute & C\_all\_standard & 9 & +0.3245 & 78 \\
softimpute & R\_all\_aggressive & 2 & +0.1227 & 310 \\
softimpute & R\_all\_aggressive & 20 & -0.0677 & 310 \\
softimpute & R\_all\_standard & 2 & +0.0164 & 298 \\
softimpute & R\_all\_standard & 20 & -0.1719 & 298 \\
softimpute & S\_all\_aggressive & 2 & -0.2156 & 293 \\
softimpute & S\_all\_aggressive & 20 & -0.0837 & 293 \\
softimpute & S\_all\_standard & 2 & +0.2324 & 124 \\
softimpute & S\_all\_standard & 5 & +0.0361 & 124 \\
softimpute & raw\_all\_aggressive & 2 & -0.2083 & 380 \\
softimpute & raw\_all\_aggressive & 10 & -0.3003 & 380 \\
softimpute & raw\_all\_standard & 2 & +0.2880 & 404 \\
softimpute & raw\_all\_standard & 10 & +0.0528 & 404 \\
softimpute\_corr & C\_all\_standard & 2 & -0.0565 & 78 \\
softimpute\_corr & C\_all\_standard & 4 & +0.0917 & 78 \\
softimpute\_corr & S\_all\_standard & 2 & -0.1664 & 124 \\
softimpute\_corr & S\_all\_standard & 5 & +0.2068 & 124 \\
fill-zeros & C\_all\_standard & 2 & +0.2965 & 78 \\
fill-zeros & C\_all\_standard & 14 & +0.2493 & 78 \\
\textbf{Average $r$} & & & \textbf{+0.0542} & 37 (groups) \\
\textbf{Average $\lvert r \lvert$} & & & \textbf{0.1840} & \\
\end{longtable}
```
