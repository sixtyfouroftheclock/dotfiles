#!/usr/bin/env zsh

if_bin_exists vim export EDITOR="vim"
if_bin_exists lsd alias ls="lsd --group-directories-first --header --icon=never"
if_bin_exists most alias less="most"
if_bin_exists batcat alias cat="batcat"
if_bin_exists fdfind alias fd="fdfind"
if_bin_exists rg alias grep="rg"
