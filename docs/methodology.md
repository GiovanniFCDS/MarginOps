# Methodology

## Data grain

- **Trading:** one intended record per site, business date and shift. The table contains 7,500 rows across five sites and two shifts.
- **Reviews:** one record per submitted review. The table contains 1,171 rows across five sites and three platforms. A site/date pair is not a unique review key.

## Cleaning and quality controls

The source data was preserved separately. Cleaning added parsed dates and explicit QA flags for missing or invalid values, site labels, day/date mismatches and possible duplicates. Ambiguous values were retained for analysis decisions rather than silently rewritten. The SQL scripts operate on the cleaned tables.

## KPI eligibility

Trading KPIs use separate row conditions. For example, revenue measures require an open shift with recorded revenue; spend per cover requires positive recorded covers; gross margin uses rows with eligible revenue and COGS; wastage has a separate recorded-wastage rule; and forecast variance requires both recorded actual revenue and a forecast.

For reviews, average ratings use valid numeric ratings, and headline rating/volume measures exclude later occurrences flagged as duplicate copies. Review volume is counted independently of rating validity when site and source are present.

## Cross-table comparison

Trading is at site/date/shift grain and reviews are individual review records. Each table is independently aggregated to site/month before a left join, with trading as the base. This avoids multiplying trading rows when several reviews exist in a month. Months without matching reviews remain visible.

## Interpretation limits

- The revenue basis is not confirmed as gross or net of VAT, discounts, promotions, service charge and tips.
- Repeated site/date/shift keys require investigation; reported totals may be affected by duplicate handling.
- Month totals vary with the number of trading days and are not automatically like-for-like.
- Recorded review dates are not confirmed visit dates. Review-month sentiment may refer to an earlier visit.
- Reviews are self-selected and do not represent every guest.
- Correlation describes co-movement in this dataset; it cannot establish causality.
