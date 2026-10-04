# Findings and open evidence gaps

## Findings reproduced from the submitted analysis

- Summing the five site-level forecast rows in the submitted SQL/Excel output gives **£6,027,795 actual revenue** against **£5,895,524 forecast**, a net variance of **+£132,271 (+2.24%)**. The submitted query does not remove trading rows using duplicate flags.
- Four of five site totals were above forecast and one was below. Dinner had a combined positive forecast variance of **£131,463**; lunch was **£808** above forecast. Friday, Saturday and Sunday were positive in the weekday breakdown; Tuesday was below.
- Site gross-margin percentages ranged from **65.14% to 66.13%** under the submitted matched-population eligibility rules.
- Review SQL reported site rating averages from **3.58 to 3.72** and platform averages of Google **3.62** (648), TripAdvisor **3.70** (355) and Facebook **3.68** (152), after excluding later flagged duplicate reviews.
- The exploratory site/month revenue-rating correlation was **-0.079** across 121 site/months with ratings.

## Interpretation limits and open reconciliation

- Trading duplicate flags are QA fields; the submitted trading KPI SQL does not use them to exclude rows.
- Net forecast variance describes bias, not absolute forecast accuracy. WAPE was not calculated in the submitted analysis.
- Monthly actual-versus-forecast performance was not calculated. The submitted SQL analyses monthly revenue changes, which are a different measure.
- The wastage rate is not reconciled: SQL and Excel use different numerator populations. Reconcile the workbook before publishing one rate.
- Site gross margins are reported, but product mix and category-specific COGS were not tested as causes.
- Revenue basis (gross or net of VAT, promotions, discounts, service charge and tips) remains unconfirmed.
- Workforce questions are outside this release's two-dataset scope.

## Publication note

Raw data, guest text, named-site outputs and the Power BI files are not included in this public repo. Public findings use aggregate values without site mapping.
