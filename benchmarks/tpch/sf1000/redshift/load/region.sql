copy region
from
    's3://bench-dataset/tpch/sf1000/region/' iam_role default GZIP DELIMITER '|'  REGION 'us-east-1';
