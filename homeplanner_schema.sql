-- ═══════════════════════════════════════════════════════════
-- HomePlanner Pro — Supabase Schema (public schema)
-- Run in: Supabase Dashboard → SQL Editor → Run All
-- ═══════════════════════════════════════════════════════════

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop & recreate (safe re-run)
DROP TABLE IF EXISTS public.hp_income_logs        CASCADE;
DROP TABLE IF EXISTS public.hp_util_meters        CASCADE;
DROP TABLE IF EXISTS public.hp_utility_logs       CASCADE;
DROP TABLE IF EXISTS public.hp_contractor_works   CASCADE;
DROP TABLE IF EXISTS public.hp_service_logs       CASCADE;
DROP TABLE IF EXISTS public.hp_amc_items          CASCADE;
DROP TABLE IF EXISTS public.hp_smart_devices      CASCADE;
DROP TABLE IF EXISTS public.hp_moodboard          CASCADE;
DROP TABLE IF EXISTS public.hp_snags              CASCADE;
DROP TABLE IF EXISTS public.hp_documents          CASCADE;
DROP TABLE IF EXISTS public.hp_key_dates          CASCADE;
DROP TABLE IF EXISTS public.hp_payment_milestones CASCADE;
DROP TABLE IF EXISTS public.hp_recurring          CASCADE;
DROP TABLE IF EXISTS public.hp_loans              CASCADE;
DROP TABLE IF EXISTS public.hp_commute_routes     CASCADE;
DROP TABLE IF EXISTS public.hp_neighbourhood      CASCADE;
DROP TABLE IF EXISTS public.hp_parking            CASCADE;
DROP TABLE IF EXISTS public.hp_society_rules      CASCADE;
DROP TABLE IF EXISTS public.hp_contacts           CASCADE;
DROP TABLE IF EXISTS public.hp_room_photos        CASCADE;
DROP TABLE IF EXISTS public.hp_furniture          CASCADE;
DROP TABLE IF EXISTS public.hp_items              CASCADE;
DROP TABLE IF EXISTS public.hp_sections           CASCADE;
DROP TABLE IF EXISTS public.hp_rooms              CASCADE;
DROP TABLE IF EXISTS public.hp_contractors        CASCADE;
DROP TABLE IF EXISTS public.hp_profiles           CASCADE;

CREATE TABLE public.hp_profiles (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id     text NOT NULL,
  city        text,
  budget      numeric,
  family      text,
  timeline    text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_sections (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  name        text NOT NULL,
  priority    text,
  budget      numeric,
  created_at  timestamptz DEFAULT now()
);

-- ★ UPDATED: added vendor_cost, vendor2, vendor2_cost, purchase_status, warranty fields
CREATE TABLE public.hp_items (
  id               uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  section_id       uuid REFERENCES public.hp_sections(id) ON DELETE CASCADE,
  name             text NOT NULL,
  cost             numeric DEFAULT 0,
  qty              integer DEFAULT 1,
  priority         text DEFAULT 'Must-have',
  notes            text,
  done             boolean DEFAULT false,
  vendor           text,
  vendor_cost      numeric DEFAULT 0,
  vendor2          text,
  vendor2_cost     numeric DEFAULT 0,
  purchase_status  text DEFAULT 'Not Started',
  warranty_months  integer,
  warranty_start   text,
  created_at       timestamptz DEFAULT now()
);

CREATE TABLE public.hp_rooms (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  name        text NOT NULL,
  type        text,
  sqft        numeric,
  direction   text,
  floor       text,
  vastu       text,
  notes       text,
  color       text,
  created_at  timestamptz DEFAULT now()
);

-- furniture FK to rooms enables ?select=*,hp_furniture(*) in PostgREST
CREATE TABLE public.hp_furniture (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  room_id     uuid REFERENCES public.hp_rooms(id) ON DELETE CASCADE,
  name        text NOT NULL,
  width       text,
  depth       text,
  notes       text,
  placed      boolean DEFAULT false,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_room_photos (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  room_id     text,
  url         text,
  caption     text,
  tag         text DEFAULT 'Before',
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_loans (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  name        text,
  type        text DEFAULT 'Home Loan',
  amount      numeric,
  rate        numeric,
  tenure      numeric,
  "rateType"  text DEFAULT 'Reducing Balance',
  notes       text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_payment_milestones (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  label       text NOT NULL,
  stage       text DEFAULT 'Booking',
  amount      numeric DEFAULT 0,
  paid_date   text,
  due_date    text,
  paid        boolean DEFAULT false,
  notes       text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_income_logs (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  source      text,
  month       text,
  amount      numeric DEFAULT 0,
  notes       text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_recurring (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  name        text NOT NULL,
  icon        text DEFAULT '💰',
  amount      numeric DEFAULT 0,
  frequency   text DEFAULT 'Monthly',
  category    text DEFAULT 'Other',
  notes       text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_snags (
  id             uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id     uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  title          text NOT NULL,
  location       text,
  priority       text DEFAULT 'High',
  status         text DEFAULT 'Open',
  contractor_id  text,
  notes          text,
  photo          text,
  created_at     timestamptz DEFAULT now()
);

CREATE TABLE public.hp_key_dates (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  label       text NOT NULL,
  date        text NOT NULL,
  type        text DEFAULT 'Possession Date',
  notes       text,
  color       text DEFAULT '#38bdf8',
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_documents (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  name        text NOT NULL,
  category    text DEFAULT 'Legal',
  status      text DEFAULT 'Pending',
  due_date    text,
  source      text,
  notes       text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_contractors (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  name        text NOT NULL,
  trade       text DEFAULT 'Plumber',
  phone       text,
  rating      integer DEFAULT 5,
  last_called text,
  status      text DEFAULT 'Active',
  notes       text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_contractor_works (
  id             uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id     uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  contractor_id  text,
  work           text,
  date           text,
  cost           numeric DEFAULT 0,
  payment_due    numeric DEFAULT 0,
  notes          text,
  created_at     timestamptz DEFAULT now()
);

-- Only snake_case columns — app converts camelCase before POST
CREATE TABLE public.hp_amc_items (
  id               uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id       uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  name             text NOT NULL,
  category         text DEFAULT 'Air Conditioner',
  brand            text,
  purchase_date    text,
  warranty_expiry  text,
  amc_expiry       text,
  amc_cost         numeric,
  vendor           text,
  notes            text,
  created_at       timestamptz DEFAULT now()
);

CREATE TABLE public.hp_service_logs (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  amc_id      text,
  date        text,
  technician  text,
  cost        numeric DEFAULT 0,
  notes       text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_smart_devices (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  name        text NOT NULL,
  category    text DEFAULT 'Lighting',
  brand       text,
  cost        numeric DEFAULT 0,
  protocol    text DEFAULT 'Wi-Fi',
  room        text,
  notes       text,
  installed   boolean DEFAULT false,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_moodboard (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  room_id     text,
  category    text DEFAULT 'Color',
  title       text,
  value       text,
  notes       text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_util_meters (
  id               uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id       uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  type             text DEFAULT 'Electricity',
  meter_no         text,
  rate_per_unit    numeric,
  connection_date  text,
  notes            text,
  created_at       timestamptz DEFAULT now()
);

CREATE TABLE public.hp_utility_logs (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  type        text DEFAULT 'Electricity',
  month       text,
  units       numeric DEFAULT 0,
  amount      numeric DEFAULT 0,
  notes       text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_neighbourhood (
  id           uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id   uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  type         text,
  name         text NOT NULL,
  distance     text,
  travel_time  text,
  rating       integer DEFAULT 5,
  notes        text,
  created_at   timestamptz DEFAULT now()
);

CREATE TABLE public.hp_commute_routes (
  id             uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id     uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  label          text,
  destination    text NOT NULL,
  mode           text DEFAULT '🚗 Car',
  distance_km    numeric,
  time_mins      numeric,
  cost_per_day   numeric,
  notes          text,
  created_at     timestamptz DEFAULT now()
);

CREATE TABLE public.hp_parking (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  slot        text NOT NULL,
  type        text DEFAULT 'Covered',
  floor       text DEFAULT 'B1',
  notes       text,
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_society_rules (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  rule        text NOT NULL,
  category    text DEFAULT 'Pets',
  created_at  timestamptz DEFAULT now()
);

CREATE TABLE public.hp_contacts (
  id          uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id  uuid REFERENCES public.hp_profiles(id) ON DELETE CASCADE,
  name        text NOT NULL,
  role        text DEFAULT 'Neighbour',
  phone       text,
  flat        text,
  notes       text,
  created_at  timestamptz DEFAULT now()
);

-- ═══════════════════════════════════════
-- DISABLE RLS on all tables
-- ═══════════════════════════════════════
ALTER TABLE public.hp_profiles           DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_sections           DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_items              DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_rooms              DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_furniture          DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_room_photos        DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_loans              DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_payment_milestones DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_income_logs        DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_recurring          DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_snags              DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_key_dates          DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_documents          DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_contractors        DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_contractor_works   DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_amc_items          DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_service_logs       DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_smart_devices      DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_moodboard          DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_util_meters        DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_utility_logs       DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_neighbourhood      DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_commute_routes     DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_parking            DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_society_rules      DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.hp_contacts           DISABLE ROW LEVEL SECURITY;

-- ═══════════════════════════════════════
-- GRANTS
-- ═══════════════════════════════════════
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES    IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;

-- ═══════════════════════════════════════
-- VERIFY — should show 27 hp_ tables
-- ═══════════════════════════════════════
SELECT table_name FROM information_schema.tables
WHERE table_schema='public' AND table_name LIKE 'hp_%'
ORDER BY table_name;
