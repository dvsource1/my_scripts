#!/usr/bin/env bash

declare -a arr

while read -r line;
do
	arr+=("$(echo "$line")")
done < text.txt

for i in "${arr[@]}"
do
	echo "$i"
done
