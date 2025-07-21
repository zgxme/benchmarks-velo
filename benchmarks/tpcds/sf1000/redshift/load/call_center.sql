copy call_center
from
    's3://bench-dataset/tpcds/sf1000/call_center/' iam_role default GZIP DELIMITER '|' EMPTYASNULL REGION 'us-east-1';
