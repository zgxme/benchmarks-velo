INSERT INTO income_band (ib_income_band_sk, ib_lower_bound, ib_upper_bound) SELECT * FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpcds_sf1000/income_band*.*",
    "format" = "csv",
    "s3.endpoint" = "https://oss-cn-beijing-internal.aliyuncs.com",
    "s3.region" = "oss-cn-beijing-internal",
    "column_separator" = "|"
);

