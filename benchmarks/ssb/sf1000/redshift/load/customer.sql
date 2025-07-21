copy customer
from
    's3://bench-dataset/ssb/sf1000/customer/' iam_role default GZIP DELIMITER '|' REGION 'us-east-1';