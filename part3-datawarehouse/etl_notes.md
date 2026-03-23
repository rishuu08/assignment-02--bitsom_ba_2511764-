# ETL Decisions

## Decision 1 — Standardized inconsistent date formats

Problem:  
The raw dataset contained multiple date formats such as `DD/MM/YYYY`, `DD-MM-YYYY`, and `YYYY-MM-DD`. This would create issues while joining with the date dimension and while running monthly analysis.

Resolution:  
I converted all date values into a single standard format: `YYYY-MM-DD`. After standardization, I generated a numeric `date_key` in the format `YYYYMMDD` for use in the star schema.


## Decision 2 — Standardized category names

Problem:  
The `category` column had inconsistent values such as `electronics`, `Electronics`, `Grocery`, and `Groceries`. These inconsistencies would split the same business category into multiple groups during reporting.

Resolution:  
I cleaned and standardized category values into consistent names:

- `electronics` → `Electronics`

- `Groceries` → `Grocery`

This ensured accurate category-level aggregation in analytical queries.

## Decision 3 — Resolved NULL store_city values

Problem:  
Some rows had NULL values in the `store_city` column, which would create incomplete store dimension records.

Resolution:  
I filled missing `store_city` values by using the known mapping from `store_name`:

- `Chennai Anna` → `Chennai`
- `Delhi South` → `Delhi`
- `Bangalore MG` → `Bangalore`
- `Pune FC Road` → `Pune`
- `Mumbai Central` → `Mumbai`

This allowed the store dimension to remain complete and consistent.