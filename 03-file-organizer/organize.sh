#!/bin/bash

dir="${1:-messy}"

if [[ ! -d "$dir" ]]; then
    echo "Error: directory '$dir' does not exist" >&2
    exit 1
fi

for f in "$dir"/*; do
    # Skip directories and anything that is not a regular file.
    [[ -f "$f" ]] || continue

    ext="${f##*.}"
    ext="${ext,,}"

    case "$ext" in
        jpg|jpeg|png|gif)
            folder="images"
            ;;
        txt|pdf|md|docx)
            folder="docs"
            ;;
        *)
            folder="other"
            ;;
    esac

    mkdir -p -- "$dir/$folder" || exit 1
    mv -- "$f" "$dir/$folder/" || exit 1

    echo "Moved ${f##*/} -> $folder/"
done
