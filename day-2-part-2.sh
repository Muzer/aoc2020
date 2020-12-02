#!/bin/bash

total=0

while read -r line; do
  range=${line%% *}
  start=${range%-*}
  end=${range#*-}
  char=${line#* }
  char=${char%: *}
  password=${line#*: }

  if [ "${password:start-1:1}" == "$char" ] || [ "${password:end-1:1}" == "$char" ]; then
    if [ "${password:start-1:1}" != "$char" ] || [ "${password:end-1:1}" != "$char" ]; then
      let total++
    fi
  fi
done

echo "$total"
