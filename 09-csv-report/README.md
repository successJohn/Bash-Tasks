# Task 9: CSV Report
**Concepts:** `while read` loops, `IFS`, associative arrays (`declare -A`), arithmetic, sorting keys

> Needs **Bash 4+**. macOS ships Bash 3.2, so run `brew install bash` there.

## Setup
```
bash setup.sh      # creates employees.csv
```
```
name,department,salary
Ada,Engineering,100000
Linus,Engineering,90000
...
```

## Your mission
Write `report.sh CSVFILE` that skips the header row and prints, per department (alphabetical), the headcount and total salary, then the highest paid person:

```
Engineering: 3 employees, total 270000
HR: 1 employees, total 70000
Sales: 2 employees, total 110000
Highest paid: Ada (100000)
```

## Rules
- Read the file with `while IFS=, read -r name dept salary`.
- Keep totals in an **associative array**: `declare -A total count`.
- Exit with a usage message if the file does not exist.

## Hints
- Wrap the loop in `{ read -r _header; while ...; done; } < "$file"` to skip the first line.
- `${!total[@]}` lists the array's keys; pipe through `sort`.
- `${total[$dept]:-0}` gives 0 when the key is new.

## Check your work
```
bash check.sh ~/path/to/report.sh
```

## Stretch goals
- Add the average salary per department.
- Output the result as a new CSV file.
