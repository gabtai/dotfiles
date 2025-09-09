#!/bin/bash

SWAPFILE="/swapfile"
SWAPSIZE_GB=8

# Ellenőrizzük, hogy root-ként fut-e a script
if [ "$(id -u)" -ne 0 ]; then
    echo "Futtasd a scriptet root-ként vagy sudo-val!"
    exit 1
fi

# Ha már van swapfile, kérdezzük meg, akarja-e felülírni
if [ -f "$SWAPFILE" ]; then
    read -p "$SWAPFILE már létezik. Felülírja? (y/n): " answer
    case "$answer" in
        [Yy]* ) echo "Felülírás...";;
        * ) echo "Kilépés."; exit 1;;
    esac
fi

echo "Létrehozás: $SWAPSIZE_GB GB swapfile $SWAPFILE..."
fallocate -l ${SWAPSIZE_GB}G "$SWAPFILE"

echo "Jogosultságok beállítása..."
chmod 600 "$SWAPFILE"

echo "Swap fájl formázása..."
mkswap "$SWAPFILE"

echo "Swap aktiválása..."
swapon "$SWAPFILE"

echo "Swap ellenőrzése:"
swapon --show

# Ellenőrizzük, hogy már van-e bejegyzés az fstab-ban
if grep -q "^$SWAPFILE" /etc/fstab; then
    echo "Bejegyzés már létezik a /etc/fstab fájlban."
else
    echo "Bejegyzés hozzáadása a /etc/fstab fájlhoz..."
    echo "$SWAPFILE none swap defaults 0 0" >> /etc/fstab
fi

echo "Kész! Az 8 GB-os swap használatra kész és automatikusan betöltődik újraindításkor."
