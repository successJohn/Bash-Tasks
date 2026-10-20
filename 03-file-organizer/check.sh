#!/usr/bin/env bash
D=$(cd "$(dirname "$0")" && pwd); source "$D/../../lib.sh"; prep "$D" "${1:?usage: check.sh your_script.sh}"
bash "$SCRIPT" messy >/dev/null
expect_file "photo1.jpg in images/" messy/images/photo1.jpg
expect_file "photo2.png in images/" messy/images/photo2.png
expect_file "notes.txt in docs/"   messy/docs/notes.txt
expect_file "report.pdf in docs/"  messy/docs/report.pdf
expect_file "readme.md in docs/"   messy/docs/readme.md
expect_file "song.mp3 in other/"   messy/other/song.mp3
expect_file "archive.zip in other/" messy/other/archive.zip
expect_file "script.sh in other/"  messy/other/script.sh
expect_eq "no loose files left" "$(find messy -maxdepth 1 -type f | wc -l | tr -d ' ')" 0
bash "$SCRIPT" nope >/dev/null 2>&1; [[ $? -ne 0 ]] && ok "missing directory gives an error" || bad "missing directory should fail"
summary
