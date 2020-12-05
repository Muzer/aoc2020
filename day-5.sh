#!/bin/bash

max_seat_id=0

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

  if [ "$seat_id" -gt "$max_seat_id" ]; then
    max_seat_id=$seat_id
  fi
done

echo "$max_seat_id"
