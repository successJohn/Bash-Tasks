#!/bin/bash

# exactly three arguments are required

if (( $# != 3 )); then
    echo "Usage: $0 NUM1 OP NUM2" >&2
    exit 2
fi


a="$1"
operator="$2"
b="$3"

case "$operator" in
    +)
        echo "$(( a + b ))"
        ;;
    -)
        echo "$(( a - b ))"
        ;;
    '*')
        echo "$(( a * b ))"
        ;;
    /)
        if (( b == 0 )); then
            echo "Error: division by zero" >&2
            exit 1
        fi
        echo "$(( a / b ))"
        ;;
    *)
        echo "Error: unknown operator '$operator'" >&2
        exit 2
        ;;
esac

