# MarginOps — Commercial Finance & FP&A Analytics

**Status: analysis complete** · **Tools: Python, BigQuery SQL, Excel, Power BI**

MarginOps is an end-to-end analytics project applying commercial finance questions to hospitality-style operating data. It covers data quality, KPI design, site trading performance, guest review analysis, reconciliation and an exploratory comparison between trading and reviews.

I started this project to connect my hospitality operations experience with my BSc in FinTech with Data Analytics. The data covers five sites, 7,500 trading records at site/date/shift level and 1,171 guest reviews.

## What I investigated

- How revenue, covers, spend per cover, cost of sales, gross margin, wastage and forecast variance differ across sites.
- How trading summaries change by shift, weekday and month.
- How valid review ratings and review counts vary by site and platform.
- Whether monthly site-level revenue and average ratings show a detectable linear association.

## Workflow

1. **Python / pandas:** inspect and clean source files; retain ambiguous values; add data-quality and duplicate flags; document exclusions.
2. **BigQuery SQL:** define KPI-specific eligibility; calculate trading and review summaries; use window functions and rankings; aggregate both tables to site/month before joining.
3. **Excel:** reconcile summary outputs and check calculations.
4. **Power BI:** present commercial performance in a report.

## Selected observations

- Site-level spend per cover was approximately £13.25–£13.50 and gross margin was approximately 65.1%–66.1%, under the eligibility rules in the trading analysis. Similar summaries alone do not establish a standardised pricing model.
- Average review ratings ranged from approximately 3.57 to 3.72. Google supplied the largest review volume; platform and reviewer selection mean these ratings do not represent all guests.
- The exploratory correlation between monthly revenue and average rating was approximately **-0.079**. This does not establish causation or show that guest sentiment has no effect on revenue.

## Limitations

- The revenue basis (VAT, promotions, discounts, service charge and tips) has not been confirmed, so revenue-based measures are provisional.
- Repeated site/date/shift keys remain flagged for investigation. Duplicate handling and row eligibility can change totals.
- Monthly totals are affected by different trading-day counts; they are not automatically like-for-like.
- Review dates are not confirmed visit dates. The site/month comparison is exploratory and not causal.
- The dataset is hospitality-style portfolio data. Findings should not be treated as official results for a named employer or venue.

## Repository contents

- `analysis/site_trading.sql` — trading quality checks and KPI analysis.
- `analysis/guest_reviews.sql` — review quality, volume and rating analysis.
- `analysis/combined_review_trading.sql` — monthly views, join coverage and exploratory correlation.
- `data/README.md` — data handling and reproduction notes.
- `visuals/README.md` — dashboard artifact notes.

Raw records and guest review text are not published. SQL references use placeholders; replace `YOUR_PROJECT_ID.YOUR_DATASET` with your own BigQuery table location before running. Saved query outputs were removed from the scripts to keep the repository focused on reproducible analysis and avoid publishing row-level results.

## About

This is a personal portfolio project demonstrating applied analytics and commercial reasoning. It is not an official report for any employer.
