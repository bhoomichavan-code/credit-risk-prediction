# Tableau Dashboard

This folder holds everything for the Tableau side of the project.

## Folders

- **`extracts/`** — flat CSV files exported from the Python pipeline for Tableau
  to connect to. These are *generated* (and git-ignored), not hand-made.
- **`workbooks/`** — the Tableau workbook(s) (`.twbx`), which are tracked in git.

## Data Tableau will connect to

Tableau visualizes flat tables, not Python. The pipeline exports two extracts:

1. **`client_level.csv`** — one row per client: demographic & financial features
   plus the engineered `target` (good/bad). Drives the segment / risk-driver
   charts (default rate by income band, age, education, housing, etc.).
2. **`payment_behavior.csv`** — tidy, one row per client-month
   (`ID`, `MONTHS_BALANCE`, `STATUS`, derived flags). Drives the
   payment-behavior-over-time / vintage charts.

These are written to `extracts/` by notebook `06_insights_summary.ipynb`.

## How to build the dashboard

1. Install **Tableau Public Desktop** (free): https://public.tableau.com/
2. Open Tableau → **Connect → Text file** → select a CSV from `extracts/`.
   (Add the second file and relate them on `ID` if you want both in one
   workbook.)
3. Build worksheets — e.g. default rate by segment, KPI cards, a time trend.
4. Assemble the worksheets into a **Dashboard**.
5. Save the packaged workbook (`.twbx`) into `workbooks/`.
6. **Publish to Tableau Public** (File → Save to Tableau Public). Note: Tableau
   Public makes the workbook publicly visible on the web — fine for this public
   dataset.
7. Paste the public link into the root `README.md` under **Dashboard**.

## Public link

_Coming soon — paste the Tableau Public URL here once published._
