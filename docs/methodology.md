# Methodology

## Data grain

- **Trading:** one intended record per site, business date and shift; 7,500 source rows across five sites and two shifts.
- **Reviews:** one record per submitted review; 1,171 source rows across five sites and three platforms. A site/date pair is not a unique review key.

## Cleaning and duplicate checks

The source tables were preserved. Cleaning added parsed dates and explicit QA flags for missing or invalid values, site labels, day/date mismatches and possible duplicates. Ambiguous values were retained rather than silently rewritten.

A value-level audit found 30 repeated trading keys, each occurring twice. Every repeated group had one distinct set of trading values: these were exact-copy pairs, not conflicting records. The 30 later copies remain in the source table but are excluded from the primary trading answers. The answer SQL includes the duplicate check and de-duplicated populations.

## KPI eligibility

Trading revenue measures use open shifts with complete food and wet revenue. Forecast comparison also requires a recorded forecast. Gross margin uses the same revenue population plus complete food and wet COGS. Wastage value requires an open shift and recorded wastage; wastage percentages additionally require complete revenue, with food revenue or combined revenue named as the denominator.

Review averages use valid numeric ratings, and later flagged duplicate copies are excluded. Review counts are paired with average ratings.

## Cross-table comparison

Trading is at site/date/shift grain and reviews are individual review records. Each table is independently aggregated to site/month before a left join, with trading as the base. This avoids multiplying trading rows when several reviews occur in a month. Months without matching reviews remain visible.

## Interpretation limits

- Revenue basis is not confirmed as gross or net of VAT, discounts, promotions, service charge and tips.
- Monthly totals vary with trading-day counts and are not automatically like-for-like.
- Recorded review dates are not confirmed visit dates. Review-month sentiment may refer to an earlier visit.
- Reviews are self-selected and do not represent every guest.
- Correlation describes co-movement in this dataset; it cannot establish causality.
- Workforce analysis is outside the final project's two-dataset scope.
