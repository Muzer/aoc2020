#!/bin/bash

declare -a rightness
declare -a trees

rightnesses_per_step=(1 3 5 7)

rightness_two_lines=0
trees_two_lines=0

line_no=0

while read -r line; do
  width=${#line}
  for rightness_per_step in ${rightnesses_per_step[@]}; do
    if [ "${line:rightness[rightness_per_step] % width:1}" == "#" ]; then
      let trees[rightness_per_step]++
    fi
    rightness[rightness_per_step]=$((rightness[rightness_per_step] + rightness_per_step))
  done

  if [ $((line_no % 2)) == 0 ]; then
    if [ "${line:rightness_two_lines % width:1}" == "#" ]; then
      let trees_two_lines++
    fi
    let rightness_two_lines++
  fi

  let line_no++
done

product=$trees_two_lines

for tree in ${trees[@]}; do
  product=$((product * tree))
done

echo "$product"
