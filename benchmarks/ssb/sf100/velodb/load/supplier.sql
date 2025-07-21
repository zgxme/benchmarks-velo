INSERT INTO supplier (
    s_suppkey,s_name,s_address,s_city,s_nation,s_region,s_phone
)
SELECT * FROM S3 (
        "uri" = "s3://bench-dataset/ssb/sf100/supplier/*",
        "format" = "csv",
        "s3.endpoint" = "https://s3.us-east-1.amazonaws.com",
        "s3.region" = "us-east-1",
        "column_separator" = "|",
        csv_schema = "s_suppkey:int;s_name:string;s_address:string;s_city:string;s_nation:string;s_region:string;s_phone:string",
        "compress_type"="gz"
);
