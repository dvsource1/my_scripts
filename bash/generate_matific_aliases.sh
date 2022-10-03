#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/matific/.matific_config"
ALIAS_FILE="$HOME/.config/matific/.matific_aliases"

prefix=${1:-fm}
echo "$prefix"

# clear alias file
> "$ALIAS_FILE"

## FUNCTIONS

write_to_file() {
	local text="$1"
	echo -e "${text}" | tee -a "$ALIAS_FILE"
}

# generate alias function
get_alias_function() {
	write_to_file "${prefix}${2}() {\n\techo \"$> ${1}\"\n\t${1}\n}\n"
}

# Read .matific_config file
# readarray -t commands < "$CONFIG_FILE"
# mapfile -t commands < "$CONFIG_FILE"

declare -a commands

while read -r command;
do
	commands+=("$(echo "$command")")
done < "$CONFIG_FILE"

# print commands
write_to_file "${prefix}print() {"
for i in "${!commands[@]}"
do
	# echo $line
	write_to_file "\techo \"${prefix}${i}: ${commands[$i]}\";"
done
write_to_file "}\n"

# print alias functions
for i in "${!commands[@]}"
do
	get_alias_function "${commands[$i]}" "${i}"
done

# source bash config
source ~/.bashrc
