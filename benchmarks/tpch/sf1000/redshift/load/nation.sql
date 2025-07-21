copy nation
from
    's3://bench-dataset/tpch/sf1000/nation/' iam_role default GZIP DELIMITER '|'  REGION 'us-east-1';
