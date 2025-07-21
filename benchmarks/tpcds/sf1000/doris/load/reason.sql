INSERT INTO reason (r_reason_sk, r_reason_id, r_reason_desc) SELECT * FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpcds_sf1000/reason*.*",
    "format" = "csv",
    "s3.endpoint" = "https://oss-cn-beijing-internal.aliyuncs.com",
    "s3.region" = "oss-cn-beijing-internal",
    "column_separator" = "|"
);


