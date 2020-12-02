#!/bin/bash

total=0

while read -r line; do
  range=${line%% *}
  start=${range%-*}
  end=${range#*-}
  char=${line#* }
  char=${char%: *}
  password=${line#*: }

  justchar=${password//[^$char]}

  if [ "${#justchar}" -ge "$start" ] && [ "${#justchar}" -le "$end" ]; then
    let total++
  fi
done

echo "$total"
