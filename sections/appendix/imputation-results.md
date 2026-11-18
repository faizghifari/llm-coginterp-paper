# Imputation Results

<!--To gauge whether the dataset correlations are trustworthy, we present diagnostics that describe the missingness pattern in the dataset or how said pattern correlate with our results.

## Observation counts

In descriptive terms, knowing the missingness pattern 
### Pairwise-correlation computability

**Table 1**. Descriptive data of benchmarks with computable correlations. A correlation counts as computable when pairwise-complete $N \ge 4$., although note that this minimum N is not enforced in correlation matrix imputers. N Compt = number of benchmarks with computable correlations. Corrs. = number of computable correlations.  $\text{N}_\text{avg}$ = mean observations (models) per computable correlation.

| Dataset            |   N | N Compt. | Mean Corrs. | SD Corrs. | Max Corrs. | Mean $\text{N}_\text{avg}$ | SD $\text{N}_\text{avg}$ |
| ------------------ | --: | -------: | ----------: | --------: | ---------: | -------------------------: | -----------------------: |
| Raw. Std.   | 404 |      312 |        61.6 |      62.6 |        229 |                        7.6 |                      7.9 |
| Raw. Aggr. | 380 |      301 |       106.6 |      85.2 |        254 |                        4.6 |                      2.8 |
| C. Std.     |  78 |       78 |        47.2 |      13.4 |         77 |                       28.6 |                     14.0 |
| C. Aggr.   | 102 |      102 |        78.5 |      17.8 |        101 |                        9.6 |                      3.4 |
| R. Std.     | 298 |      270 |        81.4 |      59.9 |        228 |                        8.8 |                      7.2 |
| R. Aggr.   | 310 |      283 |       130.2 |      76.4 |        254 |                        5.3 |                      2.2 |
| S. Std.     | 124 |      124 |        67.7 |      21.5 |        118 |                       20.2 |                     11.2 |
| S. Aggr.   | 293 |      292 |       138.1 |      71.2 |        254 |                        5.8 |                      1.6 |


**Table 2**. Per-benchmark-pair: shared N and $|r|$ of computable correlations (unit = benchmark pair). N/pair = shared non-missing models.

| Dataset            | N Total | N Compt. | %Compt. | Mean N/pair | SD N/Pair | Max N/pair | Mean $\lvert r \lvert$ | SD $\lvert r \lvert$ |
| ------------------ | ------: | -------: | ------: | ----------: | --------: | ---------: | ---------------------: | -------------------: |
| Raw. Std.   |   81406 |    12442 |    15.3 |        11.3 |      18.2 |        332 |                 0.5046 |               0.2871 |
| Raw. Aggr. |   72010 |    20261 |    28.1 |         6.2 |       4.8 |        105 |                 0.4662 |               0.2813 |
| C. Std.     |    3003 |     1840 |    61.3 |        30.2 |      40.9 |        332 |                 0.5393 |               0.2711 |
| C. Aggr.   |    5151 |     4006 |    77.8 |         9.9 |       9.7 |        105 |                 0.4315 |               0.2641 |
| R. Std.     |   44253 |    12134 |    27.4 |        10.3 |      10.3 |        109 |                 0.5031 |               0.2872 |
| R. Aggr.   |   47895 |    20188 |    42.2 |         6.1 |       4.0 |         64 |                 0.4665 |               0.2813 |
| S. Std.     |    7626 |     4198 |    55.0 |        20.0 |      29.1 |        332 |                 0.4848 |               0.2731 |
| S. Aggr.   |   42778 |    20230 |    47.3 |         6.1 |       4.2 |         70 |                 0.4661 |               0.2813 |
-->

%%
### Plots

![[density_corr_count.png| Descriptive plot of computable pairwise Pearson correlations for each individual benchmark.]]

Figure shows the average number of shared observations underlying each benchmark's computable correlations.

![[density_corr_n.png| Plot of average number of shared observations underlying each benchmark's computable correlations]]

Figure shows the distribution of observation counts per benchmark.

![[density_data.png | Plot of observation counts per benchmark.]]

Figure shows the distribution of shared non-missing observations per computable benchmark pair.

![[density_pair_n.png | Plot of the number of unique benchmark pairs with computable correlations.]]
%%
<!--
density_corr_count.png
density_corr_n.png
density_data.png
density_pair_n.png-->

<!--## Imputation results-->

The table below lists the weighted held-out $R^2$ ($wR^2$) of every dataset-imputer combination. Rows are sorted by $wR^2$. As described in the results, only 6 of the 18 combinations pass the $wR^2 \geq 0.4$ gate.

```{=latex}
\begin{longtable}{@{}llr@{}}
\caption{\textcolor{red}{Results of all imputation runs, sorted by $wR^2$.}}\label{tab:imputation-results-all}\\
\toprule
Dataset & Imputer & $wR^2$ \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Dataset & Imputer & $wR^2$ \\
\midrule
\endhead
\bottomrule
\endlastfoot
C Std. & SoftImpute & 0.586 \\
C Std. & missForest & 0.566 \\
S Std. & missForest & 0.455 \\
C Std. & k-NN & 0.442 \\
R Aggr. & SoftImpute & 0.441 \\
S Std. & SoftImpute & 0.428 \\
C Aggr. & SoftImpute & 0.398 \\
R Std. & SoftImpute & 0.355 \\
S Std. & k-NN & 0.326 \\
C Aggr. & missForest & 0.263 \\
S Aggr. & SoftImpute & 0.262 \\
C Aggr. & k-NN & 0.170 \\
S Aggr. & k-NN & 0.016 \\
R Aggr. & k-NN & 0.004 \\
S Aggr. & missForest & 0.001 \\
R Std. & missForest & 0.000 \\
R Aggr. & missForest & -0.001 \\
R Std. & k-NN & -0.004 \\
\end{longtable}
```
