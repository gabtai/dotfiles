# Előzmények (History) beállítása az új helyen
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Alapvető opciók
setopt autocd              # Csak beírod a mappa nevét és belép
setopt extendedglob        # Bővített globbing minták
setopt hist_ignore_all_dups # Duplikált parancsok kiszűrése az előzményekből

# Alapértelmezett kiegészítő rendszer (Completion)
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# Arch Linux specifikus pluginok (ha telepítetted őket pacman-nel)
# sudo pacman -S zsh-syntax-highlighting zsh-autosuggestions
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Egyszerű Prompt (vagy használhatsz starship-et is)
PROMPT='%F{cyan}%n%f@%F{blue}%m%f %F{green}%~%f %# '

# Aliasok a gyorsabb munkához
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias update='sudo pacman -Syu'
