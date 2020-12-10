#!/bin/bash

declare -a adaptors

while read -r line; do
  adaptors["$line"]=Y
done

keys=("${!adaptors[@]}")
len="${#adaptors[@]}"

adaptors[$(( keys[len-1] + 3 ))]=Y
adaptors[0]=Y

echo "${!adaptors[@]}"

prev=0

one_diffs=0
three_diffs=0

for adaptor in "${!adaptors[@]}"; do
  if [ "$((adaptor - 1))" -eq "$prev" ]; then
    let ++one_diffs
  elif [ "$((adaptor - 3))" -eq "$prev" ]; then
    let ++three_diffs
  fi
  prev="$adaptor"
done

echo "$((one_diffs * three_diffs))"
