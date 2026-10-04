# Methodology

## Data grain and scope

- **Trading:** site/date/shift grain, 7,500 rows across five sites and two shifts.
- **Guest reviews:** one row per submitted review, 1,171 rows across five sites and three platforms.
- The project uses trading and review datasets only. Staff timesheets and labour-cost analysis are outside scope.

## Cleaning and duplicate policy

The pandas notebooks standardize fields, parse dates, validate values, and add QA flags. Source values are preserved; missing and negative values are not silently replaced. The notebooks in this repository have saved cell outputs removed and expect the user to supply authorized local data.

The audit found 60 rows across 30 repeated site/date/shift key pairs. Values match within each pair. Trading duplicate flags are retained for QA, but the submitted KPI SQL does not apply them as an exclusion; Power BI follows the same policy so the KPI totals reconcile. Review-rating analysis separately excludes later flagged duplicate review copies as defined in its SQL.

## KPI eligibility

- **Revenue:** open shifts with complete food and wet revenue.
- **Forecast variance:** the revenue population above, additionally restricted to rows with a recorded forecast. Overall actual less forecast is +£132,271 (+2.24%); this is net variance, not an absolute forecast-accuracy measure.
- **Gross margin:** open shifts with complete revenue and complete food and wet COGS, using matching numerator and denominator rows. Overall gross margin is 65.32%.
- **Wastage value:** open shifts with recorded wastage.
- **Wastage % of food revenue:** wastage cost divided by food revenue on the same eligible rows: open shifts with complete revenue and recorded wastage. The reconciled total is 5.71%.
- **Review ratings:** valid numeric ratings, excluding later duplicate copies; report averages with counts.

## Cross-table comparison

Trading is aggregated separately from reviews to site/month before joining. This avoids multiplying trading values when several reviews occur in a month. The resulting correlation is exploratory: recorded review dates are not confirmed visit dates, reviewers are self-selected, and correlation does not establish causation.

## Limits

Revenue basis (gross or net of VAT, promotions, discounts, service charge and tips) is not confirmed. Monthly totals are not normalized for trading days. August 2026 is partial through 17 August and should not be read as a full month. The analysis does not calculate WAPE/MAE, nor decompose gross-margin differences into category or product-mix drivers.
