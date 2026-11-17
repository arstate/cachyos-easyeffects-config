#!/usr/bin/env bash
# ==============================================================================
# Sync latest live EasyEffects + PipeWire/WirePlumber configs from PC -> Repo
# ==============================================================================

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$REPO_DIR/configs/easyeffects/db" \
         "$REPO_DIR/configs/easyeffects/output" \
         "$REPO_DIR/configs/easyeffects/irs" \
         "$REPO_DIR/configs/autostart" \
         "$REPO_DIR/configs/systemd" \
         "$REPO_DIR/configs/pipewire" \
         "$REPO_DIR/configs/wireplumber"

cp -a ~/.config/easyeffects/db/. "$REPO_DIR/configs/easyeffects/db/"
chmod 644 "$REPO_DIR/configs/easyeffects/db/"*
cp -a ~/.local/share/easyeffects/output/. "$REPO_DIR/configs/easyeffects/output/"
cp -a ~/.local/share/easyeffects/irs/. "$REPO_DIR/configs/easyeffects/irs/"
cp -a ~/.config/autostart/com.github.wwmm.easyeffects.desktop "$REPO_DIR/configs/autostart/"
cp -a ~/.config/autostart/easyeffects-service.desktop "$REPO_DIR/configs/autostart/"
cp -a ~/.config/systemd/user/easyeffects.service "$REPO_DIR/configs/systemd/"
cp -a ~/.config/pipewire/pipewire.conf.d/. "$REPO_DIR/configs/pipewire/"
cp -a ~/.config/wireplumber/wireplumber.conf.d/. "$REPO_DIR/configs/wireplumber/"

echo "Synced live EasyEffects, PipeWire, WirePlumber, autostart, and systemd configs into $REPO_DIR/configs"
