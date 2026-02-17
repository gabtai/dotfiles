# Powerlevel10k indítása (azonnali megjelenés)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Segédfüggvények betöltése
source "$ZDOTDIR/zsh-functions"

# Előzmények beállítása
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Pluginok betöltése
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "le0me55i/zsh-extract"

# Powerlevel10k téma betöltése
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Aliasok és egyedi beállítások (Mindig a végén!)
[[ -f "$ZDOTDIR/aliasrc" ]] && source "$ZDOTDIR/aliasrc"

# Tab-kiegészítés inicializálása
autoload -Uz compinit && compinit
