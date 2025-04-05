USE windowFun

CREATE TABLE employee(
emp_id INT PRIMARY KEY,
name VARCHAR(50),
dept VARCHAR(50),
Salary INT
);

INSERT INTO employee
(emp_id,name,dept,Salary)
VALUES
(1,'Aditi','HR',40000),
(2,'Rohit','HR',50000),
(3,'Meena','IT',60000),
(4,'Suraj','IT',70000),
(5,'Anjali','IT',50000);

SELECT * FROM employee

-- Q1: Rank employees by salary within each department

SELECT name, salary, dept,
Rank() OVER (PARTITION BY dept ORDER BY Salary DESC) as Salary_Rank
FROM employee


-- Q3: Running total of salary within each department

SELECT name, salary, dept,
SUM(Salary) OVER (PARTITION BY dept ORDER BY salary) as running_salary
FROM employee

--  Q4: Show salary of next and previous employee (overall)

SELECT name, salary, dept,
LAG(salary) OVER (PARTITION BY dept ORDER BY salary) as previous_salary,
LEAD(salary) OVER (PARTITION BY dept ORDER BY salary) as next_salary
FROM employee

--  Q5: Find salary difference from previous employee

SELECT name,salary,dept,
Salary - LEAD(Salary) OVER (ORDER BY Salary) as differ_salary
FROM employee

# Another DATASET - Sales DataSet

SELECT * FROM sales

-- Q1: Add a row number to each order sorted by order_date

SELECT *, 
ROW_NUMBER() OVER (ORDER BY order_date) as Row_num
FROM sales

-- Q2: Rank orders within each region by sales_amount

SELECT *,
RANK() OVER (PARTITION BY region ORDER BY Sales_amount DESC) as Rank_by_Date
FROM sales

--  Q3: Calculate the running total of sales_amount across all orders

SELECT *,
SUM(sales_amount) OVER (ORDER BY sales_amount DESC) as running_total
FROM Sales

-- Q4: Find the previous order's sales amount (overall)

SELECT *,
LAG(sales_amount) OVER (ORDER BY Order_date) AS Previous_sales
FROM Sales

-- Q5: Get next order's (order_date) for each row

SELECT *,
LEAD(order_date) OVER (ORDER BY Order_date) AS Next_order
FROM Sales

-- Q6: Show total sales per region on each row using SUM() OVER()

SELECT *,
SUM(sales_amount) OVER (PARTITION BY region) as total_Sales
From sales

-- 🧠 Window Function Practice — Set 2

-- Q1. Show each order and the total number of orders made by that customer

SELECT *,
COUNT(order_id) OVER (PARTITION BY Customer_id) as Total_order_Each_Customer
FROM sales

-- Q2. Show each order and the average sale amount within the same region

SELECT *,
AVG(Sales_amount) OVER (PARTITION BY region) AS Avg_order
From Sales

-- Q3. Show orders where the sales amount is greater than the previous order's (ordered by order_date)

SELECT * FROM sales

-- Q4. Show each order with the difference between its sales and the average sales for its region

SELECT *,
sales_amount- AVG(Sales_amount) OVER (PARTITION BY Region) as Avg_diffence
FROM Sales

-- Q5. Show the percentile rank of each sale amount

SELECT *,
PERCENT_RANK() OVER (ORDER BY Sales_amount) AS percentile_rank
FROM Sales

-- Q6. For each region, show the highest and lowest sale amount

SELECT *,
MIN(Sales_Amount) OVER (PARTITION BY region) as Low_sales,
MAX(Sales_Amount) OVER (PARTITION BY region) as High_sales
From Sales

--  Q7. For each customer, show the gap (days) between their current and previous orders

SELECT *, 
DATEDIFF(order_date, LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date)) AS gap_days
FROM sales;






