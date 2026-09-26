# Common-Subject UMAP Plots {#common-subject-distances}

This section presents the UMAP plots for the benchmarks' composite distance, with each figure showing the plots of one imputation method. Each plot is composited over the standard and aggressive collapse strategies. The aggregate plots are composited over all collapse strategies and all imputation methods. Since the R and raw datasets only have 1 valid imputation each, they do not have a dedicated aggregate figure. This section has 16 figures in total.

Notably, through the different imputation strategies, all of the visualizations show the same pattern, in which shared-domain benchmarks tend to be dispersed across the vector space. Highlighting the same benchmarks as in the results (with some benchmarks discarded by each densifier), we see the same pattern that, for example, `aime25` and `gsm8k` are distanced quite far from each other. Through most of the different possible solutions, our core claim that same-domain benchmarks are not guaranteed to cluster together is robust.


![C_aggregate.png|C dataset, aggregated across 7 imputations.](../../umaps/C_aggregate.png)
![C_default.png|C dataset, imputed with mean fill.](../../umaps/C_default.png)
![C_knn.png|C dataset, imputed with k-NN.](../../umaps/C_knn.png)
![C_missforest.png|C dataset, imputed with missForest.](../../umaps/C_missforest.png)
![C_onesidedmc.png|C dataset, imputed with OneSidedMC.](../../umaps/C_onesidedmc.png)
![C_softimpute.png|C dataset, imputed with SoftImpute.](../../umaps/C_softimpute.png)
![C_softimpute_corr.png|C dataset, imputed with SoftImpute (corr.).](../../umaps/C_softimpute_corr.png)
![C_zeros.png|C dataset, imputed with zero fill.](../../umaps/C_zeros.png)

![S_aggregate.png|S dataset, aggregated across 5 imputations.](../../umaps/S_aggregate.png)
![S_knn.png|S dataset, imputed with k-NN.](../../umaps/S_knn.png)
![S_missforest.png|S dataset, imputed with missForest.](../../umaps/S_missforest.png)
![S_onesidedmc.png|S dataset, imputed with OneSidedMC.](../../umaps/S_onesidedmc.png)
![S_softimpute.png|S dataset, imputed with SoftImpute.](../../umaps/S_softimpute.png)
![S_softimpute_corr.png|S dataset, imputed with SoftImpute (corr.).](../../umaps/S_softimpute_corr.png)

![R_softimpute.png|R dataset, imputed with SoftImpute.](../../umaps/R_softimpute.png)
![raw_softimpute.png|Raw dataset, imputed with SoftImpute.](../../umaps/raw_softimpute.png)
