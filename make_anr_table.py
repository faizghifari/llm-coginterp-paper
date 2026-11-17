#!/usr/bin/env python3
r"""Format topgnew.csv into the appendix full-g-rankings LaTeX longtable.

Column mapping (topgnew.csv -> appendix table):
    no              -> No
    benchmark       -> Benchmark (underscores escaped)
    resid_rank      -> rho_epsilon   (residualized ANR)
    avg_norm_rank   -> rho           (plain ANR)
    raw_ci95_lo/hi  -> 95% CI        (CI refers to ANR, per appendix caption)
    best            -> Best
    worst           -> Worst
    n_cells         -> N
    Reference       -> looked up from benchmark_citations.csv, kept verbatim
                       (including any dagger)

Output: anr-full.tex
"""

import csv
import sys

TOPGNEW = "topgnew.csv"
CITATIONS = "benchmark_citations.csv"
OUT = "anr-full.tex"

# Exact preamble/header/tail as in sections/appendix/full-g-rankings.md.
# @COUNT@ is replaced with the number of data rows.
HEADER = r"""\begingroup\normalsize\setlength{\tabcolsep}{3pt}
\begin{longtable}{@{}r>{\raggedright\arraybackslash}p{0.21\textwidth}rrlrrr>{\raggedright\arraybackslash}p{0.25\textwidth}@{}}
\caption{All used @COUNT@ benchmarks, sorted by their average normalized rank order (ANR) of their $g$ factor loadings, residualized (RANR) against their frequency. The normalized rank order ranges from 0 to 1. 0 = ranked first, 1 = ranked last. $N$ cells = number of EFA solutions with that benchmark. CI and Best/Worst refers to ANR. Leading zeros are omitted. Reference is the paper introducing the benchmark; $^\dagger$ marks benchmarks without one, cited by the source of their scores.}\label{tab:full-g-rankings}\\
\toprule
No & Benchmark & $\rho_\epsilon$ & $\rho$ & 95\% CI & Best & Worst & $N$ & Reference \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
No & Benchmark & $\rho_\epsilon$ & $\rho$ & 95\% CI & Best & Worst & $N$ & Reference \\
\midrule
\endhead
\bottomrule
\endlastfoot
"""

FOOTER = r"""\end{longtable}
\endgroup
"""


def fmt(v):
    """3 decimals, leading zero omitted: -0.312 -> -.312, 0.186 -> .186."""
    s = f"{float(v):.3f}"
    if s.startswith("-0."):
        return "-" + s[2:]
    if s.startswith("0."):
        return s[1:]
    return s


def escape_bench(name):
    return name.replace("_", "\\_")


def norm(name):
    """Key for citation lookup: ignore LaTeX escaping of underscores."""
    return name.replace("\\", "").strip()


def main():
    with open(CITATIONS, newline="") as f:
        cite = {norm(r[0]): r[1].strip() for r in csv.reader(f)}

    rows = []
    with open(TOPGNEW, newline="") as f:
        for r in csv.DictReader(f):
            bench = r["benchmark"].strip()
            key = norm(bench)
            if key not in cite:
                sys.exit(f"error: no citation for benchmark {bench!r}")
            ref = cite[key]
            ci = f"[{fmt(r['raw_ci95_lo'])}, {fmt(r['raw_ci95_hi'])}]"
            row = " & ".join([
                r["no"].strip(),
                escape_bench(bench),
                fmt(r["resid_rank"]),
                fmt(r["avg_norm_rank"]),
                ci,
                fmt(r["best"]),
                fmt(r["worst"]),
                r["n_cells"].strip(),
                ref,
            ]) + " \\\\"
            rows.append(row)

    with open(OUT, "w") as f:
        f.write(HEADER.replace("@COUNT@", str(len(rows))))
        f.write("\n".join(rows) + "\n")
        f.write(FOOTER)

    print(f"wrote {OUT}: {len(rows)} rows")


if __name__ == "__main__":
    main()
