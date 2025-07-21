copy into partsupp
from
    's3://bench-dataset/tpch/sf100/partsupp/' FILE_FORMAT = (
        TYPE = CSV,
        FIELD_DELIMITER = '|',
        ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE
    );