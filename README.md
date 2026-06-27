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

**Tableau Public:** _Coming soon._

## Results

_Coming soon._

## Key Findings

_Coming soon._

## Roadmap

- [ ] 01 — Data acquisition & profiling
- [ ] 02 — Target engineering
- [ ] 03 — EDA: who defaults?
- [ ] 04 — EDA: payment behavior over time
- [ ] 05 — Cleaning & interpretable risk-factor model
- [ ] 06 — Insights summary & dashboard
- [ ] Tableau dashboard published

---

*Portfolio project. Each step is documented so the analysis and decisions can be
followed end to end. See [`docs/git-workflow.md`](docs/git-workflow.md) for the
commit conventions used in this repo.*
