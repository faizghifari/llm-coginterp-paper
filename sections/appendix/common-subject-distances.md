# Common-Subject UMAP Plots {#common-subject-distances}

This section presents the UMAP plots for the benchmarks' composite distance, with each figure showing the plots of one imputation method. Each plot is shown for one collapse strategy. The aggregate plot is composited over all collapse strategies and all imputation methods. This section has 8 figures in total.

Notably, through the different imputation strategies, all of the visualizations show the same pattern, in which shared-domain benchmarks tend to be dispersed across the vector space. Highlighting the same benchmarks as in the results (with some benchmarks discarded by each densifier), we see the same pattern that, for example, `aime25` and `gsm8k` are distanced quite far from each other. Through most of the different possible solutions, our core claim that same-domain benchmarks are not guaranteed to cluster together is robust.


![C_aggregate.png|C dataset, aggregated across imputations.](../../umaps_new/0_C_aggregate.png)
![C_standard_mknn.png|C dataset, standard collapse, k-NN ($wR^2 = 0.442$).](../../umaps_new/0_C_standard_mknn.png)
![C_standard_mmissforest.png|C dataset, standard collapse, missForest ($wR^2 = 0.566$).](../../umaps_new/0_C_standard_mmissforest.png)
![C_standard_msoftimpute.png|C dataset, standard collapse, SoftImpute ($wR^2 = 0.586$).](../../umaps_new/0_C_standard_msoftimpute.png)

![S_standard_mmissforest.png|S dataset, standard collapse, missForest ($wR^2 = 0.455$).](../../umaps_new/0_S_standard_mmissforest.png)
![S_standard_msoftimpute.png|S dataset, standard collapse, SoftImpute ($wR^2 = 0.428$).](../../umaps_new/0_S_standard_msoftimpute.png)

![R_aggressive.png|R dataset, aggressive collapse.](../../umaps_new/0_R_aggressive.png)
![R_aggressive_msoftimpute.png|R dataset, aggressive collapse, SoftImpute ($wR^2 = 0.441$).](../../umaps_new/0_R_aggressive_msoftimpute.png)
