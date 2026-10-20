#!/usr/bin/env bash
D=$(cd "$(dirname "$0")" && pwd); source "$D/../../lib.sh"; prep "$D" "${1:?usage: check.sh your_script.sh}"
bash "$SCRIPT" >/dev/null 2>&1; expect_eq "no arguments exits 2" "$?" 2
bash "$SCRIPT" nothere out >/dev/null 2>&1; [[ $? -ne 0 ]] && ok "missing source fails" || bad "missing source should fail"
bash "$SCRIPT" project backups >/dev/null
expect_eq "creates one archive" "$(ls backups/backup_*.tar.gz 2>/dev/null | wc -l | tr -d ' ')" 1
tar -tzf backups/backup_*.tar.gz | grep -q 'project/sub/data.txt' && ok "archive contains nested files" || bad "archive is missing project/sub/data.txt"
echo "(running 4 more backups, please wait...)"
for i in 1 2 3 4; do sleep 1.1; bash "$SCRIPT" project backups >/dev/null; done
expect_eq "keeps only the newest 3 backups" "$(ls backups/backup_*.tar.gz | wc -l | tr -d ' ')" 3
summary
