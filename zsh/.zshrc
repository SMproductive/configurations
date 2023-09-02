# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
source $ZDOTDIR/functions.zsh

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zhistory

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
zle -N zle-keymap-select
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.

bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load plugins
plug "zsh-autosuggestions"
plug "zsh-syntax-highlighting"
plug "zsh-history-substring-search"

bindkey '^n' autosuggest-accept



# My aliases
alias l="ls -l"
alias la="ls -al"
alias grep="grep --color=always"
alias pm="ppm ~/.ppm_passwords pipe"
alias up="guix pull; nix-channel --update"
alias sup="sudo -E guix system reconfigure ~/configurations/guix/system.scm"
alias hup="guix home reconfigure ~/configurations/guix-home/home-configuration.scm"
alias nup="nix-env -u"
alias gc="sudo guix system delete-generations; sudo guix gc; guix home delete-generations; guix gc; sudo nix-collect-garbage -d; nix-collect-garbage -d"
alias vup="sudo sysctl -w net.ipv4.ip_forward=1; sudo wg-quick up wg0"
alias vdown="sudo sysctl -w net.ipv4.ip_forward=0; sudo wg-quick down wg0"
alias n="nvim"
alias ndiff="nvim -d"
