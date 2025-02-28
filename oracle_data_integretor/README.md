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

-- or simpler approach!
CREATE USER ODI_Master IDENTIFIED BY odi_master;
CREATE USER ODI_Work IDENTIFIED BY odi_work;

GRANT DBA TO ODI_Master;
GRANT DBA TO ODI_Work;
-- run line-by-line
```
- Run the above code to create your own schema!
- Login and create a Master repo connection using `Master repo connection wizard` and under the `topology -> repositories -> work repository` create a new work repo with required credentials, use the `ODI_Work` schema.
