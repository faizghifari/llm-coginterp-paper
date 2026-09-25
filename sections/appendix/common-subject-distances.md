# Common-Subject UMAP Plots {#common-subject-distances}

This section presents the UMAP plots for the benchmarks' composite distance, with each figure showing the plots of one imputation method. Each plot are composited over the `all_standard` and `all_aggressive` deduplication strategies. The aggregate plots are composited over all deduplication strategies and all imputation methods. Since the R and raw datasets only have 1 valid imputation each, they do not have a dedicated aggregate figure. This section have 16 figures in total.

Notably, through the different imputation strategies, all of visualizations have the same pattern that shared-domain benchmarks tend are likely to be dispersed across the vector space. Highlighting the same benchmarks as in the results (with some benchmarks discarded by each densifiers), we see the same pattern that, for eample, `aime25` and `gsm8k` are distanced quite far from each other. Through most of the different possible solutions, our core claim that same-domain clustering are not guaranteed to cluster together is robust.


![C_aggregate.png|C dataset, aggregated across 7 imputations](../../umaps/C_aggregate.png)
![C_default.png|C dataset, imputed with fill-mean](../../umaps/C_default.png)
![C_knn.png|C dataset, imputed with knn](../../umaps/C_knn.png)
![C_missforest.png|C dataset, imputed with missforest](../../umaps/C_missforest.png)
![C_onesidedmc.png|C dataset, imputed with onesidedmc](../../umaps/C_onesidedmc.png)
![C_softimpute.png|C dataset, imputed with softimpute](../../umaps/C_softimpute.png)
![C_softimpute_corr.png|C dataset, imputed with softimputed (correlations)](../../umaps/C_softimpute_corr.png)
![C_zeros.png|C dataset, imputed with fill-zeros](../../umaps/C_zeros.png)

![S_aggregate.png|S dataset, aggregated across 5 imputations](../../umaps/S_aggregate.png)
![S_knn.png|S dataset, imputed with knn](../../umaps/S_knn.png)
![S_missforest.png|S dataset, imputed with missforest](../../umaps/S_missforest.png)
![S_onesidedmc.png|S dataset, imputed with onesidedmc](../../umaps/S_onesidedmc.png)
![S_softimpute.png|S dataset, imputed with softimpute](../../umaps/S_softimpute.png)
![S_softimpute_corr.png|S dataset, imputed with softimpute (correlations)](../../umaps/S_softimpute_corr.png)

![R_softimpute.png|R dataset, imputed with softimpute](../../umaps/R_softimpute.png)
![raw_softimpute.png|Raw dataset, imputed with softimpute](../../umaps/raw_softimpute.png)
