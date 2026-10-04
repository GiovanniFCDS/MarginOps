# Findings and open evidence gaps

## Findings reproduced from the submitted analysis

- Summing the five site-level forecast rows in the submitted SQL/Excel output gives **£6,027,795 actual revenue** against **£5,895,524 forecast**, a net variance of **+£132,271 (+2.24%)**. The submitted query does not remove trading rows using duplicate flags.
- Four of five site totals were above forecast and one was below. Dinner had a combined positive forecast variance of **£131,463**; lunch was **£808** above forecast. Friday, Saturday and Sunday were positive in the weekday breakdown; Tuesday was below.
- Site gross-margin percentages ranged from **65.14% to 66.13%** under the submitted matched-population eligibility rules.
- Review SQL reported site rating averages from **3.58 to 3.72** and platform averages of Google **3.62** (648), TripAdvisor **3.70** (355) and Facebook **3.68** (152), after excluding later flagged duplicate reviews.
- The exploratory site/month revenue-rating correlation was **-0.079** across 121 site/months with ratings.

## Corrections to the prior public summary

The previous summary incorrectly excluded 30 trading rows flagged as exact copies, although the submitted KPI SQL did not exclude duplicate flags. Its 7,136-shift / £6.004m / £5.872m forecast totals therefore described a different population from the user's analysis. It also added WAPE and monthly forecast claims that were not in the submitted analysis. Those claims have been removed. The corrected forecast totals above sum the five site rows in the submitted SQL/Excel output using the original eligibility rules.

## Open reconciliation and business questions

1. **Wastage rate:** SQL and Excel do not use the same numerator population. Reconcile the workbook before publishing a single wastage rate.
2. **Monthly forecast comparison:** the submitted SQL analyses monthly revenue changes but does not calculate monthly actual-versus-forecast performance.
3. **Forecast accuracy:** the submitted analysis gives net variance only; it does not measure absolute forecast error.
4. **Margin drivers:** site margin is shown, but the analysis does not test whether product mix or category-specific COGS explains differences.
5. **Revenue definition:** confirm whether revenue is gross or net of VAT, promotions, discounts, service charge and tips.

## Publication note

Raw data, guest text, named-site outputs and the Power BI files are not included in this public repo. Public findings use aggregate values without site mapping.
