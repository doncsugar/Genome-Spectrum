#!/bin/bash

echo "creating theme"

#emptying directories
rm -rf output/*
rm -rf commonDarkAssets/*

#setting up outputs
mkdir output/build

mkdir -p output/spectrum-dark
mkdir -p output/spectrum-light

cp -a commonLightAssets/* commonDarkAssets

echo "converting using light2dark"

#add git reset here for breeze-icons?

chmod a+x breeze-icons/icons-dark/light2Dark
bash -c "cd commonDarkAssets; ../breeze-icons/icons-dark/light2Dark"

cp -a commonDarkAssets/* breeze-icons/icons/
cp -a commonLightAssets/* breeze-icons/icons-dark/

cmake -S breeze-icons/ -B output/build

bash -c "cd output/build; make"

#copying over 24px icons and source because copy doesn't preserve links
cp -a breeze-icons/icons-dark/* output/spectrum-dark
cp -a output/build/icons-dark/generated/* output/spectrum-dark

cp -a breeze-icons/icons/* output/spectrum-light
cp -a output/build/icons/generated/* output/spectrum-light

#Preparations for spectrum's missing icons
sed -i '/^Name\[/d' output/spectrum-light/index.theme
sed -i '/^Comment\[/d' output/spectrum-light/index.theme

sed -i 's/^Name=.*/Name=Spectrum Light/g' output/spectrum-light/index.theme
sed -i 's/^Comment=.*/Comment=A light color-changing version of Breeze with some changes from Genome/g' output/spectrum-light/index.theme

sed -i '/^Name\[/d' output/spectrum-dark/index.theme
sed -i '/^Comment\[/d' output/spectrum-dark/index.theme

sed -i 's/^Name=.*/Name=Spectrum Dark/g' output/spectrum-dark/index.theme
sed -i 's/^Comment=.*/Comment=A dark color-changing version of Breeze with some changes from Genome/g' output/spectrum-dark/index.theme

#cleaning up
rm -r commonDarkAssets/*
rm -rf output/build

#removing folder icons that don't yet exist
rm -rf output/spectrum-light/places/48
rm -rf output/spectrum-light/places/96

rm -rf output/spectrum-dark/places/48
rm -rf output/spectrum-dark/places/96

echo "done"
exit
