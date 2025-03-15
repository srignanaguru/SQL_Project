select * from retail_sales;

select * from retail_sales limit 20;

select count(*) from retail_sales;

select * from retail_sales where transaction_id is null;

--Finding null values
select * from retail_sales where age is null or sale_time is null or gender is null or category is null or quantity is null or price_per_unit is null or cogs is null or total_sale is null or sale_date is null;

--Data Cleaning

--Removing all the null values
delete from retail_sales where age is null or sale_time is null or gender is null or category is null or quantity is null or price_per_unit is null or cogs is null or total_sale is null or sale_date is null;

select * from retail_sales;

select count(*) from retail_sales;

--Data Exploration

select count(*) as total_sales from retail_sales; 

select count(distinct(customer_id)) as cust_count from retail_sales;

select count(distinct(category)) as category_count from retail_sales;

select distinct(category) as category_names from retail_sales;

--Data Analaysis

--Specific Date Sales
select * from retail_sales where sale_date='2022-11-05';

--Specific Category and Month and quantity sales is greater or equal than 4
select * from retail_sales where category='Clothing' and to_char(sale_date,'YYYY-MM')='2022-11' and quantity>=4;

-- Calculate total sales from each category
select category, sum(total_sale) from retail_sales group by category;

--Average age of beauty category customers rounded by 2
select round(avg(age),2) as avg_age from retail_sales where category='Beauty';

--Transaction id which total_sale is greater than one thousand
select transaction_id, total_sale from retail_sales where total_sale>1000;

--Each gender transaction_id of category
select count(transaction_id),category,gender from retail_sales group by 2,3 order by 1;

--Calculate avg sale for each month and find out best selling month
select * from 
(select extract (year from sale_date) as year,
 extract (month from sale_date) as month, 
 avg(total_sale) as avg_sale, 
 rank() over(partition by extract (year from sale_date) order by avg(total_sale) desc) 
 from retail_sales group by 1,2) as t1 where rank=1;

-- Top 5 customer based on total sale
select customer_id, sum(total_sale) as total_sale from retail_sales group by 1 order by total_sale desc limit 5;

--Unique customer from each category
select count(distinct(customer_id)) as Unique_cust, category from retail_sales group by 2;

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


