# Business questions and answers

This page follows the submitted final SQL and Excel reconciliation. Trading KPI calculations retain rows according to the eligibility conditions in that SQL; duplicate flags are not applied as a global exclusion. A separate duplicate audit or WAPE calculation was not part of the submitted business analysis.

## Questions supported by the submitted analysis

| Business question | Answer and evidence |
|---|---|
| Which periods outperform or underperform sales forecasts? | The submitted forecast comparison is grouped by site, shift and weekday. Four of five site totals were above forecast and one was slightly below. At shift level, dinner variance summed to **+£131,463** and lunch to **+£808**. Saturdays, Sundays and Fridays had the largest positive weekday variances; Tuesday was negative. The analysis did not calculate monthly actual-versus-forecast performance, so it cannot support a claim that every complete month beat forecast. |
| What was the overall sales-versus-forecast result? | Summing the five site rows in the submitted SQL/Excel output gives **£6,027,795 actual revenue** against **£5,895,524 forecast**, a net variance of **+£132,271 (+2.24%)**. This is net variance/bias. The submitted analysis did not calculate WAPE or another absolute forecast-error measure, so it does not establish forecast accuracy by itself. |
| How did gross margin vary by site? | The submitted site-level results ranged from **65.14% to 66.13%**, using open shifts with complete revenue and complete food and wet COGS. The analysis reports the margin outcomes but does not decompose site differences into product-mix or category-level COGS effects; those factors remain untested. |
| What did the wastage analysis show? | The SQL output reports site-level recorded wastage totals from **£3,557 to £15,875**. The wastage-rate result is not reconciled: the SQL rate numerator uses wastage on the matched complete-revenue population, while the Excel sheet appears to divide the all-recorded wastage total by a complete-revenue denominator. Until that numerator mismatch is corrected in the workbook, no single wastage rate should be presented as the reconciled answer. |
| How did guest ratings vary? | The submitted review SQL excludes rows flagged duplicate_after_first for rating averages. Site averages ranged from **3.58 to 3.72**. Platform results were Google **3.62** (648 ratings), TripAdvisor **3.70** (355), and Facebook **3.68** (152). These are ratings from self-selected reviewers rather than a measure of every guest's experience. |
| Was monthly revenue related to average guest rating? | The submitted site/month comparison found a Pearson correlation of **-0.079** across **121 site/months with reviews**. This indicates little linear association in this sample; review dates are not confirmed visit dates, and correlation does not establish causation. |

## Questions that remain open

| Proposed question | Status | What is needed |
|---|---|---|
| Which complete months beat or missed forecast? | Not answered in the submitted analysis. | Add a month-level actual-versus-forecast query with the same eligibility rules. |
| How accurate were forecasts at shift level? | Not answered by net variance alone. No WAPE/MAE or equivalent absolute-error measure was included. | Calculate and explain an absolute error metric if forecast accuracy is a required question. |
| What caused gross-margin differences? | Site margins are reported; drivers were not decomposed. | Reconcile food/wet revenue mix and category COGS on the same eligible population before making a driver claim. |
| What is the reconciled wastage rate? | SQL and Excel numerator populations do not currently match. | Recalculate both numerator and denominator on open shifts with recorded wastage and complete revenue. |
| What was labour cost versus budget or revenue per labour hour? | Out of scope for the final two-dataset analysis. No staff-timesheet or labour-budget dataset was used. | A suitable, authorized labour dataset and budget definitions would be required. |

## Definitions and caveats

- Forecast variance uses open shifts with complete recorded food and wet revenue and a non-null forecast, exactly as in the submitted trading SQL. Trading duplicate flags are not a filter in that query.
- The estate forecast totals above are a sum of the five site rows in the submitted SQL/Excel reconciliation; no rows were removed for duplicate flags.
- Gross margin uses open shifts with complete revenue and complete food and wet COGS, following the submitted SQL.
- Rating averages exclude invalid ratings and later flagged duplicate reviews, following the submitted review SQL.
- Revenue basis (gross or net of VAT, promotions, discounts, service charge or tips) remains unconfirmed.
