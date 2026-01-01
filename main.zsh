#
# Function to work in multiple config.
#

if_bin_exists()
{
    local binary="$1"
    shift
    command -v "$binary" >/dev/null 2>&1 && "$@"
}

#
# Aliases
#

if_bin_exists vim export EDITOR="/usr/bin/vim"
if_bin_exists lsd alias ls="lsd --group-directories-first --header --icon=never"
if_bin_exists most alias less="most"

alias grep='grep --color=auto'

#
# Loading...
#

autoload -Uz compinit # Autocomplete
autoload -Uz vcs_info # Version control system 
compinit # Autocompletion init

#
# ZSH styles
#

zstyle ":completion:*" menu select
zstyle ":completion:*" use-cache on
zstyle ":completion:*" verbose yes
zstyle ":completion:*" cache-path ~/.cache/zcompdump
zstyle ":completion:*:commands" rehash 1
zstyle ":completion:*:default" list-colors "$LS_COLORS"
zstyle ":completion:*:descriptions" format "%F{yellow}%B%d%b%f"

zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:git:*" formats "on (%b)"
zstyle ":vcs_info:git:*" check-for-changes true

#
# Bindkeys
#

bindkey "^[[3~" delete-char
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "\e[3;5~" kill-word

#
# Modules
#

zmodload zsh/datetime

#
# Options
#

setopt AUTO_CD AUTO_LIST AUTO_MENU AUTO_NAME_DIRS AUTO_PARAM_KEYS AUTO_PARAM_SLASH COMPLETE_ALIASES GLOB_COMPLETE EXTENDED_GLOB prompt_subst

#
# Prompt sutff
#

precmd()
{
    local short_dir="${PWD:t}"
    local branch=""

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        [[ -n $branch && $branch != HEAD ]] && branch="($branch)"
    fi

    print -Pn "\033]0;${short_dir} ${branch}\007"
    print -P "%B%F{green}%n@%m%f:%F{cyan}%~%f%b %F{blue}${branch}%f"
}

PROMPT="%F{red}>%f "
RPROMPT='%F{blue}%?%f %F{yellow}$(strftime %H:%M:%S)%f'

    
#
# Unsetting necessary function
#

unset -f if_bin_exists
