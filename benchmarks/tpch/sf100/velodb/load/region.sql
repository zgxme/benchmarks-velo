INSERT INTO region SELECT c1, c2, c3 FROM S3 (
        "uri" = "s3://bench-dataset/tpch/sf100/region/*",
        "format" = "csv",
        "s3.endpoint" = "https://s3.us-east-1.amazonaws.com",
        "s3.region" = "us-east-1",
        "column_separator" = "|"
);