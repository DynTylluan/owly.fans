    #!/bin/bash
    # connect to internet, then run the following:
    #     pacman -Sy
    #     curl <url of raw text> | bash
    
# Thank you to a of trwnh.com for writing the original script, as seen below
# https://gist.github.com/trwnh/8e9647c8dd0344546bb031eb7680d541

    # Remakes your system partitions and mounts them
    echo "Making new fiwesystems... ^w^"
    mkfs.fat -L "EFI" -F 32 /dev/sda1
    mkfs.ext4 -L "Arch" -F /dev/sda2
    echo "Done mwaking fiwesystems...."

    echo "Mounting filesystems..."
    mount /dev/disk/by-label/Arch /mnt
    mkdir /mnt/home
    mkdir -p /mnt/boot/efi
    mount /dev/disk/by-label/home /mnt/home
    mount /dev/disk/by-label/EFI /mnt/boot/efi
    echo "Done mwounting fiwesystems. ;)"

    # Installs a base system with some useful packages
    pacstrap /mnt \
      base base-devel linux linux-firmware linux-headers amd-ucode \
      nano git zip unzip unrar networkmanager nm-connection-editor \
      xorg-server wayland gdm xfce4 xfce4-goodies gvfs gvfs-mtp file-roller \
      pipewire pipewire-pulse pipewire-jack pipewire-alsa qpwgraph pavucontrol \
      firefox mpv vlc youtube-dl gimp notepadqq pinta \
      flatpak gnome-software polkit-gnome xdg-desktop-portal-gtk
     
    # Localize your system
    echo "Wocawizing youw system... UwU"
    arch-chroot /mnt /bin/bash <<EOF
    hostnamectl set-hostname cass
    timedatectl set-timezone Europe/London
    hwclock --systohc
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
    localectl set-locale LANG=en_US.UTF-8
    localectl set-keymap uk
    EOF
    echo "Wocawization compwete, rawr XD"

    # Install a bootloader and write a basic loader entry and config
    echo "Instawwing bootwoadew... >w<"
    arch-chroot /mnt bootctl install

    cat <<EOF > /mnt/install/boot/loader/entries/arch.conf
    title Arch Linux
    linux /vmlinuz-linux
    initrd /amd-ucode.img
    initrd /initramfs-linux.img
    options root=LABEL=Arch rw
    EOF

    cat <<EOF > /mnt/install/boot/loader/loader.conf
    default arch
    timeout 5
    auto-entries
    auto-firmware
    editor yes
    EOF

    echo "Bootwoadew setup compwete. <:"

    # Recreating your user profile
    echo "Cweating usew pwofiwe... xD"
    arch-chroot /mnt /bin/bash <<EOF
    useradd -m -G wheel -s /bin/bash cass
    EOF
    echo "Done cweating usew. UwU"

    # Enable system services
    echo "Enabwing system sewvices... <3"
    arch-chroot /mnt /bin/bash <<EOF
    systemctl enable NetworkManager
    systemctl enable systemd-timesyncd
    systemctl enable gdm
    EOF
    echo "Done enabwing sewvices. ^_^ u should play 100gecs XP"

    # Edit system config files
    echo "Making pacmwan fancy... x3"
    sed -i '/#Color/s/#Color/Color\nILoveCandy/g' /etc/pacman.conf
    echo "Done editing config fiwes.... :D"

    # Install yay
    echo "Instawwing usew packages......"

    arch-chroot /mnt /bin/bash <<EOF
    cd /home/cass/yay-bin
    sudo -u cass makepkg -sic --noconfirm
    sudo -u cass yay --gendb
    sudo -u cass yay --devel --nodiffmenu --save
    EOF

    arch-chroot /mnt /bin/bash <<EOF
    sudo -u cass yay -S \
      gzdoom chocolate-doom multimc-bin jre8-openjdk jre17-openjdk\
      activate-linux-git fastfetch \
      catfish xfce4-docklike-plugin mugshot pamac-aur \
      spotify-adblock
    EOF

    arch-chroot /mnt /bin/bash <<EOF
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub com.spotify.desktop
    flatpak install flathub io.github.shiftey.Desktop
    flatpak install flathub org.audacityteam.Audacity
    flatpak install flathub com.obsproject.Studio
    flatpak install flathub com.github.huluti.Curtail
    EOF

    echo "Done instawwing packages. :P"

    echo "Scwipt done! Now mwanuawwy wun the fowwowing commwands:

    arch-chroot /mnt
    passwd
    passwd cass
    exit
    reboot
    "
