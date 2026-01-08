#!/usr/bin/env zsh

zmodload zsh/datetime

precmd()
{
    local branch=""
    formatted_branch=""
    ssh_mark=""

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || return
        formatted_branch="%F{208}git_branch:$branch%f"
    fi

    if [[ -n $SSH_CONNECTION ]]; then
        ssh_mark="%F{red}[ssh]%f"
    fi
}

PROMPT='%B%F{green}%n@%m%f%b:%B%F{cyan}%~%f%b
%B%F{red}>%f %b'
RPROMPT='${ssh_mark:+$ssh_mark }%F{blue}%?%f${formatted_branch:+ $formatted_branch} %F{yellow}$(strftime %H:%M:%S)%f'
