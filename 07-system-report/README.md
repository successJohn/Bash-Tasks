# Task 7: System Health Report
**Concepts:** functions, output redirection (`>`), command grouping `{ ...; }`, `df`, `free`, `uptime`, `awk`

## Your mission
Write `sysreport.sh [OUTPUT_FILE]` (default `report.txt`) that writes a report with these sections:

```
== System ==
Hostname: myserver
Date: Fri Oct  9 10:00:00 WAT 2026
Uptime: up 3 hours, 12 minutes

== Disk usage ==
Used 12G of 50G (24%)

== Memory ==
Used 2048MB of 7900MB

== Load average ==
0.15 0.10 0.05
```

## Rules
- Each section must be produced by its **own function** (at least 3 functions).
- Send everything to the file at once with `{ func1; func2; } > "$report"`.
- Print `Report written to <file>` when done.

## Hints
- `df -h /` shows the root disk; `awk` can pick columns 2, 3 and 5.
- `free -m` shows memory in MB; the line starting with `Mem:` is what you want.
- Load average lives in `/proc/loadavg`.

## Check your work
```
bash check.sh ~/path/to/sysreport.sh
```
(Needs Linux or WSL.)

## Stretch goals
- Print `WARNING` when disk use is above 80%.
- List the top 3 processes by memory with `ps aux --sort=-%mem | head -4`.
