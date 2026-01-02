#!/usr/bin/env zsh

autoload -Uz compinit # Autocomplete
compinit # Autocompletion init

zstyle ":completion:*" menu select
zstyle ":completion:*" use-cache on
zstyle ":completion:*" verbose yes
zstyle ":completion:*" cache-path ~/.cache/zcompdump
zstyle ":completion:*:commands" rehash 1
zstyle ":completion:*:default" list-colors "$LS_COLORS"
zstyle ":completion:*:descriptions" format "%F{yellow}%B%d%b%f"
