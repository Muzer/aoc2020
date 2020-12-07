#!/bin/bash

declare -A contains

while read -r adv colour bags contain rest; do
  IFS=',' read -ra contents <<< "$rest"
  full_colour="${adv}_$colour"
  for content in "${contents[@]}"; do
    if [ "$content" == "no other bags." ]; then
      continue
    fi
    content=${content# }
    read -r count adv2 colour2 rest2 <<< "$content"
    full_colour2="${adv2}_$colour2"
    cur_contents=""
    if [ -v contains["$full_colour"] ]; then
      cur_contents="${contains["$full_colour"]} "
    fi
    contains["$full_colour"]="$cur_contents$count:$full_colour2"
  done
done

contains()
{
  search="$1"
  shift
  for element; do
    if [ "$element" == "$search" ]; then
      return 0
    fi
  done
  return 1
}

total=0

dfs()
{
  local cur_bag="$1"

  local bag_count

  if [ -v contains["$cur_bag"] ]; then
    for bag_count in ${contains["$cur_bag"]}; do
      local count=${bag_count%:*}
      local bag=${bag_count#*:}
      local i
      for (( i=0; i<count; ++i )); do
        let total++
        dfs "$bag"
      done
    done
  fi
}

dfs "shiny_gold"

echo "$total"
