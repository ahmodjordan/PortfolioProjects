CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    date DATE,
    customer_id VARCHAR(10),
    gender VARCHAR(10),
    age INT,
    product_category VARCHAR(50),
    quantity INT,
    price_per_unit INT,
    total_amount INT
);



SELECT *
FROM retail_sales



-- Question 1: How does customer age and gender influence their purchasing behavior?

-- Calculate the average total amount spent by each age group and gender

SELECT
    CASE
        WHEN age >= 18 AND age < 30 THEN '18-29'
        WHEN age >= 30 AND age < 40 THEN '30-39'
        WHEN age >= 40 AND age < 50 THEN '40-49'
        ELSE '50+'
    END AS age_group, gender, AVG(total_amount) AS avg_purchase_amount
FROM retail_sales
GROUP BY age_group, gender
ORDER BY age_group, gender;



-- Question 2: Are there discernible patterns in sales across different time periods?

-- Calculate the total sale amounts for each month

SELECT
    EXTRACT(YEAR FROM date) AS sales_year,
    EXTRACT(MONTH FROM date) AS sales_month,
    SUM(total_amount) AS total_sales_amount
FROM retail_sales
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;



-- Question 3: Which product categories hold the highest appeal among customers?

-- Determine the most purchased product categories

SELECT
    product_category,
    SUM(total_amount) AS total_sales_amount
FROM retail_sales
GROUP BY product_category
ORDER BY total_sales_amount DESC;



-- Question 4: What are the relationships between age, spending, and product preferences? 

-- Analyze the relationship between customer age, spending, and product preferences

SELECT 
	age,
	product_category,
	AVG(total_amount) AS avg_spending
FROM retail_sales
GROUP BY age, product_category
ORDER BY age, avg_spending DESC;



-- Question 5: How do customers adapt their shopping habits during seasonal trends?

-- Calculate the total amount spent during different seasons

SELECT
    CASE
        WHEN EXTRACT(MONTH FROM date) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM date) IN (6, 7, 8) THEN 'Summer'
        WHEN EXTRACT(MONTH FROM date) IN (9, 10, 11) THEN 'Fall'
        WHEN EXTRACT(MONTH FROM date) IN (12, 1, 2) THEN 'Winter'
        ELSE 'Other'
    END AS season, product_category, SUM(total_amount) AS total_spent
FROM retail_sales
GROUP BY season, product_category
ORDER BY season, total_spent DESC;



-- Question 6: Are there distinct puchasing behaviors based on the number of items bought per transaction?

-- Analyze purchasing behavior based on the number of items per transaction

SELECT
    quantity AS items_per_transaction,
    COUNT(*) AS transaction_count,
    SUM(total_amount) AS total_spent
FROM retail_sales
GROUP BY items_per_transaction
ORDER BY items_per_transaction ASC;



-- Question 7: What insights cab be gleaned from the distribution of product prices within each category?

-- Analyzing insights from the distribution of product prices within each category

-- Analyzing insights from the distribution of product prices within each category

SELECT
    product_category,
    MIN(price_per_unit) AS min_price,
    MAX(price_per_unit) AS max_price,
    AVG(price_per_unit) AS avg_price
FROM retail_sales
GROUP BY product_category
ORDER BY product_category ASC;

