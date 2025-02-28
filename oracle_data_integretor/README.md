## ODI
* Let's see the structure of the `ODI` Graphical Modules
```txt
ODI Studio

```
---
- Under the System Schema, In order to create a new user or Schema use the below code
- Here, username or schema name is `ODI_Demo` and password is `odi_demo`
```sql
CREATE USER ODI_Demo IDENTIFIED BY odi_demo
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA 20M ON users;

GRANT DBA TO odi_demo;

SELECT
    username,
    account_status
FROM
    dba_users
WHERE
    username = 'ODI_Demo';
```
- Run the above code to create your own schema!
