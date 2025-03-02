#!/bin/bash
set -e

paru -S --noconfirm --needed downgrade
paru -S --noconfirm --needed google-chrome
paru -S --noconfirm --needed shortwave
paru -S --noconfirm --needed heroic-games-launcher-bin
paru -S --noconfirm --needed capitaine-cursors
paru -S --noconfirm --needed minecraft-launcher
paru -S --noconfirm --needed jellyfin-media-player
paru -S --noconfirm --needed video-downloader
paru -S --noconfirm --needed spacecadetpinball-bin
paru -S --noconfirm --needed protonup-qt

## MANGOHUD HASZNÁLATA STEAMBEN ## Indítási opciók-> mangohud %command% ##
## MANGOHUD HASZNÁLATA LUTRISBAN ## Beállítások -> System fül (alul advanced pipa be) Command prefix-hez -> mangohud
