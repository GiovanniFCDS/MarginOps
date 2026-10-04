-- MarginOps | Reproducible calculations following the submitted SQL eligibility rules
-- Replace YOUR_PROJECT_ID.YOUR_DATASET before execution.
-- Trading duplicate flags are retained as QA fields; they are not used as KPI filters.
-- Review rating duplicate handling follows the submitted review analysis.

-- 1. Site actual-versus-forecast totals.
SELECT
  site,
  COUNTIF(is_closed = FALSE AND revenue_missing = FALSE
          AND forecast_revenue IS NOT NULL) AS eligible_rows,
  SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
           AND forecast_revenue IS NOT NULL
      THEN food_revenue + wet_revenue END) AS actual_revenue,
  SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
           AND forecast_revenue IS NOT NULL
      THEN forecast_revenue END) AS forecast_revenue,
  SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
           AND forecast_revenue IS NOT NULL
      THEN food_revenue + wet_revenue - forecast_revenue END) AS variance,
  100 * SAFE_DIVIDE(
    SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
             AND forecast_revenue IS NOT NULL
        THEN food_revenue + wet_revenue - forecast_revenue END),
    SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
             AND forecast_revenue IS NOT NULL
        THEN forecast_revenue END)
  ) AS variance_pct
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY site
ORDER BY site;

-- 2. Forecast variance by shift and weekday, matching the original analysis.
SELECT
  'shift' AS breakdown,
  shift AS category,
  SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                AND forecast_revenue IS NOT NULL
      THEN food_revenue + wet_revenue - forecast_revenue END) AS variance
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY shift
UNION ALL
SELECT
  'weekday',
  day_of_week,
  SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                AND forecast_revenue IS NOT NULL
      THEN food_revenue + wet_revenue - forecast_revenue END)
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY day_of_week
ORDER BY breakdown, category;

-- 3. Gross margin by site, with the submitted matched-population rules.
SELECT
  site,
  SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                AND cost_cogs_missing = FALSE
      THEN food_revenue + wet_revenue END) AS eligible_revenue,
  SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                AND cost_cogs_missing = FALSE
      THEN food_cost + wet_cost_of_sales END) AS eligible_cogs,
  100 * SAFE_DIVIDE(
    SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                  AND cost_cogs_missing = FALSE
        THEN food_revenue + wet_revenue - food_cost - wet_cost_of_sales END),
    SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                  AND cost_cogs_missing = FALSE
        THEN food_revenue + wet_revenue END)
  ) AS gross_margin_pct
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY site
ORDER BY site;

-- 4. Wastage value and rate using matched row populations.
-- Reconcile the Excel numerator to these SQL definitions.
SELECT
  site,
  SUM(CASE WHEN is_closed = FALSE AND wastage_cost IS NOT NULL
      THEN wastage_cost END) AS recorded_wastage_value,
  SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                AND wastage_cost IS NOT NULL
      THEN wastage_cost END) AS wastage_on_complete_revenue_rows,
  100 * SAFE_DIVIDE(
    SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                  AND wastage_cost IS NOT NULL
        THEN wastage_cost END),
    SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                  AND wastage_cost IS NOT NULL
        THEN food_revenue END)
  ) AS wastage_pct_of_food_revenue,
  100 * SAFE_DIVIDE(
    SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                  AND wastage_cost IS NOT NULL
        THEN wastage_cost END),
    SUM(CASE WHEN is_closed = FALSE AND revenue_missing = FALSE
                  AND wastage_cost IS NOT NULL
        THEN food_revenue + wet_revenue END)
  ) AS wastage_pct_of_total_revenue
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY site
ORDER BY site;

-- 5. Review rating and count by site and platform, matching the review analysis.
SELECT
  'site' AS breakdown,
  site AS category,
  COUNTIF(rating_missing = FALSE AND rating_invalid = FALSE
          AND duplicate_after_first = FALSE) AS valid_reviews,
  AVG(IF(rating_missing = FALSE AND rating_invalid = FALSE
         AND duplicate_after_first = FALSE, rating_numeric, NULL)) AS average_rating
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
GROUP BY site
UNION ALL
SELECT
  'platform',
  source,
  COUNTIF(rating_missing = FALSE AND source_missing = FALSE
          AND rating_invalid = FALSE AND duplicate_after_first = FALSE),
  AVG(IF(rating_missing = FALSE AND source_missing = FALSE
         AND rating_invalid = FALSE AND duplicate_after_first = FALSE,
         rating_numeric, NULL))
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
GROUP BY source
ORDER BY breakdown, category;

-- WAPE and month-level forecast variance are intentionally omitted:
-- they were not part of the submitted final analysis.
