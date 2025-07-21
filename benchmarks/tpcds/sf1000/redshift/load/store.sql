copy store
from
    's3://bench-dataset/tpcds/sf1000/store/' iam_role default GZIP DELIMITER '|' EMPTYASNULL REGION 'us-east-1';