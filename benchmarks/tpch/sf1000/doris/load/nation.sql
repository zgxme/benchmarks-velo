INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) SELECT c1, c2, c3, c4 FROM S3(
    "uri" = "s3://qa-build/performance/data/tpch_sf1000/nation.tbl.gz",
    "format" = "csv",
    "s3.endpoint" = "https://oss-cn-beijing-internal.aliyuncs.com",
    "s3.region" = "oss-cn-beijing-internal",
    "column_separator" = "|",
    "skip_lines" = "0"
);