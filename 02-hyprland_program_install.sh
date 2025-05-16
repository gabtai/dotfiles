#!/bin/bash
set -e
###################################################
###	Archlinux program telepítő script	###
###		v3.0 (HYPRLAND)			###
###################################################

CPU=$(lscpu | grep "AMD" -c)

sudo pacman -Syyu --noconfirm

# KIEGÉSZÍTŐ PROGRAMOK

sudo pacman -S --noconfirm --needed btop reflector xdg-user-dirs imagemagick fastfetch

# TÖMÖRÍTŐK
#sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller
#sudo pacman -S --noconfirm --needed tar zip unrar 7zip

# BETŰTÍPUSOK

sudo pacman -S otf-font-awesome ttf-fira-sans ttf-fira-code ttf-dejavu ttf-jetbrains-mono-nerd /
ttf-firacode-nerd noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra


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
