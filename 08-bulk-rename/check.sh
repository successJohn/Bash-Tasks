#!/usr/bin/env bash
D=$(cd "$(dirname "$0")" && pwd); source "$D/../../lib.sh"; prep "$D" "${1:?usage: check.sh your_script.sh}"
bash "$SCRIPT" >/dev/null 2>&1; expect_eq "no arguments exits 2" "$?" 2
out=$(bash "$SCRIPT" photos vacation)
expect_file "vacation_0001.jpg" photos/vacation_0001.jpg
expect_file "vacation_0002.jpg" photos/vacation_0002.jpg
expect_file "vacation_0003.jpg" photos/vacation_0003.jpg
expect_file "handles spaces in filenames" "photos/vacation_0004 final.jpg"
expect_no_file "old IMG_0001.JPG is gone" photos/IMG_0001.JPG
expect_file "notes.txt is untouched" photos/notes.txt
expect_contains "reports the count" "$out" "Renamed 4 file(s)"
bash "$SCRIPT" photos vacation >/dev/null 2>&1; expect_eq "second run does nothing harmful" "$?" 0
summary
