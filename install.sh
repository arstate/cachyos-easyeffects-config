#!/usr/bin/env bash
# ==============================================================================
# CachyOS / Arch Linux EasyEffects + PipeWire Audio Setup Auto-Installer
# Author: arstate
# Repository: https://github.com/arstate/cachyos-easyeffects-config
# ==============================================================================

set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then
    echo -e "\033[1;31m[!] Please do NOT run install.sh as root/sudo. Run as normal user: ./install.sh\033[0m"
    echo -e "\033[1;33m    The script will prompt for sudo automatically when installing packages.\033[0m"
    exit 1
fi

SKIP_PACKAGES=false
SKIP_PIPEWIRE=false
KEEP_DEVICE_IDS=false

for arg in "$@"; do
    case "$arg" in
        --skip-packages) SKIP_PACKAGES=true ;;
        --skip-pipewire) SKIP_PIPEWIRE=true ;;
        --keep-device-ids) KEEP_DEVICE_IDS=true ;;
        -h|--help)
            echo "Usage: ./install.sh [--skip-packages] [--skip-pipewire] [--keep-device-ids]"
            exit 0
            ;;
        *)
            echo "Unknown option: $arg"
            exit 1
            ;;
    esac
done

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_HOME="$HOME"
CONFIG_DIR="$TARGET_HOME/.config"
DATA_DIR="$TARGET_HOME/.local/share"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

echo -e "\033[1;36m====================================================================\033[0m"
echo -e "\033[1;32m  EasyEffects + PipeWire Audio Config Installer (CachyOS / Arch)    \033[0m"
echo -e "\033[1;36m====================================================================\033[0m"
echo -e "User: \033[1;33m$USER\033[0m | Home: \033[1;33m$TARGET_HOME\033[0m"
echo -e "Repo: \033[1;33m$REPO_DIR\033[0m\n"

# ------------------------------------------------------------------------------
# STEP 1: Install EasyEffects, PipeWire, and DSP/LV2 Plugins
# ------------------------------------------------------------------------------
if [ "$SKIP_PACKAGES" = false ]; then
    echo -e "\033[1;34m[1/6] Installing EasyEffects & Audio DSP Plugins...\033[0m"
    if command -v pacman >/dev/null 2>&1; then
        PACKAGES=(
            easyeffects
            pipewire
            pipewire-alsa
            pipewire-pulse
            wireplumber
            calf
            lsp-plugins-lv2
            zam-plugins-lv2
            mda.lv2
            libbs2b
            zita-convolver
            libebur128
            rnnoise
            soundtouch
            speexdsp
        )
        sudo pacman -S --needed --noconfirm "${PACKAGES[@]}"
    else
        echo -e "\033[1;33m[!] pacman not found. Skipping package install — ensure EasyEffects 8.x, calf, lsp-plugins-lv2, zam-plugins-lv2, mda.lv2, pipewire, and wireplumber are installed manually.\033[0m"
    fi
else
    echo -e "\033[1;33m[1/6] Skipping package installation (--skip-packages).\033[0m"
fi

# ------------------------------------------------------------------------------
# STEP 2: Stop Existing EasyEffects Service Cleanly
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[2/6] Stopping active EasyEffects instances before restoring configs...\033[0m"
systemctl --user stop easyeffects.service 2>/dev/null || true
easyeffects -q 2>/dev/null || true
pkill -x easyeffects 2>/dev/null || true
sleep 1

# Backup existing configs if present
if [ -d "$CONFIG_DIR/easyeffects" ]; then
    cp -a "$CONFIG_DIR/easyeffects" "$CONFIG_DIR/easyeffects.bak.$TIMESTAMP"
    echo "Backed up existing ~/.config/easyeffects -> ~/.config/easyeffects.bak.$TIMESTAMP"
fi
if [ -d "$DATA_DIR/easyeffects" ]; then
    cp -a "$DATA_DIR/easyeffects" "$DATA_DIR/easyeffects.bak.$TIMESTAMP"
    echo "Backed up existing ~/.local/share/easyeffects -> ~/.local/share/easyeffects.bak.$TIMESTAMP"
fi

# ------------------------------------------------------------------------------
# STEP 3: Restore EasyEffects DB Configs, Presets, and IRS Files
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[3/6] Deploying EasyEffects configs, 44 presets, and 38 IRS kernels...\033[0m"

mkdir -p "$CONFIG_DIR/easyeffects/db" \
         "$DATA_DIR/easyeffects/output" \
         "$DATA_DIR/easyeffects/input" \
         "$DATA_DIR/easyeffects/autoload/input" \
         "$DATA_DIR/easyeffects/autoload/output" \
         "$DATA_DIR/easyeffects/rnnoise" \
         "$DATA_DIR/easyeffects/irs"

cp -a "$REPO_DIR/configs/easyeffects/db/." "$CONFIG_DIR/easyeffects/db/"
chmod 700 "$CONFIG_DIR/easyeffects/db"
chmod 600 "$CONFIG_DIR/easyeffects/db/"*

cp -a "$REPO_DIR/configs/easyeffects/output/." "$DATA_DIR/easyeffects/output/"
cp -a "$REPO_DIR/configs/easyeffects/irs/." "$DATA_DIR/easyeffects/irs/"

# Adapt hardware-specific audio device IDs if running on a new laptop/hardware
EE_RC="$CONFIG_DIR/easyeffects/db/easyeffectsrc"
if [ "$KEEP_DEVICE_IDS" = false ] && [ -f "$EE_RC" ] && command -v pactl >/dev/null 2>&1; then
    ORIG_OUT="$(awk -F= '/^outputDevice=/{print $2}' "$EE_RC" || true)"
    ORIG_IN="$(awk -F= '/^inputDevice=/{print $2}' "$EE_RC" || true)"

    if [ -n "$ORIG_OUT" ] && ! pactl list short sinks 2>/dev/null | grep -Fq "$ORIG_OUT"; then
        DEFAULT_SINK="$(pactl get-default-sink 2>/dev/null || true)"
        if [ -n "$DEFAULT_SINK" ]; then
            sed -i "s|^outputDevice=.*|outputDevice=$DEFAULT_SINK|" "$EE_RC"
            echo "Adapted outputDevice -> $DEFAULT_SINK (original desktop sink not present on this machine)"
        else
            sed -i "/^outputDevice=/d" "$EE_RC"
        fi
    fi

    if [ -n "$ORIG_IN" ] && ! pactl list short sources 2>/dev/null | grep -Fq "$ORIG_IN"; then
        DEFAULT_SOURCE="$(pactl get-default-source 2>/dev/null || true)"
        if [ -n "$DEFAULT_SOURCE" ]; then
            sed -i "s|^inputDevice=.*|inputDevice=$DEFAULT_SOURCE|" "$EE_RC"
            echo "Adapted inputDevice -> $DEFAULT_SOURCE (original Bluetooth mic not present on this machine)"
        else
            sed -i "/^inputDevice=/d" "$EE_RC"
        fi
    fi
fi

# ------------------------------------------------------------------------------
# STEP 4: Deploy PipeWire & WirePlumber Audio Tuning
# ------------------------------------------------------------------------------
if [ "$SKIP_PIPEWIRE" = false ]; then
    echo -e "\033[1;34m[4/6] Deploying PipeWire (48kHz Hi-Res) & WirePlumber (BlueZ TWS) configs...\033[0m"
    mkdir -p "$CONFIG_DIR/pipewire/pipewire.conf.d" "$CONFIG_DIR/wireplumber/wireplumber.conf.d"
    cp -a "$REPO_DIR/configs/pipewire/." "$CONFIG_DIR/pipewire/pipewire.conf.d/"
    cp -a "$REPO_DIR/configs/wireplumber/." "$CONFIG_DIR/wireplumber/wireplumber.conf.d/"
else
    echo -e "\033[1;33m[4/6] Skipping PipeWire/WirePlumber tuning (--skip-pipewire).\033[0m"
fi

# ------------------------------------------------------------------------------
# STEP 5: Deploy Autostart & Systemd User Service
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[5/6] Configuring Autostart & systemd user service...\033[0m"
mkdir -p "$CONFIG_DIR/autostart" "$CONFIG_DIR/systemd/user"
cp -a "$REPO_DIR/configs/autostart/com.github.wwmm.easyeffects.desktop" "$CONFIG_DIR/autostart/"
cp -a "$REPO_DIR/configs/autostart/easyeffects-service.desktop" "$CONFIG_DIR/autostart/"
cp -a "$REPO_DIR/configs/systemd/easyeffects.service" "$CONFIG_DIR/systemd/user/"

systemctl --user daemon-reload
if [ "$SKIP_PIPEWIRE" = false ]; then
    systemctl --user restart pipewire.service pipewire-pulse.service wireplumber.service 2>/dev/null || true
    sleep 1
fi
systemctl --user enable --now easyeffects.service

# ------------------------------------------------------------------------------
# STEP 6: Load Default Active Preset & Verify
# ------------------------------------------------------------------------------
echo -e "\033[1;34m[6/6] Loading active preset ('FIX ENAK 1') & verifying setup...\033[0m"

ACTIVE_PRESET="$(awk -F= '/^lastLoadedOutputPreset=/{print $2}' "$EE_RC" || true)"
if [ -z "$ACTIVE_PRESET" ]; then
    ACTIVE_PRESET="FIX ENAK 1"
fi

# Wait up to 8s for EasyEffects D-Bus service to initialize
for _ in $(seq 1 16); do
    if easyeffects -s >/dev/null 2>&1; then
        break
    fi
    sleep 0.5
done

easyeffects -l "$ACTIVE_PRESET" 2>/dev/null || true
easyeffects -b 2 2>/dev/null || true

echo ""
echo -e "\033[1;32m====================================================================\033[0m"
echo -e "\033[1;32m  EasyEffects & Audio Setup Complete!                               \033[0m"
echo -e "\033[1;32m====================================================================\033[0m"
echo "Presets installed : $(find "$DATA_DIR/easyeffects/output" -maxdepth 1 -name '*.json' | wc -l)"
echo "IRS kernels       : $(find "$DATA_DIR/easyeffects/irs" -maxdepth 1 -name '*.irs' | wc -l)"
echo "DB config files   : $(find "$CONFIG_DIR/easyeffects/db" -maxdepth 1 -type f | wc -l)"
echo "Service enabled   : $(systemctl --user is-enabled easyeffects.service 2>/dev/null || echo unknown)"
echo "Service active    : $(systemctl --user is-active easyeffects.service 2>/dev/null || echo unknown)"
echo "--- EasyEffects Status ---"
easyeffects -s 2>/dev/null || echo "Note: Start a desktop audio session if PipeWire/DBus is not running in this shell."
echo "Bypass state (2=off, 1=on): $(easyeffects -b 3 2>/dev/null || echo N/A)"
