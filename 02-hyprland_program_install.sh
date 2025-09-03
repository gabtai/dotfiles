#!/bin/bash
set -e
###################################################
###	Archlinux program telepítő script	###
###		v3.0 (HYPRLAND)			###
###################################################

CPU=$(lscpu | grep "AMD" -c)

sudo pacman -Syyu --noconfirm

# Hyprland es tartozekai

sudo pacman -S hyprland foot hyprsunset swaync gtklock

# KIEGÉSZÍTŐ PROGRAMOK

sudo pacman -S --noconfirm --needed udiskie reflector xdg-user-dirs \
imagemagick fastfetch network-manager-applet bat git fastfetch \
polkit-gnome openrgb flatpak hblock mousepad mc zsh openrgb solaar \
thunar thunar-archive-plugin xdg-user-dirs xdg-desktop-portal-gtk \
pavucontrol xdg-desktop-portal-hyprland

# Theams
sudo pacman -S --noconfirm --needed papirus-icon-theme nwg-look nwg-panel


# TÖMÖRÍTŐK
#sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller
#sudo pacman -S --noconfirm --needed tar zip unrar 7zip
sudo pacman -S --noconfirm --needed file-roller zip unrar 7zip unzip

# BETŰTÍPUSOK

sudo pacman -S otf-font-awesome ttf-dejavu noto-fonts noto-fonts-emoji cantarell-fonts

# Gaming

sudo pacman -S lutris steam gamemode lib32-gamemode corectrl \
discord wine-staging wine-mono wine-gecko 

# UCode installer - Credit Lordify
  if [[ $CPU -gt 0 ]]; then
	  sudo pacman -S amd-ucode --noconfirm
  else
	  sudo pacman -S intel-ucode --noconfirm
  fi

# Adding ucode to boot entries - Credit Lordify
  if [[ $CPU -gt 0 ]]; then
	  echo "initrd   /amd-ucode.img" | sudo tee -a /boot/loader/entries/*.conf
  else
	  echo "initrd   /intel-ucode.img" | sudo tee -a /boot/loader/entries/*.conf
  fi
