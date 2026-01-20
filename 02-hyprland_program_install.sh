#!/bin/bash
set -e
###################################################
###	Archlinux program telepítő script	###
###			v4.0 (HYPRLAND)				###
###################################################

echo "--- CachyOS és Felhasználói Programok Telepítése ---"

# 1. Rendszer és Boot kezelés
echo "Rendszer alapok telepítése..."
sudo pacman -S --noconfirm \
    linux-cachyos linux-cachyos-headers \
    systemd-boot-manager \
    cachyos-settings cachyos-hooks \
    btrfs-assistant snapper snap-pac

# 2. Hyprland, UI és Thunar
echo "Grafikus környezet és Thunar telepítése..."
sudo pacman -S --noconfirm \
    hyprland swww foot ddcutil wlsunset thunar \
    thunar-archive-plugin thunar-volman tumbler ffmpegthumbnailer \
    gvfs mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
    xdg-desktop-portal-hyprland polkit-gnome \
    qt5-wayland qt6-wayland fakeroot \
    ttf-jetbrains-mono-nerd

# 3. Gaming és Performance
echo "Gaming eszközök telepítése..."
sudo pacman -S --noconfirm flatpak gamemode lib32-gamemode mangohud

# 4. AUR csomagok (Noctalia, nwg-hello, greetd)
echo "AUR csomagok fordítása (Noctalia-shell, nwg-hello)..."
yay -S --noconfirm \
    noctalia-shell-git \
    nwg-hello \
    greetd

# 5. Boot bejegyzések legenerálása
# A pontosított parancs: sdboot-manage gen
echo "Boot bejegyzések inicializálása..."
sudo sdboot-manage gen

echo "-------------------------------------------------------"
echo "A programtelepítés befejeződött!"
echo "Következő lépés: futtasd a setup.sh-t az SSD-khez és fstab-hoz."
echo "-------------------------------------------------------"
