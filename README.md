# E-Commerce Operations Performance Analysis

Analyzing e-commerce logistics data to evaluate On-Time Delivery (OTD) performance, identify delay root causes, and surface actionable insights for operational improvement.

---

## Project Overview

This project performs an end-to-end analysis of delivery operations across a warehouse network. Raw transactional data is cleaned in Excel, KPIs are computed via SQL (BigQuery), and results are published through an interactive Tableau dashboard.

The analysis answers three core questions:
- **Where** are delays happening — warehouse and route level
- **Why** delays are occurring — root cause frequency breakdown
- **Who** is most affected — by order priority and time period

---

## Tools & Technologies

- **SQL (BigQuery)** — data extraction, cleaning, KPI computation
- **Microsoft Excel** — preprocessing, pivot summaries, KPI consolidation
- **Tableau** — interactive dashboard and visualization

---

## Dashboard Preview

<img width="1838" height="806" alt="E-Commerce dashboard_overview png" src="https://github.com/user-attachments/assets/ea2dd604-3500-4092-9a5c-31b7c17f3ba5" />

---
##  tableau link
[tableau](https://public.tableau.com/app/profile/jai.siddharth/vizzes)

---
## Key Findings

**Overall OTD rate is 51.67%** — nearly half of all orders experience delays, indicating significant operational inefficiency across the network.

- Warehouse **W4 has the highest delay rate (~60%)**, making it the primary target for process improvement
- **Traffic congestion** and **warehouse backlog** are the top two delay drivers across all warehouses
- Delivery performance fluctuates between **25% and 76% OTD** over time, suggesting demand spikes outpace capacity planning
- **High-priority orders carry a ~54% delay rate** — the fulfillment process does not currently differentiate handling by order priority

---

## Project Structure

```
ecommerce-otd-analysis/
│
├── data/
│   ├── OTD_Case_Study_raw_data.xlsx          # Raw transactional delivery dataset
│   └── Overall-KPIs-OTD_case_study.xlsx      # Consolidated KPI output for Tableau
│
├── sql/
│   └── kpi_analysis.sql                      # OTD rate, delay breakdown, time-series KPIs
│
├── dashboard/
│   └── E-Commerce Logistics Performance.twbx # Tableau packaged workbook
│
├── images/
│   └── E-Commerce dashboard_overview.png     # Dashboard screenshot
│
└── README.md
```

---

## SQL Logic

`sql/kpi_analysis.sql` computes:

- OTD rate segmented by warehouse, date, and order priority
- Delay reason frequency and percentage share
- Time-series delivery performance for trend analysis

```sql
-- OTD Rate by Warehouse
SELECT
    warehouse_id,
    COUNT(*)                                                                 AS total_orders,
    SUM(CASE WHEN delivery_status = 'On Time' THEN 1 ELSE 0 END)            AS on_time_orders,
    ROUND(
        SUM(CASE WHEN delivery_status = 'On Time' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    )                                                                        AS otd_rate_pct
FROM delivery_data
GROUP BY warehouse_id
ORDER BY otd_rate_pct ASC;
```

---

## Data Pipeline

```
Raw Data (Excel)
    └── Clean & preprocess → flag on-time vs. delayed records

Cleaned Data → BigQuery (SQL)
    └── Compute KPIs → export aggregated output to Excel

KPI Dataset → Tableau
    └── Build interactive dashboard
```

---

## KPI Summary

| Metric | Value |
|---|---|
| Overall OTD Rate | 51.67% |
| Worst Warehouse (Delay Rate) | W4 — ~60% |
| Top Delay Reasons | Traffic, Warehouse Backlog |
| OTD Range Over Time | 25% – 76% |
| High-Priority Delay Rate | ~54% |

---

## Business Impact

| Area | Action Enabled |
|---|---|
| Warehouse Operations | Prioritize W4 for process audit and staffing review |
| Delay Mitigation | Route optimization to reduce traffic-related delays |
| Priority Fulfillment | Redesign SLA handling for high-priority order tiers |
| Capacity Planning | Use trend data to pre-staff during peak demand windows |

---

## Future Improvements

-  Real-time dashboard connected to a live BigQuery feed
-  Predictive delay model using classification (logistic regression / XGBoost)
-  Automated ETL pipeline via dbt or Airflow
-  Carrier-level delay breakdown for third-party accountability
-  Geospatial mapping of delay hotspots by delivery route

---

## Author

**Jai.Siddharth.G** — [LinkedIn](https://www.linkedin.com/in/jai-siddharth/) · [Portfolio](https://public.tableau.com/app/profile/jai.siddharth/vizzes)
