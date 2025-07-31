# Windows Telemetry / Spyware Components

## Core Tracking Services

- **DiagTrack (Connected User Experiences and Telemetry)** – *Constantly collects diagnostic and usage data in the background.*
- **dmwappushservice (WPN Service)** – *Pushes app usage and telemetry data out of your system.*
- **CompatTelRunner.exe (Microsoft Compatibility Appraiser)** – *Scans every program and hardware component you have, sending inventory to Microsoft.*
- **Appraiser.dll / AppraiserTelemetry.dll** – *Deep compatibility and system inventory scans.*
- **InventoryCollector.exe** – *Full hardware and software inventory upload.*

---

## Search & Voice Tracking

- **Cortana.exe / SearchUI.exe / SearchApp.exe** – *Monitors everything you search and sends it back to Microsoft.*
- **SpeechRuntime.exe** – *Listens to your voice input and forwards recordings for analysis.*

---

## Input Tracking

- **InputPersonalization.exe** – *Logs your typing habits and keystrokes to “improve predictions”.*
- **TextInputHost.exe** – *Tracks keyboard and handwriting input.*

---

## Ad & Profile Building

- **Advertising ID** – *Unique identifier tracking you across all apps.*
- **Live Tiles & Start Menu Ads** – *Reports app usage and habits for targeted ads.*
- **Microsoft Edge & Bing integration** – *Tracks browsing history and search habits.*
- **Microsoft Store telemetry** – *Collects app usage and install activity.*

---

## Error & Update Surveillance

- **Windows Error Reporting (WerFault.exe)** – *Uploads crash dumps, app memory, and system state directly to Microsoft.*
- **Windows Update Medic Service** – *Ensures telemetry stays on even if you disable it.*
- **Application Experience (AitAgent.exe)** – *Monitors which apps you run and how they behave.*

---

## Cloud & Sync Tracking

- **Sync Settings** – *Copies your passwords, browsing history, and settings to Microsoft’s cloud.*
- **OneDrive** – *Scans files and metadata as they’re synced.*
- **Windows Hello** – *Biometric data (fingerprints, facial scans) tied to cloud APIs.*

---

## Security Telemetry

- **SmartScreen (smartscreen.exe)** – *Uploads every app you download and URL you visit for “reputation checks”.*
- **Windows Defender Cloud Protection** – *Sends suspicious files and activity patterns to Microsoft.*

---

⚠️ Many of these processes **run at all times**, even when you think telemetry is off. Several (like *Windows Update Medic*) will **re-enable tracking services after you disable them**.
