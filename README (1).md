# Retail Sales Analysis using SQL

## Project Overview

**Project Title:** Retail Sales Analysis  
**Database:** `sql_project_02`

This project demonstrates SQL skills used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing data cleaning, exploratory data analysis (EDA), and answering specific business questions through SQL queries. It is designed for beginners who want to strengthen their SQL foundation by working on a real-world style dataset.

## Objectives

1. **Set up a retail sales database:** Create and populate a retail sales table with the given dataset.
2. **Data Cleaning:** Identify and remove records with missing or null values.
3. **Exploratory Data Analysis (EDA):** Perform basic exploration to understand the dataset.
4. **Business Analysis:** Use SQL to answer specific business questions and derive insights from the sales data.

## Database Structure

The database `sql_project_02` contains a single table `retail_sales` with the following schema:

| Column Name        | Data Type    | Description                        |
|---------------------|--------------|-------------------------------------|
| transactions_id     | INT (PK)     | Unique transaction identifier       |
| sale_date           | DATE         | Date of the sale                    |
| sale_time           | TIME         | Time of the sale                    |
| customer_id         | INT          | Unique customer identifier          |
| gender              | VARCHAR(6)   | Gender of the customer              |
| age                 | INT          | Age of the customer                 |
| category            | VARCHAR(11)  | Product category                    |
| quantiy             | INT          | Quantity of items sold              |
| price_per_unit      | INT          | Price per unit of the item          |
| cogs                | INT          | Cost of goods sold                  |
| total_sale          | INT          | Total sale amount                   |

```sql
CREATE TABLE retail_sales(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(6),
    age INT,
    category VARCHAR(11),
    quantiy INT,
    price_per_unit INT,
    cogs INT,
    total_sale INT
);
```

## Data Cleaning

Before analysis, the dataset was checked for null/missing values across all columns, and rows containing nulls in any critical field were removed to ensure data integrity.

```sql
DELETE FROM retail_sales
WHERE
    transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR
    customer_id IS NULL OR gender IS NULL OR age IS NULL OR
    category IS NULL OR quantiy IS NULL OR price_per_unit IS NULL OR
    cogs IS NULL OR total_sale IS NULL;
```

## Exploratory Data Analysis (EDA)

Basic exploration was performed to understand the dataset size and diversity:

- **Total Sales Count:** Number of total transactions in the dataset.
- **Unique Customers:** Number of distinct customers who made purchases.
- **Product Categories:** Unique categories present in the dataset.

## Business Questions & Analysis

The following key business questions were answered using SQL:

1. Retrieve all sales made on a specific date (`2022-11-05`).
2. Retrieve all transactions where the category is `Clothing` and quantity sold is more than 10 in November 2022.
3. Calculate the total sales and total orders for each category.
4. Find the average age of customers who purchased items from the `Beauty` category.
5. Find all transactions where the total sale is greater than 1000.
6. Find the total number of transactions made by each gender in each category.
7. Calculate the average sale for each month and identify the best-selling month of each year.
8. Find the top 5 customers based on the highest total sales.
9. Find the number of unique customers who purchased items from each category.
10. Categorize orders into shifts (Morning, Afternoon, Evening) and count total orders in each shift.

### Example Query — Best Selling Month per Year

```sql
SELECT year, month, avg_sale
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS sale_rank
    FROM retail_sales
    GROUP BY 1, 2
) AS t1
WHERE sale_rank = 1;
```

### Example Query — Orders by Shift

```sql
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY 1;
```

## Key Findings

- The dataset spans multiple product categories with varying sales performance.
- Sales trends differ by month, helping identify peak selling seasons.
- Customer demographics (age, gender) show purchasing patterns across categories.
- Orders are distributed across different times of day (Morning, Afternoon, Evening), useful for staffing and inventory planning.

## Tools & Technologies Used

- **SQL (MySQL)** — for database creation, data cleaning, and analysis
- **Window Functions & CTEs** — used for advanced analysis (ranking, shift categorization)

## How to Use

1. Clone this repository.
2. Import the dataset into a MySQL server.
3. Run `sql_query_p1.sql` to create the database, table, clean the data, and execute all analysis queries.
4. Review the query results to explore the insights.

## Author

This project was created as part of a SQL learning and portfolio-building exercise, focusing on practical, real-world data analysis using SQL.

---

*Feel free to fork this repository, explore the queries, and suggest improvements!*
