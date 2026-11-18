# General factor and model size

\textcolor{red}{We compute each model's general-factor score from the loadings and compare it with the parameter count within model families that have at least three distinct sizes. R Aggr. is omitted because its rows merge models of different sizes.}

```{=latex}
\begin{longtable}{@{}llrrrrr@{}}
\caption{\textcolor{red}{Within-family association between general-factor score and log parameter count. $r$ is the Pearson correlation after subtracting family means from both variables; the last column counts families with a positive Spearman correlation.}}\label{tab:g-model-size}\\
\toprule
Method & Dataset & Families & Models & $r$ & $p$ & Families $\rho > 0$ \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Method & Dataset & Families & Models & $r$ & $p$ & Families $\rho > 0$ \\
\midrule
\endhead
\bottomrule
\endlastfoot
\textcolor{red}{k-NN} & \textcolor{red}{C Std.} & \textcolor{red}{35} & \textcolor{red}{142} & \textcolor{red}{+0.651} & \textcolor{red}{$<0.001$} & \textcolor{red}{32/35} \\
\textcolor{red}{missForest} & \textcolor{red}{S Std.} & \textcolor{red}{35} & \textcolor{red}{141} & \textcolor{red}{+0.591} & \textcolor{red}{$<0.001$} & \textcolor{red}{30/35} \\
\textcolor{red}{missForest} & \textcolor{red}{C Std.} & \textcolor{red}{35} & \textcolor{red}{142} & \textcolor{red}{+0.499} & \textcolor{red}{$<0.001$} & \textcolor{red}{24/35} \\
\textcolor{red}{SoftImpute} & \textcolor{red}{C Std.} & \textcolor{red}{35} & \textcolor{red}{142} & \textcolor{red}{+0.359} & \textcolor{red}{$<0.001$} & \textcolor{red}{26/35} \\
\textcolor{red}{SoftImpute} & \textcolor{red}{S Std.} & \textcolor{red}{35} & \textcolor{red}{141} & \textcolor{red}{-0.107} & \textcolor{red}{0.2} & \textcolor{red}{14/35} \\
\end{longtable}
```
