## Task

Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. 
Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.

### `employee` Schema:

| column_name   | type     | description                          |
|---------------|----------|--------------------------------------|
| employee_id   | integer  | The unique ID of the employee.       |
| name          | string   | The name of the employee.            |
| salary        | integer  | The salary of the employee.          |
| department_id | integer  | The department ID of the employee.   |
| manager_id    | integer  | The manager ID of the employee.      |

### `employee` Example Input:

| employee_id | name             | salary | department_id | manager_id |
|-------------|------------------|--------|---------------|------------|
| 1           | Emma Thompson    | 3800   | 1             | 6          |
| 2           | Daniel Rodriguez | 2230   | 1             | 7          |
| 3           | Olivia Smith     | 2000   | 1             | 8          |

### Example Output:

| second_highest_salary |
|-----------------------|
| 2230                  |

### Explanation

The output represents the second highest salary among all employees. In this case, the second highest salary is $2,230.

### 🧮 SQL Query

```sql
-- my approach
with shs as (
  select 
    nth_value(salary, 2) over (
      order by salary desc
    ) as second_highest_salary
  from employee
)
select distinct second_highest_salary
from shs
where second_highest_salary is not null;

-- simple approach 
with highest_salary as (
  select max(salary) as max_sal
  from employee
)
select max(salary) as second_highest_salary
from employee
where salary < (
  select max_sal
  from highest_salary
);
```
