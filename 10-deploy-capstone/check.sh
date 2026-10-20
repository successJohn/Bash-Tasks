#!/usr/bin/env bash
D=$(cd "$(dirname "$0")" && pwd); source "$D/../../lib.sh"; prep "$D" "${1:?usage: check.sh your_script.sh}"
bash "$SCRIPT" >/dev/null 2>&1; expect_eq "missing -v exits 2" "$?" 2
bash "$SCRIPT" -v 1.0 -e dev >/dev/null 2>&1; expect_eq "valid deploy exits 0" "$?" 0
expect_file "release copied" releases/1.0/index.html
expect_eq "current symlink points to release" "$(readlink current)" "releases/1.0"
expect_file "deploy.log created" deploy.log
expect_contains "log has start message" "$(cat deploy.log 2>/dev/null)" "Deploy started"
bash "$SCRIPT" -v 2.0 -d >/dev/null 2>&1
expect_no_file "dry run creates nothing" releases/2.0
expect_eq "dry run leaves current alone" "$(readlink current)" "releases/1.0"
bash "$SCRIPT" -v 3.0 -e banana >/dev/null 2>&1; expect_eq "invalid environment exits 3" "$?" 3
bash "$SCRIPT" -v 1.0 >/dev/null 2>&1; [[ $? -ne 0 ]] && ok "refuses to redeploy existing version" || bad "should refuse an existing version"
expect_file "existing release survives the failed redeploy" releases/1.0/index.html
grep -q 'set -euo pipefail' "$SCRIPT" && ok "uses set -euo pipefail" || bad "add: set -euo pipefail"
grep -q 'trap' "$SCRIPT" && ok "uses trap for cleanup" || bad "add a trap for cleanup/rollback"
grep -q 'getopts' "$SCRIPT" && ok "uses getopts" || bad "parse options with getopts"
summary
