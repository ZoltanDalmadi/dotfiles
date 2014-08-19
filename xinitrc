#!/bin/sh

# --------------------------- Setup font directory --------------------------

xset +fp /usr/share/fonts/local
xset fp rehash

# ------------------------------ Keyboard layout ----------------------------

setxkbmap -layout hu,us -option grp:alt_shift_toggle

# ----------------------------- Apply resources -----------------------------

xrdb -merge $HOME/.Xresources

# --------------------------- Source init scripts ---------------------------

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# -------------------------------- Start i3 ---------------------------------

exec i3
