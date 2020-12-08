#!/bin/bash

declare -a instructions

declare -a visited

while read -r line; do
  instructions+=("$line")
done

pc=0
acc=0

while [ "${visited["$pc"]}" == "" ]; do
  visited["$pc"]=1
  instruction="${instructions["$pc"]}"
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

echo "$acc"
