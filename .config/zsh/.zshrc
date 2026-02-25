# --- 1. ÚTVONALAK (fpath) ---
# Csak a saját pluginjaidat adjuk hozzá, a többit a rendszer tudja
fpath=($ZDOTDIR/plugins/zsh-async $ZDOTDIR/plugins/pure $fpath)

# --- 2. RENDSZER INDÍTÁSA ---
autoload -Uz compinit && compinit

# --- 3. ALAPBEÁLLÍTÁSOK ---
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory share_history interactivecomments

# Kiegészítési stílusok
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select

# --- 4. PLUGINOK (GitHubról) ---
# Zimfw Input (Billentyűk fixálása)
[ ! -d "$ZDOTDIR/plugins/input" ] && git clone --depth 1 https://github.com/zimfw/input "$ZDOTDIR/plugins/input"
source "$ZDOTDIR/plugins/input/init.zsh"


# Zsh-Extract
[ ! -d "$ZDOTDIR/plugins/zsh-extract" ] && git clone --depth 1 https://github.com/le0me55i/zsh-extract "$ZDOTDIR/plugins/zsh-extract"
source "$ZDOTDIR/plugins/zsh-extract/extract.plugin.zsh"

# --- 5. SYNTAX HIGHLIGHTING ---
if [ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# --- 6. EXTRÁK (Ablakcím & Aliasok) ---
case $TERM in
    xterm*|foot*|rxvt*)
        precmd() { print -Pn "\e]0;%n@%m: %~\a" }
        preexec() { print -Pn "\e]0;$1\a" }
        ;;
esac

autoload -Uz promptinit && promptinit
prompt pure

[[ -f "$HOME/.config/shell/aliasrc" ]] && source "$HOME/.config/shell/aliasrc"
