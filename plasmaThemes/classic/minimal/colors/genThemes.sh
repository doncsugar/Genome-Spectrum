#!/bin/bash

#loop through themes
for theme in spectrum-minimal-classic-charoite spectrum-minimal-classic-garnet spectrum-minimal-classic-iolite spectrum-minimal-classic-mawsitsit spectrum-minimal-classic-strawberryquartz; do
    echo "creating $theme"
    mkdir -p output/$theme
    cp -a common/* output/$theme/
    cp -a $theme/* output/$theme/
done
