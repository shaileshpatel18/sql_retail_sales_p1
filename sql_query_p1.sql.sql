-- create table as sql_project_02 - 
CREATE DATABASE sql_project_02;


-- create table as retail_sales - 

DROP TABLE If EXISTS retail_sales;
CREATE TABLE retail_sales(

			 transactions_id INT PRIMARY KEY,
             sale_date DATE,	
             sale_time	TIME,
             customer_id INT, 
             gender	VARCHAR(6),
             age INT,
             category VARCHAR(11),	
             quantiy INT,
             price_per_unit	INT,
             cogs INT,
             total_sale INT 
             );
             
-- see the table -
SELECT * FROM retail_sales;

-- data cleaning process -
SELECT * FROM retail_sales 
WHERE 
   transactions_id IS NULL
   OR 
   sale_date IS NULL
   OR 
   sale_time IS NULL
   OR 
   customer_id IS NULL
   OR 
   gender IS NULL
   OR 
   age IS NULL
   OR 
   category IS NULL
   OR 
   quantiy IS NULL
   OR 
   price_per_unit IS NULL
   OR 
   cogs IS NULL
   OR 
   total_sale IS NULL;
   
-- DELETE THE NULL DATA -
DELETE FROM retail_sales 
WHERE 
   transactions_id IS NULL
   OR 
   sale_date IS NULL
   OR 
   sale_time IS NULL
   OR 
   customer_id IS NULL
   OR 
   gender IS NULL
   OR 
   age IS NULL
   OR 
   category IS NULL
   OR 
   quantiy IS NULL
   OR 
   price_per_unit IS NULL
   OR 
   cogs IS NULL
   OR 
   total_sale IS NULL;

SELECT * FROM retail_sales;

-- how many sales we have -
SELECT count(*) as total_sales FROM retail_sales;

-- how many uniuque customer we have - 

SELECT COUNT( distinct customer_id ) as uniuque_customers FROM retail_sales;


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE
	category = 'Clothing'
    AND
    YEAR(sale_date)= 2022
    AND
    MONTH(sale_date)= 11 
    AND
    quantiy >=4 ;
    
-- the mistake i did is  i wrote quantity = quantiy - 

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
	category,
    sum(total_sale) as net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1 ;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
    round(AVG(age),2) as avg_age_of_customers
FROM retail_sales
WHERE 
	category = 'Beauty';
    
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
* 
FROM retail_sales
WHERE 
	total_sale >1000;
    

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select
    category,
    gender,
    count(*) as total_orders
FROM retail_sales
GROUP BY 
	category,
    gender
ORDER BY 1;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


SELECT 
      YEAR,
      MONTH,
      avg_sale 
FROM
(
		SELECT
			EXTRACT(YEAR FROM sale_date) as year,
			EXTRACT(MONTH FROM sale_date) as month,
			AVG(total_sale) AS avg_sale,
			RANK()  OVER(partition by extract( YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS sale_rank
		FROM retail_sales
		group by 1,2 
) AS T1
WHERE sale_rank = 1;

-- done -

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
	customer_id,
    SUM(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc 
LIMIT 5 ;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,
    COUNT(DISTINCT customer_id) as uniuque_id
from retail_sales
group by 1 ;



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17
WITH hourly_sale
AS
(
SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
	    ELSE 'evening'
	END AS shift
from retail_sales
)
SELECT 
	shift,
    COUNT(*) AS total_order
FROM hourly_sale
GROUP BY 1 ;

-- End of Project --


