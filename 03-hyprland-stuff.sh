#!/bin/bash
set -e

################################################
###		    HYPRLAND		     ###
###		Specifikus cuccok	     ###
################################################

#sudo pacman -S --noconfirm --needed hyprcursor 
sudo pacman -S --noconfirm --needed hypridle
sudo pacman -S --noconfirm --needed hyprland
sudo pacman -S --noconfirm --needed hyprlock
sudo pacman -S --noconfirm --needed qt5-wayland
sudo pacman -S --noconfirm --needed qt6-wayland
sudo pacman -S --noconfirm --needed dunst
#sudo pacman -S --noconfirm --needed hyprpaper
#sudo pacman -S --noconfirm --needed hyprpicker
sudo pacman -S --noconfirm --needed hyprpoliktagent
#sudo pacman -S --noconfirm --needed hyprsunset
#sudo pacman -S --noconfirm --needed nwg-displays
sudo pacman -S --noconfirm --needed nwg-look
sudo pacman -S --noconfirm --needed nwg-panel
sudo pacman -S --noconfirm --needed xdg-desktop-portal-hyprland
#sudo pacman -S --noconfirm --needed slurp
#sudo pacman -S --noconfirm --needed grim
sudo pacman -S --noconfirm --needed wlogout
#sudo pacman -S --noconfirm --needed xorg-xwayland
#sudo pacman -S --noconfirm --needed xdg-utils
#sudo pacman -S --noconfirm --needed mako
#sudo pacman -S --noconfirm --needed lxappearance
#sudo pacman -S --noconfirm --needed kvantum
#sudo pacman -S --noconfirm --needed wl-clipboard
#sudo pacman -S --noconfirm --needed archlinux-xdg-menu
#sudo pacman -S --noconfirm --needed xdg-desktop-portal-kde
#sudo pacman -S --noconfirm --needed xdg-desktop-portal-wlr
#sudo pacman -S --noconfirm --needed xdg-desktop-portal-gtk

paru -S tofi
