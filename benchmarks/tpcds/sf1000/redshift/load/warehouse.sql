copy warehouse
from
    's3://bench-dataset/tpcds/sf1000/warehouse/' iam_role default GZIP DELIMITER '|' EMPTYASNULL REGION 'us-east-1';