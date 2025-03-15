# Retail Sales Analysis SQL Project

## Project Overview

Project Title: Retail Sales Analysis  
Database: sql_project_p0

This project is designed to demonstrate SQL skills and techniques used by data analysts to explore, clean, and analyze the retail sales data. Also it involves setting up a retail sales database, performing exploratory data analysis(EDA), and producing specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

**Objectives**

1. Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
2. Data Cleaning: Identify and remove any records with missing or null values.
3. Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
4. Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

**Project Structure**

**1. Database Setup**

 Database Creation: The project starts by creating a database named `sql_project_p0`.
 Table Creation: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_p0;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

**2. Data Exploration & Cleaning**

1. Record Count: Determine the total number of records in the dataset.
2. Customer Count: Find out how many unique customers are in the dataset.
3. Category Count: Identify all unique product categories in the dataset.
4. Null Value Check: Check for any null values in the dataset and delete records with missing data.

```sql
select * from retail_sales;

select * from retail_sales limit 20;

select count(*) from retail_sales;

select * from retail_sales where transaction_id is null;

--Finding null values
select * from retail_sales 
	where 
		age is null or sale_time is null or gender is null or category is null or
		quantity is null or price_per_unit is null or cogs is null or total_sale is null
		or sale_date is null;

--Data Cleaning

--Removing all the null values
delete from retail_sales 
	where age is null or sale_time is null or gender is null or category is null
	or quantity is null or price_per_unit is null or cogs is null or total_sale is null
	or sale_date is null;

```

**3. Data Analysis & Findings**

The following SQL queries were developed to answer specific business questions:

1. Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
--Specific Date Sales
select * from retail_sales where sale_date='2022-11-05';
```

2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
```sql
--Specific Category and Month and quantity sales is greater or equal than 4
select * from retail_sales where category='Clothing' and to_char(sale_date,'YYYY-MM')='2022-11' and quantity>=4;
```

3. Write a SQL query to calculate the total sales (total_sale) for each category:
```sql
-- Calculate total sales from each category
select category, sum(total_sale) from retail_sales group by category;

```

4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
```sql
--Average age of beauty category customers rounded by 2
select round(avg(age),2) as avg_age from retail_sales where category='Beauty';
```

5. Write a SQL query to find all transactions where the total_sale is greater than 1000:
```sql
--Transaction id which total_sale is greater than one thousand
select transaction_id, total_sale from retail_sales where total_sale>1000;
```

6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
```sql
--Each gender transaction_id of category
select count(transaction_id),category,gender from retail_sales group by 2,3 order by 1;
```

7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
```sql
--Calculate avg sale for each month and find out best selling month
select * from 
(select extract (year from sale_date) as year,
 extract (month from sale_date) as month, 
 avg(total_sale) as avg_sale, 
 rank() over(partition by extract (year from sale_date) order by avg(total_sale) desc) 
 from retail_sales group by 1,2) as t1 where rank=1;
```

8. Write a SQL query to find the top 5 customers based on the highest total sales :
```sql
-- Top 5 customer based on total sale
select customer_id, sum(total_sale) as total_sale from retail_sales group by 1 order by total_sale desc limit 5;
```

9. Write a SQL query to find the number of unique customers who purchased items from each category:
```sql
--Unique customer from each category
select count(distinct(customer_id)) as Unique_cust, category from retail_sales group by 2;
```

10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
```sql
--Shift based works of the customers
with cte as(
select *,
	case 
		when extract(hour from sale_time)<12 then 'Morning Shift'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon Shift'
		else 'Evening Shift'
	end as shift
from retail_sales)

--Total transaction from each shift
select count(transaction_id) as total_orders,shift from cte group by shift;
```

**Findings**
1. Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
2. High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
3. Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
4. Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

**Reports**

1. Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
2. Trend Analysis: Insights into sales trends across different months and shifts.
3. Customer Insights: Reports on top customers and unique customer counts per category.

**Conclusion**

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


