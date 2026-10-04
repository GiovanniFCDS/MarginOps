# Excel reconciliation

Excel was used as an independent check of the SQL and Power BI KPI outputs. The comparison is built from matching eligible populations rather than averages of site percentages.

## Aggregate checkpoint

| KPI | Eligible rows | Excel | Power BI | Difference |
|---|---:|---:|---:|---:|
| Actual revenue | 7,165 | £6,027,795.03 | £6,027,795.03 | £0.00 |
| Forecast revenue | 7,165 | £5,895,524.00 | £5,895,524.00 | £0.00 |
| Revenue variance | 7,165 | £132,271.03 | £132,271.03 | £0.00 |
| Gross margin | 7,027 | 65.3228% | 65.32% | 0.0028 percentage points before display rounding |
| Wastage / food revenue | 7,101 | 5.7059% | 5.71% | −0.0041 percentage points before display rounding |

These are aggregate checkpoints from the final comparison; the workbook's underlying formulas are not included in the public repository. The full working workbook contains 7,500 row-level trading records and is therefore kept private. Site-level values and source rows are not published here.

## Definitions

- Revenue: open shifts with complete food and wet revenue.
- Forecast and variance: the same population, additionally requiring a non-null forecast.
- Gross margin: open shifts with complete revenue and complete food and wet COGS.
- Wastage rate: open shifts with complete revenue and recorded wastage; both wastage and food revenue use this same row set.

Rounded Power BI percentages can differ slightly from the unrounded Excel result. Differences are percentage points, not relative percent changes.
