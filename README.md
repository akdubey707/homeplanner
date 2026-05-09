# 🏡 HomePlanner Pro

> **A complete, self-hosted home planning web app — single HTML file, zero build step, all data on your own server.**

Plan your dream home from scratch — track budgets, rooms, contractors, loans, snag list, utilities, payments, moodboard and more. Works on desktop and mobile.

---

## 📦 Two Versions

| File | Backend | Best For |
|------|---------|----------|
| `home-planner-pb.html` | **PocketBase** | Simple setup, one binary, recommended |
| `home-planner-supabase.html` | **Supabase (Self-hosted)** | If you already run Supabase |
| `pb_schema_complete.json` | PocketBase | Import all 26 collections at once |
| `supabase_schema.sql` | Supabase | Run in SQL Editor to create all tables |

---

## ✨ Features

### 📋 Planning
| Tab | What you can do |
|-----|----------------|
| 🏗 **Plan** | Sections + items with cost, qty, priority. Vendor quote comparison. Purchase status. Warranty tracking. Budget per section. |
| 💰 **Budget vs Actual** | Estimated vs actual spend. Section-wise bar chart. Overall budget utilization. |
| 🏦 **Payment Milestones** | Builder payment timeline — Booking to Possession. Progress bar. |
| 📅 **Cashflow** | Month-wise outflow chart (6/12/24 months). Income tracker. Savings rate. |
| 🔴 **Snag List** | Defects log with photo, priority, contractor assign. One-tap status cycle Open → In Progress → Fixed. |

### 🏠 Home
| Tab | What you can do |
|-----|----------------|
| 🏠 **Rooms** | Area, direction, floor, Vastu. Paint details (brand, shade, finish, litres). Electrical points. Plumbing points. Furniture with dimensions. |
| 📸 **Gallery** | Before/During/After photos per room. Lightbox viewer. Camera capture on mobile. |
| 📐 **Floor Plan** | 20x15 grid sketch. Add/move/resize rooms. Import from Rooms tab. |
| 🧭 **Vastu** | 8-direction compass. Room recommendations. Your rooms Vastu check. |
| 🎨 **Moodboard** | Colors, materials, furniture, lighting per room. Color picker. Image references. |

### 💰 Finance
| Tab | What you can do |
|-----|----------------|
| 🏦 **Loans** | EMI calculator — Reducing Balance and Flat Rate. Total interest payable. |
| 🔁 **Monthly** | Recurring expenses. Monthly and annual burn rate. |
| 💡 **Utilities** | Electricity/Water/Gas bill history. Trend chart. Meter number and rate per unit. |

### 👷 People & Area
| Tab | What you can do |
|-----|----------------|
| 👷 **Contractors** | Plumber/Electrician/Carpenter etc. Call and WhatsApp buttons. Work history. Payment due tracker. |
| 🌏 **Area** | Nearby amenities, society contacts, parking, society rules, commute routes. |

### 📋 Tracking
| Tab | What you can do |
|-----|----------------|
| ⚡ **Smart Home** | Device tracker by category, protocol, room. Presets included. |
| 🔧 **AMC** | Warranty and AMC expiry tracking. Service history log. Expiry alerts. |
| 📋 **Documents** | Legal doc tracker with status, due date. |
| 🗓 **Calendar** | Key dates — possession, registration, EMI start. Countdown. |
| 📊 **Dashboard** | Full summary — all stats in one view. |
| ⚙️ **Settings** | Profile, theme, accent color, connection status + logs, Backup & Restore. |

### 🔧 Technical highlights
- Undo / Redo — full history
- Global Search — across all data
- Backup & Restore — one-click JSON export + drag-drop restore
- Live Connection Log — real-time error diagnostics
- Dark / Light theme with 8 accent colors
- Mobile optimized — keyboard stays open on Android, horizontal sidebar, card-style rows

---

## 🚀 Quick Setup

### Option A — PocketBase (Recommended)

**1. Run PocketBase**
```bash
# Download from https://pocketbase.io/docs/
./pocketbase serve --http="0.0.0.0:8100"
```

**2. Create users collection**

PocketBase Admin (`http://YOUR_IP:8100/_/`) → New collection → Type: **Auth** → Name: `users`

Add these fields to `users`:
- `name` → text
- `username` → text
- `avatar_color` → text

**3. Import all 26 collections**

Settings → Import collections → Upload `pb_schema_complete.json` → **Merge ON** → Import

**4. Open the app**

Open `home-planner-pb.html` in browser → Enter PocketBase URL → Register → Done ✅

---

### Option B — Self-Hosted Supabase

**1. Run SQL schema**

Supabase Dashboard → SQL Editor → Paste `supabase_schema.sql` → Run

**2. Add schema to PostgREST config**

In `supabase/config.toml`:
```toml
[api]
schemas = ["public", "homeplanner"]
```
Restart Supabase after this change.

**3. Open the app**

Open `home-planner-supabase.html` → Enter Supabase URL + Anon Key → Register → Done ✅

Anon key: Supabase Dashboard → Settings → API → `anon public`

---

## 📁 Database Schema (26 Tables)

| Collection / Table | Purpose |
|-------------------|---------|
| `profiles` | Property profile per user |
| `sections` | Planning sections (Kitchen, Flooring…) |
| `items` | Items with vendor quotes and warranty |
| `loans` | Home loans with EMI calculation |
| `recurring` | Monthly expenses |
| `rooms` | Rooms with paint, electrical, plumbing |
| `furniture` | Furniture within rooms |
| `smart_devices` | Smart home devices |
| `amc_items` | Appliances with warranty/AMC |
| `service_logs` | AMC service visit history |
| `neighbourhood` | Nearby amenities |
| `contacts` | Society directory |
| `parking` | Parking slot details |
| `society_rules` | Bylaws and rules |
| `documents` | Legal document tracker |
| `key_dates` | Important dates with countdown |
| `commute_routes` | Daily commute tracker |
| `room_photos` | Before/After/Progress gallery |
| `contractors` | Contractor manager |
| `contractor_works` | Work history + payment due |
| `snags` | Post-possession defect log |
| `payment_milestones` | Builder payment timeline |
| `utility_logs` | Monthly electricity/water/gas bills |
| `util_meters` | Meter info + rate per unit |
| `moodboard` | Interior design references |
| `income_logs` | Income tracker for savings calculation |

---

## 🛠 Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | React 18 (CDN/UMD), Babel Standalone, jsPDF |
| Backend (Option A) | PocketBase v0.23+ (single binary) |
| Backend (Option B) | Supabase self-hosted (PostgREST + GoTrue) |
| Database | SQLite (PocketBase) / PostgreSQL (Supabase) |
| Auth | PocketBase built-in / Supabase GoTrue |
| Fonts | Playfair Display, DM Mono (Google Fonts) |

---

## 📱 Mobile Usage

- Add to Home Screen on Android/iOS for app-like experience
- Keyboard stays open while typing
- Horizontal scrollable sidebar on small screens
- Card-style item rows on mobile, full grid on desktop
- Camera capture for photos directly from browser

---

## 🏠 Self-Hosting Tips

**PocketBase:**
- Run on Raspberry Pi / ZimaOS / Proxmox LXC for always-on access
- Keep `pb_data/` folder backed up — all data is there
- Use Tailscale for secure remote access without opening ports

**Supabase:**
- Run with Docker Compose on any Linux server
- Add `homeplanner` to `db-schemas` in PostgREST config
- Use nginx reverse proxy for HTTPS

---

## 💾 Backup & Restore

Built into the app — Settings → Backup & Restore:
- **Download Full Backup** — complete JSON of all your data
- **Export Summary CSV** — record counts per collection
- **Restore from Backup** — drag-drop JSON to restore (adds, does not overwrite)

---

## 🔌 Connection Status

Both versions include a live connection diagnostic panel in Settings → Connection:
- Real-time latency display
- Detailed error log with HTTP status codes
- Auto-refresh every 30 seconds
- One-click reconnect test

---

## 📄 License

MIT — free to use, modify, self-host, share.

---

## 🙏 Credits

- [PocketBase](https://pocketbase.io) — amazing self-hostable BaaS
- [Supabase](https://supabase.com) — open source Firebase alternative
- [React](https://react.dev) — UI library
- [jsPDF](https://github.com/parallax/jsPDF) — PDF export

---

*Built with love for homeowners who want full control of their data.*
