# Task 5: The Log Analyzer
**Concepts:** pipes, `wc`, `awk`, `sort`, `uniq -c`, `head`, command substitution

## Setup
```
bash setup.sh      # creates access.log (a web server log)
```
Each line looks like:
```
10.0.0.1 - - [10/Oct/2026:13:55:01 +0000] "GET /index.html HTTP/1.1" 200 1024
```
Field 1 is the IP address and field 9 is the HTTP status code.

## Your mission
Write `analyze.sh LOGFILE` that prints exactly this style of report:
```
Total requests: 11
404 errors: 3
500 errors: 2
Top IPs:
      5 10.0.0.1
      3 10.0.0.2
      2 10.0.0.3
```
Exit with an error and a usage message if the file does not exist.

## Hints
- `awk '$9==404' file` prints lines whose 9th field is 404.
- The classic "top N" recipe: `sort | uniq -c | sort -rn | head -N`.

## Check your work
```
bash check.sh ~/path/to/analyze.sh
```

## Stretch goals
- Show the 3 most requested URLs (field 7).
- Accept a status code as the second argument and count that instead.
