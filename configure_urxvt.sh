#!/bin/bash
script_dir=$(dirname $(readlink -f $0))

echo -e "Select your color theme:"
index=0

for theme in $script_dir/urxvt_colors/*; do
    themes[$index]=${theme##*/}
    ((index++))
done

select theme in ${themes[@]}; do
    ln -sf $script_dir/urxvt_colors/$theme $script_dir/urxvt_theme
    break;
done

echo -e "Select your font:"
index=0

for font in $script_dir/urxvt_fonts/*; do
    fonts[$index]=${font##*/}
    ((index++))
done

select font in ${fonts[@]}; do
    ln -sf $script_dir/urxvt_fonts/$font $script_dir/urxvt_font
    break;
done

xrdb -I$script_dir $script_dir/Xresources
