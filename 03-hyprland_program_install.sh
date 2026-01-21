#!/bin/bash
set -e
###################################################
###	Archlinux program telepítő script	###
###			v5.2 (CACHYOS OPTIMIZED)	###
###################################################

echo "--- Alaprendszer és AUR Helper telepítése ---"

# 1. CachyOS specifikus yay és alapok telepítése
# Mivel a cachyos-v3/v4 repók már élnek, a yay-t pacmanból húzzuk
sudo pacman -S --noconfirm \
    linux-cachyos linux-cachyos-headers \
    yay \
    bash-completion base-devel \
    cachyos-settings \
    btrfs-assistant snapper snap-pac \
    grub-btrfs inotify-tools

# 2. Hyprland, UI és Thunar
echo "Grafikus felület és fájlkezelő telepítése..."
sudo pacman -S --noconfirm \
    hyprland swww foot ddcutil wlsunset thunar \
    thunar-archive-plugin thunar-volman tumbler ffmpegthumbnailer \
    gvfs mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon \
    xdg-desktop-portal-hyprland polkit-gnome \
    qt5-wayland qt6-wayland ttf-jetbrains-mono-nerd

# 3. Flatpak alkalmazások (Steam, Discord)
echo "Flatpak alkalmazások telepítése..."
sudo pacman -S --noconfirm flatpak gamemode lib32-gamemode mangohud

# Flathub repó aktiválása
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Alkalmazások telepítése
flatpak install -y flathub com.valvesoftware.Steam
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.heroicgameslauncher.hgl

# 4. AUR csomagok (már a yay-t használjuk)
echo "AUR csomagok telepítése (Noctalia)..."
yay -S --noconfirm noctalia-shell-git nwg-hello greetd

echo "-------------------------------------------------------"
echo "AZ ALKALMAZÁSOK TELEPÍTÉSE KÉSZ!"
echo "-------------------------------------------------------"
