INSERT INTO store (s_store_sk, s_store_id, s_rec_start_date, s_rec_end_date, s_closed_date_sk, s_store_name, s_number_employees, s_floor_space, s_hours, s_manager, s_market_id, s_geography_class, s_market_desc, s_market_manager, s_division_id, s_division_name, s_company_id, s_company_name, s_street_number, s_street_name, s_street_type, s_suite_number, s_city, s_county, s_state, s_zip, s_country, s_gmt_offset, s_tax_precentage) SELECT * FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpcds_sf100/store_1_64.dat",
    "format" = "csv",
    "s3.endpoint" = "${DORIS_S3_ENDPOINT:-https://oss-cn-beijing.aliyuncs.com}",
    "s3.region" = "${DORIS_S3_REGION:-oss-cn-beijing}",
    "column_separator" = "|"
);


