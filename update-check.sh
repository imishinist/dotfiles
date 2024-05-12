#!/bin/bash

# Check for updates
while read -r line; do
  repository=$(echo $line | cut -d' ' -f1)
  version=$(echo $line | cut -d' ' -f2)
  echo $repository

  line=$(bin/github-assets.sh $repository | head -1)
  echo $line | grep -q $version
  if [ $? -ne 0 ]; then
    echo "Update available"
    echo $line | awk '{print $2}' | perl -pe 's/[a-zA-Z0-9_\-\.]+$//g'
  fi
  echo
done < <(bin/extract-package-versions.sh)
