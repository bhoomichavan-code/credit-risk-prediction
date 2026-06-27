# Credit Risk Analysis — One-Page Findings Summary

## The question
Using a credit-card application dataset, identify **which applicants are most
likely to default** (defined as ever reaching 60+ days past due) and **what drives
that risk** — the evidence a lender uses to shape approval and monitoring.

## What we did
- The dataset has **no default label**, so we engineered one from monthly
  repayment history (**bad = ever 60+ days past due**), validated against a
  24-month vintage window.
- Joined the label to applicant features, giving **36,457 analyzable clients** with
  an overall bad rate of **1.69%** (a heavily imbalanced problem).
- Analyzed risk by applicant segment, studied payment behavior over time, and fit
  an interpretable logistic model to isolate each factor's effect.

## Five headline findings
1. **Default is rare and imbalanced** — only **1.69%** of clients go bad, so
   the analysis uses bad-*rate* comparisons and rank/recall metrics, not accuracy.
2. **Risk varies most by life-stage and stability factors** — e.g. age band risk
   ranges from **1.42%** (35-44) up to **2.54%** (65+).
3. **Bad clients reveal themselves quickly** — the median time to first serious
   delinquency is **8 months**, and **92%** of eventual defaults occur
   within 24 months of account opening.
4. **Early lateness is a strong early-warning signal** — clients who slip (30+ DPD)
   in their first six months are about **11.7x** more likely to seriously
   default later than clients with a clean start.
5. **Applicant attributes carry limited predictive power** — the model beats its
   baseline but only modestly, because the strongest predictors (utilization,
   prior delinquency, debt-to-income) are not in the application data. The value
   is in *explaining* risk drivers, not in a high accuracy score.

## How to use this repo
Run notebooks `01`–`06` in order; the Tableau dashboard connects to the two CSVs
in `tableau/extracts/`. Full methodology is documented inside each notebook.

*Generated automatically from the analysis — figures match the latest run.*
