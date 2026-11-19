# General factor and model size

We compute each model's general-factor score from the loadings and compare it with the parameter count within model families that have at least three distinct sizes. R Aggr. is omitted because its rows merge models of different sizes.

```{=latex}
\begin{longtable}{@{}llrrrrr@{}}
\caption{Within-family association between general-factor score and log parameter count. $r$ is the Pearson correlation after subtracting family means from both variables; the last column counts families with a positive Spearman correlation.}\label{tab:g-model-size}\\
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
k-NN & C Std. & 35 & 142 & +0.651 & $<0.001$ & 32/35 \\
missForest & S Std. & 35 & 141 & +0.591 & $<0.001$ & 30/35 \\
missForest & C Std. & 35 & 142 & +0.499 & $<0.001$ & 24/35 \\
SoftImpute & C Std. & 35 & 142 & +0.359 & $<0.001$ & 26/35 \\
SoftImpute & S Std. & 35 & 141 & -0.107 & 0.2 & 14/35 \\
\end{longtable}
```
