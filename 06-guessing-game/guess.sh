#!/usr/bin/env bash

secret="${SECRET:-$((RANDOM % 100 + 1))}"
attempts=0

echo "I'm thinking of a number between 1 and 100."

while true; do
    printf "Your guess: "

    if ! read -r guess; then
        echo
        echo "Input ended. Goodbye!"
        exit 1
    fi

    if [[ ! $guess =~ ^[0-9]+$ ]]; then
        echo "Please enter a number."
        continue
    fi

    # Remove leading zeros so Bash treats the value as decimal.
    while [[ ${#guess} -gt 1 && $guess == 0* ]]; do
        guess="${guess#0}"
    done

    # Check the range before arithmetic to avoid oversized numbers.
    if (( ${#guess} > 3 )) || (( 10#$guess < 1 || 10#$guess > 100 )); then
        echo "Please enter a number between 1 and 100."
        continue
    fi

    guess=$((10#$guess))
    attempts=$((attempts + 1))

    if (( guess < secret )); then
        echo "Too low!"
    elif (( guess > secret )); then
        echo "Too high!"
    else
        echo "Correct! You took $attempts guesses."
        break
    fi
done
