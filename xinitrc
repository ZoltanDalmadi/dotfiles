#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xset +fp /usr/share/fonts/local
xset fp rehash

xrdb -merge $HOME/.Xresources
setxkbmap -layout hu,us -option grp:alt_shift_toggle

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec i3 
