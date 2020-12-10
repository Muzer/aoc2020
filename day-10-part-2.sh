#!/bin/bash

declare -a adaptors

while read -r line; do
  adaptors["$line"]=Y
done

adaptors[0]=Y
keys=("${!adaptors[@]}")
len="${#adaptors[@]}"

adaptors[$(( keys[len-1] + 3 ))]=Y

keys+=("$(( keys[len-1] + 3 ))")
let ++len

prev=0

one_diffs=0
three_diffs=0

declare -a combos_from_here

retval=

find_combinations()
{
  local index="$1"
  local cur_entry="${keys["$index"]}"
  local i

  if [ "$index" == "$((len - 1))" ]; then
    combos_from_here["$index"]=1
    retval=1
    return 0
  fi

  local total=0
  for ((i=index+1; i<len && keys[i]<=cur_entry+3; ++i)); do
    if [ "${combos_from_here["$i"]}" != "" ]; then
      total="$((total + combos_from_here[i]))"
    else
      find_combinations "$i"
      total="$((total + retval))"
    fi
  done
  combos_from_here["$index"]="$total"
  retval=$total
}

find_combinations 0
echo "$retval"
