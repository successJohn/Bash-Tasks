#!/usr/bin/env bash

usage() {
    echo "Usage: $0 SOURCE_DIR DEST_DIR" >&2
}

if (( $# != 2 )); then
    usage
    exit 2
fi

source_dir="$1"
dest_dir="$2"

if [[ ! -d "$source_dir" ]]; then
    echo "Error: source directory '$source_dir' does not exist" >&2
    exit 1
fi

mkdir -p -- "$dest_dir" || exit 1

# Resolve full paths before creating the archive.
source_dir=$(cd -- "$source_dir" && pwd -P) || exit 1
dest_dir=$(cd -- "$dest_dir" && pwd -P) || exit 1

# Keep backups outside the source so they do not back up themselves.
if [[ "$source_dir" == "/" ||
      "$dest_dir" == "$source_dir" ||
      "$dest_dir" == "$source_dir/"* ]]; then
    echo "Error: destination must be outside the source directory" >&2
    exit 1
fi

timestamp=$(date +%Y-%m-%d_%H%M%S)
archive="$dest_dir/backup_$timestamp.tar.gz"

if ! tar -czf "$archive" \
    -C "$(dirname -- "$source_dir")" \
    -- "$(basename -- "$source_dir")"; then
    rm -f -- "$archive"
    exit 1
fi

echo "Created $archive"

# Match backup archives only; safely handle spaces in destination paths.
shopt -s nullglob
backups=("$dest_dir"/backup_????-??-??_??????.tar.gz)

if (( ${#backups[@]} > 3 )); then
    mapfile -t sorted_backups < <(
        printf '%s\n' "${backups[@]}" | LC_ALL=C sort -r
    )

    for old_backup in "${sorted_backups[@]:3}"; do
        rm -- "$old_backup" || exit 1
    done
fi
