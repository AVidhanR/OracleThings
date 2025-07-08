-- getting the next and the prev sal of each employess within there repective departments
SELECT
    e.first_name,
    e.last_name,
    e.salary, (
       SELECT department_name 
       FROM departments d
       WHERE d.department_id = e.department_id
    ) AS department_name,
    LEAD(e.salary, 1, 0) OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary
    ) AS employees_next_salary,
    LAG(e.salary) OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary
    ) AS employees_previous_salary
FROM employees e;

-- get the salary ranking with RANK(), DENSE_RANK() and a small demo of ROW_NUMBER()
-- ranking is with respect to the each department window
SELECT
    e.first_name || ' ' || e.last_name AS full_name,
    e.salary, (SELECT
        department_name
        FROM departments
        WHERE e.department_id = department_id
    ) AS department_name,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY e.salary DESC
    ) AS salary_ranking,
    DENSE_RANK() OVER (
        PARTITION BY department_id
        ORDER BY e.salary DESC
    ) AS dense_salary_ranking,
    ROW_NUMBER() OVER (
        PARTITION BY department_id
        ORDER BY e.salary DESC
    ) AS row_num
FROM employees e
WHERE e.salary >= 5000
ORDER BY row_num, e.salary DESC;

-- divides the output into defined number of tiles based on the "window"
-- mentioned here it is according to the salary
SELECT
  employee_id,
  first_name,
  last_name,
  salary,
  NTILE(4) OVER (
    ORDER BY salary DESC
  ) AS salary_quartile 
FROM      
  employees;

-- FIRST_VALUE() and LAST_VALUE() functions are used to get the first and last value in a window. No example is provided here, but you can use them similarly to LEAD() and LAG() functions.

-- great article for understanding window functions: https://medium.com/@hisyam126/oracle-sql-window-functions-0114899572c4
