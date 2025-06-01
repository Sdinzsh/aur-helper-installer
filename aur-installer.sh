#!/bin/bash
echo "Select an option to install AUR:"
echo "1) Install Yay"
echo "2) Install Paru"
echo "3) Cancel"
read -rp "Enter your choice [1-3]: " choice

install_yay() {
    sudo pacman -S --needed base-devel git || exit 1
    git clone https://aur.archlinux.org/yay.git || exit 1
    cd yay || exit 1
    makepkg -si
    cd ..
    rm -rf yay
}

install_paru() {
    sudo pacman -S --needed base-devel git || exit 1
    git clone https://aur.archlinux.org/paru.git || exit 1
    cd paru || exit 1
    makepkg -si
    cd ..
    rm -rf paru
}

case $choice in
    1)
        echo "Installing Yay..."
        install_yay
        ;;
    2)
        echo "Installing Paru..."
        install_paru
        ;;
    3)
        echo "Cancelled."
        ;;
    *)
        echo "Invalid option."
        ;;
esac
