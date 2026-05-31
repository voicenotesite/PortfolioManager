# Portfolio Manager

**Daemon + GUI do zarządzania 5 backendami portfolio.**

⬇️ [Pobierz PortfolioManager (Linux)](https://github.com/voicenotesite/PortfolioManager/raw/main/dist/PortfolioManager)

```bash
chmod +x PortfolioManager && ./PortfolioManager
```

Windows/macOS: `python3 gui/manager.py` lub zbuduj PyInstallerem.

> ⚠️ **Portfolio Manager** zastąpił starsze `portfolio-daemon`. Wszystkie funkcje zostały przeniesione – nowsza wersja ma auto-venv, binarkę PyInstaller i lepsze wsparcie dla tuneli Cloudflare.

---

## Struktura

```
├── run.sh                ← Szybki start (venv + daemon + GUI, jednym poleceniem)
├── requirements.txt      ← Zależności Pythona
├── daemon/daemon.py      ← Główny daemon (API :19876, health check, git auto-update)
├── gui/manager.py        ← GUI z sidebarem (5 projektów) i podglądem logów
├── config.json           ← Konfiguracja backendów
├── config.json.example   ← Szablon konfiguracji
└── dist/PortfolioManager ← Gotowa binarka (PyInstaller)
```

## Jak uruchomić

### 💥 Szybki start (Linux) — polecam

```bash
chmod +x run.sh && ./run.sh
```

`run.sh` sam tworzy venv, instaluje zależności, zabija stary daemon na porcie 19876, startuje nowy i otwiera GUI – wszystko automatycznie.

### Ręcznie

```bash
pip install -r requirements.txt
python3 daemon/daemon.py &     # API na :19876
python3 gui/manager.py         # GUI okienkowe
```

### Binarka (Linux, bez Pythona)

```bash
chmod +x dist/PortfolioManager && ./dist/PortfolioManager
```

## API Daemona

| Endpoint | Metoda | Opis |
|----------|--------|------|
| `/health` | GET | Status daemona |
| `/status` | GET | Status wszystkich backendów |
| `/start/{key}` | POST | Uruchom backend |
| `/stop/{key}` | POST | Zatrzymaj backend |
| `/restart/{key}` | POST | Restart backendu |
| `/logs/{key}` | GET | Logi backendu (ostatnie 50) |
| `/update/{key}` | POST | Git pull + restart |
| `/update-all` | POST | Git pull + restart wszystkich |
| `/start-all` | POST | Uruchom wszystkie |
| `/stop-all` | POST | Zatrzymaj wszystkie |
| `/restart-all` | POST | Restart wszystkich |
| `/logs/{key}` | GET | Logi backendu (ostatnie 50) |
| `/tunnel/start` | POST | Start Cloudflare Tunnel |
| `/tunnel/stop` | POST | Stop Cloudflare Tunnel |
| `/manager.py` | GET | Pobierz manager.py |
| `/run.sh` | GET | Pobierz run.sh |

## 5 Projektów

| Projekt | Port | Status |
|---------|------|--------|
| URL Shortener | 8000 | ✅ Gotowy |
| GraphQL Blog | 8001 | ✅ Gotowy |
| AI Chat Proxy | 8003 | ✅ Gotowy |
| Async Task Queue | 8004 | 🔜 W implementacji |
| RAG PDF Q&A | 8005 | 🔜 W implementacji |

## Budowanie binarki

```bash
pip install pyinstaller
pyinstaller --onefile --windowed --collect-all tkinter gui/manager.py
```

## Licencja

MIT
