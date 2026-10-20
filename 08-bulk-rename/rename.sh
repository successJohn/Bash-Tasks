#!/usr/bin/env bash

if (( $# != 2 )); then
    echo "Usage: $0 DIR NEW_PREFIX" >&2
    exit 2
fi

dir="$1"
prefix="$2"

if [[ ! -d "$dir" ]]; then
    echo "Error: directory '$dir' does not exist" >&2
    exit 1
fi

shopt -s nullglob
count=0

for file in "$dir"/IMG_*.JPG; do
    [[ -f "$file" ]] || continue

    filename="${file##*/}"
    middle="${filename#IMG_}"
    middle="${middle%.JPG}"

    new_name="${prefix}_${middle}.jpg"
    destination="$dir/$new_name"

    if ! mv -- "$file" "$destination"; then
        exit 1
    fi

    echo "$filename -> $new_name"
    count=$((count + 1))
done

echo "Renamed $count file(s)"
