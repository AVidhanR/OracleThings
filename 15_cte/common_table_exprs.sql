-- The below data is for practice purposes only.
-- Create Department Table
CREATE TABLE departments_v (
    department_id   NUMBER PRIMARY KEY,
    department_name VARCHAR2(100)
);

-- Insert Sample Departments
INSERT INTO departments_v (department_id, department_name) VALUES (10, 'Sales');
INSERT INTO departments_v (department_id, department_name) VALUES (20, 'Marketing');
INSERT INTO departments_v (department_id, department_name) VALUES (30, 'IT');
INSERT INTO departments_v (department_id, department_name) VALUES (40, 'HR');

-- Create Employees Table
CREATE TABLE employees_v (
    employee_id   NUMBER PRIMARY KEY,
    employee_name VARCHAR2(100),
    department_id NUMBER,
    salary        NUMBER,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES departments_v (department_id)
);

-- Insert Sample Employees
INSERT INTO employees_v (employee_id, employee_name, department_id, salary) VALUES (1, 'Alice', 10, 60000);
INSERT INTO employees_v (employee_id, employee_name, department_id, salary) VALUES (2, 'Bob', 10, 75000);
INSERT INTO employees_v (employee_id, employee_name, department_id, salary) VALUES (3, 'Chuck', 20, 50000);
INSERT INTO employees_v (employee_id, employee_name, department_id, salary) VALUES (4, 'David', 20, 55000);
INSERT INTO employees_v (employee_id, employee_name, department_id, salary) VALUES (5, 'Eve', 30, 90000);
INSERT INTO employees_v (employee_id, employee_name, department_id, salary) VALUES (6, 'Frank', 30, 80000);
INSERT INTO employees_v (employee_id, employee_name, department_id, salary) VALUES (7, 'Grace', 10, 62000);
INSERT INTO employees_v (employee_id, employee_name, department_id, salary) VALUES (8, 'Heidi', 40, 70000);
INSERT INTO employees_v (employee_id, employee_name, department_id, salary) VALUES (9, 'Ivan', 40, 68000);

COMMIT;

-- Check the data
SELECT * FROM departments_v;
SELECT * FROM employees_v;

-- Query to find employees whose salary is above the average salary of their department
-- Using Common Table Expressions (CTE)
WITH dept_avg_salaries AS (
    SELECT
        d.department_id,
        d.department_name,
        AVG(e.salary) AS average_department_salary
    FROM
        departments_v d
        JOIN employees_v e ON d.department_id = e.department_id
    GROUP BY
        d.department_id,
        d.department_name
)
SELECT
    e.employee_name,
    d.department_name,
    e.salary,
    das.average_department_salary
FROM
    employees_v  e
    JOIN departments_v  d ON e.department_id = d.department_id
    JOIN dept_avg_salaries  das ON e.department_id = das.department_id
WHERE
    e.salary > das.average_department_salary
ORDER BY
    d.department_name,
    e.employee_name;