# Task 6: The Guessing Game
**Concepts:** `while` loops, `read`, `$RANDOM`, regex with `[[ =~ ]]`, `(( ))` comparisons, `break`/`continue`

## Your mission
Write `guess.sh`, a game where the computer picks a number from 1 to 100 and the player guesses it.

```
I'm thinking of a number between 1 and 100.
Your guess: 50
Too high!
Your guess: abc
Please enter a number.
Your guess: 25
Correct! You took 2 guesses.
```

## Rules
- Pick the secret with `$((RANDOM % 100 + 1))`.
- **For testing**, let an environment variable override it: `secret="${SECRET:-...}"`.
- Reject non-numeric input with `Please enter a number.` and do **not** count it as a guess.
- Do not hang forever if input ends (check the exit status of `read`).

## Hints
- `[[ $guess =~ ^[0-9]+$ ]]` tests for digits only.
- Inside `(( ))` you can compare numbers with `<` and `>` directly.

## Check your work
```
bash check.sh ~/path/to/guess.sh
```

## Stretch goals
- Say "1 guess" vs "2 guesses" correctly.
- Limit the player to 7 tries.
