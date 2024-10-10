/* We have an interesting dataset in AWS S3 that contains the downloads of Python packages
(as tracked by the PyPI repository). It's a massive dataset with billions of rows, 
but we are only going to focus on 4 months of data 
from 2023 that are contained in the following Parquet file in S3:*/

-- Retreive the names of columns and types

DESCRIBE s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/pypi/2023/pypi_0_7_34.snappy.parquet');

--query that returns only the first 10 rows of this file
SELECT * 
FROM s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/pypi/2023/pypi_0_7_34.snappy.parquet')
LIMIT (10);

--The total number of rows in the file?
SELECT COUNT(*)
FROM s3('https://datasets-documentation.s3.eu-west-3.amazonaws.com/pypi/2023/pypi_0_7_34.snappy.parquet')
LIMIT (10);

--table to store the PyPI data 
CREATE TABLE my_first_table
(
    timestamp DateTime,
    country_code String,
    url String,
    project String
)
ENGINE = MergeTree
PRIMARY KEY (timestamp)