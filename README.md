# Credit Risk Analysis — Who Defaults, and Why?

## Overview

This is a data-analysis portfolio project that examines a real credit-card
application dataset to understand **which applicants are most likely to default**
and what drives that risk. It pairs applicant information (demographics,
financials, assets) with each client's monthly repayment history to engineer a
"good vs. bad" credit label, then explores the drivers of default through
exploratory analysis, a payment-behavior study over time, an interpretable
risk-factor model, and an interactive dashboard. The emphasis is on **insight
and clear communication** — turning raw lending data into findings a business
stakeholder can act on.

## Business Problem

Credit-card lending is a risk-management business: approve too many risky
applicants and default losses pile up; approve too few and the lender forgoes
profitable customers. This project answers a practical analytical question:
**given the information available at application time, which applicant segments
carry the most credit risk, and which factors move the needle?** The output is
the kind of evidence a risk or analytics team uses to shape approval and pricing
decisions.

A realistic wrinkle: the dataset has **no ready-made default label**. It must be
*engineered* from the monthly repayment history — a documented analytical step in
its own right.

## Dataset

Two tables sharing a client `ID`:

- **`application_record.csv`** — one row per applicant (~438K): gender, age,
  income, employment length, education, family status, housing, assets.
- **`credit_record.csv`** — monthly repayment history (~1M client-months). The
  `STATUS` column records how overdue each account was each month and is the
  basis for the engineered target.

Full data dictionary:
[`data/raw/application_record and credit_record.txt`](data/raw/application%20record%20and%20credit_record.txt).

**Engineered target:** a client is **bad (1)** if their history ever reaches
**60+ days past due** (`STATUS` ∈ {2,3,4,5}), else **good (0)**. The resulting
classes are heavily imbalanced (~1.5–2% bad), which is expected for credit data
and is addressed in the analysis.

## Project Structure

```
credit-risk-prediction/
├── README.md
├── requirements.txt
├── .gitignore
├── data/
│   ├── raw/               <- Original, immutable data + data dictionary
│   └── processed/         <- Cleaned, analysis-ready data (generated)
├── notebooks/
│   ├── 01_data_acquisition.ipynb
│   ├── 02_target_engineering.ipynb
│   ├── 03_eda_who_defaults.ipynb
│   ├── 04_eda_payment_behavior.ipynb
│   ├── 05_cleaning_and_model.ipynb
│   └── 06_insights_summary.ipynb
├── tableau/
│   ├── extracts/          <- Flat CSVs exported for Tableau (generated)
│   └── workbooks/         <- Tableau workbooks (.twbx)
├── src/                   <- Reusable Python helpers
├── visualizations/        <- Exported charts/figures
├── models/                <- Saved model artifacts
└── docs/                  <- Additional documentation (incl. git workflow)
```

## How to Run

1. **Clone and enter the repo**

   ```bash
   git clone <your-repo-url>
   cd credit-risk-prediction
   ```

2. **Set up a virtual environment and install dependencies**

   ```bash
   python -m venv .venv
   source .venv/bin/activate          # Windows: .venv\Scripts\activate
   pip install -r requirements.txt
   ```

3. **Add the raw data** — place `application_record.csv` and
   `credit_record.csv` in `data/raw/` (large CSVs are git-ignored).

4. **Run the notebooks in order** (`jupyter notebook`), starting with
   `01_data_acquisition.ipynb`.

5. **Explore the dashboards** — open the Tableau workbook in `tableau/workbooks/`
   (or the public link below) and the exported charts in `visualizations/`.

## Deliverables

- Six documented Jupyter notebooks (acquisition → target → EDA → behavior →
  model → insights)
- An **interactive Tableau dashboard** (link below)
- A one-page findings summary
- Exported visualizations and a cleaned analysis dataset

## Dashboard

**Tableau Public:** (https://public.tableau.com/app/profile/bhoomi.chavan3703/viz/CreditRiskAnalysisDashboard_17826183313690/Dashboard1)

## Results

Across **36,457 analyzable clients**, the overall "bad" rate (ever 60+ days past
due) is **1.69%** — a heavily imbalanced problem (~58:1). The work produced:

- An **engineered, documented target** (bad = ever 60+ DPD), validated against a
  24-month vintage window that agrees with the simple label on 99.9% of clients.
- **Segment and behavioral insight** into who defaults and when (notebooks 03–04).
- An **interpretable logistic model** (notebook 05) reporting honest metrics —
  **ROC-AUC 0.564**, **PR-AUC 0.062 (3.7× the prevalence baseline)** — and a
  ranked, signed list of adjusted risk drivers.
- Two **dashboard-ready extracts** and a one-page
  [findings summary](docs/findings_summary.md).

A deliberate, stated limitation: applicant attributes carry only modest predictive
power, because the strongest real-world predictors (credit utilization, prior
delinquency, debt-to-income) are not in the application data. The project's value
is in rigorous methodology and *explaining* risk, not in a headline accuracy score.

## Key Findings

1. **Default is rare and imbalanced** (~1.69%), so the analysis relies on bad-rate
   comparisons and rank/recall metrics rather than accuracy.
2. **Risk varies most by life-stage and stability factors** — e.g. age-band bad
   rate ranges from **1.42%** (35–44) to **2.54%** (65+), with employment length
   and housing also separating risk.
3. **Bad clients reveal themselves quickly** — median time to first serious
   delinquency is **8 months**, and **~92%** of eventual defaults occur within 24
   months of account opening (validating the performance window).
4. **Early lateness is a strong early-warning signal** — clients who slip (30+ DPD)
   in their first six months are about **11.7× more likely** to seriously default
   later than clients with a clean start.
5. **Applicant attributes have limited predictive power** — the model beats its
   baseline only modestly; the behavioral signals above are far more informative
   than static demographics.

See [`docs/findings_summary.md`](docs/findings_summary.md) for the one-page
write-up.

## Roadmap

- [x] 01 — Data acquisition & profiling
- [x] 02 — Target engineering
- [x] 03 — EDA: who defaults?
- [x] 04 — EDA: payment behavior over time
- [x] 05 — Cleaning & interpretable risk-factor model
- [x] 06 — Insights summary & Tableau extracts
- [x] Tableau dashboard published

---

*Portfolio project. Each step is documented so the analysis and decisions can be
followed end to end. See [`docs/git-workflow.md`](docs/git-workflow.md) for the
commit conventions used in this repo.*
