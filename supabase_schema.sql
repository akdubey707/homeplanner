-- HomePlanner Pro — Self-Hosted Supabase Schema
-- Run this in Supabase Dashboard → SQL Editor
-- =====================================================

-- Create schema
CREATE SCHEMA IF NOT EXISTS homeplanner;

-- =====================================================
-- TABLES
-- =====================================================

CREATE TABLE IF NOT EXISTS homeplanner.profiles (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id text NOT NULL,
  city text,
  budget numeric,
  family text,
  timeline text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.sections (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  name text NOT NULL,
  priority text,
  budget numeric,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.items (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  section_id text NOT NULL,
  name text NOT NULL,
  cost numeric,
  qty numeric DEFAULT 1,
  priority text,
  notes text,
  done boolean DEFAULT false,
  photo_note text,
  vendor text,
  vendor2 text,
  vendor2_cost numeric,
  purchase_status text DEFAULT 'Not Started',
  warranty_months numeric,
  warranty_start text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.loans (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  name text NOT NULL,
  type text,
  amount numeric,
  rate numeric,
  tenure numeric,
  "rateType" text,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.recurring (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  name text NOT NULL,
  icon text,
  amount numeric,
  frequency text,
  category text,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.rooms (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  name text NOT NULL,
  type text,
  sqft numeric,
  direction text,
  floor text,
  color text,
  vastu text,
  notes text,
  photo_note text,
  paint_json text,
  elec_json text,
  plumb_json text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.furniture (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  room_id text NOT NULL,
  name text NOT NULL,
  width numeric,
  depth numeric,
  notes text,
  placed boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.smart_devices (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  name text NOT NULL,
  category text,
  brand text,
  cost numeric,
  protocol text,
  room text,
  notes text,
  installed boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.amc_items (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  name text NOT NULL,
  category text,
  brand text,
  purchase_date text,
  warranty_expiry text,
  amc_expiry text,
  amc_cost numeric,
  vendor text,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.neighbourhood (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  type text,
  name text NOT NULL,
  distance text,
  travel_time text,
  rating numeric,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.contacts (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  name text NOT NULL,
  role text,
  phone text,
  flat text,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.parking (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  slot text,
  type text,
  floor text,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.society_rules (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  rule text NOT NULL,
  category text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.documents (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  name text NOT NULL,
  category text,
  status text,
  due_date text,
  source text,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.key_dates (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  label text NOT NULL,
  date text,
  type text,
  notes text,
  color text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.commute_routes (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  label text NOT NULL,
  destination text,
  mode text,
  distance_km numeric,
  time_mins numeric,
  cost_per_day numeric,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.room_photos (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  room_id text,
  url text,
  caption text,
  tag text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.contractors (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  name text NOT NULL,
  trade text,
  phone text,
  rating numeric,
  last_called text,
  notes text,
  status text DEFAULT 'Active',
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.snags (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  title text NOT NULL,
  location text,
  priority text DEFAULT 'High',
  status text DEFAULT 'Open',
  contractor_id text,
  notes text,
  photo text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.payment_milestones (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  label text NOT NULL,
  stage text,
  amount numeric,
  due_date text,
  paid_date text,
  paid boolean DEFAULT false,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.utility_logs (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  type text,
  month text,
  units numeric,
  amount numeric,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.moodboard (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  room_id text,
  category text,
  title text NOT NULL,
  value text,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.service_logs (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  amc_id text,
  date text,
  technician text,
  cost numeric,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.contractor_works (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  contractor_id text,
  work text NOT NULL,
  date text,
  cost numeric,
  payment_due numeric,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.util_meters (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  type text,
  meter_no text,
  rate_per_unit numeric,
  connection_date text,
  notes text,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS homeplanner.income_logs (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  profile_id text NOT NULL,
  source text,
  amount numeric,
  month text,
  notes text,
  created_at timestamptz DEFAULT now()
);

-- =====================================================
-- Enable schema in PostgREST config:
-- Add "homeplanner" to db-schemas in your supabase config
-- =====================================================

-- Grant access to anon and authenticated roles
GRANT USAGE ON SCHEMA homeplanner TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA homeplanner TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA homeplanner TO anon, authenticated;
