
/* We have about 2.3M crypto prices in a Parquet file in S3. 
In this lab, you are going to query this file without ingesting
the data into a ClickHouse table
*/
--Step 1:
SELECT * FROM url('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet', 'Parquet')
LIMIT(100);

--Step 3:
SELECT formatReadableQuantity(COUNT()) FROM 
url('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet', 'Parquet')

--Step 4
-- calculate average volume of Bitcoin trades
SELECT round(avg(volume)) as avg_volume FROM 
url('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet', 'Parquet')
WHERE
    crypto_name = 'Bitcoin';
-- result 26071469

--Step 5:
SELECT
    crypto_name,
    count() AS count
FROM s3('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet')
GROUP BY crypto_name
ORDER BY crypto_name;

/*
OR
SELECT COUNT(DISTINCT crypto_name) AS unique_crypto_count
FROM url('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet', 'Parquet')*/

--Step 6
SELECT TRIM(crypto_name) AS crypto_name, COUNT(*) AS trade_count
FROM url('https://learnclickhouse.s3.us-east-2.amazonaws.com/datasets/crypto_prices.parquet', 'Parquet')
GROUP BY crypto_name
ORDER BY crypto_name DESC;
--result of last row= zzz.finance	75