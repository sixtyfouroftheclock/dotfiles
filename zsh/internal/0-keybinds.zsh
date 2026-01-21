#!/usr/bin/env zsh

bindkey '^[[3~' delete-char
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
bindkey '\e[3;5~' kill-word
bindkey '^[[Z' undo