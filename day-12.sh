#!/bin/bash

direction=0

eastness=0
southness=0

while read -r line; do
  command="${line:0:1}"
  argument="${line:1}"

  case $command in
    N)
      southness=$((southness - argument))
      ;;
    S)
      southness=$((southness + argument))
      ;;
    E)
      eastness=$((eastness + argument))
      ;;
    W)
      eastness=$((eastness - argument))
      ;;
    F)
      case $direction in
        0)
          eastness=$((eastness + argument))
          ;;
        90)
          southness=$((southness + argument))
          ;;
        180)
          eastness=$((eastness - argument))
          ;;
        270)
          southness=$((southness - argument))
      esac
      ;;
    L)
      direction=$(((direction - argument) % 360))
      if [ "$direction" -lt 0 ]; then
        direction=$((direction + 360))
      fi
      ;;
    R)
      direction=$(((direction + argument) % 360))
      ;;
  esac
  echo "Line was $line now $direction $eastness $southness"
done

if [ "$eastness" -lt 0 ]; then
  horizontal="$((-eastness))"
else
  horizontal=$eastness
fi

if [ "$southness" -lt 0 ]; then
  vertical="$((-southness))"
else
  vertical=$southness
fi

echo "$((horizontal + vertical))"
