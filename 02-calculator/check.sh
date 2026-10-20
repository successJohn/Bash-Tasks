#!/usr/bin/env bash
D=$(cd "$(dirname "$0")" && pwd); source "$D/../../lib.sh"; prep "$D" "${1:?usage: check.sh your_script.sh}"
expect_eq "10 + 5"  "$(bash "$SCRIPT" 10 + 5)" 15
expect_eq "10 - 4"  "$(bash "$SCRIPT" 10 - 4)" 6
expect_eq "6 * 7"   "$(bash "$SCRIPT" 6 '*' 7)" 42
expect_eq "20 / 4"  "$(bash "$SCRIPT" 20 / 4)" 5
out=$(bash "$SCRIPT" 5 / 0 2>&1); code=$?
expect_eq "divide by zero exits 1" "$code" 1
expect_contains "divide by zero message" "$out" "division by zero"
bash "$SCRIPT" >/dev/null 2>&1; expect_eq "no arguments exits 2" "$?" 2
bash "$SCRIPT" 4 % 2 >/dev/null 2>&1; expect_eq "unknown operator exits 2" "$?" 2
summary
