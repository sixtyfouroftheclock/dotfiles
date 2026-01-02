#!/usr/bin/env zsh

zmodload zsh/datetime

precmd()
{
    local branch=""
    formatted_branch=""

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || return
        formatted_branch="%F{208}git_branch:$branch%f"
    fi
}

PROMPT='%B%F{green}%n@%m%f%b:%B%F{cyan}%~%f%b
%B%F{red}>%f %b'
RPROMPT='%F{blue}%?%f${formatted_branch:+ $formatted_branch} %F{yellow}$(strftime %H:%M:%S)%f'
