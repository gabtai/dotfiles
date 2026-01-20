#!/bin/bash

echo "--- Arch Linux & CachyOS Utótelepítő Szkript ---"

# 1. MAPPÁK LÉTREHOZÁSA (Hyprland & Csatolási pontok)
mkdir -p ~/.config/hypr
sudo mkdir -p /mnt/jatekok
sudo mkdir -p /mnt/adatok

# 2. SATA SSD-K AZONOSÍTÁSA
echo -e "\n--- SATA SSD Beállítás ---"
lsblk -f
echo "---------------------------"
echo "Másold be a JÁTÉKOKAT tartalmazó SSD UUID-ját:"
read JATEK_UUID
echo "Másold be az ADATOKAT tartalmazó SSD UUID-ját:"
read ADAT_UUID

# 3. FSTAB KONFIGURÁCIÓ (Optimalizált Btrfs)
echo -e "\nFSTAB frissítése..."
cat <<EOF | sudo tee -a /etc/fstab

# SATA SSD - Jatekok (Btrfs)
UUID=$JATEK_UUID /mnt/jatekok btrfs defaults,noatime,compress=zstd:3,autodefrag 0 2

# SATA SSD - Adatok (Btrfs)
UUID=$ADAT_UUID /mnt/adatok btrfs defaults,noatime,compress=zstd:3,autodefrag 0 2
EOF

# 4. HYPRLAND KONFIGURÁCIÓ FELDARABOLÁSA
echo "Hyprland konfigurációk generálása..."

# monitors.conf
cat <<EOF > ~/.config/hypr/monitors.conf
monitor=DP-1, 3440x1440@75, 0x0, 1, vrr, 1
EOF

# execs.conf
cat <<EOF > ~/.config/hypr/execs.conf
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = swww-daemon
exec-once = noctalia-shell
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
EOF

# rules.conf
cat <<EOF > ~/.config/hypr/rules.conf
windowrulev2 = workspace 4, class:^(discord)$
windowrulev2 = workspace 5, class:^(steam)$
windowrulev2 = immediate, class:^(gamescope)$
windowrulev2 = fullscreen, class:^(gamescope)$
EOF

# keybinds.conf
cat <<EOF > ~/.config/hypr/keybinds.conf
\$mainMod = SUPER

bind = \$mainMod, Q, exec, foot
bind = \$mainMod, C, killactive, 
bind = \$mainMod, V, togglefloating, 
bind = \$mainMod, R, exec, rofi -show drun

# Monitor fényerő ddcutil-lal (SUPER+F1/F2)
bind = \$mainMod, F1, exec, ddcutil setvcp 10 - 10
bind = \$mainMod, F2, exec, ddcutil setvcp 10 + 10

# Fókusz és Workspace-ek
bind = \$mainMod, left, movefocus, l
bind = \$mainMod, right, movefocus, r
bind = \$mainMod, 1, workspace, 1
bind = \$mainMod, 2, workspace, 2
bind = \$mainMod, 3, workspace, 3
bind = \$mainMod, 4, workspace, 4
bind = \$mainMod, 5, workspace, 5
EOF

# hyprland.conf (Fő fájl)
cat <<EOF > ~/.config/hypr/hyprland.conf
source = ~/.config/hypr/monitors.conf
source = ~/.config/hypr/execs.conf
source = ~/.config/hypr/rules.conf
source = ~/.config/hypr/keybinds.conf

input {
    kb_layout = hu
    follow_mouse = 1
}

general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(33ccffee) 45deg
    col.inactive_border = rgba(595959aa)
}

decoration {
    rounding = 10
    blur {
        enabled = true
        size = 3
    }
}
EOF

# 5. RENDSZER-SZINTŰ BEÁLLÍTÁSOK
echo "Kernel modulok és jogosultságok beállítása..."
echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c-dev.conf
sudo usermod -aG i2c $USER

# 6. FLATPAK JOGOSULTSÁGOK
flatpak override --user --filesystem=/mnt/jatekok com.valvesoftware.Steam

# 7. DIAGNOSZTIKA
echo -e "\n--- DIAGNOSZTIKA ÉS ELLENŐRZÉS ---"
sudo mount -a
sudo chown -R $USER:$USER /mnt/jatekok
sudo chown -R $USER:$USER /mnt/adatok

echo -e "\n[ZRAM Állapot]:"
zramctl

echo -e "\n[Btrfs Csatolási opciók]:"
mount | grep btrfs | grep compress

echo -e "\n[Monitor fényerő vezérlés]:"
if command -v ddcutil &> /dev/null; then
    sudo ddcutil detect | grep "Display" || echo "Monitor nem található DDC buszon."
fi

echo -e "\nKÉSZ! Indítsd újra a rendszert a változások érvényesítéséhez."
