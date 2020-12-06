#!/bin/bash

declare -A questions

count=0

person_count=0

while read -r line; do
  if [ "$line" == "" ]; then
    for q_count in ${questions[@]}; do
      if [ "$q_count" == "$person_count" ]; then
        let count++
      fi
    done
    unset questions
    declare -A questions
    person_count=0
  else
    let person_count++
    for (( i=0; i<${#line}; ++i )); do
      question=${line:i:1}
      let questions[$question]++
    done
  fi
done

for q_count in ${questions[@]}; do
  if [ "$q_count" == "$person_count" ]; then
    let count++
  fi
done

echo "$count"
