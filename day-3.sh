#!/bin/bash

rightness=0
trees=0

rightness_per_step=3

while read -r line; do
  width=${#line}
  if [ "${line:rightness % width:1}" == "#" ]; then
    let trees++
  fi
  rightness=$((rightness + rightness_per_step))
done

echo "$trees"
