INSERT INTO partsupp SELECT c1, c2, c3, c4, c5 FROM S3 (
        "uri" = "s3://bench-dataset/tpch/sf100/partsupp/*",
        "format" = "csv",
        "s3.endpoint" = "https://s3.us-east-1.amazonaws.com",
        "s3.region" = "us-east-1",
        "column_separator" = "|"
);