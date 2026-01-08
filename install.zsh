#!/usr/bin/env zsh

SCRIPT_DIRECTORY=$(dirname "$0")
ZSH_SOURCE_DIRECTORY=${SCRIPT_DIRECTORY}/zsh


if [ ! -d "${ZSH_SOURCE_DIRECTORY}" ]
then
    print -P "${ZSH_SOURCE_DIRECTORY} directory is missing."
    exit 2
fi

clear

ZSHRC_FILE_NOT_EXPANDED='$HOME/.zshrc'
ZSHRC_FILE_EXPANDED="$HOME/.zshrc"

ZSHD_DIRECTORY_NOT_EXPANDED='$HOME/.zsh.d'
ZSHD_DIRECTORY_EXPANDED="$HOME/.zsh.d"

print -P "
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃                                                                       ┃
┃ ╻       ╻ ┏━━━━━━━╸ ╻         ┏━━━━━━━╸ ┏━━━━━━━┓ ┏━━━┳━━━┓ ┏━━━━━━━╸ ┃
┃ ┃       ┃ ┃         ┃         ┃         ┃       ┃ ┃   ┃   ┃ ┃         ┃
┃ ┃   ╻   ┃ ┣━━━━╸    ┃         ┃         ┃       ┃ ┃   ╹   ┃ ┣━━━━╸    ┃
┃ ┃   ┃   ┃ ┃         ┃         ┃         ┃       ┃ ┃       ┃ ┃         ┃
┃ ┗━━━┻━━━┛ ┗━━━━━━━╸ ┗━━━━━━━╸ ┗━━━━━━━╸ ┗━━━━━━━┛ ╹       ╹ ┗━━━━━━━╸ ┃
┃                                                                       ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                                       ┃
┃      Welcome to %F{blue}%BOK_ZSH%b%f This is a simple ZSH configuration for my      ┃
┃                              enviroment!                              ┃
┃                                                                       ┃
┃                  Press %B%F{yellow}ENTER%f%b to start the installation                ┃
┃                                                                       ┃
┃                                v26.0                                  ┃
┃                             Peace of mind.                            ┃
┃                                                                       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
"

read

#
# Verbose mode. Use -v or --verbose.
#

VERBOSE=0
[[ $1 == "-v" || $1 == "--verbose" ]] && VERBOSE=1 && shift

#
# Functions
#

cp()
{
    if (( VERBOSE )); then
        command cp -v "$@"
    else
        command cp "$@"
    fi
}

rm()
{
    if (( VERBOSE )); then
        command rm -v "$@"
    else
        command rm "$@"
    fi
}

mv()
{
    if (( VERBOSE )); then
        command mv -v "$@"
    else
        command mv "$@"
    fi
}

separate_lines()
{
    print "
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
"
}

delete_files()
{
    if (( $# == 0 )); then
        return 1
    fi

    print -Pn "%B%F{red}Remove %F{green}$@%f%b? y/n -> "
    read -r confirmation
    [[ $confirmation != y ]] && { print "Aborting..."; exit 2 }

    rm -r -- "$@"
}

# Scanning if there's another `.zshrc` file.

if [[ -e "$ZSHRC_FILE_EXPANDED" ]]; then
    print -P "A configuration file already exists in %F{green}%B$ZSHRC_FILE_NOT_EXPANDED%f%b."
    print -Pn "Are you sure you wanna continue? The current file is going to be %F{blue}%Bmoved%b%f to %F{green}%B${ZSHRC_FILE_NOT_EXPANDED}.bak%f%b. (y/n) "
    read -r confirmation
    [[ $confirmation != y ]] && { print "Aborting..."; exit 2 }
    
    rm "${ZSHRC_FILE_EXPANDED}.bak"
    mv "${ZSHRC_FILE_EXPANDED}" "${ZSHRC_FILE_EXPANDED}.bak"
fi

if [[ -f "$ZSHD_DIRECTORY_EXPANDED" ]]; then
    print -P "%F{green}%B$ZSHD_DIRECTORY_EXPANDED%f%b is a file. Remove it and run this installation again."
    exit 1
fi

separate_lines

print -P "Creating directory in %F{green}%B${ZSHD_DIRECTORY_NOT_EXPANDED}%f%b..."
mkdir -p $ZSHD_DIRECTORY_EXPANDED
print "Copying files..."

cp -R "$ZSH_SOURCE_DIRECTORY"/. "$ZSHD_DIRECTORY_EXPANDED"/

print -P "Creating file %B%F{green}$ZSHRC_FILE_NOT_EXPANDED%f%b..."

print -P "# Hold on!
# I think it's better for you to use $HOME/.zsh.d to customize your zsh.

setopt EXTENDED_GLOB

for file in ~/.zsh.d/internal/**/*.zsh(N) ~/.zsh.d/**/*.zsh(N:^*/internal/*); do
    source \"\$file\"
done
" > "$ZSHRC_FILE_EXPANDED"

separate_lines

print -P "Done. To customize your ZSH, use %B%F{green}${ZSHD_DIRECTORY_NOT_EXPANDED}%b%f!"
print -P "But before, you may need to apply settings restarting this shell or sourcing into %B%F{green}$ZSHRC_FILE_NOT_EXPANDED%b%f using %F{243}source $ZSHRC_FILE_NOT_EXPANDED%f."
