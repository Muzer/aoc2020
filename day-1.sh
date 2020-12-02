#!/bin/bash

rm -f /tmp/aoc1

while read -r line; do
  echo "$line" >> /tmp/aoc1
  if [ "$((2020 - line))" -ge 0 ]; then
    map[2020 - line]=Y
  fi
done

while read -r line; do
  if [ "$((2020 - line))" -ge 0 ]; then
    if [ "${map[line]}" == "Y" ]; then
      echo "$line * $((2020 - line)) == $((line * (2020 - line)))"
    fi
  fi
done < /tmp/aoc1
