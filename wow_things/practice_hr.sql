-- 1) Retrieve the employee names in uppercase to standardize the reporting format.
SELECT UPPER(employee_name) 
    FROM hr.employees;

-- 2) Fetch employee first names in lowercase for email ID generation.
SELECT LOWER(first_name) 
    FROM hr.employees;

-- 3) Display employee first names with only the first letter capitalized (Title Case).
SELECT INITCAP(first_name) 
    FROM hr.employees;

-- 4) Extract the first three letters of each employee’s first name for department username creation.
SELECT SUBSTR(first_name, 1, 3) 
	FROM hr.employees;

-- 5) Retrieve employees whose last names contain the letter "A" in any position.
SELECT * FROM hr.employees 
    WHERE last_name LIKE '%A%';

-- 6) Replace 'Manager' with 'Lead' in the job title column for specific employees.
UPDATE hr.employees 
    SET job_title = REPLACE(job_title, 'Manager', 'Lead') 
    WHERE job_title LIKE '%Manager%';

-- 7) Retrieve employees hired in the last 6 months from the hire_date column.
SELECT * FROM hr.employees 
    WHERE hire_date >= ADD_MONTHS(SYSDATE, -6);

-- 8) Fetch the last working day of the current month for payroll processing.
SELECT LAST_DAY(SYSDATE) - 
    CASE 
    WHEN TO_CHAR(LAST_DAY(SYSDATE), 'DY') IN ('SAT', 'SUN') 
    THEN TO_CHAR(LAST_DAY(SYSDATE), 'D') - 6 
    ELSE 0 
    END AS last_working_day
FROM dual;

-- 9) Find employees whose hire date falls on a Monday for training batch scheduling.
SELECT * FROM hr.employees WHERE TO_CHAR(hire_date, 'DY') = 'MON';

-- 10) Calculate the number of months each employee has worked in the company.
SELECT employee_id, MONTHS_BETWEEN(SYSDATE, hire_date) AS months_worked 
    FROM hr.employees;

-- 11) Retrieve employees' salary rounded to the nearest thousand for budgeting purposes.
SELECT employee_id, ROUND(salary, -3) AS rounded_salary 
    FROM hr.employees;

-- 12) Find employees earning an odd salary amount using the MOD function.
SELECT * FROM hr.employees 
    WHERE MOD(salary, 2) <> 0;

-- 13) Display the salary without decimal values for a financial summary report.
SELECT employee_id, TRUNC(salary) AS truncated_salary 
    FROM hr.employees;

-- 14) Show employee commission, but if NULL, display "No Commission" instead using NVL.
SELECT employee_id, NVL(TO_CHAR(commission_pct), 'No Commission') AS commission 
    FROM hr.employees;

-- 15) Display 'Eligible for Bonus' if the commission is not NULL; otherwise, display "Not Eligible" using NVL2.
SELECT employee_id, 
    NVL2(commission_pct, 'Eligible for Bonus', 'Not Eligible') AS bonus_eligibility 
    FROM hr.employees;

-- 16) Classify employees based on their salary range.
SELECT employee_id, 
       CASE
           WHEN salary > 15000 THEN 'High Salary'
           WHEN salary BETWEEN 10000 AND 15000 THEN 'Medium Salary'
           ELSE 'Low Salary'
       END AS salary_range
FROM hr.employees;

-- 17) Determine bonus eligibility based on job title.
SELECT employee_id, 
       CASE 
           WHEN job_title = 'Manager' THEN salary * 0.20
           WHEN job_title = 'Sales' THEN salary * 0.15
           ELSE salary * 0.10
       END AS bonus
FROM hr.employees;

-- 18) Display experience level of employees based on hire date.
SELECT employee_id, 
       CASE 
           WHEN hire_date < TO_DATE('2005-01-01', 'YYYY-MM-DD') THEN 'Senior Employee'
           WHEN hire_date BETWEEN TO_DATE('2005-01-01', 'YYYY-MM-DD') AND TO_DATE('2015-12-31', 'YYYY-MM-DD') THEN 'Mid-Level Employee'
           ELSE 'Junior Employee'
       END AS experience_level
FROM hr.employees;

-- 19) Check if an employee is eligible for a commission.
SELECT employee_id, 
       CASE 
           WHEN commission_pct IS NULL THEN 'No Commission'
           ELSE 'Eligible for Commission'
       END AS commission_status
FROM hr.employees;

-- 20) Classify employees based on department.
SELECT employee_id, 
       CASE 
           WHEN department_id = (SELECT department_id FROM hr.departments WHERE department_name = 'IT_PROG') THEN 'Tech Team'
           WHEN department_id = (SELECT department_id FROM hr.departments WHERE department_name = 'AD_VP') THEN 'VP Team'
           ELSE 'Other Team'
       END AS department_team
FROM hr.employees;


----------------------------------- part 2


-- 1) Retrieve all employee details from the EMPLOYEES table.
SELECT * FROM hr.employees;

-- 2) Fetch the first name, last name, and salary of all employees in descending order of salary.
SELECT first_name, last_name, salary FROM hr.employees ORDER BY salary DESC;

-- 3) Get the department name and location of all departments from the DEPARTMENTS table.
SELECT department_name, location_id FROM hr.departments;

-- 4) Find the job titles available in the JOBS table.
SELECT job_title FROM hr.jobs;

-- 5) Fetch the details of employees whose salary is greater than $10,000.
SELECT * FROM hr.employees WHERE salary > 10000;

-- 6) List employees whose first name starts with 'A'.
SELECT * FROM hr.employees WHERE first_name LIKE 'A%';

-- 7) Retrieve employees who were hired after January 1, 2005.
SELECT * FROM hr.employees WHERE hire_date > TO_DATE('2005-01-01', 'YYYY-MM-DD');

-- 8) Get the total number of employees in each department.
SELECT department_id, COUNT(*) AS total_employees FROM hr.employees GROUP BY department_id;

-- 9) Calculate the average salary for each job title.
SELECT job_id, AVG(salary) AS average_salary FROM hr.employees GROUP BY job_id;

-- 10) List departments that have more than 5 employees.
SELECT department_id, COUNT(*) AS total_employees FROM hr.employees GROUP BY department_id HAVING COUNT(*) > 5;

-- 11) Retrieve employee names along with their department names.
SELECT e.first_name, e.last_name, d.department_name 
FROM hr.employees e 
JOIN hr.departments d ON e.department_id = d.department_id;

-- 12) Fetch employee names along with their job titles from the JOBS table.
SELECT e.first_name, e.last_name, j.job_title 
FROM hr.employees e 
JOIN hr.jobs j ON e.job_id = j.job_id;

-- 13) Get a list of employees along with their manager’s name.
SELECT e.first_name, e.last_name, m.first_name AS manager_first_name, m.last_name AS manager_last_name 
FROM hr.employees e 
LEFT JOIN hr.employees m ON e.manager_id = m.employee_id;

-- 14) Fetch employees along with their department and location.
SELECT e.first_name, e.last_name, d.department_name, l.city 
FROM hr.employees e 
JOIN hr.departments d ON e.department_id = d.department_id 
JOIN hr.locations l ON d.location_id = l.location_id;

-- 15) Retrieve the department name for employees earning more than $12,000.
SELECT e.first_name, e.last_name, d.department_name 
FROM hr.employees e 
JOIN hr.departments d ON e.department_id = d.department_id 
WHERE e.salary > 12000;

-- 16) Retrieve employees who earn more than the average salary of the company.
SELECT * FROM hr.employees WHERE salary > (SELECT AVG(salary) FROM hr.employees);

-- 17) Find employees who have the same salary as employee_id=101.
SELECT * FROM hr.employees WHERE salary = (SELECT salary FROM hr.employees WHERE employee_id = 101);

-- 18) Get the list of employees who work in the same department as employee_id=200.
SELECT * FROM hr.employees WHERE department_id = (SELECT department_id FROM hr.employees WHERE employee_id = 200);

-- 19) Fetch the highest-paid employee details.
SELECT * FROM hr.employees WHERE salary = (SELECT MAX(salary) FROM hr.employees);

-- 20) List employees who earn less than the department’s average salary.
SELECT * FROM hr.employees e 
WHERE salary < (SELECT AVG(salary) FROM hr.employees WHERE department_id = e.department_id);

SELECT * FROM hr.employees;
