#!/bin/bash

#loop through themes
for theme in spectrum-classic-colors spectrum-classic-colors-opaque spectrum-classic-charoite spectrum-classic-garnet spectrum-classic-iolite spectrum-classic-mawsitsit spectrum-classic-strawberryquartz; do
    echo "creating $theme"
    mkdir -p output/$theme
    cp -a common/* output/$theme/
    cp -a $theme/* output/$theme/
done

rm -rf output/spectrum-classic-colors-opaque/translucent
rm -f output/spectrum-classic-colors-opaque/changeOpacity.sh

echo done
