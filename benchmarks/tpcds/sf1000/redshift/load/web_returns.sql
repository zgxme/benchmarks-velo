copy web_returns
from
    's3://bench-dataset/tpcds/sf1000/web_returns/' iam_role default GZIP DELIMITER '|' EMPTYASNULL REGION 'us-east-1';