# There is **ZERO** reason to use Linux... oh wait, you like spyware? 🤡💀

## Core Tracking Services

- **systemd-journald** – *Because who doesn’t love a binary log that can log literally everything about your system?*  
- **udev / hwdb** – *Knows every single piece of hardware you plug in or remove, forever.*  
- **D-Bus** – *An omnipresent message bus… so your apps can gossip about you behind your back.*  
- **NetworkManager** – *Tracks every Wi-Fi network you've ever connected to.*  

---

## Search & Desktop Tracking

- **GNOME Tracker / Baloo / Zeitgeist** – *Full-text indexer that knows about every file you touched, opened, or looked at.*  
- **Desktop Environments (GNOME/KDE)** – *Metadata collection of your usage habits (because “usability metrics”).*  

---

## Input Tracking

- **IBus / Fcitx** – *Handles your keyboard input, remembers your typing habits… for your “convenience”.*  

---

## Ad & Profile Building

- **Ubuntu’s "Amazon Lens" (RIP but they tried)** – *Remember when your desktop search got sent to Amazon?*  
- **Flatpak Telemetry (Flathub)** – *Every app you download is logged for analytics.*  
- **Snap Telemetry (Canonical)** – *Tracks Snap installs and updates because why not?*  

---

## Error & Update Surveillance

- **Apport (Ubuntu)** – *Crash reports? Straight to Canonical.*  
- **Whoopsie** – *Sends error telemetry automatically, just in case you didn’t opt in.*  
- **Package Repositories** – *Every update ping goes through centralized servers; they know when you update and what you installed.*  

---

## Cloud & Sync Tracking

- **GNOME Online Accounts** – *All your accounts, centralized. Sounds safe, right?*  
- **Ubuntu Pro & Canonical SSO** – *Login hooks tied directly to Canonical services.*  

---

## Security Telemetry

- **SELinux / AppArmor logs** – *Every denied access attempt is recorded for “security” (and central audits in enterprise).*  
- **Debian Popularity Contest (popcon)** – *Voluntary? Sure. But it logs every package you have installed.*  

---

⚠️ Many of these processes **run at all times**, even when you think you disabled them. Some distros (looking at you, Ubuntu 👀) have a **long history of slipping in opt-out telemetry**.  
