## Oracle PL/SQL 
- One can learn `Oracle PL/SQL` if they have a basic experience in any programming language.
- It is easy to understand the syntaxes and experiment on the `SQL` tables using this Procedural Language.

## Cheat Sheet for Oracle `SQL`
### `ORDER BY` clause

```sql
SELECT
    column_1,
    column_2,
    column_3,
    ...
FROM
    table_name
ORDER BY
    {column_1 | col_1_pos} [ASC | DESC] [NULLS FIRST | NULLS LAST],
    {column_1 | col_2_pos} [ASC | DESC] [NULLS FIRST | NULLS LAST],
    ... 
```

### `SELECT DISTINCT` statement

```sql
SELECT DISTINCT column_1
FROM table;
```

### Oracle `FETCH` clause syntax

```sql
[ OFFSET offset ROWS]
 FETCH  NEXT [  row_count | percent PERCENT  ] ROWS  [ ONLY | WITH TIES ] 
```
```sql
-- example
SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC 
FETCH NEXT 5 ROWS ONLY;
```
### Oracle `BETWEEN DATES`

```sql
SELECT
    order_id,
    customer_id,
    status,
    order_date
FROM
    orders
WHERE
    order_date BETWEEN DATE '2016-12-01' AND DATE '2016-12-31'
ORDER BY
    order_date;
```
### Escape characters in `LIKE` operator

```sql
-- The following statement retrieves products that have a discount of 25%:
SELECT
	product_id,
	discount_message
FROM
	discounts
WHERE
	discount_message LIKE '%25!%%' ESCAPE '!';
```

### `ROLLUP` operator
* The ROLLUP operator in Oracle SQL is used to generate subtotals and grand totals in a result set. It is particularly useful in reporting and data analysis to summarize data at multiple levels of aggregation.
	* How `ROLLUP` Works \
	The ROLLUP operator creates a grouping hierarchy from the most detailed level to a grand total. It adds subtotals for each level of the hierarchy and a grand total at the end.
	```sql
	SELECT column1, column2, ..., aggregate_function(column)
	FROM table
	GROUP BY ROLLUP (column1, column2, ...);
	```

### Oracle `ANY` operator

```sql
SELECT
    *
FROM
    table_name
WHERE
    c > ANY (
        v1,
        v2,
        v3
    );

-- the below does the same thing as above

SELECT
    *
FROM
    table_name
WHERE
    c > v1
    OR c > v2
    OR c > v3;
```

### Oracle `ALL` operator

```sql
SELECT
    *
FROM
    table_name
WHERE
    c > ALL (
        v1,
        v2,
        v3
    );

--  transform the ALL operator

SELECT
    *
FROM
    table_name
WHERE
    c > v1
    AND c > v2
    AND c > v3;
```

###  Oracle `UNION` v `JOIN`
*  A UNION places a result set on top of another, meaning that it appends result sets vertically. However, a join such as INNER JOIN or LEFT JOIN combines result sets horizontally.

<div align="center"><img src="https://github.com/user-attachments/assets/c4e04c3c-94da-4680-9b44-a9b61b75c20d" width="500px" height="300px" /></div>

## Cheat Sheet for Oracle `PL/SQL`

## Quick go-through functions
- [String Functions](https://www.oracletutorial.com/oracle-string-functions/)
- [Date Functions](https://www.oracletutorial.com/oracle-date-functions/)
- [Comparision Functions](https://www.oracletutorial.com/oracle-comparison-functions/)
	- [Decode](https://www.oracletutorial.com/oracle-comparison-functions/oracle-decode/)	

- Learning from `Udemy` and able to practice parallel coding in the `PL/SQL`
- I'm using Oracle Live SQL web editor, I know it's not preferrable but situation demands; access the `Oracle Live SQL` from [here](https://livesql.oracle.com/ords/f?p=590:1000)
- Created & Maintained by [AVidhanR](https://linkedin.com/in/AVidhanR)
