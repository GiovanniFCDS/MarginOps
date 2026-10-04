-- MarginOps | Trading and review comparison
-- Each source is aggregated independently to site + month before joining.
-- Results are exploratory; review dates are not confirmed visit dates.
-- Replace YOUR_PROJECT_ID.YOUR_DATASET before execution.

-- Query 1
/* Creating a reusable monthly total revenue view */

CREATE OR REPLACE VIEW `YOUR_PROJECT_ID.YOUR_DATASET.v_trading_monthly` AS

SELECT
  DATE_TRUNC(date, MONTH) AS month,
  SUM(CASE WHEN is_closed = false AND revenue_missing = false THEN food_revenue + wet_revenue END) AS total_revenue,
  site
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Cleaned_Site_Trading`
GROUP BY month, site;

-- Query 2
/* Creating a reusable monthly reviews view */

CREATE OR REPLACE VIEW `YOUR_PROJECT_ID.YOUR_DATASET.v_reviews_monthly` AS

SELECT
  DATE_TRUNC(date_parsed, MONTH) AS month,
  AVG(CASE WHEN rating_missing = false AND rating_invalid = false
    AND duplicate_after_first = false THEN rating_numeric END) AS avg_rating,
  COUNT(CASE WHEN rating_missing = false AND rating_invalid = false
    AND duplicate_after_first = false THEN rating_numeric END) AS total_reviews,
  site
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
GROUP BY month, site;

-- Query 3
/* Joining */

SELECT
t.site,
t.month,
t.total_revenue,
r.avg_rating,
r.total_reviews

FROM `YOUR_PROJECT_ID.YOUR_DATASET.v_trading_monthly` AS t
LEFT JOIN `YOUR_PROJECT_ID.YOUR_DATASET.v_reviews_monthly` AS r
  ON t.site = r.site AND t.month = r.month;

-- Query 4
/* Joining and aggregating as a sanity check  */

SELECT
COUNT(*) AS total_rows,
  COUNTIF(avg_rating IS NULL) AS rows_with_no_reviews,
  COUNTIF(avg_rating IS NOT NULL) AS rows_with_reviews
FROM (
SELECT
t.site,
t.month,
t.total_revenue,
r.avg_rating,
r.total_reviews

FROM `YOUR_PROJECT_ID.YOUR_DATASET.v_trading_monthly` AS t
LEFT JOIN `YOUR_PROJECT_ID.YOUR_DATASET.v_reviews_monthly` AS r
  ON t.site = r.site AND t.month = r.month
);

-- Query 5
/* Identifying nulls */

SELECT t.site, t.month
FROM `YOUR_PROJECT_ID.YOUR_DATASET.v_trading_monthly` AS t
LEFT JOIN `YOUR_PROJECT_ID.YOUR_DATASET.v_reviews_monthly` AS r
  ON t.site = r.site AND t.month = r.month
WHERE r.avg_rating IS NULL;

-- Query 6
/* Looking at correlation */

SELECT
  CORR(total_revenue, avg_rating) AS revenue_rating_correlation,
  COUNT(*) AS sample_size
FROM (
  SELECT t.total_revenue, r.avg_rating
  FROM `YOUR_PROJECT_ID.YOUR_DATASET.v_trading_monthly` AS t
  LEFT JOIN `YOUR_PROJECT_ID.YOUR_DATASET.v_reviews_monthly` AS r
    ON t.site = r.site AND t.month = r.month
  WHERE r.avg_rating IS NOT NULL
);
