# Data notes

The completed project uses two datasets: site trading at site/date/shift grain and guest reviews at individual-review grain. This public repository does not include raw or row-level records or guest review text.

The final analysis does not include staff timesheets or a labour budget. Labour budget and labour-hour questions therefore remain out of scope.

For reproduction, load the source data into your own BigQuery dataset and replace `YOUR_PROJECT_ID.YOUR_DATASET` in the SQL scripts. Follow each KPI's eligibility conditions and confirm the revenue basis before treating commercial measures as final.
