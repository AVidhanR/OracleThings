## Task

Assume you are given the table below on Uber transactions made by users. 
Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

### `transactions` Table:

| Column Name       | Type      |
|-------------------|-----------|
| user_id           | integer   |
| spend             | decimal   |
| transaction_date  | timestamp |

### `transactions` Example Input:

| user_id | spend  | transaction_date       |
|---------|--------|------------------------|
| 111     | 100.50 | 01/08/2022 12:00:00    |
| 111     | 55.00  | 01/10/2022 12:00:00    |
| 121     | 36.00  | 01/18/2022 12:00:00    |
| 145     | 24.99  | 01/26/2022 12:00:00    |
| 111     | 89.60  | 02/05/2022 12:00:00    |

### Example Output:

| user_id | spend | transaction_date       |
|---------|-------|------------------------|
| 111     | 89.60 | 02/05/2022 12:00:00    |

### 🧮 SQL Query

```sql
-- my first brute force approach (not recommended at all!)
with ordered_transactions as (
  select  
    user_id,
    spend,
    transaction_date
  from transactions
  order by user_id, extract(month from transaction_date)
),
users_counter as (
  select
    user_id,
    count(user_id) as users_count
  from ordered_transactions
  group by user_id
),
three_transactioned_users as (
  select  
    user_id,
    spend,
    transaction_date
  from ordered_transactions ot
  where (
    select users_count
    from users_counter uc
    where uc.user_id = ot.user_id
  ) = 3
),
users_third_transaction as (
  select *
  from three_transactioned_users ttu
  where (
    select max(transaction_date)
    from ordered_transactions
    group by user_id
    having user_id = ttu.user_id
  ) = transaction_date
)
select *
from users_third_transaction;

-- the simplest approach 
with users_third_transaction as (
  select
    t.*,
    nth_value(user_id, 3) over (
      partition by user_id
      order by transaction_date
    ) as third_transaction
  from transactions t
)
select user_id, spend, transaction_date 
from users_third_transaction
where third_transaction is not null;
```

### Definition

The `NTH_VALUE` **analytic function** is available in both Oracle and PostgreSQL. 
It is a window function that retrieves the value of an expression from the nth row within an ordered set of rows in a partition (or the entire result set if no `PARTITION BY` clause is used). 

### Syntax: 
```sql
NTH_VALUE(expression, offset) 
OVER (
    [ PARTITION BY partition_expression ]
    ORDER BY sort_expression [ASC | DESC]
    [ frame_clause ]
)
```

### Key components: 

- expression: The column or expression from which the value is to be retrieved.
- offset: A positive integer indicating the row number (1-based) from which to retrieve the value.
- `PARTITION BY` clause: Divides the result set into partitions to which the NTH_VALUE function is applied independently.
- `ORDER BY` clause: Sorts the rows within each partition to determine the nth row.
- frame_clause: (Optional) Defines the subset of rows within the partition that the function considers. This is important for controlling how the nth value is determined, especially if the default frame (often RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) is not suitable for your needs. [1]  

### Functionality: 

`NTH_VALUE` is similar to `FIRST_VALUE` and `LAST_VALUE`, but it offers the flexibility to retrieve a value from any specific position within the defined window, not just the first or last. 
If the specified nth row does not exist within the window, the function returns `NULL`. 

[1] https://www.geeksforgeeks.org/postgresql/postgresql-nth_value-function/
