#!/bin/bash
target="GenomeLight.svg"

rm $target

cp "${target}.bak" $target

echo "Run this script with a hexadecimal color value"
echo
echo "e.g. ./changeHighlight.sh d9113c"

sed -i -e "s/fill:#3daee9/fill:#${1}/g" "$target"

echo "Colors changed to $1"

exit
