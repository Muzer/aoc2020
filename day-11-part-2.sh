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
      for ((l=j-1; l>=0; --l)); do # check lefts
        if [ "${line:l:1}" == "U" ] || [ "${line:l:1}" == "#" ]; then
          let ++occupied
          break
        fi
        if [ "${line:l:1}" == "O" ] || [ "${line:l:1}" == "L" ]; then
          let ++unoccupied
          break
        fi
      done
      for ((k=i-1, l=j-1; k>=0 && l>=0; --k, --l)); do # check up-lefts
        if [ "${matrix[k]:l:1}" == "U" ] || [ "${matrix[k]:l:1}" == "#" ]; then
          let ++occupied
          break
        fi
        if [ "${matrix[k]:l:1}" == "O" ] || [ "${matrix[k]:l:1}" == "L" ]; then
          let ++unoccupied
          break
        fi
      done
      for ((k=i+1, l=j-1; k<${#matrix[@]} && l>=0; ++k, --l)); do # check up-lefts
        if [ "${matrix[k]:l:1}" == "U" ] || [ "${matrix[k]:l:1}" == "#" ]; then
          let ++occupied
          break
        fi
        if [ "${matrix[k]:l:1}" == "O" ] || [ "${matrix[k]:l:1}" == "L" ]; then
          let ++unoccupied
          break
        fi
      done
      for ((l=j+1; l<${#line}; ++l)); do # check rights
        if [ "${line:l:1}" == "U" ] || [ "${line:l:1}" == "#" ]; then
          let ++occupied
          break
        fi
        if [ "${line:l:1}" == "O" ] || [ "${line:l:1}" == "L" ]; then
          let ++unoccupied
          break
        fi
      done
      for ((k=i-1, l=j+1; k>=0 && l<${#line}; --k, ++l)); do # check up-rights
        if [ "${matrix[k]:l:1}" == "U" ] || [ "${matrix[k]:l:1}" == "#" ]; then
          let ++occupied
          break
        fi
        if [ "${matrix[k]:l:1}" == "O" ] || [ "${matrix[k]:l:1}" == "L" ]; then
          let ++unoccupied
          break
        fi
      done
      for ((k=i+1, l=j+1; k<${#matrix[@]} && l<${#line}; ++k, ++l)); do # check down-rights
        if [ "${matrix[k]:l:1}" == "U" ] || [ "${matrix[k]:l:1}" == "#" ]; then
          let ++occupied
          break
        fi
        if [ "${matrix[k]:l:1}" == "O" ] || [ "${matrix[k]:l:1}" == "L" ]; then
          let ++unoccupied
          break
        fi
      done
      for ((k=i-1; k>=0; --k)); do # straight up
        if [ "${matrix[k]:j:1}" == "U" ] || [ "${matrix[k]:j:1}" == "#" ]; then
          let ++occupied
          break
        fi
        if [ "${matrix[k]:j:1}" == "O" ] || [ "${matrix[k]:j:1}" == "L" ]; then
          let ++unoccupied
          break
        fi
      done
      for ((k=i+1; k<${#matrix[@]}; ++k)); do # straight down
        if [ "${matrix[k]:j:1}" == "U" ] || [ "${matrix[k]:j:1}" == "#" ]; then
          let ++occupied
          break
        fi
        if [ "${matrix[k]:j:1}" == "O" ] || [ "${matrix[k]:j:1}" == "L" ]; then
          let ++unoccupied
          break
        fi
      done
      if [ "${line:j:1}" == "L" ] && [ "$occupied" -eq "0" ]; then
        line="${line:0:j}O${line:j+1}"
        matrix[i]="$line"
      fi
      if [ "${line:j:1}" == "#" ] && [ "$occupied" -ge "5" ]; then
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
