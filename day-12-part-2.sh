#!/bin/bash

waypoint_eastness=10
waypoint_northness=1

eastness=0
northness=0

while read -r line; do
  command="${line:0:1}"
  argument="${line:1}"

  case $command in
    N)
      waypoint_northness=$((waypoint_northness + argument))
      ;;
    S)
      waypoint_northness=$((waypoint_northness - argument))
      ;;
    E)
      waypoint_eastness=$((waypoint_eastness + argument))
      ;;
    W)
      waypoint_eastness=$((waypoint_eastness - argument))
      ;;
    F)
      eastness=$((eastness + waypoint_eastness * argument))
      northness=$((northness + waypoint_northness * argument))
      ;;
    L)
      for((i=0; i<argument; i+=90)); do
        tmp=$((-waypoint_northness))
        waypoint_northness=$((waypoint_eastness))
        waypoint_eastness=$tmp
      done
      ;;
    R)
      for((i=0; i<argument; i+=90)); do
        tmp=$((waypoint_northness))
        waypoint_northness=$((-waypoint_eastness))
        waypoint_eastness=$tmp
      done
      ;;
  esac
  echo "Line was $line now $direction $eastness $southness"
done

if [ "$eastness" -lt 0 ]; then
  horizontal="$((-eastness))"
else
  horizontal=$eastness
fi

if [ "$northness" -lt 0 ]; then
  vertical="$((-northness))"
else
  vertical=$northness
fi

echo "$((horizontal + vertical))"
