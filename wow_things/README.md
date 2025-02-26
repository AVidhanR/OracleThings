## WOW Things in SQL or PLSQL
* Using `patients` table and to practice visit [link](https://www.sql-practice.com/)
* The awesome things are added below:
```sql
SELECT first_name
FROM patients
WHERE
  first_name LIKE 'C%'
  OR (substr(first_name, 1, 1) = 'C');

--  simple things but, cannot get it on time
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

```
