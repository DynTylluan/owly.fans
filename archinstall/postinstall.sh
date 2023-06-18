#!/bin/bash

## install AUR helper

mkdir -p build
cd build
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -sic
cd ~
yay --gendb
yay --devel --nodiffmenu --save


## install more desktop stuff
### note: https://github.com/PrismLauncher/PrismLauncher/issues/991 so we use the qt5 version for now

yay -S --noconfirm \
  xfce4-goodies xfce4-docklike-plugin catfish mugshot polkit-gnome xdg-desktop-portal-gtk \
  ntfsprogs-ntfs3 \
  jre8-openjdk jre17-openjdk prismlauncher-qt5-bin \
  fastfetch-bin notepadqq pinta \
  hexchat discord \
  nextcloud-client \
  pacman-contrib git zip unzip unrar gvfs-mtp kernel-modules-hook ttf-ubuntu-font-family adobe-source-han-sans-jp-fonts \
  qpwgraph vlc yt-dlp spotify-adblock

## set up flatpaks

yay -S --noconfirm flatpak gnome-software
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.spotify.desktop
flatpak install flathub io.github.shiftey.Desktop  # github desktop
flatpak install flathub org.audacityteam.Audacity
flatpak install flathub com.obsproject.Studio
flatpak install flathub com.github.huluti.Curtail
flatpak install flathub org.zdoom.GZDoom
flatpak install flathub org.chocolate_doom.ChocolateDoom

## system config

### services
sudo systemctl enable systemd-boot-update
sudo systemctl enable linux-modules-cleanup
sudo systemctl enable paccache.timer
### enable pacman chomp animation
sudo sed -i '/#Color/s/#Color/Color\nILoveCandy/g' /etc/pacman.conf
