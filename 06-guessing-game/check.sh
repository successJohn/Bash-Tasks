#!/usr/bin/env bash
D=$(cd "$(dirname "$0")" && pwd); source "$D/../../lib.sh"; prep "$D" "${1:?usage: check.sh your_script.sh}"
out=$(printf '10\n90\n42\n' | SECRET=42 timeout 5 bash "$SCRIPT" 2>&1)
expect_contains "says Too low" "$out" "Too low"
expect_contains "says Too high" "$out" "Too high"
expect_contains "says Correct" "$out" "Correct"
expect_contains "counts guesses" "$out" "3 guess"
out=$(printf 'abc\n42\n' | SECRET=42 timeout 5 bash "$SCRIPT" 2>&1)
expect_contains "rejects non-numbers" "$out" "Please enter a number"
expect_contains "invalid input is not counted" "$out" "took 1 guess"
printf '5\n' | SECRET=42 timeout 5 bash "$SCRIPT" >/dev/null 2>&1; code=$?
[[ $code -ne 124 ]] && ok "does not hang when input ends" || bad "script hangs when input runs out"
grep -q 'RANDOM' "$SCRIPT" && ok "uses \$RANDOM" || bad "should use \$RANDOM for the secret"
summary
