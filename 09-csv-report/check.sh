#!/usr/bin/env bash
D=$(cd "$(dirname "$0")" && pwd); source "$D/../../lib.sh"; prep "$D" "${1:?usage: check.sh your_script.sh}"
out=$(bash "$SCRIPT" employees.csv)
expect_contains "Engineering line" "$out" "Engineering: 3 employees, total 270000"
expect_contains "HR line" "$out" "HR: 1 employees, total 70000"
expect_contains "Sales line" "$out" "Sales: 2 employees, total 110000"
expect_contains "highest paid" "$out" "Highest paid: Ada (100000)"
first=$(echo "$out" | head -1)
expect_contains "departments sorted alphabetically" "$first" "Engineering"
grep -q 'declare -A' "$SCRIPT" && ok "uses an associative array" || bad "use an associative array (declare -A)"
bash "$SCRIPT" nofile.csv >/dev/null 2>&1; [[ $? -ne 0 ]] && ok "missing file gives an error" || bad "missing file should fail"
summary
