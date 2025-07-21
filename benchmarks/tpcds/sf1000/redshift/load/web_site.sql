copy web_site
from
    's3://bench-dataset/tpcds/sf1000/web_site/' iam_role default GZIP DELIMITER '|' EMPTYASNULL REGION 'us-east-1';