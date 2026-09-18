# Software environment and reproduction

**Languages and dependency management.** Python (managed by `uv`; `pyproject.toml` + `uv.lock`, Python 3.14) for corpus construction, densification, and analysis scripts; R (managed by `renv`; `renv.lock`) for imputation and factor analysis; Julia (project-scoped `Project.toml` / `Manifest.toml`) for OneSidedMC.

**Key packages.** R: `softImpute`, `VIM`, `missForest`, `mice`, `missMDA`, `filling`, `psych`, `Matrix`, `CVXR`, `ggm`, `DBI`/`RSQLite`, `doParallel`/`foreach`. Python: `pandas`, `polars`, `numpy`, `scipy`, `matplotlib`.

**Reproduction.** In the analysis repository:

```bash
make deps && make env                         # system deps + all three environments

python3 scripts/verify_data.py                # corpus integrity
python3 scripts/make_text_only_copy.py        # derive data/text_only/ (Appendix D)

python3 scripts/collapse_results.py --data-root data/text_only   # Appendix F
python3 scripts/densify.py         --data-root data/text_only   # Appendix G

Rscript src/run/impute.R --method <m> --data-root data/text_only \
                         --results-root results/text_only [--raw] [--reimpute]
Rscript src/run/factor.R --method <m> --data-root data/text_only \
                         --results-root results/text_only [--raw] [--loco]

python3 scripts/compare_loadings.py           # Appendix J.6
python3 scripts/sensitivity.py                # Appendix J.5 correlation table + plots
python3 scripts/correlations.py               # omega_h vs imputation R²
```

**Conventions.** Every script resolves paths from its own file location, not the working directory, so any stage runs from anywhere. Imputed matrices are written to `data/<root>/imputed/<method>/<densifier>/<strategy>/`; all other outputs to `results/<root>/<method>/` under flat `<method>_<densifier>_<strategy>_<suffix>` names. Numeric results are persisted to a SQLite store with tables `imputation` (RMSE, $R^2$, chosen hyperparameter), `factoring` (factor count, variance explained, $\omega_t$, $\omega_h$, $\omega_{hs}$, $\Phi$), and `loco` ($\Delta\omega_h$ vectors), keyed by (dataset, method, run).

**Diagnostics.** `scripts/plot_missing.py` and `scripts/miss_corr.py` characterise the missingness itself — per benchmark, how many other benchmarks it has a computable pairwise correlation with (co-observation $\geq 4$ and non-degenerate variance) and the average co-observation count behind those correlations; per benchmark pair, the shared-observation count. Both are computed in closed form via matrix products over the observation mask rather than by looping over pairs.
