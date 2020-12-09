#!/bin/bash

declare -a numbers
declare -a sum_map

i=0

while read -r line; do
  numbers+=("$line")
  let ++sum_map["$line"]

  if [ "$i" -lt 25 ]; then
    let ++i
    continue
  fi

  found=0
  for ((j=i-25; j<i; ++j)); do
    cur_num="${numbers["$j"]}"
    if [ "${sum_map["$((line - cur_num))"]}" != "" ] && [ "${sum_map["$((line - cur_num))"]}" -gt 0 ]; then
      found=1
      break
    fi
  done
  if [ "$found" == "0" ]; then
    echo "$line"
    break
  fi
  let --sum_map[numbers[i-25]]

  let ++i
done
