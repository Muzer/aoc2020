#!/bin/bash

declare -a instructions

declare -a visited

while read -r line; do
  instructions+=("$line")
done

for (( i=0; i<${#instructions[@]}; ++i )); do
  unset visited
  declare -a visited

  modded_instructions=("${instructions[@]}")
  instruction="${modded_instructions["$i"]}"
  read -r opcode operand <<< "$instruction"
  if [ "$opcode" == "acc" ]; then
    continue
  elif [ "$opcode" == "jmp" ]; then
    opcode=nop
  else
    opcode=jmp
  fi
  modded_instructions["$i"]="$opcode $operand"

  pc=0
  acc=0

  while [ "${visited["$pc"]}" == "" ] && [ "$pc" -lt "${#modded_instructions[@]}" ]; do
    visited["$pc"]=1
    instruction="${modded_instructions["$pc"]}"
    read -r opcode operand <<< "$instruction"
    let pc++
    case "$opcode" in
      nop)
        ;;
      jmp)
        pc=$(( pc - 1 + operand ))
        ;;
      acc)
        acc=$(( acc + operand ))
        ;;
    esac
  done

  if [ "$pc" -ge "${#modded_instructions[@]}" ]; then
    echo "$acc"
  fi
done
