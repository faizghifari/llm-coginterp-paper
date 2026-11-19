# Imputation methods

Every method implemented in R shares one interface. It takes the sparse matrix in, and returns the completed matrix, the swept-parameter grid, and the held-out RMSE and $wR^2$ at each parameter value. None of them factor. This is what allows the factoring stage to be identical across methods. `\hyperref[tab:imputation-cell-methods]{Table~\ref*{tab:imputation-cell-methods}}`{=latex} shows the list of full-dataset missing data estimators.

```{=latex}
\begin{longtable}{@{}>{\raggedright\arraybackslash}p{0.15\textwidth}>{\raggedright\arraybackslash}p{0.30\textwidth}>{\raggedright\arraybackslash}p{0.12\textwidth}>{\raggedright\arraybackslash}p{0.26\textwidth}@{}}
\caption{Estimators of the missing dataset entries.}\label{tab:imputation-cell-methods}\\
\toprule
Method & Description & Package & Configuration \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Method & Description & Package & Configuration \\
\midrule
\endhead
\bottomrule
\endlastfoot
SoftImpute \citep{mazumder2010} & Nuclear-norm-penalized low-rank completion by iterative soft-thresholded SVD, assuming a low-rank signal plus noise. Primary cell-level method. & softImpute & sweeps rank: 1\ldots10 (capped at $\min(n,p)-1$), and at each rank a 30-point geometric $\lambda$ grid from $\lambda_0$ down to $\lambda_0/100$, ALS with warm starts \\*
k-NN & Each missing cell filled from the $k$ most similar models, an assumption-light baseline with no low-rank, linearity, or normality assumption. & VIM & sweeps $k$: 1\ldots10 (capped below $n$), Gower distance over benchmarks, weighted-mean aggregation \\*
missForest \citep{stekhoven2012} & Iterative random-forest imputation, nonparametric, able to capture nonlinear dependence the low-rank methods cannot represent. & missForest & sweeps number of trees: \{50, 100, 200, 400\}, at most 10 iterations \\*
\end{longtable}
```

There were other methods that we used to impute the data, particularly those that worked with the correlation matrix instead of the full dataset. However, we omit them as we fail to obtain a result that pass the $wR^2$ \textcolor{red}{quality filter}.