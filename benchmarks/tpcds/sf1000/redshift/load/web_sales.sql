copy web_sales
from
    's3://bench-dataset/tpcds/sf1000/web_sales/' iam_role default GZIP DELIMITER '|' EMPTYASNULL REGION 'us-east-1';