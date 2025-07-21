copy into partsupp from 's3://bench-dataset/tpch/sf1000/partsupp/' FILE_FORMAT =(TYPE = CSV, COMPRESSION = GZIP, FIELD_DELIMITER = '|', ERROR_ON_COLUMN_COUNT_MISMATCH=FALSE);
