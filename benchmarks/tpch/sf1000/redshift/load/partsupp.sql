copy partsupp
from
    's3://bench-dataset/tpch/sf1000/partsupp/' iam_role default GZIP DELIMITER '|'  REGION 'us-east-1';
