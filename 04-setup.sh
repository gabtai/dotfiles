#!/bin/bash
set -e
###################################################
###	Archlinux utólagos beállító script	###
###			v4.3 (GRUB + Snapper)			###
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
echo "FSTAB bejegyzések hozzáadása..."
cat <<EOF | sudo tee -a /etc/fstab

# Tmpfs a RAM-ban (Gyorsítja a rendszert, védi az SSD-t)
tmpfs   /tmp         tmpfs   rw,nodev,nosuid,size=8G,mode=1777   0   0

# SATA SSD-k Btrfs optimalizációval (noatime, compress, autodefrag)
UUID=$JATEK_UUID /mnt/GAMES btrfs defaults,noatime,compress=zstd:3,autodefrag 0 2
UUID=$ADAT_UUID /mnt/DATA btrfs defaults,noatime,compress=zstd:3,autodefrag 0 2
EOF

# 4. SNAPPER KONFIGURÁCIÓK FINOMHANGOLÁSA
echo "--- Snapper konfigurációk finomhangolása ---"

# Felhasználó hozzáadása és szabályok
for config in root home; do
    sudo snapper -c $config set-config "ALLOW_USERS=$USER" "SYSLOG=yes"
    sudo snapper -c $config set-config "TIMELINE_LIMIT_HOURLY=5"
    sudo snapper -c $config set-config "TIMELINE_LIMIT_DAILY=7"
    sudo snapper -c $config set-config "TIMELINE_LIMIT_WEEKLY=0"
    sudo snapper -c $config set-config "TIMELINE_LIMIT_MONTHLY=0"
    sudo snapper -c $config set-config "TIMELINE_LIMIT_YEARLY=0"
    sudo snapper -c $config set-config "NUMBER_LIMIT=10"
    sudo snapper -c $config set-config "NUMBER_LIMIT_IMPORTANT=10"
done

# Jogosultságok és időzítők
sudo chown -R :$USER /.snapshots /home/.snapshots
sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer

# 5. GRUB OKOSÍTÁSA
echo "--- GRUB beállítása (Ultrawide, Mentés, Snapshotok) ---"

# Felbontás és utolsó választás beállítása
sudo sed -i 's/GRUB_GFXMODE=.*/GRUB_GFXMODE=3440x1440x32,auto/' /etc/default/grub
sudo sed -i 's/GRUB_DEFAULT=.*/GRUB_DEFAULT=saved/' /etc/default/grub

# A kikommentezett SAVEDEFAULT aktiválása (töröljük a #-et az elejéről)
if grep -q "#GRUB_SAVEDEFAULT=true" /etc/default/grub; then
    sudo sed -i 's/#GRUB_SAVEDEFAULT=true/GRUB_SAVEDEFAULT=true/' /etc/default/grub
# Ha esetleg egyáltalán nincs benne a fájlban, akkor azért adjuk hozzá
elif ! grep -q "GRUB_SAVEDEFAULT=true" /etc/default/grub; then
    echo "GRUB_SAVEDEFAULT=true" | sudo tee -a /etc/default/grub
fi

# Snapshot figyelő daemon indítása (grub-btrfs része)
sudo systemctl enable --now grub-btrfsd

# GRUB menü újragenerálása
sudo grub-mkconfig -o /boot/grub/grub.cfg

# 6. FLATPAK JOGOSULTSÁGOK
echo "Steam jogosultság megadása..."
if command -v flatpak &> /dev/null; then
    flatpak override --user --filesystem=/mnt/GAMES com.valvesoftware.Steam
fi

# 7. MEGHAJTÓK CSATOLÁSA ÉS JOGOSULTSÁGOK FIXÁLÁSA
echo "Meghajtók csatolása és jogosultságok beállítása..."
sudo mount -a
sudo chown -R $USER:$USER /mnt/GAMES
sudo chown -R $USER:$USER /mnt/DATA

echo "-------------------------------------------------------"
echo "RENDRAKÁS BEFEJEZVE! A rendszer készen áll."
echo "-------------------------------------------------------"
