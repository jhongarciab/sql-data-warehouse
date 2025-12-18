-- Explore all objects and columns in the DB
SELECT * FROM information_schema.tables WHERE table_schema IN ('bronze', 'silver', 'gold');
SELECT * FROM information_schema.columns WHERE table_schema IN ('bronze', 'silver', 'gold');

-- Explore the categories
SELECT DISTINCT country FROM gold.dim_customers;
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products ORDER BY category;

-- Explore the date timespan of the order date
SELECT 
    MIN(order_date) AS first_order_date, 
    MAX(order_date) AS last_order_date,
    -- Days
    MAX(order_date) - MIN(order_date) AS total_days,
    -- Months
    (EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12)
    + EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))) AS total_months,
    -- Years
    EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) AS total_years
FROM gold.fact_sales;

-- Explore the youngest and oldest customers
SELECT 
    MIN(birthdate) AS oldest_customer_birthdate,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, MIN(birthdate))) AS age_oldest_customer,
    MAX(birthdate) AS youngest_customer_birthdate,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, MAX(birthdate))) AS age_youngest_customer
FROM gold.dim_customers;

-- Measure exploration
SELECT 'Total Sales Amount' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity Sold' AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' AS measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Products Sold' AS measure_name, COUNT(DISTINCT product_name) AS measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Customers' AS measure_name, COUNT(customer_key) AS measure_value FROM gold.dim_customers;

-- Magnitud Analysis
SELECT 
    country,
    gender, COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY country, gender ORDER BY country;

SELECT
    category,
    COUNT(product_key) AS total_products
FROM gold.dim_products
GROUP BY category ORDER BY total_products DESC;

SELECT
    category,
    AVG(cost) AS avg_cost
FROM gold.dim_products
GROUP BY category ORDER BY avg_cost DESC;

SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;

SELECT 
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_customers c 
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
    ORDER BY total_revenue DESC;

SELECT
    c.country,
    SUM(f.quantity) AS total_sold_items
FROM gold.fact_sales f 
LEFT JOIN gold.dim_customers c 
    ON c.customer_key = f.customer_key
GROUP BY
    c.country
ORDER BY total_sold_items DESC;

-- Ranking Analysis
SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue
LIMIT 5;