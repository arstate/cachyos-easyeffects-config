# EasyEffects + PipeWire Audio Configuration Suite (`arstate`)

[![OS](https://img.shields.io/badge/OS-CachyOS%20%2F%20Arch%20Linux-0078D7?style=for-the-badge&logo=arch-linux&logoColor=white)](https://cachyos.org/)
[![EasyEffects](https://img.shields.io/badge/EasyEffects-8.2.4-1D99F3?style=for-the-badge&logo=linux&logoColor=white)](https://github.com/wwmm/easyeffects)
[![PipeWire](https://img.shields.io/badge/Audio-PipeWire%20%2B%20WirePlumber-5856D6?style=for-the-badge&logo=linux&logoColor=white)](https://pipewire.org/)

Backup lengkap seluruh konfigurasi **EasyEffects (`8.2.4`)**, **44 Output Presets**, **38 Impulse Response (`.irs`)**, **21 Live DB Plugin Configs**, **Autostart / Systemd Service**, serta **PipeWire & WirePlumber Audio Tuning** milik **[arstate](https://github.com/arstate)**.

Dirancang agar saat pindah ke **laptop atau PC Linux baru**, cukup **1x copas prompt ke AI Agent** (atau jalankan `./install.sh`) untuk langsung mendapatkan kualitas audio yang **100% identik**.

---

## ⚡ INSTALASI 1-KLIK VIA AI AGENT (COPAS PROMPT INI DI LAPTOP BARU)

> [!TIP]
> **Punya laptop baru dengan CachyOS / Arch Linux?**
> Copy seluruh prompt di dalam kotak di bawah ini, lalu paste ke AI Agent Anda (Antigravity CLI, Claude Code, Cursor, Windsurf, Cline, Aider, dll.). AI Agent akan otomatis menginstall EasyEffects, semua plugin LV2/DSP, semua 44 preset, 38 IRS, tuning PipeWire/WirePlumber, dan mengaktifkan preset utama **`FIX ENAK 1`**.

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
      - Seluruh 44 file `.json` terpasang di `~/.local/share/easyeffects/output/`.
      - Seluruh 38 file `.irs` terpasang di `~/.local/share/easyeffects/irs/`.
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

> Lihat juga [PROMPT_COPAS_AI_AGENT.md](PROMPT_COPAS_AI_AGENT.md) untuk versi prompt Indonesia & English terpisah.

---

## 🛠️ INSTALASI MANUAL VIA TERMINAL

```bash
git clone https://github.com/arstate/cachyos-easyeffects-config.git /tmp/cachyos-easyeffects-config
cd /tmp/cachyos-easyeffects-config
chmod +x install.sh
./install.sh
```

Opsi tambahan `./install.sh`:
- `--skip-packages` — lewati instalasi paket `pacman` (hanya restore config, preset, IRS, dan service).
- `--skip-pipewire` — lewati deployment config PipeWire & WirePlumber.
- `--keep-device-ids` — pertahankan `outputDevice` / `inputDevice` asli PC desktop (tidak di-adaptasi ke default sink laptop baru).

---

## 🎛️ DETAIL PENGATURAN LIVE EASY EFFECTS DI PC INI

### 1. Pengaturan Global & Urutan Rantai Output (`easyeffectsrc`)
- **Versi EasyEffects**: `8.2.4` (Qt6 / Kirigami KConfig DB)
- **Active Output Preset**: `FIX ENAK 1`
- **Global Bypass**: OFF (`2`)
- **Level Meters FPS Cap**: `120 FPS`
- **Window Size**: `1000 x 566` (`visiblePage=pluginsPage`, `visiblePlugin=equalizer#0`)
- **Autostart on Login**: `true` (via `easyeffects.service` user systemd + `.desktop` autostart)
- **Most Used Presets**: `Bass Enhancing + Perfect EQ - Low Latency`, `Bass Enhancing + Perfect EQ`, `josgandos1`, `mantul`, `dolby_71_real_subwoofer`
- **Active Output Pipeline Order (7 Plugin Berurutan)**:
  1. `convolver#0`
  2. `equalizer#0`
  3. `bass_enhancer#0`
  4. `bass_loudness#0`
  5. `stereo_tools#0`
  6. `loudness#0`
  7. `limiter#0`

---

### 2. Parameter Detail Setiap Plugin di Live DB (`~/.config/easyeffects/db/`)

#### A. `convolverrc` (Convolver)
- **Convolver#0 (Active)**: `kernelName=Dolby Headphone Cinema` *(catatan: di preset JSON `FIX ENAK 1.json`, convolver memakai `Dolby Surround Pro Logic`, `autogain=true`, `dry=-100.0`, `wet=0.0`, `ir-width=100`)*
- **Convolver#1**: `bypass=true`, `kernelName=Dolby Pro Logic II 3`

#### B. `equalizerrc` (10-Band Parametric Equalizer — Live DB)
- `balance=5`, `inputGain=-0.5`, `numBands=10` (Channel Left & Right simetris; DB juga menyimpan slot kurva `band10`–`band30` untuk preset 31-band):
  - **Band 0**: `60 Hz` | Gain `+4.15 dB` | `Q = 1.0`
  - **Band 1**: `120 Hz` | Gain `+6.30 dB` | `Q = 1.1`
  - **Band 2**: `250 Hz` | Gain `+4.49 dB` | `Q = 1.0`
  - **Band 3**: `500 Hz` | Gain `+1.50 dB` | `Q = 1.0`
  - **Band 4**: `1000 Hz` | Gain `-3.89 dB` | `Q = 1.0`
  - **Band 5**: `2500 Hz` | Gain `-5.64 dB` | `Q = 1.0`
  - **Band 6**: `5000 Hz` | Gain `+0.99 dB` | `Q = 1.0`
  - **Band 7**: `8000 Hz` | Gain `+6.94 dB` | `Q = 1.2`
  - **Band 8**: `12000 Hz` | Gain `+1.91 dB` | `Q = 1.0`
  - **Band 9**: `16000 Hz` | Gain `-0.24 dB` | `Q = 1.0`

*(Catatan: Preset JSON `FIX ENAK 1.json` memakai `input-gain=-2.8`, `mode="IIR"`, filter `"RLC (BT)"`, serta kurva `60Hz +2.24`, `120Hz +6.36`, `250Hz +4.49`, `500Hz +1.5`, `1kHz -4.35`, `2.5kHz -5.69`, `5kHz -0.66`, `8kHz +4.29`, `12kHz +6.19`, `16kHz +2.13` — semua tersimpan utuh di `db/` maupun `output/FIX ENAK 1.json`.)*

#### C. `bassEnhancerrc` (Bass Enhancer)
- `amount=5`, `blend=-10`, `floorActive=true`, `harmonics=7`, `inputGain=-2`, `outputGain=-0.7`, `scope=150`
- *(Di `FIX ENAK 1.json`: `amount=6.0`, `blend=-10.0`, `floor=20.0`, `floor-active=true`, `harmonics=7.0`, `scope=140.0`)*

#### D. `bassLoudnessrc` (Bass Loudness / MDA Loudness)
- `loudness=-3.3`, `output=-5.3`, `outputGain=-1` *(plus `link=-9.1` di `FIX ENAK 1.json`)*

#### E. `stereotoolsrc` (Stereo Tools)
- `stereoBase=0.55` *(mode `LR > LR (Stereo Default)` di `FIX ENAK 1.json`)*

#### F. `loudnessrc` (LSP Loudness Compensator)
- `Loudness#0`: `iirApproximation=3` (`High`), `mode=1` (`IIR`), `outputGain=-1` *(di `FIX ENAK 1.json`: `std="ISO226-2023"`, `fft="4096"`)*
- `Loudness#1`: `iirApproximation=3`, `mode=1`

#### G. `limiterrc` (LSP Limiter)
- `attack=2`, `release=15`, `outputGain=-0.5` *(di `FIX ENAK 1.json`: `mode="Herm Thin"`, `gain-boost=true`, `lookahead=5.0`, `stereo-link=100.0`, `threshold=0.0`)*

#### H. Plugin DB Lainnya (Tersimpan & Siap Pakai di `~/.config/easyeffects/db/`)
- `multibandcompressorrc`: 4-band split (`250 Hz`, `1250 Hz`, `5000 Hz`), `ratio=1.7`, `knee=-24`, `attackThreshold=-30`, attack `50/30/10/5 ms`, release `600/450/250/... ms`
- `compressorrc`: `mode=1`, `sidechainMode=1`, `threshold=-10`, `ratio=5`, `knee=-24`, `attack=130`, `release=600`, `boostThreshold=-60`
- `autogainrc`: `target=-12`, `outputGain=1.5`
- `gaterc`: `attack=2000`, `release=2000`, `curveThreshold=-40`, `curveZone=-40`, `reduction=-30`
- `exciterrc`: `amount=6`, `harmonics=8.0`, `inputGain=-2`, `scope=5500`
- `maximizerrc`: `release=3.15`, `threshold=-3.0`
- `crossfeedrc`: `feed=3.5`
- `crystalizerrc`: `outputGain=-1`
- `deepfilternetrc`: `postFilterBeta=0.02`
- `rnnoiserc`: `bypass=true`, `vadThres=10`, `wet=5`
- `echoCancellerrc`: `echoCancellerEnforceHighPass=false`
- `speexrc`: `bypass=true`, `enableDenoise=false`, `enableVad=true`
- `reverbrc`: `bypass=true`, `roomSize=0`

---

### 3. PipeWire, WirePlumber & Service Autostart

- **PipeWire (`configs/pipewire/99-hi-res-audio.conf`)**:
  - `default.clock.rate = 48000`
  - `default.clock.allowed-rates = [ 48000 ]`
  - `default.clock.quantum = 2048` (`min = 512`, `max = 4096`)
  - `resample.quality = 4`
  - *(Tersedia juga template `99-enable-lfe.conf.disabled` untuk channelmix LFE 120Hz)*
- **WirePlumber Bluetooth TWS Fix (`configs/wireplumber/51-bluez-tws-fix.conf`)**:
  - Aktifkan `bluez5.enable-sbc-xq = true`, `bluez5.enable-msbc = true`, `bluez5.enable-hw-volume = true`, `bluez5.default.rate = 48000`
  - `session.suspend-timeout-seconds = 0`, `node.pause-on-idle = false`, `node.latency = "2048/48000"`
- **Autostart & Systemd**:
  - `configs/systemd/easyeffects.service` (`ExecStart=/usr/bin/easyeffects --gapplication-service`, `Restart=on-failure`, `WantedBy=default.target`)
  - `configs/autostart/com.github.wwmm.easyeffects.desktop` (`easyeffects --hide-window --service-mode`)
  - `configs/autostart/easyeffects-service.desktop` (`easyeffects --gapplication-service`)

---

### 4. Daftar Lengkap 44 Output Presets & 38 IRS Kernels

<details>
<summary><b>📂 Klik untuk melihat seluruh 44 Output Presets & 38 file .irs</b></summary>

**44 Output Presets (`configs/easyeffects/output/`):**
1. `FIX ENAK 1.json` *(Active Default)*
2. `ENAK 2.json`
3. `LAPTOP TWS JOS.json`
4. `jos baru.json`
5. `josgandos1.json`
6. `mantul.json`
7. `Dolby_Atmos_Cinema_LFE.json`
8. `dolby_71_real_subwoofer.json`
9. `dolby_71_surround.json`
10. `dolby_v4_audiophile_master.json`
11. `dolby_v4_deep_bold.json`
12. `dolby_v4_macbook_blend.json`
13. `dolby_v4_perfect_balance.json`
14. `dolby_v4_perfect_natural.json`
15. `dual_jack_21_master.json`
16. `macbook_bold_sound.json`
17. `Bass Enhancing + Perfect EQ.json`
18. `Bass Enhancing + Perfect EQ - Low Latency.json`
19. `Bass Boosted.json`
20. `Boosted.json`
21. `Perfect EQ.json`
22. `Advanced Auto Gain.json`
23. `Laptop.json`
24. `Loudness+Autogain.json`
25. `speaker_bass_boost.json`
26. `warm_deep_bass.json`
27. `robot_rb490_boost.json`
28. `robot_rb690_standalone_jos.json`
29. `robot_rb690_subout_boost.json`
30. `robot_rb690_subwoofer_boost.json`
31. `soundbar_akalan_gacor_max.json`
32. `soundbar_beast_ultimate_v3.json`
33. `soundbar_beast_ultimate_v4.json`
34. `soundbar_gacor_bass.json`
35. `soundbar_gacor_bass_v2.json`
36. `soundbar_gold_master.json`
37. `soundbar_ultimate_bass_virtual.json`
38. `subwoofer_beast_boost.json`
39. `subwoofer_direct_pc.json`
40. `subwoofer_extreme_amplified.json`
41. `subwoofer_extreme_drive.json`
42. `subwoofer_max_soundbar_quiet.json`
43. `subwoofer_only_boosted.json`
44. `subwoofer_ultra_boost.json`

**38 Impulse Response Files (`configs/easyeffects/irs/`):**
Termasuk `Dolby Headphone Cinema.irs`, `Dolby Surround Pro Logic.irs`, `Dolby Pro Logic II 3.irs`, `Dolby ATMOS ((128K MP3)) 1.Default.irs`, `DTS Headphone X - Wide.irs`, `Creative CMSS-3D - Max.irs`, `Creative X-Fi ((Z-Edition)) Crystalizer 10 + Expand 10.irs`, `HTC Beats Audio ((Z-Edition)).irs`, `Soundstage Expander V2.irs`, `XHR X-Pro.irs`, `XHR qSurround.irs`, seri `Razor Surround ((48k Z-Edition))` (1–7), seri `Accudio ((48kHz Z.E.))` (10 profil), seri `Waves MaxxAudio` & `MaxxAudio Pro`, serta custom IRS `wenak.irs`, `tes.irs`, `tes5.irs`.

</details>

---

## 🔄 SYNC PERUBAHAN BARU DARI PC KE REPO

Jika nanti Anda mengubah EQ atau menambah preset baru di PC ini dan ingin update backup ke GitHub:

```bash
./backup-current.sh
git add -A
git commit -m "chore: update easyeffects presets & configs"
git push
```
