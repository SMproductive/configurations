#!/bin/sh
export XCURSOR_PATH="${XCURSOR_PATH}:~/.icons"
export XCURSOR_THEME=Nordzy-cursors
export XCURSOR_SIZE=14
export GTK_THEME=Nordic
export BEMENU_OPTS="--hf '#EBCB8B' --hb '#3B4252' --nb '#2E3440' --nf '#ECEFF4' --tb '#2E3440' --tf '#ECEFF4' -H 30 --fn JetBrainsMono"

# export XDG_RUNTIME_DIR=/tmp/`id -u`
export XDG_CURRENT_DESKTOP=dwl
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=dwl

export QT_QPA_PLATFORM="wayland;xcb"
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORMTHEME=qt5ct

export GDK_BACKEND=wayland

export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONEREPARENTING=1
export CLUTTER_BACKEND=wayland

STARTUP="brightnessctl set 10% & emacs --daemon & gentoo-pipewire-launcher &"

# DWL
status.sh &
sh -c "sleep 4; sway-idle" &
sh -c "sleep 4; wallpaper.sh" &
dwl -s "$STARTUP dwlb -no-ipc"
#
## exec Hyprland

## Xsession
#xss-lock -- slock &
#slstatus &
#feh ~/wallpapers/ -z --bg-fill --randomize &
