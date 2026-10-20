#!/usr/bin/env bash
D=$(cd "$(dirname "$0")" && pwd); source "$D/../../lib.sh"; prep "$D" "${1:?usage: check.sh your_script.sh}"
head -1 "$SCRIPT" | grep -q '^#!' && ok "has a shebang line" || bad "missing shebang (#!/usr/bin/env bash)"
out=$(bash "$SCRIPT" Ada);        expect_contains "greets a name" "$out" "Hello, Ada!"
out=$(bash "$SCRIPT");            expect_contains "defaults to World" "$out" "Hello, World!"
out=$(bash "$SCRIPT" "Mary Jane"); expect_contains "handles a quoted two-word name" "$out" "Hello, Mary Jane!"
expect_contains "prints the date" "$out" "Today is"
summary
