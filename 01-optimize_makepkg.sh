#!/bin/bash

CONF="/etc/makepkg.conf"
BACKUP="/etc/makepkg.conf.bak.$(date +%F_%T)"

if [ ! -w "$CONF" ]; then
  echo "Hiba: a szkriptet root-ként kell futtatni, hogy módosíthassa a $CONF fájlt."
  exit 1
fi

# Biztonsági mentés készítése
cp "$CONF" "$BACKUP"
echo "Biztonsági mentés készült ide: $BACKUP"

# CFLAGS és CXXFLAGS beállítása -march=native értékkel
sed -i -r 's/^CFLAGS=.*/CFLAGS="-march=native -O2 -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=3 -Wformat -Werror=format-security -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer"/' "$CONF"
sed -i -r 's/^CXXFLAGS=.*/CXXFLAGS="\$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"/' "$CONF"

# MAKEFLAGS beállítása a magok számához igazítva
sed -i -r 's/^MAKEFLAGS=.*/MAKEFLAGS="-j$(nproc)"/' "$CONF"

# debug opció eltávolítása az OPTIONS-ból (ha jelen van)
sed -i 's/\bdebug\b//g' "$CONF"

# Többszálas xz tömörítés engedélyezése
sed -i -r 's/^COMPRESSXZ=.*/COMPRESSXZ=(xz -c -z - --threads=0)/' "$CONF"

echo "Módosítások alkalmazva a $CONF fájlban."
echo "Ellenőrizd a fájlt, majd indítsd újra a buildet, ha szükséges."
