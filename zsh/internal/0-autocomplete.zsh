#!/usr/bin/env zsh

autoload -Uz compinit # Autocomplete
compinit # Autocompletion init

zstyle ':completion:*' menu select
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' list-colors '$LS_COLORS'
zstyle ':completion:*' cache-path ~/.cache/zcompdump
zstyle ':completion:*' rehash true
zstyle ':completion:*' verbose true
zstyle ':completion:*:descriptions' format '%F{yellow}%B%d%b%f'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
