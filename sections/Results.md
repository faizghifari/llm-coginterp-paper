# Results

## Variance explained by $G$

Only 6 of the 18 dataset-imputer combinations yield a weighted $R^2$ above the 0.4 threshold (`\hyperref[imputation-results]{Appendix~\ref*{imputation-results}}`{=latex}).

`\hyperref[tab:point-summaries]{Table~\ref*{tab:point-summaries}}`{=latex} below shows the point summaries of the factor analyses. The most important statistic here is the $\omega_h$, the share of variance in the summed score over all benchmarks that is due to the general factor. Across the six solutions, $\omega_h$ ranges from 0.04 to 0.76 and ECV from 0.11 to 0.52.

The range of $\omega_h$ is wide. The best-performing imputer, SoftImpute on C Std., yielded a $G$ factor that accounts for 36.7\% of the summed-score variance. Newer models score higher on the $G$ factor (`\hyperref[release-date-analysis]{Appendix~\ref*{release-date-analysis}}`{=latex}). Leaving out single benchmarks shows that the change in $\omega_h$ is only weakly related to how often a benchmark is observed (mean $|r| = 0.241$, `\hyperref[omega-sensitivity]{Appendix~\ref*{omega-sensitivity}}`{=latex}).


```{=latex}
\begin{longtable}{@{}llrrrrr@{}}
\caption{Point summaries of factor analysis results. AVE = average variance explained per factor, $k$ = number of factors extracted, $\phi_\text{avg}$ = average inter-factor correlation.}\label{tab:point-summaries}\\
\toprule
Dataset & Imputer & $\text{AVE}^{\uparrow}$ & ${\omega_h}^{\uparrow}$ & $\text{ECV}^{\uparrow}$ & $\phi_\text{avg}$ & ${wR^2}^{\uparrow}$ \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Dataset & Imputer & $\text{AVE}^{\uparrow}$ & ${\omega_h}^{\uparrow}$ & $\text{ECV}^{\uparrow}$ & $\phi_\text{avg}$ & ${wR^2}^{\uparrow}$ \\
\midrule
\endhead
\bottomrule
\endlastfoot
S Std. & missForest & 17.6\% & 0.760 & 0.501 & 0.215 & 0.455 \\
C Std. & k-NN & 9.7\% & 0.731 & 0.451 & 0.216 & 0.442 \\
C Std. & missForest & 22.0\% & 0.713 & 0.520 & -0.088 & 0.566 \\
C Std. & SoftImpute & 9.6\% & 0.367 & 0.126 & 0.038 & 0.586 \\
R Aggr. & SoftImpute & 4.9\% & 0.287 & 0.321 & 0.028 & 0.441 \\
S Std. & SoftImpute & 11.6\% & 0.044 & 0.114 & 0.041 & 0.428 \\
\end{longtable}
```

## Benchmark clusters


```{=latex}
\begin{wraptable}{R}{0.48\textwidth}
\vspace{-2pt}
\footnotesize\setlength{\tabcolsep}{3pt}
\centering
\caption{Cohesion of subject labels. Full cohesion results for every label can be seen in \hyperref[label-cohesion-results]{Appendix~\ref*{label-cohesion-results}}.}\label{tab:cohesion-subset}
\begin{tabular}{@{}lrr@{}}
\toprule
Label & Median A & Significant \\
\midrule
\texttt{reading\_comprehension} & +0.331 & 3/9 \\
\texttt{commonsense} & +0.329 & 2/9 \\
\texttt{code} & +0.278 & 4/9 \\
\texttt{math} & +0.028 & 0/9 \\
\bottomrule
\end{tabular}
\vspace{4pt}
\end{wraptable}
```

Figure 1 below shows an illustrative UMAP plot of benchmarks using composite distances aggregated from factor loadings, colored based on their subject matter (`\hyperref[benchmark-embedding]{Appendix~\ref*{benchmark-embedding}}`{=latex}). In this plot, benchmarks with a common subject only occasionally cluster together. This is supported by the low cohesion scores in `\hyperref[tab:cohesion-subset]{Table~\ref*{tab:cohesion-subset}}`{=latex}, where `reading_comprehension`, `commonsense`, and `code` show weak cohesion that is significant in at most 4 of 9 cells, while `math` shows no structure distinguishable from chance. Narrow labels such as `finance` are cohesive, but they have very few members (`\hyperref[label-cohesion-results]{Appendix~\ref*{label-cohesion-results}}`{=latex}). Across the entire figure, the spaces occupied by each flagged subject matter span across the entire plot. In other words, evidence from benchmark correlations suggest that **capability in one task does not always generalize to another task of the same subject**. A semantically coherent generalization is probable but not guaranteed, which makes domain abilities difficult to isolate from a purely semantic and intuitive standpoint. This phenomenon, where same-domain benchmarks lack a tendency to cluster together, is observed in nearly all of our imputations, which we discuss further in `\hyperref[common-subject-distances]{Appendix~\ref*{common-subject-distances}}`{=latex}.

![[umaps_new/0_C_standard_msoftimpute.png| UMAP plot of benchmark distances from C, SoftImpute ($wR^2 = 0.586$). Domain-similar benchmarks are not guaranteed to cluster together. For results from all our other valid imputations, see `\hyperref[common-subject-distances]{Appendix~\ref*{common-subject-distances}}`{=latex}]]


## Benchmarks' $G$-centrality

Another point of interest for the research question is which benchmarks act as a good proxy of general intelligence, particularly as research is concerned with performance in certain specific benchmarks to quantify intelligence advancements. `\hyperref[tab:g-rankings]{Table~\ref*{tab:g-rankings}}`{=latex} answers this question by ranking the benchmarks by the normalized average rank order[^4] of their loadings on the $G$ factor ($\rho$). To account for confounding effects from benchmark frequency, we report the residuals of the rank order regressed on frequency ($\rho_\epsilon$). Further details and justification are given in `\hyperref[benchmark-g-rankings]{Appendix~\ref*{benchmark-g-rankings}}`{=latex}.


[^4]: We use rank order as factor loadings vary in range, and they are normalized as different datasets have different numbers of benchmarks.

The top benchmarks are not dominated by common standard benchmarks. The top proxies include factual question answering (\texttt{simpleqa}, FACTS), medical exams (\texttt{medqa}), Thai school exams, and bias and safety tests (\texttt{bbq}). Of the common reasoning benchmarks, only \texttt{pwc\_arc\_challenge} (rank 8) reaches the top 10. To add to this, standard intelligence benchmarks like `mmlu` and `gpqa_diamond` are placed near the middle of the rankings (ranks 46 and 75 of 124; \texttt{gsm} is 58), with \texttt{swe\_bench} and \texttt{hellaswag} further down (ranks 85 and 116). The benchmarks that load most on $G$ are therefore not mainly abstract reasoning tasks. **In this corpus, reasoning, mathematics, and coding benchmarks are not the best proxies of the $G$ factor**, contrary to a common assumption.

```{=latex}

\begin{longtable}{@{}rlrrlrrr@{}}
\caption{Benchmarks and their average normalized rank order ($\rho$) of their $G$ factor loadings. Sorted by frequency-residualized rank ($\rho_\epsilon$). $\rho$ ranges from 0 to 1, where 0 = ranked first, 1 = ranked last. $N$ = number of EFA estimations with that benchmark. CI and Best/Worst refer to $\rho$.}\label{tab:g-rankings}\\
\toprule
No & Benchmark & ${\rho_\epsilon}^{\downarrow}$ & $\rho^{\downarrow}$ & 95\% CI & Best & Worst & $N$ \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
No & Benchmark & ${\rho_\epsilon}^{\downarrow}$ & $\rho^{\downarrow}$ & 95\% CI & Best & Worst & $N$ \\
\midrule
\endhead
\bottomrule
\endlastfoot
1 & simpleqa & -0.312 & 0.186 & [-0.199, 0.572] & 0.041 & 0.350 & 3 \\
2 & kaggle\_yulongt\_facts\_parametric & -0.307 & 0.189 & [-0.491, 0.870] & 0.006 & 0.504 & 3 \\
3 & kaggle\_andrewmingwang\_asset\_ops\_bench & -0.267 & 0.228 & [-0.424, 0.879] & 0.049 & 0.528 & 3 \\
4 & kaggle\_olamysiak\_eclektic & -0.242 & 0.256 & [0.049, 0.463] & 0.175 & 0.341 & 3 \\
5 & tydiqa & -0.235 & 0.260 & [0.046, 0.474] & 0.195 & 0.358 & 3 \\
6 & facts\_search & -0.232 & 0.262 & [-0.208, 0.732] & 0.104 & 0.472 & 3 \\
7 & medqa & -0.192 & 0.316 & [0.016, 0.615] & 0.065 & 0.819 & 6 \\
8 & pwc\_arc\_challenge & -0.186 & 0.351 & [0.083, 0.619] & 0.104 & 0.767 & 6 \\
9 & thai\_exam\_a\_level & -0.175 & 0.354 & [0.020, 0.688] & 0.123 & 0.959 & 6 \\
10 & bbq & -0.162 & 0.349 & [-0.013, 0.711] & 0.013 & 0.967 & 6 \\
46 & mmlu & -0.070 & 0.367 & [0.027, 0.706] & 0.039 & 0.829 & 6 \\
58 & gsm & -0.040 & 0.449 & [0.022, 0.877] & 0.000 & 0.935 & 6 \\
75 & gpqa\_diamond & 0.019 & 0.548 & [0.353, 0.743] & 0.340 & 0.870 & 6 \\
85 & swe\_bench & 0.043 & 0.535 & [-0.512, 1.581] & 0.084 & 0.919 & 3 \\
116 & hellaswag & 0.162 & 0.599 & [0.329, 0.870] & 0.252 & 0.961 & 6 \\
\end{longtable}
```
