#!/bin/bash

CONF="/etc/makepkg.conf"
BACKUP="/etc/makepkg.conf.bak.$(date +%F_%T)"

# Biztonsági mentés készítése
sudo cp "$CONF" "$BACKUP"
echo "Biztonsági mentés készült ide: $BACKUP"

# CFLAGS és CXXFLAGS beállítása -march=native értékkel
sudo sed -i '/^CFLAGS=/ s/-march=x86-64\b/-march=native/' "$CONF"
sudo sed -i '/^CFLAGS=/ s/-mtune=generic\b//' "$CONF"
# sudo sed -i -r 's/^CFLAGS=.*/CFLAGS="-march=native -O2 -pipe -fno-plt -fexc/' "$CONF"
sudo sed -i -r 's/^CXXFLAGS=.*/CXXFLAGS="\$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"/' "$CONF"

# MAKEFLAGS beállítása a magok számához igazítva
sudo sed -i -r 's/^MAKEFLAGS=.*/MAKEFLAGS="-j$(nproc)"/' "$CONF"

# debug opció eltávolítása az OPTIONS-ból (ha jelen van)
sudo sed -i '/^OPTIONS=/ s/\bdebug\b/!debug/' "$CONF"

# Többszálas xz tömörítés engedélyezése
sudo sed -i -r 's/^COMPRESSXZ=.*/COMPRESSXZ=(xz -c -z - --threads=0)/' "$CONF"

echo "Módosítások alkalmazva a $CONF fájlban."
echo "Ellenőrizd a fájlt, majd indítsd újra a buildet, ha szükséges."
