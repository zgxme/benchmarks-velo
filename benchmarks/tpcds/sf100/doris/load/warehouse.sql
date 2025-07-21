INSERT INTO warehouse (w_warehouse_sk, w_warehouse_id, w_warehouse_name, w_warehouse_sq_ft, w_street_number, w_street_name, w_street_type, w_suite_number, w_city, w_county, w_state, w_zip, w_country, w_gmt_offset) SELECT * FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpcds_sf100/warehouse*.*",
    "format" = "csv",
    "s3.endpoint" = "${DORIS_S3_ENDPOINT:-https://oss-cn-beijing.aliyuncs.com}",
    "s3.region" = "${DORIS_S3_REGION:-oss-cn-beijing}",
    "column_separator" = "|"
);


