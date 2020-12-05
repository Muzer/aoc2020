#!/bin/bash

declare -a seats

while read -r line; do
  binary=${line//F/0}
  binary=${binary//B/1}
  binary=${binary//L/0}
  binary=${binary//R/1}
  
  seat_id=$(( 2#$binary ))

  seats[$seat_id]=Y
done

prevseat=

for seat in ${!seats[@]}; do
  if [ "$prevseat" != "" ] && [ "$((prevseat + 1))" -ne "$seat" ]; then
    echo "$((seat - 1))"
  fi
  prevseat=$seat
done
