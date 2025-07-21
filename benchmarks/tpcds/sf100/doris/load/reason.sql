INSERT INTO reason (r_reason_sk, r_reason_id, r_reason_desc) SELECT * FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpcds_sf100/reason*.*",
    "format" = "csv",
    "s3.endpoint" = "${DORIS_S3_ENDPOINT:-https://oss-cn-beijing.aliyuncs.com}",
    "s3.region" = "${DORIS_S3_REGION:-oss-cn-beijing}",
    "column_separator" = "|"
);


