CREATE DATABASE Windowfun
USE Windowfun

SELECT * FROM employeeswin

-- To change Column name 
ALTER TABLE employeeswin
CHANGE COLUMN `ï»¿employee_id`  `employee_id` INT; 

-- Q1: Assign a Row Number to Each Employee in Their Department Based on Salary (Highest First)

SELECT employee_id , name, department, salary,
      ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) As Row_num
From employeeswin

-- Q2: Rank Employees in Each Department by Salary (Handling Ties)

SELECT employee_id, name, department, salary,
      RANK() OVER (PARTITION BY department ORDER BY salary DESC) As Rank_num
From employeeswin

-- Q3: Calculate the Running Total Salary for Each Department

SELECT employee_id, name, department, salary,
      SUM(salary) OVER (PARTITION BY department ORDER BY join_date) As Runing_total
From employeeswin

-- Q4: Find the Highest Salary Within Each Department

SELECT employee_id, name, department, salary,
      Max(salary) OVER (PARTITION BY department) As High_Salary
From employeeswin

-- Q5: Find the First Employee Who Joined in Each Department

SELECT employee_id, name, department, join_date,
      FIRST_VALUE(name) OVER (PARTITION BY department ORDER BY Join_date) As First_Employee
From employeeswin

-- Q6: Find the Salary Difference Between Each Employee and the Highest Salary in Their Department

SELECT employee_id, name, department, salary,
    MAX(salary) OVER (PARTITION BY department) - salary AS salary_diff
FROM employeeswin;


-- Q7 Find the Difference Between Each Employee’s Salary and the Average Salary of Their Department

SELECT AVG(salary) FROM employeeswin

SELECT employee_id, name, department, salary,
       salary - AVG(salary) OVER (PARTITION BY department) As salary_difference
FROM employeeswin

-- Q8. Rank Employees Based on Their Joining Date in Each Department

SELECT employee_id, name, department, join_date,
       RANK() OVER (PARTITION BY department ORDER BY join_date) AS Joining_Rank
FROM employeeswin

-- Q9. Assign a Unique ID to Each Employee Across All Departments Based on Salary (Descending)

SELECT employee_id, name, department, salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS Uniuque_ID
FROM employeeswin

-- 10. Find the Employee Who Earns the Second-Highest Salary in Each Department

WITH RankedEmplyees AS (
       SELECT employee_id, name, department, salary,
	   Rank() OVER (PARTITION BY department ORDER BY salary DESC) AS Salary_Rank
       FROM employeeswin
)
SELECT * FROM RankedEmplyees WHERE Salary_Rank = 2

-- Q11: Find the Previous and Next Salary of Employees in Each Department

SELECT employee_id, name, department, salary,
       LAG(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS Previous_salary,
       LEAD(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS next_salary
FROM employeeswin

-- 12. Compare Each Employee’s Salary with the Previous and Next Employee’s Salary

SELECT employee_id, name, department, salary,
    LAG(salary) OVER (PARTITION BY department ORDER BY salary) AS previous_salary,
    LEAD(salary) OVER (PARTITION BY department ORDER BY salary) AS next_salary
FROM employeeswin;














