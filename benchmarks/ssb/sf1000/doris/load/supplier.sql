INSERT INTO supplier (s_suppkey,s_name,s_address,s_city,s_nation,s_region,s_phone) SELECT c1, c2, c3, c4, c5, c6, c7 FROM S3 (
    "uri" = "s3://qa-build/performance/data/ssb_sf1000/supplier.tbl",
    "format" = "csv",
    "s3.endpoint" = "https://oss-cn-beijing-internal.aliyuncs.com",
    "s3.region" = "oss-cn-beijing-internal",
    "column_separator" = "|",
    "skip_lines" = "0"
);