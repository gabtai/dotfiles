#!/bin/bash
set -e
###################################################
###    Zsh & Zimfw Konfiguráló Script           ###
###    v1.1 (Minimál git, Max sebesség)         ###
###################################################

echo "--- Zsh és Zimfw beállítása ---"

# 1. Zimfw letöltése és telepítése
if [ ! -f ${ZDOTDIR:-${HOME}}/.zim/zimfw.zsh ]; then
    echo "Zimfw telepítése..."
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
else
    echo "Zimfw már telepítve van."
fi

# 2. .zimrc módosítása (Letisztult lista)
echo "Zimfw modulok konfigurálása..."
cat <<EOF > ${ZDOTDIR:-${HOME}}/.zimrc
# Modulok listája (Git nélkül)
zmodule archive
zmodule completion
zmodule zsh-users/zsh-autosuggestions
zmodule zsh-users/zsh-syntax-highlighting
zmodule romkatv/powerlevel10k --use degit
EOF

# 3. Zimfw frissítése és modulok letöltése
echo "Modulok letöltése és telepítése..."
zsh ~/.zim/zimfw.zsh install

# 4. Alapértelmezett Shell váltás
if [[ $SHELL != "/usr/bin/zsh" ]]; then
    echo "Zsh beállítása alapértelmezett shellnek..."
    sudo chsh -s $(which zsh) $USER
fi

echo "-------------------------------------------------------"
echo "ZSH BEÁLLÍTVA!"
echo "Nyiss egy új terminált a P10k konfigurálásához."
echo "-------------------------------------------------------"
