## 🧾 Well Paid Employees

### 🧠 Problem Statement
As an HR Analyst, identify all employees who earn **more than their direct managers**.  
Return the **employee ID** and **employee name**.

### 🗃️ Table: `employee`

| Column Name   | Type     | Description                                      |
|---------------|----------|--------------------------------------------------|
| employee_id   | integer  | The unique ID of the employee                    |
| name          | string   | The name of the employee                         |
| salary        | integer  | The salary of the employee                       |
| department_id | integer  | The department ID of the employee                |
| manager_id    | integer  | The manager ID of the employee                   |

### 🧪 Example Input

| employee_id | name             | salary | department_id | manager_id |
|-------------|------------------|--------|---------------|------------|
| 1           | Emma Thompson    | 3800   | 1             | 6          |
| 2           | Daniel Rodriguez | 2230   | 1             | 7          |
| 3           | Olivia Smith     | 7000   | 1             | 8          |
| 4           | Noah Johnson     | 6800   | 2             | 9          |
| 5           | Sophia Martinez  | 1750   | 1             | 11         |
| 6           | Liam Brown       | 13000  | 3             | NULL       |
| 7           | Ava Garcia       | 12500  | 3             | NULL       |
| 8           | William Davis    | 6800   | 2             | NULL       |

### 📤 Expected Output

| employee_id | employee_name |
|-------------|----------------|
| 3           | Olivia Smith   |

**Explanation**:
- Olivia Smith earns \$7000  
- Her manager, William Davis, earns \$6800  
- Therefore, Olivia earns more than her manager

### 🧮 SQL Query

```sql
select
  e1.employee_id,
  e1.name as empoyee_name
from employee e1 inner join employee e2
on e1.manager_id = e2.employee_id
where e1.salary > e2.salary;
```
