#!/bin/bash

#loop through themes
for theme in spectrum-folders-light spectrum-folders-dark; do
    echo "creating $theme"
    mkdir -p output/$theme
    cp -a common/* output/$theme/
    cp -a $theme/* output/$theme/
done
