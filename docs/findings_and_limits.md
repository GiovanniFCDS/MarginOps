# Findings and open evidence gaps

## Supported findings

- On **7,136** de-duplicated open shifts with complete revenue and a forecast, actual revenue was **£6.004m** against **£5.872m** forecast. Net variance was **+2.24%** and WAPE **8.06%**.
- All 24 complete estate-level calendar months were above forecast. At observed site/month grain, **49 of 123** combinations were below forecast.
- Gross margin was **65.32%** across **6,998** de-duplicated open shifts with complete revenue and COGS. Site results ranged from **65.15% to 66.13%**.
- Recorded wastage was **£45,692** across **7,234** de-duplicated open shifts with wastage present. On the matched complete-revenue population it was **5.72% of food revenue**.
- After review duplicate handling, **1,155** valid ratings averaged **3.65/5**. The exploratory site/month revenue-rating correlation was **-0.079**.

## Data checks resolved

- The 60 rows flagged as repeated trading keys are 30 two-row groups. Each group contains one unique original value set, confirming 30 additional exact copies and no value-conflicting key groups.
- Excluding those copies changes aggregate forecast bias and WAPE by less than 0.01 percentage points. The main direction of the findings is robust to that sensitivity check.

## Questions outside scope

The completed two-dataset release does not contain workforce hours or labour budgets. It cannot establish which sites exceed a labour budget or calculate sales per labour hour. Those questions require a separate, approved workforce dataset and budget baseline.

## Open business definitions

1. Confirm whether revenue is gross or net of VAT, promotions, discounts, service charge and tips.
2. Use trading-day-normalised measures for like-for-like monthly comparisons.
3. Support operational explanations (such as refurbishments) with site notes or another source, not revenue trends alone.
4. Continue to report review counts with averages, particularly for sparse site/platform/month groups.

## Publication note

Raw data, guest text, named-site outputs and the Power BI files are not included in this public repo. Public findings use aggregate values without site mapping.
