#!/bin/bash

echo "creating theme"

mkdir -p output/spectrum-dark
cp -a commonLightAssets/* commonDarkAssets
cp -a commonLightAssets/* output/spectrum-dark
cp -an breeze-icons/icons-dark/* output/spectrum-dark

mkdir -p output/spectrum-light
bash -c "cd commonDarkAssets; ../breeze-icons/icons-dark/light2Dark"
cp -a commonDarkAssets/* output/spectrum-light
cp -an breeze-icons/icons/* output/spectrum-light

rm -r commonDarkAssets/*

#removing folder icons that don't yet exist
rm -r output/spectrum-light/places/48
rm -r output/spectrum-light/places/96

rm -r output/spectrum-dark/places/48
rm -r output/spectrum-dark/places/96

echo "done"
exit

cd output/spectrum-light
sed -i '/^Name[/d' index.theme
sed -i '/^Comment[/d' index.theme

sed -i '/^Name=/d' index.theme
sed -i '/^Comment[/d' index.theme
exit
#loop through themes
for theme in spectrum-folders-light spectrum-folders-dark; do
    echo "creating $theme"
    mkdir -p output/$theme
    cp -a common/* output/$theme/
    cp -a $theme/* output/$theme/
done
