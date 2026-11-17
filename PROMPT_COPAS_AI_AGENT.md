# PROMPT SEKALI COPAS UNTUK AI AGENT (ONE-CLICK EASY EFFECTS SETUP)

> **Cara Pakai di Laptop Baru:**
> Setelah install CachyOS / Arch Linux di laptop baru, buka AI Agent Anda (Antigravity CLI, Claude Code, Cursor, Windsurf, Cline, Aider, dll.), lalu **copy-paste seluruh teks di dalam kotak kode di bawah ini**. AI Agent akan otomatis menginstall EasyEffects, seluruh plugin LV2/DSP, semua 44 preset, 38 file impulse response (`.irs`), seluruh konfigurasi detail (`~/.config/easyeffects/db/`), tuning PipeWire/WirePlumber, serta mengaktifkan service & preset aktif **`FIX ENAK 1`** agar 100% sama persis dengan PC desktop ini.

---

## Versi Indonesia (Rekomendasi)

```markdown
Tolong install dan konfigurasi **EasyEffects + PipeWire/WirePlumber Audio Tuning** di laptop Linux (CachyOS / Arch Linux) saya agar 100% sama persis dengan pengaturan EasyEffects di PC desktop saya dari repository resmi:
https://github.com/arstate/cachyos-easyeffects-config

Lakukan seluruh langkah berikut secara otomatis dari terminal tanpa perlu saya edit manual:

1. Clone repository resmi ke direktori temporary:
   rm -rf /tmp/cachyos-easyeffects-config
   git clone https://github.com/arstate/cachyos-easyeffects-config.git /tmp/cachyos-easyeffects-config
   cd /tmp/cachyos-easyeffects-config

2. Jalankan master installer secara otomatis:
   chmod +x install.sh backup-current.sh
   ./install.sh

3. Pastikan seluruh detail konfigurasi berikut terpasang dan aktif sempurna:
   a. **Paket & Plugin DSP/LV2 Lengkap**:
      - `easyeffects` (8.x), `pipewire`, `pipewire-alsa`, `pipewire-pulse`, `wireplumber`
      - `calf`, `lsp-plugins-lv2`, `zam-plugins-lv2`, `mda.lv2`, `libbs2b`, `zita-convolver`, `libebur128`, `rnnoise`, `soundtouch`, `speexdsp`
   b. **Database Konfigurasi Live (`~/.config/easyeffects/db/`)**:
      - Seluruh 21 file `*rc` terpasang lengkap (`easyeffectsrc`, `equalizerrc`, `convolverrc`, `bassEnhancerrc`, `bassLoudnessrc`, `stereotoolsrc`, `loudnessrc`, `limiterrc`, `multibandcompressorrc`, `compressorrc`, `autogainrc`, `gaterc`, `exciterrc`, `maximizerrc`, `crossfeedrc`, `crystalizerrc`, `deepfilternetrc`, `rnnoiserc`, `echoCancellerrc`, `speexrc`, `reverbrc`).
      - `levelMetersFpsCap=120`, `autostartOnLogin=true`, `lastLoadedOutputPreset=FIX ENAK 1`.
      - Rantai plugin output aktif: `convolver#0 -> equalizer#0 -> bass_enhancer#0 -> bass_loudness#0 -> stereo_tools#0 -> loudness#0 -> limiter#0`.
      - Pastikan `outputDevice` dan `inputDevice` di `easyeffectsrc` sudah otomatis disesuaikan dengan default sink/source audio laptop baru bila hardware PC desktop tidak ada.
   c. **44 Output Presets & 38 Impulse Response (`.irs`)**:
      - Seluruh 44 file `.json` terpasang di `~/.local/share/easyeffects/output/` (termasuk `FIX ENAK 1.json`, `ENAK 2.json`, `LAPTOP TWS JOS.json`, `jos baru.json`, `josgandos1.json`, `mantul.json`, `Dolby_Atmos_Cinema_LFE.json`, `dolby_71_real_subwoofer.json`, `dolby_v4_*`, `soundbar_*`, `subwoofer_*`, `robot_rb*`, `Bass Enhancing + Perfect EQ*.json`).
      - Seluruh 38 file `.irs` terpasang di `~/.local/share/easyeffects/irs/` (`Dolby Headphone Cinema.irs`, `Dolby Surround Pro Logic.irs`, `Dolby Pro Logic II 3.irs`, `Dolby ATMOS ((128K MP3)) 1.Default.irs`, `DTS Headphone X - Wide.irs`, `Razor Surround ((48k Z-Edition)) *`, `Accudio ((48kHz Z.E.)) *`, `Waves MaxxAudio *`, `Creative X-Fi *`, `HTC Beats Audio *`, `wenak.irs`, dll.).
   d. **PipeWire & WirePlumber Audio Tuning**:
      - `~/.config/pipewire/pipewire.conf.d/99-hi-res-audio.conf` (48000 Hz, quantum 2048, min 512, max 4096, resample.quality 4)
      - `~/.config/wireplumber/wireplumber.conf.d/51-bluez-tws-fix.conf` (BlueZ5 SBC-XQ, mSBC, HW volume, 48kHz, zero suspend timeout, no pause-on-idle)
   e. **Autostart & Background Service**:
      - `~/.config/systemd/user/easyeffects.service` aktif & enabled (`systemctl --user enable --now easyeffects.service`)
      - `~/.config/autostart/com.github.wwmm.easyeffects.desktop` dan `easyeffects-service.desktop` terpasang.

4. Validasi status akhir di terminal:
   - `systemctl --user status easyeffects.service --no-pager`
   - `easyeffects -s` (pastikan output preset aktif `FIX ENAK 1`)
   - `easyeffects -b 3` (pastikan hasil `2`, artinya global bypass OFF / efek aktif)
   - `easyeffects -p` (pastikan 44 output presets terbaca)

Laporkan hasil validasi setiap langkah dan pastikan audio EasyEffects sudah langsung bekerja di laptop baru saya.
```

---

## English Version

```markdown
Please install and configure my exact **EasyEffects + PipeWire/WirePlumber audio setup** on this Linux laptop (CachyOS / Arch Linux) from my official repository:
https://github.com/arstate/cachyos-easyeffects-config

Execute all steps automatically via terminal:

1. Clone the repository to a temporary directory:
   rm -rf /tmp/cachyos-easyeffects-config
   git clone https://github.com/arstate/cachyos-easyeffects-config.git /tmp/cachyos-easyeffects-config
   cd /tmp/cachyos-easyeffects-config

2. Run the automated installer:
   chmod +x install.sh backup-current.sh
   ./install.sh

3. Verify that:
   - EasyEffects (`easyeffects`) and all LV2/DSP plugins (`calf`, `lsp-plugins-lv2`, `zam-plugins-lv2`, `mda.lv2`, `libbs2b`, `zita-convolver`, `libebur128`, `rnnoise`, `soundtouch`, `speexdsp`) are installed.
   - All 21 `~/.config/easyeffects/db/*rc` files, 44 presets in `~/.local/share/easyeffects/output/`, and 38 `.irs` kernels in `~/.local/share/easyeffects/irs/` are deployed.
   - PipeWire (`99-hi-res-audio.conf`) and WirePlumber (`51-bluez-tws-fix.conf`) configs are deployed and user services restarted.
   - `easyeffects.service` is enabled and active, `outputDevice`/`inputDevice` are adapted to this machine's default PipeWire sink/source if needed, active preset `FIX ENAK 1` is loaded, and global bypass is disabled (`easyeffects -b 3` outputs `2`).

Report the final verification output from `easyeffects -s`, `easyeffects -b 3`, `easyeffects -p | wc -l`, and `systemctl --user is-active easyeffects.service`.
```
