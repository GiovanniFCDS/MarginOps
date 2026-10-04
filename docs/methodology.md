# Methodology

## Data grain

- **Trading:** intended grain is site, business date and shift; the cleaned table contains 7,500 rows across five sites and two shifts.
- **Reviews:** one record per submitted review; 1,171 rows across five sites and three platforms. Site/date is not a unique review key.

## Cleaning and duplicate handling

The raw and cleaned tables were preserved. Cleaning added parsed dates and QA flags for missing or invalid values, site labels, day/date mismatches and possible duplicates.

The submitted trading KPI SQL applies its stated per-metric eligibility conditions and does **not** filter on is_exact_duplicate or is_key_duplicate. Therefore published trading results must retain the same rows used by those queries. Review rating queries separately exclude duplicate_after_first, as specified in the submitted review analysis.

## KPI eligibility

- Trading revenue uses open shifts with complete food and wet revenue.
- Forecast comparison additionally requires a recorded forecast.
- Gross margin uses open shifts with complete revenue and complete food and wet COGS.
- Wastage value uses open shifts with recorded wastage. The rate requires recorded wastage and complete revenue, with food revenue or combined revenue as denominator. The SQL and Excel rate numerator populations currently do not reconcile; see business_questions.md.
- Review ratings use valid numeric ratings and exclude later flagged duplicate copies. Review counts are shown with average ratings.

## Cross-table comparison

Trading is at site/date/shift grain and reviews are individual review records. Each table is independently aggregated to site/month before a left join, with trading as the base. This avoids multiplying trading rows when several reviews occur in a month. Months without matching reviews remain visible.

## Interpretation limits

- Net forecast variance is not a forecast-accuracy metric; the submitted analysis did not calculate absolute errors such as WAPE.
- Monthly actual-versus-forecast performance was not calculated in the submitted analysis.
- Revenue basis is not confirmed as gross or net of VAT, discounts, promotions, service charge and tips.
- Monthly totals vary with trading-day counts and are not automatically like-for-like.
- Recorded review dates are not confirmed visit dates. Review-month sentiment may refer to an earlier visit.
- Reviews are self-selected and do not represent every guest.
- Correlation describes co-movement in this dataset; it cannot establish causality.
- Workforce analysis is outside the final project's two-dataset scope.
