#!/bin/bash
set -e

echo "--- Foot terminál konfigurálása (Rendrakó Edition) ---"

# 1. Konfigurációs mappa létrehozása
mkdir -p ~/.config/foot

# 2. A konfigurációs fájl generálása
cat <<EOF > ~/.config/foot/foot.ini
# -*- conf -*-

# Betűtípus beállítása (JetBrains Mono Nerd Font)
font=JetBrainsMono Nerd Font:size=11
# A sorok közötti távolság és betűköz (opcionális finomhangolás)
line-height=14

[cursor]
style=block
color=111111 dcdccc
blink=yes

[mouse]
hide-when-typing=yes

[colors]
# Enyhén áttetsző háttér (ha a Hyprland támogatja)
alpha=0.95
background=111111
foreground=dcdccc

## Normal színek
regular0=111111  # black
regular1=f2777a  # red
regular2=99cc99  # green
regular3=ffcc66  # yellow
regular4=6699cc  # blue
regular5=cc99cc  # magenta
regular6=66cccc  # cyan
regular7=dcdccc  # white

[csd]
# Dekoratív elemek kikapcsolása (Hyprland kezeli az ablakkeretet)
size=0

[main]
# Belső margók (Padding) - Ez adja meg a "levegőt" a szöveg körül
pad=15x15
EOF

echo "Foot terminál gatyába rázva (JetBrains Mono + Margók)!"
