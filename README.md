# AUR Helper Installer

A simple, safe, and interactive Bash script to install AUR helpers — **Yay** or **Paru** — on Arch-based Linux systems (Arch, Manjaro, CachyOS, EndeavourOS, etc.).

---

## Features

- Interactive menu to choose between **Yay** and **Paru**
- Detects if the helper is **already installed** and asks before reinstalling
- Blocks execution if run as **root** (safety guard)
- Validates that the system is **Arch-based** (checks for `pacman`)
- Uses an **isolated temp directory** for building — no clutter in your home folder
- Clean **color-coded output** with log levels (`[✔]`, `[!]`, `[✘]`, `[i]`)
- Fails fast with `set -euo pipefail` — no silent errors

---

## Requirements

| Requirement | Details |
|---|---|
| OS | Arch Linux or any Arch-based distro |
| User | A normal user with `sudo` privileges |
| Packages | `base-devel`, `git` (auto-installed by the script) |

---

## Usage

### 1. Clone or download the script

```bash
git clone https://github.com/Sdinzsh/aur-helper-installer.git
cd aur-helper-installer
```

Or just download the script directly:

```bash
curl -O https://raw.githubusercontent.com/Sdinzsh/aur-helper-installer/main/install-aur.sh
```

### 2. Make it executable

```bash
chmod +x install-aur.sh
```

### 3. Run the script

```bash
./install-aur.sh
```

### 4. Follow the menu

```
╔══════════════════════════════════╗
║    AUR Helper Installer Script   ║
╚══════════════════════════════════╝

  1) Install Yay
  2) Install Paru
  3) Cancel

  Enter your choice [1-3]:
```

---

## What Happens Under the Hood

```
1. Checks for pacman (Arch guard)
2. Checks you're not running as root
3. Checks if the selected tool is already installed
4. Installs base-devel and git via pacman
5. Clones the AUR repo into a secure temp directory
6. Builds and installs using makepkg -si
7. Cleans up the temp directory automatically
```

---

## After Installation

Once installed, you can use your AUR helper to search, install, and update packages from both the official repos and the AUR:

**Using Yay:**
```bash
yay -Syu          # Sync and upgrade all packages
yay -S <package>  # Install a package
yay -Ss <query>   # Search for a package
```

**Using Paru:**
```bash
paru -Syu          # Sync and upgrade all packages
paru -S <package>  # Install a package
paru -Ss <query>   # Search for a package
```

---

## Troubleshooting

**`pacman not found`**
> You are not on an Arch-based system. This script only works with Arch Linux and its derivatives.

**`Do not run this script as root`**
> Run the script as your regular user. The script will call `sudo` internally when needed.

**`makepkg failed`**
> Ensure `base-devel` is fully installed. Try running `sudo pacman -S base-devel` manually and retry.

**`Failed to clone repository`**
> Check your internet connection. AUR requires access to `https://aur.archlinux.org`.

---

## Tested On

| Distro | Status |
|---|---|
| Arch Linux | ✅ Tested |
| Manjaro | ✅ Tested |
| CachyOS | ✅ Tested |
| EndeavourOS | ✅ Tested |


---

> **Note:** This script installs software from the AUR (Arch User Repository). Always review AUR `PKGBUILD` files before installing packages. The AUR is community-maintained and not officially supported by Arch Linux.
