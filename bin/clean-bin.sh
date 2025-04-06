#!/bin/bash

bin_dir="$HOME/bin"

targets=$(mktemp)
find "$bin_dir" -type d -depth 1 | sort > "$targets"

while read -r file; do
    line=$(readlink "$file")
    trimmed=${line#$bin_dir}
    name=$(echo $trimmed | cut -d/ -f2)

    echo "alive: $name"
    perl -i -ne "print unless /${name}/" "$targets"
done < <(find "$bin_dir" -type l | sort)

while read -r file; do
    echo "rm -f $file"
    rm -rf "$file"
done < "$targets"
