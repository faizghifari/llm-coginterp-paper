#!/usr/bin/env bash
# Write tmp_plots.md with markdown image links of all plots in umaps/,
# sorted by prefix: C, S, R, raw.
cd "$(dirname "$0")"

{
  for f in umaps/C_*.png; do echo "![${f##*/}]($f)"; done
  for f in umaps/S_*.png; do echo "![${f##*/}]($f)"; done
  for f in umaps/R_*.png; do echo "![${f##*/}]($f)"; done
  for f in umaps/raw_*.png; do echo "![${f##*/}]($f)"; done
} > tmp_plots.md
