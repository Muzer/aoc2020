#!/bin/bash

declare -A is_contained_by

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
    if [ -v is_contained_by["$full_colour2"] ]; then
      cur_contents="${is_contained_by["$full_colour2"]} "
    fi
    is_contained_by["$full_colour2"]="$cur_contents$full_colour"
  done
done

declare -a outer_bags

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

dfs()
{
  local cur_bag="$1"

  if [ "$cur_bag" != "shiny_gold" ]; then
    outer_bags+=("$cur_bag")
  fi

  local bag

  if [ -v is_contained_by["$cur_bag"] ]; then
    for bag in ${is_contained_by["$cur_bag"]}; do
      if ! contains "$bag" "${outer_bags[@]}"; then
        dfs "$bag"
      fi
    done
  fi
}

dfs "shiny_gold"

echo "${#outer_bags[@]}"
