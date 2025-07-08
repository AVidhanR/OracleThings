-- getting the next and the prev sal of each employess within there repective departments
SELECT
    e.first_name,
    e.last_name,
    e.salary, (
       SELECT department_name 
       FROM departments d
       WHERE d.department_id = e.department_id
    ) AS department_name,
    LEAD(e.salary) OVER (
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

-- great article for understanding window functions: https://medium.com/@hisyam126/oracle-sql-window-functions-0114899572c4
