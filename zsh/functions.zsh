#!/usr/bin/env zsh

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

function plug () {
    if [ ! -d "$ZDOTDIR/plugins" ]; then
      echo "$ZDOTDIR/plugins"
      mkdir $ZDOTDIR/plugins/
    fi
    if [ ! -d "$ZDOTDIR/plugins/$1" ]; then
      git clone https://github.com/zsh-users/$1 $ZDOTDIR/plugins/$1
    fi
    source $ZDOTDIR/plugins/$1/$1.zsh
}

function plugUpdate () {
    rm -rf $ZDOTDIR/plugins/
    source $ZDOTDIR/.zshrc
}

# Use beam shape cursor for each new prompt.
preexec() {
    echo -ne '\e[5 q' ;
}

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
