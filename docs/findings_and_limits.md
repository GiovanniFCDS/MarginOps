# Findings and limits

## Reconciled headline results

The supplied KPI comparison reports matching Excel and Power BI actual revenue, forecast revenue, and revenue variance at each site. At total level the figures are **£6,027,795.03 actual revenue**, **£5,895,524.00 forecast**, and **+£132,271.03 (+2.24%) variance**. Gross margin is **65.32%** and matched-population wastage is **5.71% of food revenue**. Site margin and wastage display differences are limited to rounding at the shown precision.

The duplicate audit identified 60 rows across 30 repeated site/date/shift pairs, with matching values within each pair. KPI rows are retained to match the submitted SQL/Excel policy; the duplicate flags are for audit and caveat reporting.

## Interpretation limits

- Revenue basis has not been confirmed as gross or net of VAT, discounts, service charge and tips.
- Net revenue variance is not an absolute forecast accuracy measure. WAPE/MAE was not calculated.
- Monthly trading results are not normalized for trading-day counts.
- August 2026 data runs through 17 August and is partial.
- Recorded review dates are not confirmed visit dates; reviews are self-selected.
- Correlation is descriptive and does not establish causation.
- Gross-margin differences are not decomposed by category or product mix.
- Staff timesheets and labour analysis are outside the project's scope.

## Public evidence

The pandas notebooks are included without saved outputs. Aggregate methodology and findings are documented. The full Excel workbook and Power BI file are intentionally omitted because they embed row-level data; add only an approved, sanitized public export.
