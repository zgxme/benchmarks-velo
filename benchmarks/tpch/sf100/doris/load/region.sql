INSERT INTO region (r_regionkey, r_name, r_comment) SELECT c1, c2, c3 FROM S3(
    "uri" = "s3://qa-build/performance/data/tpch_sf100/region.tbl",
    "format" = "csv",
    "s3.endpoint" = "https://oss-cn-beijing-internal.aliyuncs.com",
    "s3.region" = "oss-cn-beijing-internal",
    "column_separator" = "|",
    "skip_lines" = "0"
);