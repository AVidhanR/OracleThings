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