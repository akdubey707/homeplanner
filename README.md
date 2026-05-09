# 🏡 HomePlanner Pro

A **single-file, offline-capable home planning web app** backed by your own self-hosted [PocketBase](https://pocketbase.io) instance. No cloud subscriptions, no data leaving your network.

> Built with React 18 (CDN), plain HTML/CSS — no build step required.

---

## ✨ Features

| Tab | What you can do |
|-----|----------------|
| 🏗 **Plan** | Create sections (Living Room, Kitchen…), add items with cost, quantity, priority. Drag-to-reorder. Budget tracking with over-budget warnings. |
| 🏠 **Rooms** | Track each room's sqft, direction, floor, Vastu notes. Add furniture with dimensions. Photo notes. |
| ⚡ **Smart Home** | Log smart devices by category (Lighting, Security, Climate…), brand, protocol, room, cost. |
| 🔧 **AMC** | Track appliance warranties and AMC expiry dates. Never miss a renewal. |
| 🏦 **Loans** | Home loan EMI calculator — supports Reducing Balance & Flat Rate. Multiple loans. |
| 🔁 **Monthly** | Recurring expenses tracker — society charges, rent, subscriptions. Monthly burn rate. |
| 🌏 **Area** | Neighbourhood amenities, society contacts, parking slots, society rules. |
| 🗓 **Calendar** | Visual calendar for key dates — possession date, registration, EMI start etc. |
| 📋 **Documents** | Track legal documents — status, due date, source. |
| ⚙️ **Settings** | Profile, theme (dark/light), accent color, PocketBase connection diagnostics with live logs. |

### Other highlights
- 🔍 Global search across all data
- ↩️ Undo / Redo support
- 📄 PDF export of your plan
- 🌙 Dark / Light theme with 8 accent colors
- 📱 Mobile-friendly — keyboard stays open on Android
- 🔒 Auth via PocketBase native email + password
- 📡 Live connection log with error diagnostics

---

## 🛠 Tech Stack

- **Frontend** — React 18 (UMD CDN), Babel Standalone, jsPDF
- **Backend** — [PocketBase](https://pocketbase.io) (self-hosted, v0.23+)
- **Storage** — PocketBase SQLite (auto-managed)
- **Auth** — PocketBase built-in email/password auth
- **Fonts** — Playfair Display, DM Mono (Google Fonts)

---

## 🚀 Setup

### 1. Run PocketBase

```bash
# Download from https://pocketbase.io/docs/
./pocketbase serve --http="0.0.0.0:8100"
```

Admin panel will be at `http://YOUR_IP:8100/_/`

---

### 2. Import Collections (one-time)

1. Open PocketBase Admin → **Settings → Import collections**
2. Upload the included **`pb_schema.json`** file
3. Enable **"Merge with existing collections"** toggle ✅
4. Click **Review → Import**

This creates all 16 required collections instantly.

---

### 3. Add `avatar_color` field to `users`

1. Collections → `users` → **Edit**
2. **Add field** → Name: `avatar_color`, Type: `text`
3. Save

---

### 4. Open the App

Open `home-planner-v8-pb.html` directly in any browser — no server needed for the frontend.

On first open:
- Enter your PocketBase URL (e.g. `http://192.168.1.20:8100`)
- Click **Test & Save Connection**
- Register your account → Start planning 🏡

---

## 📁 Collections (Database Schema)

| Collection | Purpose |
|------------|---------|
| `profiles` | User's property profile (city, budget, family, timeline) |
| `sections` | Planning sections (e.g. Living Room, Kitchen) |
| `items` | Items within sections (furniture, appliances etc.) |
| `loans` | Home loans with EMI calculation |
| `recurring` | Monthly recurring expenses |
| `rooms` | Rooms with dimensions and Vastu notes |
| `furniture` | Furniture within rooms |
| `smart_devices` | Smart home devices |
| `amc_items` | Appliances with warranty/AMC tracking |
| `neighbourhood` | Nearby amenities (hospital, school, market…) |
| `contacts` | Society contacts (neighbours, security, plumber…) |
| `parking` | Parking slot details |
| `society_rules` | Society bylaws and rules |
| `documents` | Legal/property documents tracker |
| `key_dates` | Important dates (possession, registration…) |
| `commute_routes` | Daily commute routes with cost/time |

---

## 📱 Mobile Usage

Works great on Android Chrome / Samsung Internet:

- Add to Home Screen for PWA-like experience
- Keyboard stays open while typing (fixed with `React.memo` + `resizes-visual` viewport)
- Swipe left/right to navigate between tabs

---

## 🔧 Configuration

To change the default PocketBase URL, edit this line near the top of the HTML file:

```javascript
const DEFAULT_PB_URL = "http://192.168.1.20:8100";
```

---

## 📦 Files

```
├── home-planner-v8-pb.html   ← The entire app (single file)
├── pb_schema.json            ← PocketBase collections schema (import once)
└── README.md                 ← This file
```

---

## 🏠 Self-Hosting Tips

- Run PocketBase on a **Raspberry Pi / ZimaOS / Proxmox LXC** for always-on access
- Use **Tailscale** or **WireGuard** to access from outside your home network securely
- PocketBase auto-backs up SQLite — keep `pb_data/` folder safe
- No reverse proxy needed for local LAN use

---

## 📸 Screenshots

> Add your screenshots here

---

## 📄 License

MIT — free to use, modify, self-host.

---

## 🙏 Credits

- [PocketBase](https://pocketbase.io) — amazing self-hostable BaaS
- [React](https://react.dev) — UI library
- [jsPDF](https://github.com/parallax/jsPDF) — PDF export
