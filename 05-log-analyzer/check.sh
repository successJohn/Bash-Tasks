#!/usr/bin/env bash
D=$(cd "$(dirname "$0")" && pwd); source "$D/../../lib.sh"; prep "$D" "${1:?usage: check.sh your_script.sh}"
out=$(bash "$SCRIPT" access.log)
expect_contains "total requests" "$out" "Total requests: 11"
expect_contains "404 count" "$out" "404 errors: 3"
expect_contains "500 count" "$out" "500 errors: 2"
echo "$out" | grep -Eq '^ *5 +10\.0\.0\.1$' && ok "top IP is 10.0.0.1 with 5" || bad "expected '5 10.0.0.1' in Top IPs"
echo "$out" | grep -Eq '^ *2 +10\.0\.0\.3$' && ok "third IP is 10.0.0.3 with 2" || bad "expected '2 10.0.0.3' in Top IPs"
echo "$out" | grep -q '10\.0\.0\.4' && bad "only the top 3 IPs should be listed" || ok "lists only the top 3 IPs"
bash "$SCRIPT" nofile.log >/dev/null 2>&1; [[ $? -ne 0 ]] && ok "missing file gives an error" || bad "missing file should fail"
summary
