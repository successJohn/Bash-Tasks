# Task 1: Hello Script
**Concepts:** shebang, `chmod +x`, variables, positional parameters (`$1`), default values, command substitution

## Your mission
Write `hello.sh` that greets the person named in the first argument. With no argument it greets `World`.
It must also print today's date.

```
$ ./hello.sh Ada
Hello, Ada! Today is Friday, 09 October 2026.
$ ./hello.sh
Hello, World! Today is Friday, 09 October 2026.
```

## Steps
1. Create `hello.sh` and start it with `#!/usr/bin/env bash`.
2. Store the name in a variable using a default: `name="${1:-World}"`.
3. Use `$(date +"%A, %d %B %Y")` to get the date.
4. Make it executable: `chmod +x hello.sh`, then run `./hello.sh Ada`.

## Check your work
```
bash check.sh ~/path/to/hello.sh
```

## Stretch goals
- Greet with "Good morning/afternoon/evening" based on `date +%H`.
- Greet several names given as separate arguments (`"$@"`).
