copy lineorder
from
    's3://bench-dataset/ssb/sf1000/lineorder/' iam_role default GZIP DELIMITER '|'  REGION 'us-east-1';