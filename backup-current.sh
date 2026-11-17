#!/usr/bin/env bash
# ==============================================================================
# Sync latest live EasyEffects + PipeWire/WirePlumber configs from PC -> Repo
# ==============================================================================

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sync_clean_dir() {
    local src="$1" dst="$2" keep_gitkeep="${3:-false}"
    rm -rf "$dst"
    mkdir -p "$dst"
    if [ -d "$src" ] && [ -n "$(find "$src" -mindepth 1 -maxdepth 1 2>/dev/null)" ]; then
        cp -a "$src/." "$dst/"
    elif [ "$keep_gitkeep" = true ]; then
        : > "$dst/.gitkeep"
    fi
}

sync_clean_dir "$HOME/.config/easyeffects/db" "$REPO_DIR/configs/easyeffects/db"
chmod 644 "$REPO_DIR/configs/easyeffects/db/"* 2>/dev/null || true

sync_clean_dir "$HOME/.local/share/easyeffects/output" "$REPO_DIR/configs/easyeffects/output"
sync_clean_dir "$HOME/.local/share/easyeffects/irs" "$REPO_DIR/configs/easyeffects/irs"
sync_clean_dir "$HOME/.local/share/easyeffects/input" "$REPO_DIR/configs/easyeffects/input" true
sync_clean_dir "$HOME/.local/share/easyeffects/rnnoise" "$REPO_DIR/configs/easyeffects/rnnoise" true
sync_clean_dir "$HOME/.local/share/easyeffects/autoload/input" "$REPO_DIR/configs/easyeffects/autoload/input" true
sync_clean_dir "$HOME/.local/share/easyeffects/autoload/output" "$REPO_DIR/configs/easyeffects/autoload/output" true

mkdir -p "$REPO_DIR/configs/autostart" "$REPO_DIR/configs/systemd"
cp -a "$HOME/.config/autostart/com.github.wwmm.easyeffects.desktop" "$REPO_DIR/configs/autostart/"
cp -a "$HOME/.config/autostart/easyeffects-service.desktop" "$REPO_DIR/configs/autostart/"
cp -a "$HOME/.config/systemd/user/easyeffects.service" "$REPO_DIR/configs/systemd/"

sync_clean_dir "$HOME/.config/pipewire/pipewire.conf.d" "$REPO_DIR/configs/pipewire"
sync_clean_dir "$HOME/.config/wireplumber/wireplumber.conf.d" "$REPO_DIR/configs/wireplumber"

echo "Synced live EasyEffects, PipeWire, WirePlumber, autostart, and systemd configs into $REPO_DIR/configs"
