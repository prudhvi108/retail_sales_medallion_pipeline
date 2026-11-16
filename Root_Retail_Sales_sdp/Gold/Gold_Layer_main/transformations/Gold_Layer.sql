


-- GOLD: DATA QUALITY SUMMARY


CREATE OR REFRESH MATERIALIZED VIEW gold_data_quality_summary
COMMENT 'Data quality summary: row counts across pipeline layers'
AS

SELECT
  'Bronze (raw)' AS layer,
  'Raw records from CSV' AS description,
  COUNT(*) AS row_count
FROM cs_bronze_sales

UNION ALL

SELECT
  'Silver (clean)' AS layer,
  'Valid, deduplicated records' AS description,
  COUNT(*) AS row_count
FROM cs_silver_sales;



CREATE OR REPLACE MATERIALIZED VIEW gold_monthly_sales_trends
COMMENT 'Gold layer: Monthly sales and profit trends over time'
AS
SELECT
  date_trunc('year', order_date) AS order_year,
  date_trunc('month', order_date) AS order_month,
  count(order_id) AS order_count,
  sum(sales) AS total_sales,
  sum(profit) AS total_profit,
  avg(sales) AS avg_sales,
  sum(quantity) AS total_quantity
FROM cs_silver_sales
GROUP BY ALL;