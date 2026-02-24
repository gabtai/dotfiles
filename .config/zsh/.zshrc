# --- 1. Alapok és Funkciók ---
# A függvényeknek elöl kell lenniük, hogy használhassuk őket
source "$ZDOTDIR/zsh-functions"

# --- 2. Prompt és Elérési utak (fpath) ---
# A Pure Prompt-nak az fpath-ban kell lennie a compinit előtt!
fpath=($ZDOTDIR/plugins/zsh-async $ZDOTDIR/plugins/pure $fpath)

autoload -Uz promptinit && promptinit
prompt pure

# --- 3. Kiegészítő rendszer (Luke-féle optimalizáció) ---
# A kiegészítők beállítása a Pure után, de a pluginok ELŐTT
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# --- 4. Előzmények (History) ---
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt share_history
setopt interactivecomments

# --- 5. Pluginok betöltése ---
# A syntax-highlighting mindig az utolsó plugin legyen a listában!
zsh_add_plugin "zimfw/input"
zsh_add_plugin "zsh-users/zsh-completions"
zsh_add_plugin "le0me55i/zsh-extract"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# --- 6. Dinamikus ablakcím (Luke-féle) ---
case $TERM in
    xterm*|foot*|rxvt*)
        precmd() { print -Pn "\e]0;%n@%m: %~\a" }
        preexec() { print -Pn "\e]0;$1\a" }
        ;;
esac

# --- 7. Moduláris beállítások ---
[[ -f "$HOME/.config/shell/aliasrc" ]] && source "$HOME/.config/shell/aliasrc"
