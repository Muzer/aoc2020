#!/bin/bash

declare -a seats

while read -r line; do
  min_row=0
  max_row=128 # one past the end

  min_col=0
  max_col=8

  for (( i=0; i<${#line}; ++i )); do
    case ${line:i:1} in
      F)
        max_row=$(( max_row - (max_row - min_row) / 2 ))
        ;;
      B)
        min_row=$(( min_row + (max_row - min_row) / 2 ))
        ;;
      L)
        max_col=$(( max_col - (max_col - min_col) / 2 ))
        ;;
      R)
        min_col=$(( min_col + (max_col - min_col) / 2 ))
        ;;
    esac
  done

  if [ "$min_row" -ne "$((max_row - 1 ))" ]; then
    echo "$min_row $max_row"
  fi
  if [ "$min_col" -ne "$((max_col - 1 ))" ]; then
    echo "$min_col $max_col"
  fi
  seat_id=$(( min_row * 8 + min_col ))

  seats[$seat_id]=Y
done

prevseat=

for seat in ${!seats[@]}; do
  if [ "$prevseat" != "" ] && [ "$((prevseat + 1))" -ne "$seat" ]; then
    echo "$((seat - 1))"
  fi
  prevseat=$seat
done
