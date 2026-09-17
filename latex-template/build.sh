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
# Before that, Obsidian's ![[Note]] embed syntax is resolved by recursively
# inlining the referenced file's content, vault-root-relative (same resolution
# rule as the plain [[Note#Heading|text]] links elsewhere in the paper). This
# lets the paper be split into one file per section (see sections/) so multiple
# people can edit concurrently, while pandoc still only ever sees one flattened
# markdown string -- Obsidian itself renders the same embeds inline too, so the
# split is also visible when browsing the vault directly.
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

python3 - "$SRC" "$STRIPPED" "$REPO_ROOT" <<'PY'
import re, sys, os, shutil
src, dst, repo_root = sys.argv[1], sys.argv[2], sys.argv[3]

# Obsidian embed: a line containing only "![[target]]" (optionally "#heading"
# or "|display", which we don't support resolving into a sub-section -- whole
# files only). Resolved vault-root-relative, same as Obsidian itself does.
EMBED_RE = re.compile(r'^!\[\[([^\]\n]+?)\]\][ \t]*$', re.MULTILINE)

def resolve(target, base_dir):
    target = target.split('#', 1)[0].split('|', 1)[0].strip()
    # Non-markdown embeds (images) are referenced with their exact filename;
    # everything else is a note, so the .md extension is implicit.
    cands = [target] if os.path.splitext(target)[1] else [target + ".md"]
    for cand in cands:
        for base in (base_dir, repo_root):
            p = os.path.normpath(os.path.join(base, cand))
            if os.path.isfile(p):
                return p
    return None

out_dir = os.path.dirname(os.path.abspath(dst))

def expand(path, visited):
    path = os.path.normpath(path)
    if path in visited:
        sys.exit(f"error: circular ![[embed]] detected involving {path}")
    visited = visited | {path}
    text = open(path, encoding="utf-8").read()
    base_dir = os.path.dirname(path)
    def repl(m):
        target = m.group(1)
        resolved = resolve(target, base_dir)
        if resolved is None:
            sys.stderr.write(f"warning: could not resolve embed ![[{target}]] referenced from {path}\n")
            return m.group(0)
        if not resolved.endswith(".md"):
            # Images (etc.) are not inlined -- they're copied next to the
            # output .tex (and into latex-template/, which is what Overleaf
            # syncs) so the bare filename pandoc emits is resolvable by
            # pdflatex at compile time.
            name = os.path.basename(resolved)
            for dest_dir in dict.fromkeys([os.path.join(repo_root, "latex-template"), out_dir]):
                shutil.copy2(resolved, os.path.join(dest_dir, name))
            # Preserve any "|caption" part of the embed so pandoc turns it
            # into the figure caption instead of using the filename.
            caption = target.split("|", 1)[1].strip() if "|" in target else None
            return f"![[{name}|{caption}]]" if caption else f"![[{name}]]"
        return expand(resolved, visited)
    return EMBED_RE.sub(repl, text)

text = expand(src, set())
# Obsidian comments: %% ... %%, non-greedy, spans multiple lines/paragraphs.
text = re.sub(r"%%.*?%%", "", text, flags=re.DOTALL)
# collapse the blank-line runs the removal leaves behind
text = re.sub(r"\n{3,}", "\n\n", text)
open(dst, "w", encoding="utf-8").write(text)
PY

# Tables wider than pandoc's --columns would get fixed p{...} column widths
# derived from the separator-row dash counts (padded with dead space); a large
# value keeps them as plain l-columns that size to their actual cell contents.
pandoc -f markdown+wikilinks_title_after_pipe \
  --columns=200 \
  --resource-path="$REPO_ROOT" \
  --resource-path="$REPO_ROOT/latex-template" \
  --lua-filter="$LUA_DIR/pdf.lua" \
  --template="$REPO_ROOT/latex-template/iclr2027_pandoc.tex" \
  -o "$OUT" \
  -t latex "$STRIPPED"

echo "wrote $OUT"

# Word count as a reader would see it: convert to plain text first so markdown
# syntax (links, math markup, emphasis) doesn't inflate the count. The
# markdown contains no references section -- those are generated by natbib
# from the .bib at LaTeX time -- so this count already excludes them.
WORDS="$(pandoc -f markdown+wikilinks_title_after_pipe -t plain "$STRIPPED" | wc -w)"
echo "word count (excl. references): $WORDS"

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
    # First pass emits the .aux with \citation/\bibdata commands for bibtex to
    # read; only then can the two follow-up passes resolve \cite references
    # and settle cross-references/page numbers. Skipped if bibtex isn't
    # installed -- the two-pass loop below still runs so a .tex-only or
    # no-bibtex environment still gets a PDF, just with unresolved [?] cites.
    if command -v bibtex >/dev/null 2>&1; then
      pdflatex -interaction=nonstopmode -halt-on-error "$BASE.tex" >"$BASE.pdflatex.log" 2>&1 \
        || { echo "pdflatex failed — see $OUT_DIR/$BASE.pdflatex.log" >&2; tail -40 "$BASE.pdflatex.log" >&2; exit 1; }
      bibtex "$BASE" >"$BASE.bibtex.log" 2>&1 \
        || { echo "bibtex failed — see $OUT_DIR/$BASE.bibtex.log" >&2; tail -40 "$BASE.bibtex.log" >&2; exit 1; }
    else
      echo "(no bibtex found on this machine, so citations will render as [?] in the PDF)"
    fi
    for _ in 1 2; do
      pdflatex -interaction=nonstopmode -halt-on-error "$BASE.tex" >"$BASE.pdflatex.log" 2>&1 \
        || { echo "pdflatex failed — see $OUT_DIR/$BASE.pdflatex.log" >&2; tail -40 "$BASE.pdflatex.log" >&2; exit 1; }
    done
    rm -f "$BASE.aux" "$BASE.log" "$BASE.out" "$BASE.bbl" "$BASE.blg" "$BASE.pdflatex.log" "$BASE.bibtex.log"
    echo "wrote $OUT_DIR/$BASE.pdf"
  )
else
  echo "(no pdflatex found on this machine, so only .tex is produced; install TeX Live to render a PDF)"
fi
