SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'zepto';

-- Zepto E-Commerce Data Analytics Project
-- Tool: PostgreSQL (pgAdmin4)
-- Author: Srivalli Namburi

--------------------------------------------------
-- 1. View Raw Data
--------------------------------------------------
SELECT * FROM zepto LIMIT 10;

--------------------------------------------------
-- 2. Data Cleaning
--------------------------------------------------

-- Handle zero or NULL selling prices
UPDATE zepto
SET discountedsellingprice = NULL
WHERE discountedsellingprice = 0;

-- Create cleaned dataset (remove duplicates)
CREATE TABLE zepto_cleaned AS
SELECT DISTINCT *
FROM zepto;

--------------------------------------------------
-- 3. Exploratory Data Analysis (EDA)
--------------------------------------------------

-- Total products
SELECT COUNT(*) AS total_products
FROM zepto_cleaned;

-- Category-wise product count
SELECT category, COUNT(*) AS product_count
FROM zepto_cleaned
GROUP BY category
ORDER BY product_count DESC;

--------------------------------------------------
-- 4. Revenue Analysis
--------------------------------------------------

SELECT name AS product_name,
       SUM(discountedsellingprice * availablequantity) AS total_revenue
FROM zepto_cleaned
GROUP BY name
ORDER BY total_revenue DESC;

--------------------------------------------------
-- 5. Stock Performance
--------------------------------------------------

-- Low stock products
SELECT name AS product_name, availablequantity
FROM zepto_cleaned
WHERE availablequantity < 10
ORDER BY availablequantity;

--------------------------------------------------
-- 6. Business Insights
--------------------------------------------------

-- High-demand but low-stock items
SELECT name AS product_name, availablequantity, discountedsellingprice
FROM zepto_cleaned
WHERE availablequantity < 10
ORDER BY discountedsellingprice DESC;


