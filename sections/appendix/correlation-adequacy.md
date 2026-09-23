# Correlation adequacy

## Minimally adequate correlations

In this section we present descriptive statistics revolving on the datasets' missingness pattern. As our EFA fundamentally works with the correlation matrix, it is useful to gain an illustration on the computability of pairwise correlations. Many benchmark pairs only have a low $N$, hence making correlation estimates potentially unstable. For the purposes of diagnostics we informally call a pairwise correlation "minimally adequate" when the number of observations are $N \ge 4$. The number 4 is chosen as 3 is the mininum number of observations enforced by our densifier step (and also the minimum for a Pearson correlation to be estimable).

Table 1 provides this illustration through a benchmark perspective. The dataset with the lowest number of benchmarks without adequate correlations is `raw_all_standard`at 312/404 (~79%), indicating our large-scale benchmarks approach is not within the realms of feasibility. One caveat to flag is the relatively high spread of the descriptive statistics, with many standard deviations at least half of the corresponding mean.

**Table 1**. Descriptive data of benchmarks with minimally adequate correlations. $N$ Adeq. = number of benchmarks with minimally adequate correlations. Corrs. = number of minimally adequate correlations.  $\text{N}_\text{avg}$ = mean observations (models) per minimally adequate correlation.

| Dataset            | $N$ | $N$ Adeq. | Mean Corrs. | SD Corrs. | Max Corrs. | Mean $N_\text{avg}$ | SD $N_\text{avg}$ |
| ------------------ | --: | --------: | ----------: | --------: | ---------: | ------------------: | ----------------: |
| raw_all_standard   | 404 |       312 |        61.6 |      62.6 |        229 |                 7.6 |               7.9 |
| raw_all_aggressive | 380 |       301 |       106.6 |      85.2 |        254 |                 4.6 |               2.8 |
| C_all_standard     |  78 |        78 |        47.2 |      13.4 |         77 |                28.6 |              14.0 |
| C_all_aggressive   | 102 |       102 |        78.5 |      17.8 |        101 |                 9.6 |               3.4 |
| R_all_standard     | 298 |       270 |        81.4 |      59.9 |        228 |                 8.8 |               7.2 |
| R_all_aggressive   | 310 |       283 |       130.2 |      76.4 |        254 |                 5.3 |               2.2 |
| S_all_standard     | 124 |       124 |        67.7 |      21.5 |        118 |                20.2 |              11.2 |
| S_all_aggressive   | 293 |       292 |       138.1 |      71.2 |        254 |                 5.8 |               1.6 |

Table 2 provides a similar illustration, but this time through the view of the pairwise correlations. The `raw_all_standard` benchmarks again come out possessing the lowest adequacy, with only 15.3% of computable Pearson correlations are minimally adequate. The C datasets appear to have the greatest number of minimally adequate $r$, but this comes at a cost that the benchmarks are lacking in diversity and narrow in scope, making it highly biased to commonly measured LLM abilities. Like the benchmarks data, the pairwise correlations tend ot have large standard deviations relative to their mean statistics.

**Table 2**. Pairwise correlations: shared $N$ and $|r|$ of adequate correlations (unit = benchmark pair). $N$/pair = shared non-missing models.

| Dataset            |   $N$ | $N$ Adeq. | %Adeq. | Mean $N$/pair | SD $N$/pair | Max $N$/pair | Mean $\lvert r \lvert$ | SD $\lvert r \lvert$ |
| ------------------ | ----: | --------: | -----: | ----------: | --------: | ---------: | ---------------------: | -------------------: |
| raw_all_standard   | 81406 |     12442 |   15.3 |        11.3 |      18.2 |        332 |                 0.5046 |               0.2871 |
| raw_all_aggressive | 72010 |     20261 |   28.1 |         6.2 |       4.8 |        105 |                 0.4662 |               0.2813 |
| C_all_standard     |  3003 |      1840 |   61.3 |        30.2 |      40.9 |        332 |                 0.5393 |               0.2711 |
| C_all_aggressive   |  5151 |      4006 |   77.8 |         9.9 |       9.7 |        105 |                 0.4315 |               0.2641 |
| R_all_standard     | 44253 |     12134 |   27.4 |        10.3 |      10.3 |        109 |                 0.5031 |               0.2872 |
| R_all_aggressive   | 47895 |     20188 |   42.2 |         6.1 |       4.0 |         64 |                 0.4665 |               0.2813 |
| S_all_standard     |  7626 |      4198 |   55.0 |        20.0 |      29.1 |        332 |                 0.4848 |               0.2731 |
| S_all_aggressive   | 42778 |     20230 |   47.3 |         6.1 |       4.2 |         70 |                 0.4661 |               0.2813 |
