# Power BI report

A five-page Power BI report was created for MarginOps. The `.pbix` file is not included in this public repository because Power BI files may embed the underlying data. The PDF export also contains named-site figures and detailed trading rows, so it is not included until those details are reviewed for public release.

The provided five-page PDF was inspected. Its revenue, gross-margin and forecast-variance totals do not match the submitted SQL/Excel outputs, and its duplicate-key note conflicts with the cleaned pandas duplicate flags. Reconcile the filters, measures and duplicate description before treating the report as validated or sharing it as the project’s final result.

The repository also lacks the pandas cleaning notebooks and Excel reconciliation workbook, so a public reviewer cannot currently inspect those stages. Add sanitized, reproducible versions once row-level and named-site content has been removed.
