#!/bin/bash

echo -e "Select your color theme:"
index=0

for theme in urxvt_colors/*; do
    themes[$index]=${theme##*/}
    ((index++))
done

select theme in ${themes[@]}; do
    ln -sf urxvt_colors/$theme urxvt_theme
    break;
done

echo -e "Select your font:"
index=0

for font in urxvt_fonts/*; do
    fonts[$index]=${font##*/}
    ((index++))
done

select font in ${fonts[@]}; do
    ln -sf urxvt_fonts/$font urxvt_font
    break;
done

xrdb -I$PWD Xresources
