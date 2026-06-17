#!/bin/bash
# ============================================================
# VOH Academy — System Setup Script
# Purpose: Update system + install/verify the standard VOH toolset
# Safe to re-run anytime — skips what's already installed/up to date
# ============================================================

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log()      { echo -e "${GREEN}[OK]${NC}   $1"; }
log_skip() { echo -e "${YELLOW}[SKIP]${NC} $1"; }
log_err()  { echo -e "${RED}[FAIL]${NC} $1"; }

echo -e "${YELLOW}VOH Academy — System Setup${NC}"
echo "================================="

# ---- Update package list ----
echo ""
echo "Updating package list..."
sudo apt update -qq
log "Package list updated"

# ---- Upgrade existing packages ----
echo ""
echo "Upgrading installed packages..."
sudo apt upgrade -y -qq
log "System packages upgraded"

# ---- Install toolset (idempotent — apt skips already-installed packages) ----
echo ""
echo "Installing VOH standard toolset..."

PACKAGES=(
    curl
    wget
    git
    tree
    htop
    unzip
    jq
    net-tools
    dnsutils
    nmap
    tmux
    build-essential
    python3
    python3-pip
)

for pkg in "${PACKAGES[@]}"; do
    if dpkg -l "$pkg" &>/dev/null && dpkg -l "$pkg" | grep -q "^ii"; then
        log_skip "$pkg already installed"
    else
        if sudo apt install -y -qq "$pkg"; then
            log "$pkg installed"
        else
            log_err "$pkg failed to install"
        fi
    fi
done

# ---- Clean up ----
echo ""
echo "Cleaning up..."
sudo apt autoremove -y -qq
sudo apt clean
log "Cleanup complete"

# ---- Summary ----
echo ""
echo "================================="
echo -e "${GREEN}Setup complete.${NC}"
echo ""
echo "Installed tool versions:"
echo "  curl:   $(curl --version | head -1)"
echo "  git:    $(git --version)"
echo "  python: $(python3 --version)"
echo "  jq:     $(jq --version)"
