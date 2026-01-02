_precmd_title()
{
    print -Pn "\e]0;%n@%m:%~\a"
}


autoload -Uz add-zsh-hook
add-zsh-hook precmd _precmd_title
