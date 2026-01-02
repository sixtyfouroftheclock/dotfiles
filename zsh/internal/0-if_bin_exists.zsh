#!/usr/bin/env zsh

if_bin_exists()
{
    local binary="$1"
    shift
    command -v "$binary" >/dev/null 2>&1 && "$@"
}
