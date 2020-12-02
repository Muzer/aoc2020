#!/bin/bash

echo -n > /tmp/aoc1

while read -r line; do
  echo "$line" >> /tmp/aoc1
  if [ "$((2020 - line))" -ge 0 ]; then
    map[2020 - line]=Y
  fi
done

while read -r line; do
  for i in ${!map[@]}; do
    i=$((2020 - i))
    if [ "$((2020 - (line + i)))" -ge 0 ]; then
      if [ "${map[line + i]}" == "Y" ]; then
        echo "$line * $i * $((2020 - (line + i))) == $((line * i * (2020 - (line + i))))"
      fi
    fi
  done
done < /tmp/aoc1
