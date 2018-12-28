#!/bin/bash
script_dir=$(dirname $(readlink -f $0))

echo "Select your color theme:"
index=0

for theme in $script_dir/colors/*; do
    themes[$index]=${theme##*/}
    ((index++))
done

select theme in ${themes[@]}; do
    ln -sf $script_dir/colors/$theme $script_dir/theme
    break;
done

echo "Select your font:"
index=0

for font in $script_dir/fonts/*; do
    fonts[$index]=${font##*/}
    ((index++))
done

select font in ${fonts[@]}; do
    ln -sf $script_dir/fonts/$font $script_dir/font
    break;
done

xrdb -I$script_dir $script_dir/Xresources && killall -USR1 st && i3-msg restart
