# 🏡 HomePlanner Pro

A self-hosted, offline-capable home buying and interior planning app built with **React + Supabase**. Manage your entire home journey — from budget planning and loan tracking to room design, contractor management, and AMC warranties — all in a **single HTML file**.

---

## ✨ Features

| Module | What it does |
|---|---|
| 📋 **Planner** | Sections & line items with vendor quotes, warranty tracking, purchase status |
| 🏠 **Rooms** | Room inventory with Vastu tips, sqft, direction, floor, color |
| 🪑 **Furniture** | Per-room furniture tracker with dimensions and placement status |
| 🖼 **Gallery** | Before/After photo gallery per room |
| 🗺 **Floor Plan** | Grid-based floor plan builder |
| 🧿 **Vastu** | Room-by-room Vastu compliance tips |
| 🔴 **Snag List** | Defect tracker with priority, status, contractor assignment |
| 💰 **Budget** | One-time cost breakdown by section with over-budget alerts |
| 🏦 **Payments** | Builder payment milestone tracker by construction stage |
| 📈 **Cashflow** | 12/24/36-month EMI + recurring expense projection |
| 🎨 **Moodboard** | Color palettes, material swatches, finish references per room |
| ⚡ **Utility** | Electricity/water/gas meter and monthly log tracker |
| 📱 **Smart Home** | Smart device inventory by category and protocol |
| 🔧 **AMC** | Appliance warranty and AMC expiry tracker with alerts |
| 🏦 **Loans** | Multi-loan EMI calculator (reducing balance + flat rate) |
| 🔁 **Recurring** | Monthly/quarterly/annual expense tracker |
| 🏘 **Neighbourhood** | Nearby amenities with distance and travel time |
| 🚗 **Commute** | Route planner with cost-per-day calculation |
| 🅿️ **Parking** | Parking slot registry |
| 📜 **Society Rules** | Society bylaws and rules reference |
| 👥 **Contacts** | Neighbours, vendors, committee members directory |
| 👷 **Contractors** | Contractor directory with trade, rating, work history |
| 📅 **Calendar** | Key dates and possession timeline view |
| 📄 **Documents** | Legal and financial document checklist with status |
| 📊 **Dashboard** | Full summary with alerts, EMI burden, budget health |
| ⚙️ **Settings** | Theme, accent color, profile, import/export, backup |

---

## 🛠 Tech Stack

- **Frontend** — React 18 (UMD, no build step), Babel standalone, DM Mono font
- **Backend** — [Supabase](https://supabase.com) (self-hosted or cloud) — PostgREST + GoTrue Auth
- **PDF Export** — jsPDF
- **Deployment** — Single `.html` file, works from any static host or local filesystem

---

## 🚀 Quick Start

### 1. Set up Supabase

You can use **Supabase Cloud** (free tier) or **self-hosted** Supabase.

- Cloud: [supabase.com](https://supabase.com) → New project
- Self-hosted: [supabase.com/docs/guides/self-hosting](https://supabase.com/docs/guides/self-hosting)

### 2. Run the SQL schema

In **Supabase Dashboard → SQL Editor**, paste and run the full contents of `homeplanner_schema.sql`.

This creates **27 tables** all prefixed with `hp_`, disables RLS, and grants access to `anon` and `authenticated` roles.

### 3. Get your credentials

From **Supabase Dashboard → Settings → API**:

| Field | Where to find it |
|---|---|
| Project URL | `https://your-project.supabase.co` |
| `anon` public key | Under "Project API keys" |

### 4. Configure the app

Open `home-planner.html` and update the two constants near the top:

```js
const DEFAULT_SB_URL   = "https://your-project.supabase.co";
const DEFAULT_ANON_KEY = "your-anon-key-here";
```

### 5. Open the app

Just open `home-planner.html` in any modern browser. No server, no `npm install`, no build step.

- Works from `file://` locally
- Works hosted on GitHub Pages, Netlify, Vercel, or any static host
- Works on mobile — add to home screen for PWA-like experience

---

## 📁 File Structure

```
├── home-planner.html        # Entire app — single file
├── homeplanner_schema.sql   # Supabase database schema
└── README.md
```

---

## 🗄 Database Schema

All tables live in the `public` schema and are prefixed `hp_`.

```
hp_profiles           — User profile (city, budget, family, timeline)
hp_sections           — Planner sections (Kitchen, Flooring, etc.)
hp_items              — Line items per section (with vendor quotes & warranty)
hp_rooms              — Rooms (type, sqft, direction, vastu, color)
hp_furniture          — Furniture per room
hp_room_photos        — Before/After photos per room
hp_loans              — Home/personal loans
hp_payment_milestones — Builder payment stages
hp_income_logs        — Monthly income entries
hp_recurring          — Recurring expenses (EMI, maintenance, etc.)
hp_snags              — Snag/defect list
hp_key_dates          — Important dates (possession, registration, etc.)
hp_documents          — Document checklist
hp_contractors        — Contractor directory
hp_contractor_works   — Work log per contractor
hp_amc_items          — Appliances with warranty and AMC details
hp_service_logs       — AMC/service visit logs
hp_smart_devices      — Smart home device inventory
hp_moodboard          — Room moodboard (colors, materials, finishes)
hp_util_meters        — Utility meter details
hp_utility_logs       — Monthly utility readings
hp_neighbourhood      — Nearby amenities
hp_commute_routes     — Commute routes with cost
hp_parking            — Parking slot details
hp_society_rules      — Society rules and bylaws
hp_contacts           — Contacts directory
```

> **PostgREST embedding note:** Nested fetches use `?select=*,hp_items(*)` and `?select=*,hp_furniture(*)` — the embed key must match the actual table name, not an alias.

---

## 🔐 Authentication

The app uses **Supabase GoTrue** email/password auth.

- Register with email, password, name, and optional property details
- JWT token is stored in `localStorage` and sent as `Authorization: Bearer <token>` on every API call
- RLS is **disabled** on all tables — the app uses `user_id` filtering at the query level (`?user_id=eq.<id>`)
- If you want stricter security, enable RLS and add policies — see [Supabase RLS docs](https://supabase.com/docs/guides/auth/row-level-security)

---

## 📤 Import / Export

| Format | Direction | What |
|---|---|---|
| CSV | Import | Items, Rooms, Contacts |
| CSV | Export | Items, Loans, Recurring, Rooms |
| JSON | Export | Full backup of all data |
| WhatsApp | Export | Summary text for sharing |
| PDF | Export | Full planner report |

---

## ⌨️ Keyboard Shortcuts

| Shortcut | Action |
|---|---|
| `/` | Open global search |
| `Escape` | Close modal / search |
| `Ctrl + Z` | Undo last action |
| `Ctrl + Y` | Redo |
| `G` then `D` | Go to Dashboard |
| `G` then `P` | Go to Planner |

---

## 📱 Mobile Support

- Fully responsive — works on iPhone and Android
- Font size 16px on inputs to prevent iOS zoom
- Sidebar collapses to horizontal pill tabs on mobile
- Modals slide up from bottom on mobile
- Touch-friendly tap targets throughout

---

## ⚡ Performance

- **Cache-first loading** — data renders instantly from `localStorage` on every open, then syncs fresh data from Supabase in the background
- **23 parallel fetches** on load via `Promise.all` — all tables load simultaneously
- **Memoized components** — `React.memo` + `useCallback` on all inputs and helpers prevent unnecessary re-renders
- **GPU-composited scrolling** — `transform: translateZ(0)` on scroll containers for smooth 60fps scrolling
- **Undo/redo stack** — up to 20 snapshots in memory, no performance impact on normal usage

---

## 🎨 Theming

8 accent colors available (Ocean, Emerald, Violet, Amber, Rose, Coral, Cyan, Lime) with full dark/light mode. Theme preference is saved to `localStorage`.

---

## 🐛 Known Limitations

- No real-time sync between multiple devices/tabs (refresh to get latest)
- Photo URLs must be externally hosted (no file upload — use Supabase Storage or Imgur)
- RLS is disabled — not recommended for multi-tenant or public deployments without adding row-level policies

---

## 📝 License

MIT — free to use, modify, and self-host.

---

## 🙏 Credits

Built with [React](https://react.dev), [Supabase](https://supabase.com), [jsPDF](https://github.com/parallax/jsPDF), and [Google Fonts](https://fonts.google.com).
