# Results

## Variance explained by $G$

Only \textcolor{red}{6 of the 18} dataset-imputer combinations yield \textcolor{red}{a weighted} $R^2$ above the \textcolor{red}{0.4} threshold (`\hyperref[imputation-results]{Appendix~\ref*{imputation-results}}`{=latex}).

`\hyperref[tab:point-summaries]{Table~\ref*{tab:point-summaries}}`{=latex} below shows the point summaries of the factor analyses. The most important statistic here is the $\omega_h$, \textcolor{red}{the share of variance in the summed score over all benchmarks that is due to the general factor}. \textcolor{red}{Across the six solutions, $\omega_h$ ranges from 0.04 to 0.76 and ECV from 0.11 to 0.52.}

The range of $\omega_h$ is wide. The best-performing imputer, SoftImpute on \textcolor{red}{C} Std., yielded a $G$ factor that accounts for \textcolor{red}{36.7\%} of the \textcolor{red}{summed-score} variance. $\omega_h$ also stays in this range when we split the models by release year. Newer models score higher on the $G$ factor, but the variance it accounts for shows no trend with release year (`\hyperref[release-date-analysis]{Appendix~\ref*{release-date-analysis}}`{=latex}) `\textcolor{red}{\textbf{[STALE]}}`{=latex}. Leaving out single benchmarks shows that the change in $\omega_h$ is only weakly related to how often a benchmark is observed (mean $|r| = \textcolor{red}{0.241}$, `\hyperref[omega-sensitivity]{Appendix~\ref*{omega-sensitivity}}`{=latex}).


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

%%TODO: RUN AND UPDATE LOCO%%

![[umaps_new/0_C_standard_msoftimpute.png| UMAP plot of benchmark distances from \textcolor{red}{C}, SoftImpute ($wR^2 = 0.586$). Domain-similar benchmarks are not guaranteed to cluster together.]]


## Benchmarks' $G$-centrality

Another point of interest for the research question is which benchmarks act as a good proxy of general intelligence, particularly as research is concerned with performance in certain specific benchmarks to quantify intelligence advancements. `\hyperref[tab:g-rankings]{Table~\ref*{tab:g-rankings}}`{=latex} answers this question by ranking the benchmarks by the normalized average rank order[^4] of their loadings on the $G$ factor ($\rho$). To account for confounding effects from benchmark frequency, we report the residuals of the rank order regressed on frequency ($\rho_\epsilon$). Further details and justification are given in `\hyperref[benchmark-g-rankings]{Appendix~\ref*{benchmark-g-rankings}}`{=latex}.


[^4]: We use rank order as factor loadings vary in range, and they are normalized as different datasets have different numbers of benchmarks.

The top benchmarks are not dominated by common standard benchmarks. The top proxies include measures of creativity, legal use cases, and even emotional intelligence. There is no evidence that a $G$ factor resembles anything like abstract reasoning. This diversity is expected on its own, since a general factor is indifferent to the content of its indicators. To add to this, standard intelligence benchmarks like `arc` and `gpqa_diamond` are placed near the middle of the rankings. **Our results are evidence that the prevailing assumption that reasoning, mathematics, and coding benchmarks are the best proxies of general intelligence does not hold**.

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
11 & legalbench & -0.157 & 0.353 & [0.079, 0.627] & 0.078 & 0.748 & 6 \\
12 & pwc\_piqa & -0.156 & 0.381 & [0.053, 0.710] & 0.033 & 0.939 & 6 \\
13 & thai\_exam\_tpat1 & -0.156 & 0.373 & [0.013, 0.733] & 0.000 & 0.878 & 6 \\
14 & openbookqa & -0.154 & 0.343 & [-0.021, 0.708] & 0.026 & 0.862 & 6 \\
15 & thaiexam & -0.153 & 0.376 & [-0.007, 0.758] & 0.074 & 0.984 & 6 \\
\end{longtable}

```
