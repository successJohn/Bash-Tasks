#!/usr/bin/env bash

if (( $# != 1 )) || [[ ! -f "$1" || ! -r "$1" ]]; then
    echo "Usage: $0 LOGFILE (must be an existing, readable file)" >&2
    exit 1
fi

logfile="$1"

total=$(awk 'END { print NR + 0 }' "$logfile")
errors_404=$(awk '$9 == 404' "$logfile" | wc -l)
errors_500=$(awk '$9 == 500' "$logfile" | wc -l)

echo "Total requests: $total"
echo "404 errors: $errors_404"
echo "500 errors: $errors_500"
echo "Top IPs:"

awk '{ print $1 }' "$logfile" |
    sort |
    uniq -c |
    sort -rn |
    head -3
