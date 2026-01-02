#!/usr/bin/env zsh

zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:git:*" formats "on (%b)"
zstyle ":vcs_info:git:*" check-for-changes true
