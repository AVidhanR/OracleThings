## Collections
One can create `TYPE` for `RECORD` or `VARRAY` explicitly such as,
```sql
CREATE OR REPLACE TYPE type_name
IS RECORD(
    <mention_specific_types>
    emp_id hr.employees.employee_id%TYPE
);
```
For `VARRAY`
```sql
CREATE OR REPLACE TYPE type_name
IS VARRAY(size)
OF data_type;
```
Where `OF data_type` is only for `VARRAY` - Variable Sized Array.
Drop a `TYPE` for example,
```sql
DROP TYPE type_name;
```

## `Associate Arrays` v `VArrays`
- The most doubted topic I've ever got into my mind. In Oracle PL/SQL, **Arrays** and **Varrays (Variable-size Arrays)** are both types of collections, but they differ in structure, usage, and limitations. Here's a breakdown of the key differences:


### 🔹 **Arrays (Associative Arrays / Index-by Tables)**

- **Type**: Unbounded, sparse collection.
- **Indexing**: Can be indexed by either integers or strings (depending on declaration).
- **Declaration**:
  ```plsql
  TYPE arr_type IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
  ```
- **Storage**: Exists only in PL/SQL memory (not stored in the database).
- **Flexibility**: Can have gaps in indexing (sparse).
- **Use Case**: Ideal for temporary in-memory data structures, like lookup tables or caches.

### 🔹 **Varrays (Variable-size Arrays)**

- **Type**: Bounded, dense collection.
- **Indexing**: Indexed by consecutive integers starting from 1.
- **Declaration**:
  ```plsql
  TYPE varray_type IS VARRAY(10) OF VARCHAR2(100);
  ```
- **Storage**: Can be stored in database columns and used in SQL.
- **Flexibility**: Fixed maximum size; cannot exceed the declared limit.
- **Use Case**: Suitable for small, fixed-size collections that need to be stored in the database.


### 🔸 Summary Table

| Feature              | Associative Array         | Varray                     |
|----------------------|---------------------------|----------------------------|
| Index Type           | Integer or String         | Integer (1 to N)           |
| Size                 | Unbounded                 | Bounded (fixed max size)   |
| Sparse/Dense         | Sparse                    | Dense                      |
| SQL Usage            | Not usable in SQL         | Usable in SQL              |
| Storage              | PL/SQL memory only        | Can be stored in DB        |
| Flexibility          | High                      | Limited by max size        |
