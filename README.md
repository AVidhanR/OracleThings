## Oracle PL/SQL 
- One can learn `Oracle PL/SQL` if they have a basic experience in any programming language.
- It is easy to understand the syntaxes and experiment on the `SQL` tables using this Procedural Language.

<!-- Current repo directory structure:
```txt
Directory structure:
└── avidhanr-oraclepl-sql/
    ├── README.md
    ├── LICENSE
    ├── 01_intro/
    │   └── hello_world.sql
    ├── 02_variables/
    │   ├── bind_variables.sql
    │   ├── scalar_vars.sql
    │   ├── type_attribute.sql
    │   └── variable_scope.sql
    ├── 03_control_structures/
    │   ├── basic_loop.sql
    │   ├── case_expr.sql
    │   ├── continue_stt.sql
    │   ├── for_loop.sql
    │   ├── goto_stt.sql
    │   ├── if_ctrl_structure.sql
    │   ├── nested_loops.sql
    │   └── while_loop.sql
    ├── 04_sql_in_plsql/
    │   ├── README.md
    │   ├── delete_demo.sql
    │   ├── insert_demo.sql
    │   ├── select_demo.sql
    │   ├── sequence_demo.sql
    │   └── update_demo.sql
    ├── 05_composite_data_types/
    │   ├── README.md
    │   ├── associative_arrays.sql
    │   ├── associative_arrays_with_rec.sql
    │   ├── associative_arrays_with_table.sql
    │   ├── dml_with_records.sql
    │   ├── nested_tables.sql
    │   ├── records.sql
    │   ├── records_demo.sql
    │   └── varrays.sql
    ├── 06_storing_collections_in_tables/
    │   ├── using_nested_tables.sql
    │   └── using_varrays.sql
    ├── 07_cursors/
    │   ├── cursor_attributes.sql
    │   ├── cursor_demo.sql
    │   ├── cursor_for_update.sql
    │   ├── cursors_loops.sql
    │   ├── cursors_records.sql
    │   └── cursors_with_parameters.sql
    └── wow_things/
        └── amazing.sql
```
-->
## Cheat Sheet for myself
1. `ORDER BY` clause
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
2. `SELECT DISTINCT` statement
```sql
SELECT DISTINCT column_1
FROM table;
```
3. Oracle `FETCH` clause syntax
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
* Oracle `BETWEEN DATES`
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
* Escape characters in `LIKE` operator
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
4. 
- Learning from `Udemy` and able to practice parallel coding in the `PL/SQL`
- I'm using Oracle Live SQL web editor, I know it's not preferrable but situation demands; access the `Oracle Live SQL` from [here](https://livesql.oracle.com/ords/f?p=590:1000)
- Created & Maintained by [AVidhanR](https://linkedin.com/in/AVidhanR)
