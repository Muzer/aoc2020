#!/bin/bash

# Adding two more states
# U -> Transitioning from occupied to unoccupied
# O -> Transitioning from unoccupied to occupied

declare -a matrix

while read -r line; do
  matrix+=("$line")
done

while true; do
  oldmatrix=("${matrix[@]}")
  for i in "${!matrix[@]}"; do
    line="${matrix[i]}"
    for ((j=0; j<${#line}; ++j)); do
      occupied=0
      unoccupied=0
      if [ "$j" -gt 0 ]; then # check lefts
        if [ "${line:j-1:1}" == "U" ] || [ "${line:j-1:1}" == "#" ]; then
          let ++occupied
        fi
        if [ "${line:j-1:1}" == "O" ] || [ "${line:j-1:1}" == "L" ]; then
          let ++unoccupied
        fi
        if [ "$i" -gt 0 ]; then # check up-lefts
          if [ "${matrix[i-1]:j-1:1}" == "U" ] || [ "${matrix[i-1]:j-1:1}" == "#" ]; then
            let ++occupied
          fi
          if [ "${matrix[i-1]:j-1:1}" == "O" ] || [ "${matrix[i-1]:j-1:1}" == "L" ]; then
            let ++unoccupied
          fi
        fi
        if [ "$i" -lt "${#matrix[@]}" ]; then # check down-lefts
          if [ "${matrix[i+1]:j-1:1}" == "U" ] || [ "${matrix[i+1]:j-1:1}" == "#" ]; then
            let ++occupied
          fi
          if [ "${matrix[i+1]:j-1:1}" == "O" ] || [ "${matrix[i+1]:j-1:1}" == "L" ]; then
            let ++unoccupied
          fi
        fi
      fi
      if [ "$j" -lt "${#line}" ]; then # check rights
        if [ "${line:j+1:1}" == "U" ] || [ "${line:j+1:1}" == "#" ]; then
          let ++occupied
        fi
        if [ "${line:j+1:1}" == "O" ] || [ "${line:j+1:1}" == "L" ]; then
          let ++unoccupied
        fi
        if [ "$i" -gt 0 ]; then # check up-rights
          if [ "${matrix[i-1]:j+1:1}" == "U" ] || [ "${matrix[i-1]:j+1:1}" == "#" ]; then
            let ++occupied
          fi
          if [ "${matrix[i-1]:j+1:1}" == "O" ] || [ "${matrix[i-1]:j+1:1}" == "L" ]; then
            let ++unoccupied
          fi
        fi
        if [ "$i" -lt "${#matrix[@]}" ]; then # check down-rights
          if [ "${matrix[i+1]:j+1:1}" == "U" ] || [ "${matrix[i+1]:j+1:1}" == "#" ]; then
            let ++occupied
          fi
          if [ "${matrix[i+1]:j+1:1}" == "O" ] || [ "${matrix[i+1]:j+1:1}" == "L" ]; then
            let ++unoccupied
          fi
        fi
      fi
      if [ "$i" -gt 0 ]; then # straight up
        if [ "${matrix[i-1]:j:1}" == "U" ] || [ "${matrix[i-1]:j:1}" == "#" ]; then
          let ++occupied
        fi
        if [ "${matrix[i-1]:j:1}" == "O" ] || [ "${matrix[i-1]:j:1}" == "L" ]; then
          let ++unoccupied
        fi
      fi
      if [ "$i" -lt "${#matrix[@]}" ]; then # straight down
        if [ "${matrix[i+1]:j:1}" == "U" ] || [ "${matrix[i+1]:j:1}" == "#" ]; then
          let ++occupied
        fi
        if [ "${matrix[i+1]:j:1}" == "O" ] || [ "${matrix[i+1]:j:1}" == "L" ]; then
          let ++unoccupied
        fi
      fi
      if [ "${line:j:1}" == "L" ] && [ "$occupied" -eq "0" ]; then
        line="${line:0:j}O${line:j+1}"
        matrix[i]="$line"
      fi
      if [ "${line:j:1}" == "#" ] && [ "$occupied" -ge "4" ]; then
        line="${line:0:j}U${line:j+1}"
        matrix[i]="$line"
      fi
    done
  done

  for i in "${!matrix[@]}"; do
    line="${matrix[i]}"
    for ((j=0; j<${#line}; ++j)); do
      if [ "${line:j:1}" == "O" ]; then
        line="${line:0:j}#${line:j+1}"
        matrix[i]="$line"
      fi
      if [ "${line:j:1}" == "U" ]; then
        line="${line:0:j}L${line:j+1}"
        matrix[i]="$line"
      fi
    done
    echo "$line"
  done
  echo

  same=1
  for index in "${!oldmatrix[@]}"; do
    if [ "${oldmatrix[index]}" != "${matrix[index]}" ]; then
      same=0
      break
    fi
  done
  if [ "$same" == "1" ]; then
    occupied=0
    for line in "${matrix[@]}"; do
      for ((i=0; i<"${#line}"; ++i)); do
        if [ "${line:i:1}" == "#" ]; then
          let ++occupied
        fi
      done
    done
    echo "$occupied"
    break
  fi
done
