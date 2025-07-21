INSERT INTO ship_mode (sm_ship_mode_sk, sm_ship_mode_id, sm_type, sm_code, sm_carrier, sm_contract) SELECT * FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpcds_sf1000/ship_mode*.*",
    "format" = "csv",
    "s3.endpoint" = "https://oss-cn-beijing-internal.aliyuncs.com",
    "s3.region" = "oss-cn-beijing-internal",
    "column_separator" = "|"
);


