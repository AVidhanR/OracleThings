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
