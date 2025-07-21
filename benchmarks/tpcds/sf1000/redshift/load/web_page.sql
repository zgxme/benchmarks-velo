copy web_page
from
    's3://bench-dataset/tpcds/sf1000/web_page/' iam_role default GZIP DELIMITER '|' EMPTYASNULL REGION 'us-east-1';