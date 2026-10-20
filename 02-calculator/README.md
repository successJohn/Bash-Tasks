# Task 2: Command-Line Calculator
**Concepts:** arithmetic `$(( ))`, `case`, `if`, exit codes, `$#`, writing errors to stderr (`>&2`)

## Your mission
Write `calc.sh NUM1 OP NUM2` supporting `+ - * /`.

```
$ ./calc.sh 10 + 5
15
$ ./calc.sh 6 '*' 7
42
```

## Rules
- Wrong number of arguments: print a usage message to **stderr**, exit code **2**.
- Division by zero: print `Error: division by zero` to stderr, exit code **1**.
- Unknown operator: print an error, exit code **2**.

## Hints
- Quote `*` on the command line or the shell will expand it into filenames.
- `echo $?` shows the exit code of the last command.

## Check your work
```
bash check.sh ~/path/to/calc.sh
```

## Stretch goals
- Support `%` (modulo) and `**` (power).
- Validate that both numbers are integers with `[[ $a =~ ^-?[0-9]+$ ]]`.
