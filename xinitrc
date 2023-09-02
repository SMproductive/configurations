export PATH=$PATH:~/.guix-profile/bin
export XCURSOR_PATH=${XCURSOR_PATH}:~/.icons
export XCURSOR_THEME=Nordzy-cursors

xss-lock -- slock &
emacs --daemon &
#nextcloud --background &
slstatus &
feh ~/wallpapers/ -z --bg-fill --randomize &
brightnessctl set 10% &
dwm
