#!/bin/bash

declare -A questions

count=0

while read -r line; do
  if [ "$line" == "" ]; then
    unset questions
    declare -A questions
  else
    for (( i=0; i<${#line}; ++i )); do
      question=${line:i:1}
      if [ "${questions[$question]}" == "" ]; then
        let count++
        questions[$question]=Y
      fi
    done
  fi
done

echo "$count"
