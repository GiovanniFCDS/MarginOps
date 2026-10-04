# Pipeline and release notes

## End-to-end workflow

1. **Pandas cleaning and QA** — inspect the trading and review tables, standardize fields, parse dates, test validity and duplicates, and add explicit quality flags. The public notebooks are code-only; provide authorized input files locally.
2. **BigQuery SQL** — calculate each KPI with its own row eligibility, answer supported business questions, and aggregate trading/review data separately before exploratory comparison.
3. **Excel reconciliation** — independently check totals and matched-population rates. The public documentation contains an aggregate checkpoint; the source workbook is not published because it includes row-level trading data.
4. **Power BI** — present trading, wastage, guest-review and data-quality findings in a six-page report. The PBIX is not published because it embeds source rows.

## Reproduction

- Put authorized input files in `data/raw/` using the filenames in the notebooks.
- Run the two notebooks from the repository root or `cleaning/`; processed data is saved under `data/cleaned/`.
- Load the cleaned tables into a BigQuery dataset and replace `YOUR_PROJECT_ID.YOUR_DATASET` in the SQL scripts.
- Rebuild the Excel reconciliation and Power BI report from the same eligibility rules in `docs/methodology.md`.

Raw and cleaned datasets, execution outputs, the full workbook and PBIX are not included in the public repo. No staff-timesheet data is part of this pipeline.
