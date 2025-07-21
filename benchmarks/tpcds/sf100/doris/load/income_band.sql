INSERT INTO income_band (ib_income_band_sk, ib_lower_bound, ib_upper_bound) SELECT * FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpcds_sf100/income_band*.*",
    "format" = "csv",
    "s3.endpoint" = "${DORIS_S3_ENDPOINT:-https://oss-cn-beijing.aliyuncs.com}",
    "s3.region" = "${DORIS_S3_REGION:-oss-cn-beijing}",
    "column_separator" = "|"
);

