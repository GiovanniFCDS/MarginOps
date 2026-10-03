-- MarginOps | Site trading analysis
-- Grain: site + date + shift.
-- Run against a cleaned table matching the project schema.
-- KPI eligibility is defined independently in each query.
-- Replace YOUR_PROJECT_ID.YOUR_DATASET before execution.

-- Query 1
SELECT*
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`

-- Query 2
/* Looking for exact numbers of missing data*/

SELECT
COUNTIF(revenue_missing) AS revenue_missing_count,
COUNTIF(cost_cogs_missing) AS cost_cogs_missing_count,
COUNTIF(covers_missing) AS covers_missing_count,
COUNTIF(is_exact_duplicate) AS is_exact_duplicate_count,
COUNTIF(is_key_duplicate) AS is_key_duplicate_count,
COUNTIF(day_mismatch) AS day_mismatch_count

FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`

-- Query 3
/* Looking at missing percentages*/

WITH count_pcts AS(
SELECT
COUNT(*) AS total_rows,
ROUND(COUNTIF(revenue_missing) / COUNT(*) * 100, 1) AS missing_revenue_pct,
ROUND(COUNTIF(cost_cogs_missing) / COUNT(*) * 100, 1) AS cost_cogs_missing_pct,
ROUND(COUNTIF(covers_missing) /  COUNT(*) * 100, 1) AS covers_missing_pct,
ROUND(COUNTIF(is_exact_duplicate) / COUNT(*) * 100, 1) AS is_exact_duplicate_pct,
ROUND(COUNTIF(is_key_duplicate) / COUNT(*) * 100, 1) AS is_key_duplicate_pct,
ROUND(COUNTIF(day_mismatch) / COUNT(*) * 100, 1) AS day_mismatch_pct
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
)

SELECT
missing_revenue_pct,
cost_cogs_missing_pct,
covers_missing_pct,
is_exact_duplicate_pct,
is_key_duplicate_pct,
day_mismatch_pct
FROM count_pcts

-- Query 4
/* Checking date ranges */

SELECT
min(date) AS earliest_date,
max(date) AS latest_date

FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`

-- Query 5
/* Checking if site names are correct */

SELECT
DISTINCT (site)

FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`

-- Query 6
/* Checking if shifts are correct */

SELECT
DISTINCT(shift)
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`

-- Query 7
/* Checking how many non-values in wastage */

SELECT COUNTIF(wastage_cost IS NULL) AS wastage_missing_count
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`

-- Query 8
/* Creating Core KPIs */

SELECT
  SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue END) AS total_food_revenue,
  SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN wet_revenue END) AS total_wet_revenue,
  SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue + wet_revenue END) AS total_revenue,
  SUM(CASE WHEN covers_missing = false AND covers > 0 THEN covers END) AS total_covers,
  SUM(CASE WHEN is_closed = false AND revenue_missing = false AND covers_missing = false AND covers > 0 THEN food_revenue + wet_revenue END)
    / SUM(CASE WHEN is_closed = false AND revenue_missing = false AND covers_missing = false AND covers > 0 THEN covers END) AS spend_per_cover,
  SUM(CASE WHEN cost_cogs_missing = false THEN food_cost + wet_cost_of_sales END) AS total_cogs,
  SUM(CASE WHEN wastage_cost IS NOT NULL AND is_closed = false THEN wastage_cost END) AS total_wastage,
  SUM(CASE WHEN is_closed = false AND revenue_missing = false AND cost_cogs_missing = false THEN food_revenue + wet_revenue END)
    - SUM(CASE WHEN is_closed = false AND revenue_missing = false AND cost_cogs_missing = false THEN food_cost + wet_cost_of_sales END) AS gross_margin,
  (SUM(CASE WHEN is_closed = false AND revenue_missing = false AND cost_cogs_missing = false THEN food_revenue + wet_revenue END)
    - SUM(CASE WHEN is_closed = false AND revenue_missing = false AND cost_cogs_missing = false THEN food_cost + wet_cost_of_sales END))
    / SUM(CASE WHEN is_closed = false AND revenue_missing = false AND cost_cogs_missing = false THEN food_revenue + wet_revenue END) * 100 AS gross_margin_pct,
  site
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY site

-- Query 9
/* Looking at total wastage, food wastage and total wastage percentage */

SELECT
  SUM(CASE WHEN wastage_cost IS NOT NULL AND is_closed = false THEN wastage_cost END) AS total_wastage,

  SUM(CASE WHEN is_closed = false AND revenue_missing = false AND wastage_cost IS NOT NULL THEN wastage_cost END)
    / SUM(CASE WHEN is_closed = false AND revenue_missing = false AND wastage_cost IS NOT NULL THEN food_revenue END) AS wastage_pct_of_food,

  SUM(CASE WHEN is_closed = false AND revenue_missing = false AND wastage_cost IS NOT NULL THEN wastage_cost END)
    / SUM(CASE WHEN is_closed = false AND revenue_missing = false AND wastage_cost IS NOT NULL THEN food_revenue + wet_revenue END) AS wastage_pct_of_total,

  site
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY site

-- Query 10
/* Calculating actual vs forecast revenue - variance */

SELECT
  SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN food_revenue + wet_revenue END) AS total_actual_revenue,
  SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN forecast_revenue END) AS total_forecast_revenue,

  SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN food_revenue + wet_revenue END)
    - SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN forecast_revenue END) AS variance,

  (SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN food_revenue + wet_revenue END)
    - SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN forecast_revenue END))
    / SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN forecast_revenue END) * 100 AS variance_pct,

  site
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY site

-- Query 11
/* Looking at KPIs over Lunch and Dinner on sites */

SELECT
SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue END) AS total_food_revenue,
SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN wet_revenue END) AS total_wet_revenue,
SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue + wet_revenue END) AS total_revenue,

SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN food_revenue + wet_revenue END)
 - SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN forecast_revenue END) AS forecast_variance,

site,
shift,

FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY shift, site

-- Query 12
/* Looking at KPIs over the days of the week on sites */

SELECT
SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue END) AS total_food_revenue,
SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN wet_revenue END) AS total_wet_revenue,
SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue + wet_revenue END) AS total_revenue,

SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN food_revenue + wet_revenue END)
 - SUM(CASE WHEN is_closed = false AND revenue_missing = false AND forecast_revenue IS NOT NULL THEN forecast_revenue END) AS forecast_variance,

site,
day_of_week,

FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY day_of_week, site
ORDER BY site ASC

-- Query 13
/* Looking at previous month total revenue vs current month - creates variance p/m */

WITH pre_lag AS (
SELECT
DATE_TRUNC(
  date, MONTH) AS month,
SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue END) AS total_food_revenue,
SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN wet_revenue END) AS total_wet_revenue,
SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue + wet_revenue END) AS total_revenue,
site,

FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`

GROUP BY month,site
ORDER BY month
),

with_lags AS (
  SELECT
  month,
  site,
  total_food_revenue,
  total_wet_revenue,
  total_revenue,
  LAG(total_food_revenue) OVER(
    PARTITION BY site
    ORDER BY month) AS
  prior_food_revenue,
  LAG(total_wet_revenue) OVER(
    PARTITION BY site
    ORDER BY month) AS
  prior_wet_revenue,
  LAG(total_revenue) OVER(
    PARTITION BY site
    ORDER BY month) AS
  prior_total_revenue
  FROM pre_lag
  )

SELECT
month,
site,
total_food_revenue - prior_food_revenue AS food_revenue_variance,
total_wet_revenue - prior_wet_revenue AS wet_revenue_variance,
total_revenue - prior_total_revenue AS total_revenue_variance
FROM with_lags
ORDER BY site, month

-- Query 14
/* Creating a ranking classification with total revenues */

WITH pre_rank AS (
  SELECT
    SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue END) AS total_food_revenue,
    SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN wet_revenue END) AS total_wet_revenue,
    SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue + wet_revenue END) AS total_revenue,
    site
  FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
  GROUP BY site
),

ranking AS (
  SELECT
    site,
    total_food_revenue,
    total_wet_revenue,
    total_revenue,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
  FROM pre_rank
)

SELECT *
FROM ranking
ORDER BY revenue_rank
