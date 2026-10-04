# Business questions and answers

This note answers the questions in the original project brief using the completed trading and guest-review analyses. It keeps the original scope clear: workforce budget and labour-hour questions were proposed in an early draft, but staff timesheets and a labour budget are not part of the final two-dataset analysis.

All trading answer figures below exclude the 30 later exact-copy rows. The source table is preserved unchanged. A value-level check confirmed that the 30 repeated site/date/shift groups each contain two copies of one value set, with no conflicting versions.

## Commercial questions

| Business question | Answer from the analysis |
|---|---|
| Which periods outperform or underperform sales forecasts? | Across the estate, actual revenue beat forecast in all 24 complete months from Aug 2024 to Jul 2026. The partial Aug 2026 period was also above forecast but is not comparable to a full month. Dinner outperformed by 3.46%; lunch was almost exactly on plan (+0.04%). Saturday (+4.74%), Sunday (+4.29%) and Friday (+3.94%) were the strongest weekday totals. Tuesday was 0.87% below forecast and Wednesday was nearly on plan (-0.06%). At site/month grain, 49 of 123 observed combinations were below plan, so the estate-wide result does not mean every site or month beat forecast. |
| How accurate were the sales forecasts? | On 7,136 eligible, de-duplicated shifts, actual revenue was £6.004m against £5.872m forecast, a net overperformance of £131.6k (+2.24%). Weighted absolute percentage error (WAPE) was 8.06%. This says the forecasts slightly undercalled revenue overall, while individual shifts still had meaningful errors. The estimate changes very little when duplicate copies are excluded. |
| What factors are associated with gross-margin differences? | Gross margin was 65.32% across 6,998 open, complete-revenue and complete-COGS shifts. Site results ranged from 65.15% to 66.13%. Food COGS were about 31.8%–32.4% of food revenue, while wet COGS were about 35.0%–35.1% of wet revenue. Food's share of sales varied more widely, from 9.5% to 35.0%, so product mix is a plausible contributor to the small site differences. The data does not support a causal claim or an item-level pricing explanation. |
| Where did wastage have the greatest impact? | Across 7,234 open shifts with recorded wastage, total wastage was £45,692. The site with the largest absolute amount recorded £15,832. On the 7,073 shifts with complete revenue and recorded wastage, wastage equalled 5.72% of food revenue (0.76% of combined food and wet revenue). The highest site rate was 7.22% of food revenue; the lowest was 3.02%. Absolute cost and rate give different rankings, so both should be shown. |
| How did guest reviews vary? | After excluding later flagged duplicate copies, 1,155 valid ratings averaged 3.65/5. Site averages ranged from 3.58 to 3.72. By platform, Google averaged 3.62 (648 ratings), TripAdvisor 3.70 (355), and Facebook 3.68 (152). These are ratings from self-selected reviewers, not a direct measure of all guests' experience. |
| Was there a relationship between monthly revenue and average rating? | The exploratory site/month correlation was -0.079, indicating little linear association in this dataset. Review dates are not confirmed visit dates, and correlation cannot establish causation. |

## Questions outside this release's scope

| Proposed question | Why it is not answered here | Evidence needed |
|---|---|---|
| Where are labour costs exceeding budget? | The final project package has no labour budget or labour-budget targets. | Approved labour budgets at a matching site/date/shift or site/month grain, plus an agreed definition of labour cost. |
| How efficiently are labour hours converted into revenue? | The final analysis deliberately covers trading and guest reviews only; it does not include a workforce-hours table. | Validated clocked/scheduled hours joined to trading shifts, with missing-punch and duplicate rules. |

These remain explicit out-of-scope items. No labour performance claim should be inferred from the current project.

## Definitions and caveats

- Forecast variance is `(actual food + wet revenue - forecast revenue) / forecast revenue` on open shifts with complete recorded revenue and a forecast.
- WAPE is the sum of absolute shift-level forecast errors divided by total forecast revenue.
- Gross margin is calculated on the matched population with complete revenue and both COGS fields.
- Wastage rate uses open shifts with recorded wastage and complete revenue; the denominator is identified beside each rate.
- The source revenue basis is not confirmed as gross or net of VAT, promotions, discounts, service charge or tips. Treat revenue-linked values as provisional.
- Site names are omitted from this public findings note. The SQL scripts retain the grouping logic but do not include saved query outputs or row-level records.
