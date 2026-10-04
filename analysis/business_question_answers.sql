-- MarginOps | Reproducible calculations for the business-question answers
-- Uses the cleaned trading and review tables. Replace YOUR_PROJECT_ID.YOUR_DATASET.
-- Primary trading results exclude later exact-copy rows. The source table remains unchanged.

-- 1. Confirm duplicate-key groups and count distinct original trading value sets.
SELECT
  COUNT(*) AS repeated_key_groups,
  SUM(row_count) AS rows_in_repeated_groups,
  COUNTIF(value_versions = 1) AS exact_copy_groups,
  COUNTIF(value_versions > 1) AS conflicting_value_groups
FROM (
  SELECT
    site,
    date,
    shift,
    COUNT(*) AS row_count,
    COUNT(DISTINCT TO_JSON_STRING(STRUCT(
      day_of_week, covers, wet_revenue, food_revenue, promotions, discounts,
      service_charge, tips, food_cost, wet_cost_of_sales, wastage_cost,
      forecast_revenue, is_closed, notes
    ))) AS value_versions
  FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
  GROUP BY site, date, shift
  HAVING COUNT(*) > 1
);

-- Shared de-duplicated eligible population for forecast comparisons.
WITH forecast_rows AS (
  SELECT
    site,
    date,
    derived_day,
    shift,
    food_revenue + wet_revenue AS actual_revenue,
    forecast_revenue
  FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
  WHERE is_exact_duplicate = FALSE
    AND is_closed = FALSE
    AND revenue_missing = FALSE
    AND forecast_revenue IS NOT NULL
)
SELECT
  'estate' AS breakdown,
  'all eligible shifts' AS period,
  COUNT(*) AS eligible_shifts,
  SUM(actual_revenue) AS actual_revenue,
  SUM(forecast_revenue) AS forecast_revenue,
  SUM(actual_revenue - forecast_revenue) AS variance,
  100 * SAFE_DIVIDE(SUM(actual_revenue - forecast_revenue), SUM(forecast_revenue)) AS variance_pct,
  100 * SAFE_DIVIDE(SUM(ABS(actual_revenue - forecast_revenue)), SUM(forecast_revenue)) AS wape_pct
FROM forecast_rows
UNION ALL
SELECT
  'month', FORMAT_DATE('%Y-%m', DATE_TRUNC(date, MONTH)), COUNT(*),
  SUM(actual_revenue), SUM(forecast_revenue),
  SUM(actual_revenue - forecast_revenue),
  100 * SAFE_DIVIDE(SUM(actual_revenue - forecast_revenue), SUM(forecast_revenue)),
  100 * SAFE_DIVIDE(SUM(ABS(actual_revenue - forecast_revenue)), SUM(forecast_revenue))
FROM forecast_rows
GROUP BY DATE_TRUNC(date, MONTH)
UNION ALL
SELECT
  'weekday', derived_day, COUNT(*),
  SUM(actual_revenue), SUM(forecast_revenue),
  SUM(actual_revenue - forecast_revenue),
  100 * SAFE_DIVIDE(SUM(actual_revenue - forecast_revenue), SUM(forecast_revenue)),
  100 * SAFE_DIVIDE(SUM(ABS(actual_revenue - forecast_revenue)), SUM(forecast_revenue))
FROM forecast_rows
GROUP BY derived_day
UNION ALL
SELECT
  'shift', shift, COUNT(*),
  SUM(actual_revenue), SUM(forecast_revenue),
  SUM(actual_revenue - forecast_revenue),
  100 * SAFE_DIVIDE(SUM(actual_revenue - forecast_revenue), SUM(forecast_revenue)),
  100 * SAFE_DIVIDE(SUM(ABS(actual_revenue - forecast_revenue)), SUM(forecast_revenue))
FROM forecast_rows
GROUP BY shift
ORDER BY breakdown, period;

-- 2. Gross margin and cost rates, on the same eligible population.
SELECT
  site,
  COUNT(*) AS eligible_shifts,
  SUM(food_revenue + wet_revenue) AS revenue,
  SUM(food_cost + wet_cost_of_sales) AS cogs,
  SUM(food_revenue + wet_revenue) - SUM(food_cost + wet_cost_of_sales) AS gross_margin,
  100 * SAFE_DIVIDE(
    SUM(food_revenue + wet_revenue) - SUM(food_cost + wet_cost_of_sales),
    SUM(food_revenue + wet_revenue)
  ) AS gross_margin_pct,
  100 * SAFE_DIVIDE(SUM(food_revenue), SUM(food_revenue + wet_revenue)) AS food_revenue_mix_pct,
  100 * SAFE_DIVIDE(SUM(food_cost), SUM(food_revenue)) AS food_cogs_pct,
  100 * SAFE_DIVIDE(SUM(wet_cost_of_sales), SUM(wet_revenue)) AS wet_cogs_pct
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
WHERE is_exact_duplicate = FALSE
  AND is_closed = FALSE
  AND revenue_missing = FALSE
  AND cost_cogs_missing = FALSE
GROUP BY site
ORDER BY site;

-- 3. Wastage value and rates. The percentage denominator requires complete revenue.
SELECT
  site,
  SUM(CASE WHEN is_closed = FALSE AND is_exact_duplicate = FALSE
    AND wastage_cost IS NOT NULL THEN wastage_cost END) AS recorded_wastage_cost,
  COUNTIF(is_closed = FALSE AND is_exact_duplicate = FALSE
    AND wastage_cost IS NOT NULL) AS shifts_with_recorded_wastage,
  100 * SAFE_DIVIDE(
    SUM(CASE WHEN is_closed = FALSE AND is_exact_duplicate = FALSE
      AND revenue_missing = FALSE AND wastage_cost IS NOT NULL THEN wastage_cost END),
    SUM(CASE WHEN is_closed = FALSE AND is_exact_duplicate = FALSE
      AND revenue_missing = FALSE AND wastage_cost IS NOT NULL THEN food_revenue END)
  ) AS wastage_pct_of_food_revenue,
  100 * SAFE_DIVIDE(
    SUM(CASE WHEN is_closed = FALSE AND is_exact_duplicate = FALSE
      AND revenue_missing = FALSE AND wastage_cost IS NOT NULL THEN wastage_cost END),
    SUM(CASE WHEN is_closed = FALSE AND is_exact_duplicate = FALSE
      AND revenue_missing = FALSE AND wastage_cost IS NOT NULL THEN food_revenue + wet_revenue END)
  ) AS wastage_pct_of_total_revenue
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY site
ORDER BY recorded_wastage_cost DESC;

-- 4. Review rating with eligible review count, by platform and by site.
SELECT
  'site' AS breakdown,
  site AS category,
  COUNTIF(rating_valid AND duplicate_after_first = FALSE) AS valid_reviews,
  AVG(IF(rating_valid AND duplicate_after_first = FALSE, rating_numeric, NULL)) AS average_rating
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
WHERE site_missing = FALSE
GROUP BY site
UNION ALL
SELECT
  'source',
  source,
  COUNTIF(rating_valid AND duplicate_after_first = FALSE),
  AVG(IF(rating_valid AND duplicate_after_first = FALSE, rating_numeric, NULL))
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
WHERE source_missing = FALSE
GROUP BY source
ORDER BY breakdown, category;
