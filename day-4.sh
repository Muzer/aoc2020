#!/bin/bash

declare -A passports

required_fields=( byr iyr eyr hgt hcl ecl pid )

count=0

donefinal=0

validate()
{
  valid=1
  for field in ${required_fields[@]}; do
    if [ "${passports["$field"]}" == "" ]; then
      valid=0
    fi
  done
  if [ "$valid" == "1" ]; then
    let count++
  fi
}

while read -r line; do
  donefinal=0
  if [ "$line" == "" ]; then
    donefinal=1
    validate
    unset passports
    declare -A passports
  fi

  for part in $line; do
    key="${part%%:*}"
    value="${part#*:}"

    passports["$key"]=$value
  done
done

if [ "$donefinal" == 0 ]; then
  validate
fi

echo "$count"
