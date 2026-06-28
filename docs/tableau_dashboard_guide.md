# Tableau Dashboard — Step-by-Step Build Guide

A click-by-click guide to building a 6-report credit-risk dashboard in **Tableau
Public Desktop** (free). No prior Tableau experience assumed.

The dashboard tells one story in three acts:

1. **How big is the problem?** → KPI tiles
2. **Who defaults?** → bad rate by age, income, employment
3. **When and how does it happen?** → vintage curve + status-over-time

---

## 0. Before you start

**Install:** Tableau Public Desktop — https://public.tableau.com/ (free; you'll
create a free Tableau Public account to publish at the end).

**Your data:** two files in `tableau/extracts/`:

- `client_level.csv` — one row per client (drives reports 1–4).
- `payment_behavior.csv` — one row per client-month (drives reports 5–6).

> If `tableau/extracts/` is empty, run notebook `06_insights_summary.ipynb` first
> to generate the CSVs.

**The one trick you'll reuse everywhere:** the column `target` is `1` for a bad
client and `0` for good. So the **bad rate = the *average* of `target`**. Every
"bad rate" chart is just `AVG(target)` formatted as a percentage. Remember this
and the whole dashboard is easy.

---

## 1. Connect the data

1. Open Tableau Public Desktop.
2. Left panel **Connect → To a File → Text file** → choose `client_level.csv`.
   Tableau shows a data-preview screen; you can leave everything as-is.
3. Add the second file: top-left **Data → New Data Source → Text file** →
   choose `payment_behavior.csv`.
4. You now have two data sources. We use them separately — **no join needed.**
   Switch between them using the data-source pills on the left of any worksheet.
5. Click the **Sheet 1** tab at the bottom to start building.

---

## 2. Report 1 — KPI summary tiles

Three big-number tiles. Build each as its own small worksheet.

**Tile A — Total clients**
1. New worksheet (bottom tab ➕). Rename it `KPI Clients` (double-click the tab).
2. Use the **client_level** data source.
3. Drag `ID` to the **Text** box on the Marks card.
4. Click the `ID` pill → **Measure → Count (Distinct)**. It shows ~36,457.
5. On the Marks card click **Text** → increase font to ~28pt, bold. Add a label
   line "Clients analyzed" if you like.

**Tile B — Overall bad rate**
1. New worksheet `KPI Bad Rate`.
2. Drag `target` to **Text**.
3. Click the pill → **Measure → Average**.
4. Right-click the pill → **Format → Numbers → Percentage → 2 decimals**. Shows
   ~1.69%.
5. Enlarge the font; label it "Overall bad rate."

**Tile C — Bad clients**
1. New worksheet `KPI Bad Clients`.
2. Drag `target` to **Text** → keep it as **Sum** (sum of 1s = count of bad
   clients). Shows the number of bad clients.
3. Label it "Bad clients (ever 60+ DPD)."

*(These three small sheets get placed side by side on the dashboard later.)*

---

## 3. Report 2 — Bad rate by age band

1. New worksheet `Bad Rate by Age`. Data source: **client_level**.
2. Drag `age_band` to **Columns**.
3. Drag `target` to **Rows** → click the pill → **Measure → Average**.
4. Format the axis as %: right-click the `AVG(target)` pill → **Format →
   Numbers → Percentage**.
5. The age bands should read `<25, 25-34, … 65+`. If they're out of order,
   right-click the `age_band` header → **Sort → Manual** and order them.
6. **Add the baseline:** right-click the bad-rate axis → **Add Reference Line →
   Line → Value = Average → Label = Value**. This draws the overall ~1.69% line
   so viewers see which bars are above/below average.
7. Optional: drag `target` (Average) onto **Label** to print the % on each bar,
   and onto **Color** for a subtle gradient.
8. Give it a clear title: "Bad rate by age band."

---

## 4. Report 3 — Bad rate by income quintile

Same recipe as Report 2:

1. New worksheet `Bad Rate by Income`.
2. `income_band` → **Columns**; `target` (→ **Average**, formatted %) → **Rows**.
3. The quintiles read `Q1 (lowest) … Q5 (highest)` — keep that order.
4. Add the **Average reference line** as before.
5. Title: "Bad rate by income quintile." The story: risk generally falls as
   income rises.

> Prefer concrete categories? Swap `income_band` for `NAME_INCOME_TYPE`
> (Working, Pensioner, Student, …) — same steps.

---

## 5. Report 4 — Bad rate by employment length

1. New worksheet `Bad Rate by Employment`.
2. `employ_band` → **Columns**; `target` (→ **Average**, %) → **Rows**.
3. Order the bands manually: `Not employed, <1 yr, 1-3 yr, 3-5 yr, 5-10 yr,
   10+ yr`.
4. Add the **Average reference line**.
5. Title: "Bad rate by employment length." Story: shorter tenure / not employed
   = higher risk.

---

## 6. Report 5 — Vintage curve (delinquency by account age)

This one uses the **payment_behavior** data source. The column `is_60plus` is `1`
when an account was 60+ days past due that month, so its **average = the
delinquency rate**.

1. New worksheet `Vintage Curve`. Switch to the **payment_behavior** source.
2. Drag `months_on_book` to **Columns**. Click its pill and make sure it's
   **Continuous** (green pill, "Dimension → Continuous" if needed).
3. Drag `is_60plus` to **Rows** → **Measure → Average** → format as **%**.
4. On the Marks card, change the mark type dropdown from Automatic to **Line**.
5. **Trim the noisy tail:** drag `months_on_book` to **Filters** → set range to
   `0` to about `40` (older account-ages have very few records). Keeps the line
   trustworthy.
6. Title: "Delinquency rate as accounts age (vintage curve)." Story: risk is low
   at opening and climbs as accounts season.

---

## 7. Report 6 — Status composition over account age

A 100%-stacked area showing how the mix of repayment statuses changes with
account age. Also from **payment_behavior**.

1. New worksheet `Status Over Time`. Data source: **payment_behavior**.
2. Drag `months_on_book` to **Columns** (Continuous), and filter to `0–40` as in
   Report 5.
3. Drag `ID` to **Rows** → change to **Count** (this just gives a record count to
   stack).
4. Drag `status_group` to **Color** on the Marks card.
5. Change the mark type to **Area**.
6. Make it 100%-stacked: right-click the `CNT(ID)` pill on Rows → **Quick Table
   Calculation → Percent of Total**; then right-click again → **Compute Using →
   status_group**. Each column now sums to 100%.
7. Reorder/recolor the legend so it reads worst-to-best or best-to-worst, e.g.
   green `Paid / no loan`, yellow `1-29 DPD`, orange `30-59 DPD`, red `60+ DPD`
   (click the color legend → Edit Colors).
8. Title: "How repayment behavior drifts as accounts age." Story: the healthy
   green band slowly gives way to late/delinquent bands.

---

## 8. Assemble the dashboard

1. Bottom toolbar → **New Dashboard** (the grid icon).
2. Set a size: **Size → Automatic** (or Fixed 1200×900) in the left panel.
3. Drag worksheets from the left list onto the canvas. A good layout:

   ```
   ┌───────────── Title: "Credit Risk Dashboard" ─────────────┐
   │  [KPI Clients] [KPI Bad Rate] [KPI Bad Clients]          │  <- 3 tiles in a row
   ├──────────────────────────┬──────────────────────────────┤
   │  Bad Rate by Age         │  Bad Rate by Income          │
   ├──────────────────────────┼──────────────────────────────┤
   │  Bad Rate by Employment  │  Vintage Curve               │
   ├──────────────────────────┴──────────────────────────────┤
   │  Status Composition Over Account Age (full width)        │
   └──────────────────────────────────────────────────────────┘
   ```

4. Add a dashboard **Title**: drag a **Text** object to the top, or turn on
   **Dashboard → Show Title**.
5. Tidy up: hide redundant axis titles, shrink the KPI tiles, align with the grey
   snap-guides.
6. **Optional interactivity:** drag a **Filter** — e.g. right-click the age sheet
   → **Filters → Education or Gender → Apply to Worksheets → All Using This Data
   Source** — so viewers can slice the whole dashboard.

---

## 9. Publish to Tableau Public

1. **File → Save to Tableau Public As…**
2. Sign in (or create a free Tableau Public account).
3. Give it a name like "Credit Risk Dashboard" and save. It uploads and opens in
   your browser.
4. Copy the public URL.
5. Paste it into the project `README.md` (under **Dashboard**) and into
   `tableau/README.md` (under **Public link**).
6. Save a local copy too: **File → Save As → .twbx** into `tableau/workbooks/`.

> Note: Tableau Public makes the workbook publicly visible — fine for this public
> dataset and ideal for a portfolio link.

---

## Optional advanced report — early-warning signal (the killer insight)

The strongest finding (early-slippers default ~11.7× more later) needs two
client-level calculated fields, so it's a stretch goal once you're comfortable:

1. In **payment_behavior**, create calc field **Early Slip** (per client, was 30+
   DPD in first 6 months):
   `{ FIXED [ID] : MAX(IF [months_on_book] < 6 AND [dpd] >= 30 THEN 1 ELSE 0 END) }`
2. Create **Later Default** (per client, 60+ DPD from month 6 on):
   `{ FIXED [ID] : MAX(IF [months_on_book] >= 6 AND [dpd] >= 60 THEN 1 ELSE 0 END) }`
3. New worksheet: `Early Slip` → **Columns**; `Later Default` → **Rows** →
   **Average**, formatted %. Two bars: clean-start vs early-slip. The gap is the
   story.

---

*Build the six core reports first — that's a complete, compelling dashboard. The
advanced report is a bonus if you want to show off the early-warning insight.*
