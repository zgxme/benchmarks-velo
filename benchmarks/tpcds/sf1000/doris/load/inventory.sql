INSERT INTO inventory (inv_date_sk, inv_item_sk, inv_warehouse_sk, inv_quantity_on_hand) SELECT * FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpcds_sf1000/inventory*.*",
    "format" = "csv",
    "s3.endpoint" = "https://oss-cn-beijing-internal.aliyuncs.com",
    "s3.region" = "oss-cn-beijing-internal",
    "column_separator" = "|"
);

