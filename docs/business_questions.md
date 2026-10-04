# Business questions and answers

MarginOps answers questions supported by site trading and guest-review data. Labour questions are explicitly out of scope because no staff timesheets or labour-budget dataset is used.

## Trading performance

| Question | Answer |
|---|---|
| How did revenue compare with forecast? | Across the eligible forecast-row population, actual revenue was **£6,027,795.03**, forecast was **£5,895,524.00**, and net variance was **+£132,271.03 (+2.24%)**. This is net bias; it does not measure absolute forecast accuracy. |
| How did gross margin vary? | Site margin ranged from **65.14% to 66.13%**; the total matched-population gross margin was **65.32%**. The work reports outcomes but does not isolate product-mix or category COGS drivers. |
| What was the wastage rate? | **5.71% of food revenue**, calculated with the same eligible rows in numerator and denominator: open shifts with complete revenue and recorded wastage. This matches the reported Excel and Power BI total. |
| How were repeated trading keys handled? | The audit flagged 60 rows across 30 repeated site/date/shift pairs. Values matched within each pair. KPI SQL and Power BI retain those rows to match the submitted methodology; the flags remain available for QA. |
| What does the forecast comparison say about accuracy? | The net variance is positive overall, but WAPE, MAE or another absolute-error metric was not calculated. No claim about forecast accuracy is made. |

## Guest reviews and comparison

- Site average ratings ranged from **3.58 to 3.72** after invalid ratings and later flagged duplicate copies were excluded.
- The exploratory site/month revenue-rating Pearson correlation was approximately **−0.079**. Review dates are not confirmed visit dates, reviews are self-selected, and the result does not establish cause and effect.

## Questions outside this project

Labour cost versus budget and revenue per labour hour require authorized staff-time data and a defined labour budget. They are not answered or inferred here.

## Other caveats

Revenue basis (including VAT, discounts, service charge and tips) is not confirmed. Monthly totals are not normalized for trading days. August 2026 is a partial month through 17 August.
