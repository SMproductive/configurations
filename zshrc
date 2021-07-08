# Created by newuser for 5.8
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

prompt=">>%#"
