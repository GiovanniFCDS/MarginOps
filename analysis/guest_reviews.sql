-- MarginOps | Guest review analysis
-- Grain: one row per submitted review.
-- Valid ratings and review-volume populations have separate rules.
-- Replace YOUR_PROJECT_ID.YOUR_DATASET before execution.

-- Query 1
/* First load of the cleaned data */

SELECT*
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`

-- Query 2
/* Counting rows */

SELECT
COUNT(*) AS total_row_count
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`

-- Query 3
/* Earliest and latest date check */

SELECT
min(date_parsed) AS earliest_date,
max(date_parsed) AS latest_date
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`

-- Query 4
/* Counting all missing numbers and duplicates */

SELECT
COUNTIF(date_missing) AS missing_dates,
COUNTIF(date_invalid) AS invalid_dates,
COUNTIF(rating_missing) AS missing_ratings,
COUNTIF(rating_invalid) AS invalid_ratings,
COUNTIF(site_missing) AS missing_sites,
COUNTIF(source_missing) AS missing_sources,
COUNTIF(review_text_missing) AS missing_review_text,
COUNTIF(potential_duplicate) AS potential_dupes_count,
COUNTIF(duplicate_after_first) AS after_first_dupes_count

FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`

-- Query 5
/* Showing site names and numbers to confirm cleaned data */

SELECT
DISTINCT(site),
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`

-- Query 6
/* Showing source names and numbers to confirm cleaned data */

SELECT
DISTINCT(source)
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`

-- Query 7
/* Looking at ratings per site, with percentages and average per site */

WITH starring AS (
SELECT
COUNTIF(rating_missing = false AND rating_invalid = false AND duplicate_after_first = false AND rating_numeric = 1) AS one_star,
COUNTIF(rating_missing = false AND rating_invalid = false AND duplicate_after_first = false AND rating_numeric = 2) AS two_star,
COUNTIF(rating_missing = false AND rating_invalid = false AND duplicate_after_first = false AND rating_numeric = 3) AS three_star,
COUNTIF(rating_missing = false AND rating_invalid = false AND duplicate_after_first = false AND rating_numeric = 4) AS four_star,
COUNTIF(rating_missing = false AND rating_invalid = false AND duplicate_after_first = false AND rating_numeric = 5) AS five_star,
COUNTIF(rating_missing = false AND rating_invalid = false AND duplicate_after_first = false) AS total_reviews,
site
FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
GROUP BY site
)

SELECT
site,
one_star,
two_star,
three_star,
four_star,
five_star,
total_reviews,
one_star / total_reviews * 100 AS one_star_pct,
two_star / total_reviews * 100 AS two_star_pct,
three_star / total_reviews * 100 AS three_star_pct,
four_star / total_reviews * 100 AS four_star_pct,
five_star / total_reviews * 100 AS five_star_pct
FROM starring

-- Query 8
/* Average rating with review count by site */

SELECT
AVG(CASE WHEN rating_missing = false AND rating_invalid = false
AND duplicate_after_first = false THEN rating_numeric END) AS avg_rating,

COUNT(CASE WHEN rating_missing = false
AND rating_invalid = false AND duplicate_after_first = false THEN rating_numeric END) AS total_reviews,

site,

FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
GROUP BY site

-- Query 9
/* Average rating by source against total reviews */

SELECT
AVG(CASE WHEN rating_missing = false AND source_missing = false AND rating_invalid = false
AND duplicate_after_first = false THEN rating_numeric END) AS avg_rating,

COUNT(CASE WHEN rating_missing = false AND source_missing = false
AND rating_invalid = false AND duplicate_after_first = false THEN rating_numeric END) AS total_reviews,

source,

FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
GROUP BY source
ORDER BY total_reviews DESC

-- Query 10
/* Review volume over time */

WITH pre_lag AS (
  SELECT
    DATE_TRUNC(date_parsed, MONTH) AS month,
    COUNTIF(site_missing = false AND source_missing = false
      AND duplicate_after_first = false) AS total_reviews,
    source,
    site
  FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
  GROUP BY month, source, site
),

lagging AS (
  SELECT
    month,
    source,
    site,
    total_reviews,
    LAG(total_reviews) OVER (
      PARTITION BY source, site
      ORDER BY month
    ) AS previous_month_reviews
  FROM pre_lag
)

SELECT *, total_reviews - previous_month_reviews AS review_variance
FROM lagging
ORDER BY site, source, month

-- Query 11
/* Ranking by average rating */

WITH pre_ranking AS (
  SELECT
    AVG(CASE WHEN rating_missing = false AND rating_invalid = false
      AND duplicate_after_first = false THEN rating_numeric END) AS avg_rating,
    COUNT(CASE WHEN rating_missing = false AND rating_invalid = false
      AND duplicate_after_first = false THEN rating_numeric END) AS total_reviews,
    site
  FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
  GROUP BY site
),

ranking AS (
  SELECT
    site,
    avg_rating,
    total_reviews,
    RANK() OVER (ORDER BY avg_rating DESC) AS average_rating_rank
  FROM pre_ranking
)

SELECT *
FROM ranking
ORDER BY average_rating_rank

-- Query 12
/* Duplicate impact check */

SELECT
site,

  -- WITH duplicates excluded (your current standard)
  AVG(CASE WHEN rating_missing = false AND rating_invalid = false
    AND duplicate_after_first = false THEN rating_numeric END) AS avg_rating_excl_dupes,
  COUNT(CASE WHEN rating_missing = false AND rating_invalid = false
    AND duplicate_after_first = false THEN rating_numeric END) AS total_reviews_excl_dupes,

  -- WITH duplicates included (comparison)
  AVG(CASE WHEN rating_missing = false AND rating_invalid = false
    THEN rating_numeric END) AS avg_rating_incl_dupes,
  COUNT(CASE WHEN rating_missing = false AND rating_invalid = false
    THEN rating_numeric END) AS total_reviews_incl_dupes

FROM `YOUR_PROJECT_ID.YOUR_DATASET.Guest_Reviews_Cleaned`
GROUP BY site
