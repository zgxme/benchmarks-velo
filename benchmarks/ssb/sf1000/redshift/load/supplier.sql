copy supplier
from
    's3://bench-dataset/ssb/sf1000/supplier/' iam_role default GZIP DELIMITER '|'  REGION 'us-east-1';