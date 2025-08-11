In Oracle SQL, **you cannot use `RANK(expr)`** like a regular function. Instead, `RANK`, `DENSE_RANK`, and `ROW_NUMBER` are **analytic functions** that **must** be used with the `OVER()` clause.

### 🔹 Why `RANK(expr)` Doesn't Work

Unlike scalar functions (like `UPPER(expr)` or `ROUND(expr)`), analytic functions operate **over a set of rows** and require a **windowing clause** to define how the ranking should be calculated.

So this is **invalid**:
```sql
SELECT RANK(salary) FROM employees; -- ❌ Not allowed
```

This is the **correct usage**:
```sql
SELECT 
  employee_id,
  salary,
  RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
```

### 🔸 What Does `OVER()` Do?

The `OVER()` clause defines:
- **Partitioning**: Optional grouping of rows (like `PARTITION BY department_id`)
- **Ordering**: Required for ranking functions (like `ORDER BY salary DESC`)

Example with partitioning:
```sql
SELECT 
  employee_id,
  department_id,
  salary,
  RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM employees;
```

This ranks employees **within each department** based on salary.

### Custom example using `products_v` table
The below query selects data from a view or table called products_v, and for each product, 
it calculates two types of rankings based on the price in descending order:

```sql
SELECT 
    product_name,
    DENSE_RANK() OVER (ORDER BY price DESC) as price_dense_rank,
    RANK() OVER (ORDER BY price DESC) as price_rank,
    price
FROM    
    products_v;
```

Output: (In JSON for understanding purposes)
```json
[
  {
    "product_name": "IPad",
    "price_dense_rank": 1,
    "price_rank": 1,
    "price": 30000
  },
  {
    "product_name": "TV",
    "price_dense_rank": 2,
    "price_rank": 2,
    "price": 20000
  },
  {
    "product_name": "Laptop",
    "price_dense_rank": 3,
    "price_rank": 3,
    "price": 1200
  },
  {
    "product_name": "Powerbank",
    "price_dense_rank": 3,
    "price_rank": 3,
    "price": 1200
  },
  {
    "product_name": "Monitor",
    "price_dense_rank": 4,
    "price_rank": 5,
    "price": 300
  },
  {
    "product_name": "Headphones",
    "price_dense_rank": 5,
    "price_rank": 6,
    "price": 100
  },
  {
    "product_name": "Keyboard",
    "price_dense_rank": 6,
    "price_rank": 7,
    "price": 75
  },
  {
    "product_name": "Webcam",
    "price_dense_rank": 7,
    "price_rank": 8,
    "price": 50
  },
  {
    "product_name": "Mouse",
    "price_dense_rank": 8,
    "price_rank": 9,
    "price": 25
  }
]
```
