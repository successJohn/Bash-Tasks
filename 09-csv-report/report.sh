#!/usr/bin/env bash

if (( $# != 1 )) || [[ ! -f "$1" || ! -r "$1" ]]; then
    echo "Usage: $0 CSVFILE (must be an existing, readable file)" >&2
    exit 1
fi

file="$1"

declare -A total count

highest_name=""
highest_salary=-1

{
    read -r _header

    while IFS=, read -r name dept salary || [[ -n "$name$dept$salary" ]]; do
        # Remove a Windows-style carriage return, if present.
        salary="${salary%$'\r'}"

        # Skip blank lines.
        [[ -z "$name$dept$salary" ]] && continue

        if [[ -z "$dept" || ! $salary =~ ^[0-9]+$ ]]; then
            echo "Error: invalid department or salary for '$name'" >&2
            exit 1
        fi

        salary=$((10#$salary))

        total["$dept"]=$(( ${total["$dept"]:-0} + salary ))
        count["$dept"]=$(( ${count["$dept"]:-0} + 1 ))

        if (( salary > highest_salary )); then
            highest_salary="$salary"
            highest_name="$name"
        fi
    done
} < "$file"

if (( ${#total[@]} > 0 )); then
    while IFS= read -r dept; do
        printf '%s: %s employees, total %s\n' \
            "$dept" "${count["$dept"]}" "${total["$dept"]}"
    done < <(printf '%s\n' "${!total[@]}" | LC_ALL=C sort)

    printf 'Highest paid: %s (%s)\n' "$highest_name" "$highest_salary"
else
    echo "No employee records found."
fi
