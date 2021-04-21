#!/bin/bash

hexinator() {
temp=$1
#shaves off text, preserving only rgb vals
temp=${temp##*=}
#reformats into hexadecimal format
temp=$(echo $temp | awk -F, '{printf "%02x%02x%02x" , $1 , $2 , $3}')
echo $temp
}

inputColors=$1

target="GenomeSpectrum.svg"
config="GenomeSpectrum.kvconfig"

#moves target and config to old for updated version
mv -- "$target" "OLD$target"
mv -- "$config" "OLD$config"

echo "backed up last version to old, running this script again will delete them and replace them with the current version"

cp "${target}.bak" $target
cp "${config}.bak" $config

echo "Run this script with a .colors file"
echo "e.g. ./changeColorScheme Charoite.colors"
echo

#general colors
windowColor=$(awk 'c&&!--c;/Colors:Window/{ c=2 }' $inputColors)
windowColor=$(hexinator $windowColor)

windowHighlight=$(awk 'c&&!--c;/Colors:Window/{ c=4 }' $inputColors)
windowHighlight=$(hexinator $windowHighlight)

windowFocus=$(awk 'c&&!--c;/Colors:Window/{ c=3 }' $inputColors)
windowFocus=$(hexinator $windowFocus)

windowText=$(awk 'c&&!--c;/Colors:Window/{ c=10 }' $inputColors)
windowText=$(hexinator $windowText)

windowNegativeText=$(awk 'c&&!--c;/Colors:Window/{ c=8 }' $inputColors)
windowNegativeText=$(hexinator $windowNegativeText)

#echo $windowHighlight $windowColor $windowHighlight $windowText $windowNegativeText

viewColor=$(awk 'c&&!--c;/Colors:View/{ c=2 }' $inputColors)
viewColor=$(hexinator $viewColor)

viewColorAlt=$(awk 'c&&!--c;/Colors:View/{ c=1 }' $inputColors)
viewColorAlt=$(hexinator $viewColorAlt)

#echo $viewColor $viewColorAlt

buttonColor=$(awk 'c&&!--c;/Colors:Button/{ c=2 }' $inputColors)
buttonColor=$(hexinator $buttonColor)

#echo $buttonColor

headerSeparatorColor=$windowText

headerActiveColor=$(awk 'c&&!--c;/Colors:Header/{ c=2 }' $inputColors)
#set header to window color if .colors doesn't have it
if [ $headerActiveColor == ]; then
    headerActiveColor=$windowColor
    headerSeparatorColor=$windowColor
    else
    headerActiveColor=$(hexinator $headerActiveColor)
fi

headerInactiveColor=$(awk 'c&&!--c;/Colors:Header\]\[Inactive/{ c=2 }' $inputColors)
#set header to window color if .colors doesn't have it
if [ $headerInactiveColor == ]; then
    headerInactiveColor=$windowColor
    else
    headerInactiveColor=$(hexinator $headerInactiveColor)
fi

#echo $headerInactiveColor

sed -i -e "s/fill:#2a2e32/fill:#$windowColor/g" -e "s/fill:#93cee9/fill:#$windowHighlight/g" -e "s/fill:#3daee9/fill:#$windowFocus/g" -e "s/fill:#fcfcfc/fill:#$windowText/g" -e "s/fill:#da4453/fill:#$windowNegativeText/g" -e "s/fill:#1b1e20/fill:#$viewColor/g" -e "s/fill:#31363b/fill:#$buttonColor/g" -e "s/fill:#3c4449/fill:#$headerActiveColor/g" -e "s/fill:#282b2f/fill:#$headerInactiveColor/g" -e "s/fill:#fafafa/fill:#$headerSeparatorColor/g" "$target"

sed -i -e "s/base.color=#1b1e20/base.color=#$viewColor/g" "$config"

echo "Colors changed to match $1"

exit
