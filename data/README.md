# Data handling

The analysis uses two datasets only:

- Site trading records at site/date/shift grain (7,500 rows in the working dataset).
- Guest reviews at one row per submitted review (1,171 rows in the working dataset).

Staff timesheets and labour data are out of scope and are not used by the project.

The original trading and review files contain row-level operational data and review text. They are not included in this public repository. The Excel reconciliation workbook also contains a full cleaned-data sheet, and the Power BI file embeds its model data, so neither source artifact is published here.

For local reproduction, place files you are authorized to use in `data/raw/` with the filenames expected by the notebooks. The notebooks write processed files to `data/cleaned/`. These folders are excluded from Git. Do not commit raw or cleaned rows, review text, credentials, or a PBIX/XLSX containing embedded source data. Publish only an approved, sanitized aggregate export.
