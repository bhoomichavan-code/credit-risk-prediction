# Interview Prep — Credit Risk Analysis

A study aid for explaining this project to an interviewer. Covers the process
framework, the data-mining concepts used (and not used), and ready-to-say answers
to likely questions.

---

## The project in one breath

> "I built a credit-risk analysis on a credit-card application dataset. The data
> had no default label, so I engineered one from monthly repayment history (bad =
> ever 60+ days past due), analyzed who defaults and when, and fit an
> interpretable logistic model to quantify the risk drivers. Default is rare
> (~1.7%), so I focused on bad-rate comparisons and rank/recall metrics rather
> than accuracy, and I'm explicit that demographic features carry only modest
> predictive power — the value is rigorous methodology and explanation."

---

## CRISP-DM framing (use this to structure any walkthrough)

The project follows the standard data-mining process, **CRISP-DM**:

1. **Business understanding** — why predicting default matters (loss vs. lost
   customer trade-off). *(README, nb01)*
2. **Data understanding** — profiling, missingness, distributions, the two-table
   structure. *(nb01)*
3. **Data preparation** — cleaning, feature engineering, label construction.
   *(nb02, nb05)*
4. **Modeling** — interpretable logistic regression with imbalance handling.
   *(nb05)*
5. **Evaluation** — imbalanced-aware metrics, honest limitations. *(nb05)*
6. *(Deployment)* — surfaced as a dashboard + findings summary rather than a live
   system. *(nb06, Tableau)*

You can literally point to the notebooks as these phases.

---

## Data-mining concepts USED

- **Data integration** — joining the application and credit tables on `ID`;
  reasoning about grain (per-applicant vs. per-client-month).
- **Data cleaning** — sentinel handling (`DAYS_EMPLOYED` positive = not employed),
  decoding negative day-counts into age/tenure.
- **Missing-value handling** — `OCCUPATION_TYPE` (~30% null) treated as its own
  "Unknown" category (see the imputation note below).
- **Data reduction / feature selection** — dropping the zero-variance
  `FLAG_MOBIL` column.
- **Data transformation** — log transform of income; standardization/scaling.
- **Discretization (binning)** — age bands, income quintiles, employment-length
  bands.
- **Attribute construction (feature engineering)** — income-per-member, age,
  employment years.
- **Encoding** — one-hot encoding of categorical variables.
- **Target/label construction** — deriving the binary "bad" label, with
  **threshold sensitivity analysis** (30+ vs 60+ vs 90+ DPD).
- **Classification** — supervised learning (logistic regression).
- **Imbalanced-class handling** — class weighting (`class_weight="balanced"`).
- **Pattern exploration** — EDA segment/lift analysis and temporal
  **cohort / vintage analysis** (delinquency by months on book).

---

## The imputation question (know this nuance cold)

**Q: "Did you use data imputation?"**

> "I handled missing data deliberately, but I didn't need classic statistical
> imputation. The only meaningfully missing field was `OCCUPATION_TYPE` at about
> 30%, and I treated *missing as its own category* ('Unknown') rather than
> guessing the value — for occupation, missingness may itself be informative.
> `DAYS_EMPLOYED` had a sentinel for unemployed applicants, which I handled
> explicitly with an `is_employed` flag. The numeric features — income, age,
> family size — had no missing values, so there was nothing to impute. If a
> future dataset had missing numerics, I'd use median imputation as a baseline, or
> a model-based method like KNN or MICE if the missingness pattern warranted it."

**Why this is a strong answer:** it shows you know the difference between
*missing-value handling* (category/sentinel treatment) and *imputation*
(estimating values), and that you choose the method based on the data rather than
applying a reflex.

---

## Data-mining concepts NOT used (good "what would you do next" answers)

- **Formal imputation** (KNN / MICE) — not needed; no missing numerics.
- **Outlier detection & treatment** — noted income outliers but didn't formally
  treat them.
- **k-fold cross-validation** — used a single stratified train/test split; k-fold
  would give a more robust performance estimate.
- **Resampling (SMOTE / undersampling)** — chose class weights instead; SMOTE is
  an alternative worth comparing.
- **Clustering / unsupervised segmentation** — could segment customers without
  the label.
- **Dimensionality reduction (PCA)** — not needed at this feature count.
- **Association-rule mining** — not applicable to this data.

---

## Other likely questions (quick answers)

**Q: Why logistic regression and not linear regression?**
The outcome is binary (good/bad). Linear regression predicts unbounded continuous
values and would give nonsensical "probabilities" outside 0–1. Logistic regression
passes a linear combination through the sigmoid to produce a valid probability,
and its coefficients convert to **odds ratios** — the interpretability credit
scoring needs. (It's a *classification* model despite the name.)

**Q: Why not report accuracy?**
With a ~1.7% bad rate, predicting "everyone is good" scores ~98% accuracy while
catching zero defaults. I used **ROC-AUC**, **PR-AUC vs. the prevalence baseline**,
and precision/recall, and treated the decision threshold as a business choice.

**Q: How did you define "bad," and why that line?**
Bad = ever 60+ days past due (`STATUS` 2–5). 60+ DPD is an industry-standard
serious-delinquency marker — severe enough to signal real risk, common enough to
analyze. I showed sensitivity to 30+/90+ and validated against a 24-month vintage
window (99.9% agreement).

**Q: The model's AUC is modest — isn't that a weak project?**
That's expected and I state it openly: the strongest predictors (credit
utilization, prior delinquency, debt-to-income) aren't in the application data —
they live in the repayment history I spent on the label. The project's strength is
methodology, honest evaluation, and explanation, not a vanity accuracy number.

**Q: Biggest risk-driver findings?**
Risk concentrates by life-stage and stability (age, employment length, housing);
bad clients reveal themselves fast (median 8 months to first default, ~92% within
24 months); and **early lateness is an ~11.7× early-warning signal** for later
serious default.

---

*Pair this with `findings_summary.md` (the numbers) and the notebooks (the
methodology) when preparing.*
