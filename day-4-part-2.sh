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
  is_int='^[0-9]+$'
  if ( ! [[ ${passports[byr]} =~ $is_int ]] ) || [ "${passports[byr]}" -lt 1920 ] || [ "${passports[byr]}" -gt 2002 ]; then
    valid=0
  fi
  if ( ! [[ ${passports[iyr]} =~ $is_int ]] ) || [ "${passports[iyr]}" -lt 2010 ] || [ "${passports[iyr]}" -gt 2020 ]; then
    valid=0
  fi
  if ( ! [[ ${passports[eyr]} =~ $is_int ]] ) || [ "${passports[eyr]}" -lt 2020 ] || [ "${passports[eyr]}" -gt 2030 ]; then
    valid=0
  fi
  height=${passports[hgt]%[ic][nm]}
  if ! [[ $height =~ $is_int ]]; then
    valid=0
  elif [ "${passports[hgt]: -2:2}" == "cm" ]; then
    if [ "$height" -lt 150 ] || [ "$height" -gt 193 ]; then
      valid=0
    fi
  elif [ "${passports[hgt]: -2:2}" == "in" ]; then
    if [ "$height" -lt 59 ] || [ "$height" -gt 76 ]; then
      valid=0
    fi
  else
    valid=0
  fi
  if ! [[ ${passports[hcl]} =~ ^\#[0-9a-f]{6}$ ]]; then
    valid=0
  fi
  eyevalid=0
  for colour in amb blu brn gry grn hzl oth; do
    if [ "${passports[ecl]}" == "$colour" ]; then
      eyevalid=1
    fi
  done
  if [ "$eyevalid" == 0 ]; then
    valid=0
  fi
  if ! [[ ${passports[pid]} =~ ^[0-9]{9}$ ]]; then
    valid=0
  fi

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
