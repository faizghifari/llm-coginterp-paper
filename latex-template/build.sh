#!/usr/bin/env bash
# Builds the ICLR-formatted LaTeX from the Obsidian vault's markdown, headlessly.
#
# Mirrors the Obsidian "Enhancing Export" plugin's "ICLR 2027" preset (PDF export,
# textemplate=neurips.tex -> symlinked to iclr2027_pandoc.tex in this directory),
# so the paper can be built from the CLI without opening Obsidian.
#
# Obsidian's %% ... %% editorial comments are stripped first: pandoc's markdown
# reader has no notion of that syntax, so left in place they are parsed as plain
# text and leak into the compiled output verbatim (confirmed by running the
# plugin's own pandoc invocation directly against Main.md unmodified).
#
# Usage: latex-template/build.sh [source.md] [output.tex]
#   defaults: Main.md -> latex-template/Main.tex
#
# The output lands directly in latex-template/, alongside the .sty/.bst/.bib
# files it \usepackage's/\bibliography's -- that's also the directory synced
# to Overleaf via git, and Overleaf needs the main .tex co-located with its
# style dependencies to compile at all. Main.tex (the compiled paper) and its
# deps are therefore tracked in git; only the per-build byproducts (.aux,
# .log, .out, .bbl, .blg, .pdf) are gitignored -- see ../.gitignore.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

SRC="${1:-Main.md}"
OUT="${2:-latex-template/$(basename "${SRC%.md}").tex}"
mkdir -p "$(dirname "$OUT")"

LUA_DIR="$REPO_ROOT/.obsidian/.obsidian/plugins/obsidian-enhancing-export/lua"
if [ ! -d "$LUA_DIR" ]; then
  echo "error: Enhancing Export plugin lua/ dir not found at $LUA_DIR" >&2
  exit 1
fi

STRIPPED="$(mktemp --suffix=.md)"
trap 'rm -f "$STRIPPED"' EXIT

python3 - "$SRC" "$STRIPPED" <<'PY'
import re, sys
src, dst = sys.argv[1], sys.argv[2]
text = open(src, encoding="utf-8").read()
# Obsidian comments: %% ... %%, non-greedy, spans multiple lines/paragraphs.
text = re.sub(r"%%.*?%%", "", text, flags=re.DOTALL)
# collapse the blank-line runs the removal leaves behind
text = re.sub(r"\n{3,}", "\n\n", text)
open(dst, "w", encoding="utf-8").write(text)
PY

pandoc -f markdown+wikilinks_title_after_pipe \
  --resource-path="$REPO_ROOT" \
  --resource-path="$REPO_ROOT/latex-template" \
  --lua-filter="$LUA_DIR/pdf.lua" \
  --template="$REPO_ROOT/latex-template/iclr2027_pandoc.tex" \
  -o "$OUT" \
  -t latex "$STRIPPED"

echo "wrote $OUT"

if command -v pdflatex >/dev/null 2>&1; then
  OUT_DIR="$(dirname "$OUT")"
  # pdflatex needs the .sty/.bst/.bib files alongside the .tex it's compiling.
  # When OUT isn't already inside latex-template/ (e.g. a custom output path),
  # drop copies there instead of relying on TEXINPUTS.
  if [ "$(cd "$OUT_DIR" && pwd)" != "$REPO_ROOT/latex-template" ]; then
    cp -f latex-template/*.sty latex-template/*.bst latex-template/*.bib latex-template/math_commands.tex "$OUT_DIR/" 2>/dev/null || true
  fi
  (
    cd "$OUT_DIR"
    BASE="$(basename "${OUT%.tex}")"
    for _ in 1 2; do
      pdflatex -interaction=nonstopmode -halt-on-error "$BASE.tex" >"$BASE.pdflatex.log" 2>&1 \
        || { echo "pdflatex failed — see $OUT_DIR/$BASE.pdflatex.log" >&2; tail -40 "$BASE.pdflatex.log" >&2; exit 1; }
    done
    rm -f "$BASE.aux" "$BASE.log" "$BASE.out" "$BASE.bbl" "$BASE.blg" "$BASE.pdflatex.log"
    echo "wrote $OUT_DIR/$BASE.pdf"
  )
else
  echo "(no pdflatex found on this machine, so only .tex is produced; install TeX Live to render a PDF)"
fi
