#!/bin/bash

# ─────────────────────────────────────────────
#  AUR Helper Installer — Yay / Paru
# ─────────────────────────────────────────────

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

log()     { echo -e "${GREEN}[✔]${NC} $1"; }
warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[✘]${NC} $1"; exit 1; }
info()    { echo -e "${CYAN}[i]${NC} $1"; }

# ── Guard: Must be on Arch-based system ──────
if ! command -v pacman &>/dev/null; then
    error "pacman not found. This script is for Arch-based systems only."
fi

# ── Guard: Don't run as root ─────────────────
if [[ $EUID -eq 0 ]]; then
    error "Do not run this script as root. Run as a normal user with sudo privileges."
fi

# ── Check if already installed ───────────────
check_already_installed() {
    local tool="$1"
    if command -v "$tool" &>/dev/null; then
        warn "${tool} is already installed at $(command -v "$tool")."
        read -rp "  Reinstall anyway? [y/N]: " confirm
        [[ "$confirm" =~ ^[Yy]$ ]] || { info "Skipping installation."; exit 0; }
    fi
}

# ── Core installer ────────────────────────────
install_aur_helper() {
    local name="$1"
    local url="https://aur.archlinux.org/${name}.git"
    local tmp_dir
    tmp_dir=$(mktemp -d)

    check_already_installed "$name"

    log "Installing dependencies..."
    sudo pacman -S --needed --noconfirm base-devel git || error "Failed to install dependencies."

    log "Cloning ${name} from AUR..."
    git clone "$url" "$tmp_dir/${name}" || error "Failed to clone ${name} repository."

    log "Building and installing ${name}..."
    (
        cd "$tmp_dir/${name}"
        makepkg -si --noconfirm
    ) || error "makepkg failed for ${name}."

    log "Cleaning up build files..."
    rm -rf "$tmp_dir"

    log "${name} installed successfully!"
    info "Run '${name} -Syu' to sync and upgrade your system."
}

# ── Menu ──────────────────────────────────────
echo ""
echo -e "${CYAN}╔══════════════════════════════════╗${NC}"
echo -e "${CYAN}║    AUR Helper Installer Script   ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════╝${NC}"
echo ""
echo "  1) Install Yay"
echo "  2) Install Paru"
echo "  3) Cancel"
echo ""
read -rp "  Enter your choice [1-3]: " choice

case "$choice" in
    1)
        info "Starting Yay installation..."
        install_aur_helper "yay"
        ;;
    2)
        info "Starting Paru installation..."
        install_aur_helper "paru"
        ;;
    3)
        warn "Installation cancelled by user."
        exit 0
        ;;
    *)
        error "Invalid option: '${choice}'. Please enter 1, 2, or 3."
        ;;
esac
