INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) SELECT c1, c2, c3, c4, c5, c6, c7, c8 FROM S3 (
    "uri" = "s3://qa-build/performance/data/tpch_sf100/customer.tbl",
    "format" = "csv",
    "s3.endpoint" = "https://oss-cn-beijing-internal.aliyuncs.com",
    "s3.region" = "oss-cn-beijing-internal",
    "column_separator" = "|",
    "skip_lines" = "0"
);