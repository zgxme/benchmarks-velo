INSERT INTO household_demographics (hd_demo_sk, hd_income_band_sk, hd_buy_potential, hd_dep_count, hd_vehicle_count) SELECT * FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpcds_sf1000/household_demographics*.*",
    "format" = "csv",
    "s3.endpoint" = "https://oss-cn-beijing-internal.aliyuncs.com",
    "s3.region" = "oss-cn-beijing-internal",
    "column_separator" = "|"
);
