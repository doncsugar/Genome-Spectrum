#!/bin/bash

#loop through themes
for theme in spectrum-classic-basic spectrum-classic-basic-opaque spectrum-classic-light spectrum-classic-dark spectrum-malice spectrum-malice-opaque spectrum-spite spectrum-spite-opaque; do
    echo "creating $theme"
    mkdir -p output/$theme
    cp -a $theme/* output/$theme/
    cp -an common/* output/$theme/
done

echo cleaning opaque themes

rm -rf output/spectrum-spite/translucent
rm -rf output/spectrum-malice/translucent
rm -rf output/spectrum-spite-opaque/translucent
rm -rf output/spectrum-malice-opaque/translucent

rm -rf output/spectrum-classic-basic-opaque/translucent

echo done
