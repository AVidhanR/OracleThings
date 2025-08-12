# IBM DB2 Query Usage Analysis (Q3 2023)

IBM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed by their employees. The objective is to generate data to populate a histogram that shows the number of unique queries run by employees during the third quarter of 2023 (July to September). Additionally, it should count the number of employees who did not run any queries during this period.

## 🎯 Objective

Display the number of unique queries as histogram categories, along with the count of employees who executed that number of unique queries.

## 📄 Schema

### `queries` Table

| Column Name     | Type      | Description                                      |
|------------------|-----------|--------------------------------------------------|
| employee_id      | integer   | The ID of the employee who executed the query.  |
| query_id         | integer   | The unique identifier for each query (Primary Key). |
| query_starttime  | datetime  | The timestamp when the query started.           |
| execution_time   | integer   | The duration of the query execution in seconds. |

#### Example Input (July 2023)

| employee_id | query_id | query_starttime       | execution_time |
|-------------|----------|------------------------|----------------|
| 226         | 856987   | 07/01/2023 01:04:43    | 2698           |
| 132         | 286115   | 07/01/2023 03:25:12    | 2705           |
| 221         | 33683    | 07/01/2023 04:34:38    | 91             |
| 240         | 17745    | 07/01/2023 14:33:47    | 2093           |
| 110         | 413477   | 07/02/2023 10:55:14    | 470            |

### `employees` Table

| Column Name  | Type     | Description                                |
|--------------|----------|--------------------------------------------|
| employee_id  | integer  | The ID of the employee who executed the query. |
| full_name    | string   | The full name of the employee.             |
| gender       | string   | The gender of the employee.                |

#### Example Input

| employee_id | full_name         | gender |
|-------------|-------------------|--------|
| 1           | Judas Beardon     | Male   |
| 2           | Lainey Franciotti | Female |
| 3           | Ashbey Strahan    | Male   |

## ✅ Example Output

| unique_queries | employee_count |
|----------------|----------------|
| 0              | 191            |
| 1              | 46             |
| 2              | 12             |
| 3              | 1              |

### 📝 Explanation

The output indicates that:
- 191 employees did not run any queries,
- 46 employees ran exactly 1 unique query,
- 12 employees ran 2 unique queries,
- 1 employee ran 3 unique queries.


### 🧮 SQL Query

```sql
with unique_queries_analytics as (
  select
    e.employee_id,
    count(q.query_id) as unique_queries
  from
    queries q right join employees e
    on (q.employee_id = e.employee_id) and 
    extract(year from q.query_starttime) = 2023 and 
    extract(month from q.query_starttime) in (7, 8, 9)
  group by e.employee_id
)
select  
  unique_queries,
  count(employee_id) as employee_count
from unique_queries_analytics
group by unique_queries
order by unique_queries asc;
```
