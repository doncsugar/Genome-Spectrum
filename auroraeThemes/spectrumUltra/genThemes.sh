#!/bin/bash

#loop through themes
for theme in spectrumUltraColors spectrumUltraDark spectrumUltraLight; do
    echo "creating $theme"
    mkdir -p output/$theme
    cp -a common/* output/$theme/
    cp -a $theme/* output/$theme/
done
