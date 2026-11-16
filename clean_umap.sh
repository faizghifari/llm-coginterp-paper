#!/usr/bin/env bash
# clean_umap.sh — deduplicate single-solution aggregates and strip the pa_s_ infix
# from plot filenames in a directory (default: cwd).
#
# Steps:
#   1. md5sum every .png in the directory.
#   2. Delete any *aggregate* file whose checksum is identical to a
#      non-aggregate file (single available solution, so aggregation
#      produced a duplicate).
#   3. If duplicate checksums remain among non-aggregates (e.g. standard.png
#      byte-identical to standard_msoftimpute.png), keep only
#      standard_msoftimpute.png from that group.
#   4. Rename remaining files, removing the "pa_s_" infix.

set -euo pipefail

dir="${1:-.}"
cd "$dir"

mapfile -t files < <(ls -1 *.png 2>/dev/null || true)
if [ "${#files[@]}" -eq 0 ]; then
    echo "no .png files in $(pwd)"
    exit 0
fi

# checksum every file: "<hash> <name>"
sums=$(md5sum "${files[@]}")

# --- step 2: remove aggregates that duplicate a non-aggregate ---
for f in "${files[@]}"; do
    case "$f" in
        *aggregate*) ;;
        *) continue ;;
    esac
    h=$(md5sum "$f" | cut -d' ' -f1)
    if echo "$sums" | grep -v aggregate | grep -q "^$h"; then
        echo "removing duplicate aggregate: $f"
        rm -- "$f"
    fi
done

# --- step 3: collapse remaining duplicate groups ---
mapfile -t remaining < <(ls -1 *.png 2>/dev/null || true)
if [ "${#remaining[@]}" -gt 0 ]; then
    sums=$(md5sum "${remaining[@]}")
    dup_hashes=$(echo "$sums" | cut -d' ' -f1 | sort | uniq -d)
    for h in $dup_hashes; do
        group=$(echo "$sums" | grep "^$h" | cut -d' ' -f3- | sort)
        keep=""
        for f in $group; do
            [ "$f" = "standard_msoftimpute.png" ] && keep=$f
        done
        [ -z "$keep" ] && keep=$(echo "$group" | head -n 1)
        for f in $group; do
            if [ "$f" != "$keep" ]; then
                echo "removing duplicate (hash $h): $f (keeping $keep)"
                rm -- "$f"
            fi
        done
    done
fi

# --- step 4: strip pa_s_ infix ---
for f in *.png; do
    case "$f" in
        *pa_s_*)
            mv -- "$f" "${f/pa_s_/}"
            ;;
    esac
done

echo "done: $(pwd)"
