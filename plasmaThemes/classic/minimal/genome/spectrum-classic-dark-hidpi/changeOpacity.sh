#!/bin/bash

#makes a backup of the original and replaces it with an extracted version with opacity updated
#args are target asset, target's percent to be replaced, replacement value
bakconvert () {
    cp "$1" "$1.bak" &&
    gunzip -cd "$1.bak" > "${1%.svgz}.svg"
    rm "$1"
    #newvalue=`echo "scale=2; $3/100" |  bc`
    sed -i -e "s/opacity:$2/opacity:0.$3/g" "${1%.svgz}.svg"
}

#restores backup and removes asset that was modified
bakrevert () {
    mv -- "$1.bak" "${1%.bak}"
    rm "${1%.svgz}.svg"
}

#convert takes desired opacity percent (int from 0-100)

#backs up and modifies "regular" assets
widgetconv () {
for asset in "widgets/tooltip.svgz" "widgets/panel-background.svgz" "dialogs/background.svgz"; do
    bakconvert $asset $targetpercent $1
done
}

#backs up and modifies translucent/ (used for contrast effect) assets
translucentwidgetconv () {
for asset in "translucent/widgets/tooltip.svgz" "translucent/widgets/panel-background.svgz" "translucent/dialogs/background.svgz"; do
    bakconvert $asset $targetpercenttranslucent $1
done
}

#revert does not take arguments

#restores "regular" assets and removes modified version
widgetrev () {
for asset in "widgets/tooltip.svgz" "widgets/panel-background.svgz" "dialogs/background.svgz"; do
    bakrevert $asset
done
}

#restores translucent/ (used for contrast effect) assets and removes modified version
translucentwidgetrev () {
for asset in "translucent/widgets/tooltip.svgz" "translucent/widgets/panel-background.svgz" "translucent/dialogs/background.svgz"; do
    bakrevert $asset
done
}

check () {
for asset in "widgets/tooltip" "widgets/panel-background" "dialogs/background"; do
    if ! [ -a "$asset.svgz" ]; then
        if [ -a "$asset.svg" ] && [ -a "$asset.svgz.bak" ]; then
            widgetstatus="backedup"
        else
            widgetstatus="broken"
            echo "$asset is missing"
        fi
    else
        widgetstatus="clean"
    fi
    #translucent
    if [ $includetranslucent == 1 ]; then
        if ! [ -a "translucent/$asset.svgz" ]; then
            if [ -a "translucent/$asset.svg" ] && [ -a "translucent/$asset.svgz.bak" ]; then
                translucentwidgetstatus="backedup"
            else
                translucentwidgetstatus="broken"
                echo "translucent/$asset is missing"
            fi
        else
            translucentwidgetstatus="clean"
        fi
    else
        translucentwidgetstatus="clean"
    fi
done
}

#config
#modifies translucent/ contents. Do not change this value unless the files exist in translucent/
includetranslucent=1
#opacity of asset pieces to be modified. Do not change unless you know what you are doing
targetpercent=0.655
targetpercenttranslucent=0.757


#checks if files are present and if they are in modified or original state
check

#prepares for script by restoring files if they have been modified
if [ $widgetstatus = "clean" ] && [ $translucentwidgetstatus = "clean" ]; then
    echo "Files are present"
else
    if [ $widgetstatus = "backedup" ]; then
        widgetrev
        if [ $includetranslucent = 1 ] && [ $translucentwidgetstatus = "backedup" ]; then
            translucentwidgetrev
        fi
    else
        echo "Try running this script with a fresh copy of this theme, something is wrong."
    fi
fi

echo "0% opacity is like clear glass and can make text hard to read"
echo "99% opacity is like concrete and will not let you see blur effects at all"

echo "Pass an integer value from 0 to 99 to set the opacity"

if [[ $1 =~ ^[0-9]+$ && ($1 -ge 0 && $1 -lt 100) ]]; then
    echo "Setting opacity to $1"
    widgetconv "$1"
    if [ $includetranslucent = 1 ]; then
        translucentwidgetconv "$1"
    fi
else
    echo "This is not in the range."
fi
