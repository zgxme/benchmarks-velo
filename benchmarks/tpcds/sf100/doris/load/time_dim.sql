INSERT INTO time_dim (t_time_sk, t_time_id, t_time, t_hour, t_minute, t_second, t_am_pm, t_shift, t_sub_shift, t_meal_time) SELECT * FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpcds_sf100/time_dim*.*",
    "format" = "csv",
    "s3.endpoint" = "${DORIS_S3_ENDPOINT:-https://oss-cn-beijing.aliyuncs.com}",
    "s3.region" = "${DORIS_S3_REGION:-oss-cn-beijing}",
    "column_separator" = "|"
);


