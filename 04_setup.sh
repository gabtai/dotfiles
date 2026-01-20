#!/bin/bash
set -e
###################################################
###	Archlinux utólagos beállító script	###
###			v4.2 (FINAL)    				###
###################################################

# 1. SSD UUID-k lekérése
echo "--- Lemezek listázása az UUID-khoz ---"
lsblk -f
echo "-------------------------------------------------------"
echo "Másold be a GAMES SSD UUID-ját:"
read JATEK_UUID
echo "Másold be az DATA SSD UUID-ját:"
read ADAT_UUID

# 2. Csatolási pontok létrehozása
echo "Mappák létrehozása a /mnt alatt..."
sudo mkdir -p /mnt/GAMES /mnt/DATA

# 3. FSTAB konfigurálása (tmpfs + Btrfs optimalizáció)
# Itt adjuk hozzá a RAM disket és az SSD-ket az fstab-hoz
echo "FSTAB bejegyzések hozzáadása..."
cat <<EOF | sudo tee -a /etc/fstab

# Tmpfs a RAM-ban (Gyorsítja a rendszert, védi az SSD-t)
tmpfs   /tmp         tmpfs   rw,nodev,nosuid,size=8G,mode=1777   0   0

# SATA SSD-k Btrfs optimalizációval (noatime, compress, autodefrag)
UUID=$JATEK_UUID /mnt/GAMES btrfs defaults,noatime,compress=zstd:3,autodefrag 0 2
UUID=$ADAT_UUID /mnt/DATA btrfs defaults,noatime,compress=zstd:3,autodefrag 0 2
EOF

# 4. Snapper konfigurálása és automatizálás (Intelligens ellenőrzéssel)
if ! snapper list-configs | grep -q "root"; then
    echo "Snapper konfiguráció létrehozása..."
    sudo snapper -c root create-config /
    
    echo "Jogosultságok és időzítők (Timer) beállítása..."
    sudo chmod 750 /.snapshots
    # Alapértelmezett timerek aktiválása
    sudo systemctl enable --now snapper-boot.timer
    sudo systemctl enable --now snapper-timeline.timer
    sudo systemctl enable --now snapper-cleanup.timer
else
    echo "A Snapper konfig már létezik, a beállításokat átugrottam."
fi

# 5. Flatpak JOGOSULTSÁGOK
echo "Steam jogosultság megadása a GAMES SSD-hez..."
if command -v flatpak &> /dev/null; then
    # Csak a jogosultságot állítjuk be, mert a Steam már fent van
    flatpak override --user --filesystem=/mnt/GAMES com.valvesoftware.Steam
fi

# 6. Meghajtók csatolása és jogosultságok fixálása
echo "Meghajtók csatolása és jogosultságok beállítása..."
sudo mount -a
sudo chown -R $USER:$USER /mnt/GAMES
sudo chown -R $USER:$USER /mnt/DATA

echo "-------------------------------------------------------"
echo "RENDRAKÁS BEFEJEZVE! A rendszer készen áll."
echo "-------------------------------------------------------"
