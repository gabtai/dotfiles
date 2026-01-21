#!/bin/bash
set -e
###################################################
###    Bash Konfiguráló Script (Rendrakó)       ###
###    v1.2 - Absolute Minimalist               ###
###################################################

echo "--- Bash kényelmi funkciók beállítása ---"

cat <<EOF > ~/.bashrc
# --- 1. Alapvető színek és kényelem ---
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# --- 2. History ---
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend

# --- 3. Aliasok ---
alias ..='cd ..'
alias ...='cd ../..'
alias update='sudo pacman -Syu'
alias mc='mc -u'

# --- 4. Extract (Univerzális kicsomagoló) ---
extract() {
    if [ -f \$1 ] ; then
        case \$1 in
            *.tar.bz2)   tar xjf \$1     ;;
            *.tar.gz)    tar xzf \$1     ;;
            *.bz2)       bunzip2 \$1     ;;
            *.rar)       unrar x \$1     ;;
            *.gz)        gunzip \$1      ;;
            *.tar)       tar xf \$1      ;;
            *.zip)       unzip \$1       ;;
            *.7z)        7z x \$1        ;;
            *)           echo "'\$1' nem kicsomagolható" ;;
        esac
    else
        echo "'\$1' nem érvényes fájl"
    fi
}
EOF

echo "Bash konfiguráció kész. Letisztult, stabil, gyors."
