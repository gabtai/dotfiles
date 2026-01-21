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

# 4. echo "--- Snapper konfigurációk (root és home) finomhangolása ---"

# Felhasználó hozzáadása a konfigokhoz (hogy lásd őket sudo nélkül is)
sudo snapper -c root set-config "ALLOW_USERS=$USER" "SYSLOG=yes"
sudo snapper -c home set-config "ALLOW_USERS=$USER" "SYSLOG=yes"

# Jogosultságok javítása a .snapshots mappákon
sudo chown -R :$USER /.snapshots
sudo chown -R :$USER /home/.snapshots

# Túlélési szabályok beállítása (Ne gyűljön a szemét)
# Csak az utolsó 5 órás, 7 napi és 0 havi mentést tartjuk meg
for config in root home; do
    sudo snapper -c $config set-config "TIMELINE_LIMIT_HOURLY=5"
    sudo snapper -c $config set-config "TIMELINE_LIMIT_DAILY=7"
    sudo snapper -c $config set-config "TIMELINE_LIMIT_WEEKLY=0"
    sudo snapper -c $config set-config "TIMELINE_LIMIT_MONTHLY=0"
    sudo snapper -c $config set-config "TIMELINE_LIMIT_YEARLY=0"
    
    # Pacman tranzakciók (snap-pac) száma: max 10
    sudo snapper -c $config set-config "NUMBER_LIMIT=10"
    sudo snapper -c $config set-config "NUMBER_LIMIT_IMPORTANT=10"
done

# Időzítők bekapcsolása (hogy a fenti szabályok alapján töröljön is a rendszer)
sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer

echo "Snapper rendbe rakva: szigorúbb korlátok és felhasználói hozzáférés beállítva."

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
