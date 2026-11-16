-- Bronze layer: Raw data ingestion
CREATE OR REFRESH STREAMING TABLE cs_bronze_table
(
    CONSTRAINT data_loaded EXPECT (OrderID IS NOT NULL)
)
COMMENT 'Bronze layer : Retail sales Data Ingestion'
AS
SELECT *,
    _metadata.file_path as source_file,
    current_timestamp() as ingested_at

FROM stream read_files("/Volumes/retail_sales_sdp/default/sales_volume/", format => 'CSV', header => 'true');
