This theme includes a script which will let you use a .colors file to change the appearance of the contained assets. This will allow you to use different colorschemes and have a translucent background in windows (e.g. Dolphin).

Included are 2 example .colors files. "example.colors" does not contain headers, which were added in Plasma 21. "exampleHeader.colors" has different colored headers for windows.

To use this script, copy a .colors file to this directory and run the script "changeColorScheme.sh" with the .colors in the format:

"./changeColorScheme.sh example.colors"

You can find your .colors files in ~/.local/share/color-schemes/



Not all features of the .colors file are currently supported. Additionally, do not make changes to the .svg file in this directory if you do not intend to back it up, as running this script will overwrite it.
