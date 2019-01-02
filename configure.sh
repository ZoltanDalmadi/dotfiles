#!/bin/sh

has_command() {
    command -v "$1" >/dev/null 2>&1
}

join() {
    local IFS="$1"; shift; echo "$*";
}

script_dir=$(dirname $(readlink -f $0))

index=0
for theme in $script_dir/colors/*; do
    themes[$index]=${theme##*/}
    ((index++))
done

index=0
for font in $script_dir/fonts/*; do
    fonts[$index]=${font##*/}
    ((index++))
done

if has_command rofi; then
    menu="rofi -dmenu"
elif has_command dmenu; then
    menu="dmenu"
fi

if [[ -n $menu ]]; then
    theme=$(join $'\n' ${themes[@]} | $menu -p "Select your color theme")
    font=$(join $'\n' ${fonts[@]} | $menu -p "Select your font")
else
    echo "Select your color theme:"
    select theme in ${themes[@]}; do
        break;
    done

    echo "Select your font:"
    select font in ${fonts[@]}; do
        break;
    done
fi

[[ -n $theme ]] && ln -sf $script_dir/colors/$theme $script_dir/theme
[[ -n $font ]] && ln -sf $script_dir/fonts/$font $script_dir/font

xrdb -I$script_dir -merge $script_dir/Xresources && killall -USR1 st && i3-msg restart
