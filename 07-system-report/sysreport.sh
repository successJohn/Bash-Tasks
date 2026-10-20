#!/usr/bin/env bash

report="${1:-report.txt}"

system_section() {
    echo "== System =="
    echo "Hostname: $(hostname)"
    echo "Date: $(date)"
    echo "Uptime: $(uptime -p)"
    echo
}

disk_section() {
    echo "== Disk usage =="
    df -h / | awk 'NR == 2 {
        printf "Used %s of %s (%s)\n", $3, $2, $5
    }'
    echo
}

memory_section() {
    echo "== Memory =="
    free -m | awk '/^Mem:/ {
        printf "Used %sMB of %sMB\n", $3, $2
    }'
    echo
}

load_section() {
    echo "== Load average =="
    awk '{ print $1, $2, $3 }' /proc/loadavg
}

if {
    system_section
    disk_section
    memory_section
    load_section
} > "$report"; then
    echo "Report written to $report"
else
    echo "Error: could not write report to '$report'" >&2
    exit 1
fi
