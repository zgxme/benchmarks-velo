copy supplier
from
    's3://bench-dataset/tpch/sf1000/supplier/' iam_role default GZIP DELIMITER '|'  REGION 'us-east-1';
