#!/usr/bin/env bash
D=$(cd "$(dirname "$0")" && pwd); source "$D/../../lib.sh"; prep "$D" "${1:?usage: check.sh your_script.sh}"
bash "$SCRIPT" report.txt >/dev/null 2>&1
expect_file "creates report.txt" report.txt
r=$(cat report.txt 2>/dev/null)
expect_contains "has Hostname" "$r" "Hostname:"
expect_contains "has Disk usage section" "$r" "Disk usage"
expect_contains "has Memory section" "$r" "Memory"
expect_contains "has Load average section" "$r" "Load average"
n=$(grep -cE '^[[:space:]]*(function[[:space:]]+)?[A-Za-z_][A-Za-z0-9_]*[[:space:]]*\(\)' "$SCRIPT")
[[ $n -ge 3 ]] && ok "defines at least 3 functions ($n found)" || bad "define at least 3 functions (found $n)"
summary
