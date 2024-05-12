#!/bin/bash

while read -r line; do
  file=$(echo $line | cut -d':' -f1)
  constant=$(echo $line | cut -d: -f3 | cut -d" " -f1)
  version=$(echo $line | cut -d"'" -f2)

  repository=$(grep $constant $file -B 2 | grep repository | awk '{print $2}' | perl -pe "s/'//g")
  echo "$repository $version"
done < <(grep -E "VERSION = '.+'" -nr cookbooks/ | grep -v "#")

