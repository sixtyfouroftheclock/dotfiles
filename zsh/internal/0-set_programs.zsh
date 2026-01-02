#!/usr/bin/env zsh

if_bin_exists vim
{
    export EDITOR="/usr/bin/vim"
}
if_bin_exists lsd
{
    alias ls="lsd --group-directories-first --header --icon=never"
}
if_bin_exists most
{
    alias less="most"
}

alias grep='grep --color=auto'
