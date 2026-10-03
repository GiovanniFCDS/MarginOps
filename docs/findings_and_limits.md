# Findings and open checks

## Findings reported by the analysis

- Spend per cover was approximately **£13.25–£13.50** and gross margin approximately **65.1%–66.1%** across the five sites under the documented SQL eligibility rules.
- Review averages were closely grouped, approximately **3.57–3.72**. Google contributed the largest share of reviews, while platform averages differed only modestly.
- The exploratory monthly revenue/average-rating correlation was approximately **-0.079**. The result indicates little linear association in this dataset; it does not show that guest sentiment has no effect on sales.

## Checks to resolve before stronger claims

1. **Trading duplicate keys:** 60 rows are flagged as sharing a site/date/shift key, while 30 are flagged as exact duplicates. Inspect value-level groups and recalculate a sensitivity version before relying on totals or rankings.
2. **Revenue definition:** confirm how VAT, discounts, promotions, service charge and tips are represented.
3. **Like-for-like monthly comparison:** adjust totals for trading days or compare average revenue per eligible trading day.
4. **Attribution:** a monthly revenue drop does not establish refurbishment or another operational cause without source notes or corroborating evidence.
5. **Rating volume:** show review counts beside averages, particularly for sparse site/platform/month groups.

## Publication note

The SQL scripts contain no saved query output or row-level examples. Public releases should continue to omit raw files, guest text, embedded Power BI data and named-site detail unless the data owner has confirmed that publication is appropriate.
