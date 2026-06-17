-- ── phase_tasks table ──────────────────────────────────────
-- Run in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS phase_tasks (
  id         SERIAL PRIMARY KEY,
  phase_id   INTEGER NOT NULL,
  date       TEXT NOT NULL,
  task       TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS
ALTER TABLE phase_tasks ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow anon all" ON phase_tasks
  FOR ALL USING (true) WITH CHECK (true);

-- Pre-populate Phase 1 tasks
INSERT INTO phase_tasks (phase_id, date, task) VALUES
  (1, '11 Jun 2026 (Thu)', 'Team meeting'),
  (1, '12 Jun 2026 (Fri)', 'VPN and Claude (team plan) subscribed');

-- Add added_by column if not present
ALTER TABLE phase_tasks ADD COLUMN IF NOT EXISTS added_by TEXT DEFAULT '';
