# 🛡️ PagarNet — Browser Extension Anti Judol & Scam Indonesia

## Fitur Utama

| Fitur | Deskripsi |
|-------|-----------|
| 🕵️ Deep Scan Mode | Lacak redirect chain, deteksi domain typosquatting |
| 🔗 Hover Link Scanner | Hover di atas link → langsung muncul skor keaman |
| 🚨 Auto Blocker | Blokir otomatis situs judol & scam sebelum terbuka |
| 📋 Paste Link Detector | Deteksi link berbahaya saat paste (cocok untuk WA Web) |
| 🧠 Behavioral Analysis | Analisis konten halaman secara real-time |
| ⚡ Panic Button | Tutup semua tab berbahaya sekaligus |
| 🚩 Report to Kominfo | Laporkan situs langsung dari popup |
| 📊 Dashboard Statistik | Lihat berapa judol & scam yang sudah diblokir |

---

## Cara Install (Developer Mode)

1. **Download / clone** folder `pagarnet/` ini
2. Buka Chrome → ketik di address bar: `chrome://extensions`
3. Aktifkan **Developer Mode** (toggle kanan atas)
4. Klik **"Load unpacked"**
5. Pilih folder `pagarnet/`
6. Extension PagarNet akan muncul di toolbar! ✅

> Untuk Firefox: buka `about:debugging` → "This Firefox" → "Load Temporary Add-on" → pilih `manifest.json`

## Struktur File

```
pagarnet/
├── manifest.json      # Konfigurasi extension (Manifest V3)
├── background.js      # Engine utama: deteksi, blokir, scoring
├── content.js         # Injected ke halaman: hover scanner, behavioral analysis
├── popup.html         # UI popup extension
├── popup.js           # Logic popup
├── blocked.html       # Halaman yang muncul saat situs diblokir
└── icons/             # Icon extension (tambahkan sendiri)
    ├── icon16.png
    ├── icon48.png
    └── icon128.png
```

---

## Cara Kerja Detection Engine

```
URL masuk
    ↓
[1] Cek Blacklist (database domain judol/scam)
    ↓
[2] Keyword Analysis (slot, gacor, togel, scam, dll)
    ↓
[3] Typosquatting Detection (b-c-a.net meniru bca?)
    ↓
[4] Redirect Chain Tracker (lacak semua redirect)
    ↓
[5] TLD & Domain Pattern Check (.xyz, .club, dll)
    ↓
[Skor 0-100] → ≥50 = BLOKIR, 30-49 = WARNING, <30 = AMAN
```

---

## Pengembangan Selanjutnya

- [ ] Server backend untuk sinkronisasi blacklist real-time
- [ ] Integrasi API Kominfo untuk laporan resmi
- [ ] Machine learning classifier untuk deteksi konten visual
- [ ] QR code scanner
- [ ] Dukungan Firefox penuh
- [ ] Mode Parental Control

---

## Tech Stack

- **JavaScript** (Vanilla, no framework)
- **Chrome Extension Manifest V3**
- **Web Navigation API** untuk redirect tracking
- **Chrome Storage API** untuk cache & statistik
- **Chrome Notifications API** untuk alert

---

## Push ke GitHub

Repo tujuan:
- `https://github.com/Maftuuh1922/Pagarnet.git`

Set identitas git (sesuaikan jika email typo):

```bash
git config --global user.name "Maftuuh1922"
git config --global user.email "rizkiuya12gmail.com"
```

Inisialisasi dan push:

```bash
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/Maftuuh1922/Pagarnet.git
git push -u origin main
```

Jika remote `origin` sudah ada:

```bash
git remote set-url origin https://github.com/Maftuuh1922/Pagarnet.git
git push -u origin main
```

---

Made with ❤️ untuk Indonesia 🇮🇩 — Lawan Judol, Lawan Scam!

