## Collections
One can create `TYPE` explicitly such as,
```sql
CREATE OR REPLACE TYPE type_name
IS RECORD/VARRAY(size)
[OF data_type]
```
Where `OF data_type` is only for `VARRAY` - Variable Sized Array.
