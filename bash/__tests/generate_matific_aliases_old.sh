#!/usr/bin/env bash

CONFIG_FILE="$HOME/.config/matific/.matific_config"
ALIAS_FILE="$HOME/.config/matific/.matific_aliases"

__COMMAND_INDEX=0

# clear alias file
> "$ALIAS_FILE"

## FUNCTIONS
# generate alias function
get_alias_function() {
	local __command="$1"
	echo -e "fm${__COMMAND_INDEX}() {\n\t$> \"${__command}\"\n\t${__command}\n}\n" | tee -a "$ALIAS_FILE"
	__COMMAND_INDEX=$((__COMMAND_INDEX+1))
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
echo -e "fmprint() {" | tee -a "$ALIAS_FILE"
for i in "${!commands[@]}"
do
	# echo $line
	echo -e "\tfm${i}: ${commands[$i]}" | tee -a "$ALIAS_FILE"
done
echo -e "}\n" | tee -a "$ALIAS_FILE"

# print alias functions
for i in "${!commands[@]}"
do
	get_alias_function "${commands[$i]}" "$i"
done

# source bash config
source ~/.bashrc
