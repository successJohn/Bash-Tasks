#!/usr/bin/env bash

today=$(date +"%A, %d %B, %Y")
hour=$(date +%H)

if((hour < 12)); then
	greeting="Good morning"

elif ((hour < 18)); then
	greeting="Good afternoon"
else
	greeting="Good evening"
fi

if(( $# == 0)); then
	set -- "World"
fi


for name in "$@"; do
	echo "$greeting, $name! Today is $today."
done


