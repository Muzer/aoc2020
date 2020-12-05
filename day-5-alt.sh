#!/bin/bash

max_seat_id=0

while read -r line; do
  binary=${line//F/0}
  binary=${binary//B/1}
  binary=${binary//L/0}
  binary=${binary//R/1}
  
  seat_id=$(( 2#$binary ))

  if [ "$seat_id" -gt "$max_seat_id" ]; then
    max_seat_id=$seat_id
  fi
done

echo "$max_seat_id"
