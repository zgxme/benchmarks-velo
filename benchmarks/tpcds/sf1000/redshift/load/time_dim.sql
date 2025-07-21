copy time_dim
from
    's3://bench-dataset/tpcds/sf1000/time_dim/' iam_role default GZIP DELIMITER '|' EMPTYASNULL REGION 'us-east-1';