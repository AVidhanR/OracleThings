-- GROUP BY usage wrt. ORDER BY
SELECT TO_CHAR(hire_date, 'Mon') AS month_name, 
       COUNT(employee_id) AS employee_count
FROM hr.employees
GROUP BY TO_CHAR(hire_date, 'Mon'), TO_CHAR(hire_date, 'MM')
ORDER BY TO_CHAR(hire_date, 'MM');

-- inner query
SELECT employee_id, first_name, job_id, salary
FROM hr.employees
WHERE salary IN (
    SELECT MAX(salary) FROM hr.employees
);

SELECT department_id, department_name, manager_id
FROM hr.departments
WHERE location_id IN (
    SELECT location_id FROM hr.locations 
    WHERE country_id = 'US'
);

-- nested query
SELECT employee_id, first_name, job_id, salary
FROM hr.employees
WHERE department_id IN (
    SELECT department_id FROM hr.departments
    WHERE location_id IN (
    	SELECT location_id FROM hr.locations 
    	WHERE state_province = 'Texas'
    )
);

-- or use ALL()
SELECT job_id, SUM(salary) AS total_sal, COUNT(employee_id) AS no_emp
FROM hr.employees
GROUP BY job_id
HAVING MAX(employee_id) >= ALL(
    SELECT COUNT(employee_id)
    FROM hr.employees
);
