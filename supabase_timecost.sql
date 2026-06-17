-- ── Time cost savings sub-table ──────────────────────────
-- Run this in Supabase SQL Editor
-- (Drop and recreate if you already ran the previous version)

DROP TABLE IF EXISTS time_cost_savings;

CREATE TABLE time_cost_savings (
  id                SERIAL PRIMARY KEY,
  operation_id      INTEGER NOT NULL REFERENCES phase1_operations(id),
  staff_hours       NUMERIC(6,1)  DEFAULT 0,
  staff_rate        NUMERIC(8,2)  DEFAULT 0,
  manager_hours     NUMERIC(6,1)  DEFAULT 0,
  manager_rate      NUMERIC(8,2)  DEFAULT 0,
  partner_hours     NUMERIC(6,1)  DEFAULT 0,
  partner_rate      NUMERIC(8,2)  DEFAULT 0,
  notes             TEXT,
  updated_at        TIMESTAMPTZ   DEFAULT NOW(),
  UNIQUE(operation_id)
);

-- Auto-update updated_at
CREATE TRIGGER set_tcs_updated_at
BEFORE UPDATE ON time_cost_savings
FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- RLS: allow anon read and write (internal team use)
ALTER TABLE time_cost_savings ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow anon all" ON time_cost_savings
  FOR ALL USING (true) WITH CHECK (true);

-- Add jobs_per_year column if not already present
ALTER TABLE time_cost_savings
  ADD COLUMN IF NOT EXISTS jobs_per_year INTEGER DEFAULT 0;
