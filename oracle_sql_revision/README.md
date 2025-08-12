## WOW Things in ORACLEs SQL or PLSQL
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

## Remove Duplicates

Here are **simple and clear ways to delete duplicate rows in SQL**, with examples anyone can understand. Let's say you have a table called `people` like this:

```sql
id | name  | age
---|-------|-----
1  | John  | 25
2  | John  | 25
3  | Alice | 30
4  | Bob   | 22
5  | Bob   | 22
```

You want to **remove duplicates** based on `name` and `age`, and **keep only one copy**.

### ✅ Method 1: Using `ROW_NUMBER()` (Best for modern databases)

This method gives each duplicate a number and deletes all except the first.

```sql
WITH numbered AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY name, age ORDER BY id) AS rn
  FROM people
)
DELETE FROM people
WHERE id IN (
  SELECT id FROM numbered WHERE rn > 1
);
```

**Explanation:**
- `ROW_NUMBER()` gives each duplicate a number.
- `PARTITION BY name, age` means duplicates are based on those columns.
- Only rows with number > 1 are deleted.

### ✅ Method 2: Using `DELETE` with `JOIN` (Good for MySQL)

```sql
DELETE p1 FROM people p1
JOIN people p2
ON p1.name = p2.name AND p1.age = p2.age AND p1.id > p2.id;
```

**Explanation:**
- This compares each row with others.
- If two rows have same `name` and `age`, it deletes the one with the bigger `id`.

### ✅ Method 3: Using `GROUP BY` and `MIN(id)`

```sql
DELETE FROM people
WHERE id NOT IN (
  SELECT MIN(id)
  FROM people
  GROUP BY name, age
);
```

**Explanation:**
- `GROUP BY name, age` finds duplicates.
- `MIN(id)` keeps the first one.
- Deletes all others.

### ✅ Method 4: Create a new table with unique rows

```sql
CREATE TABLE new_people AS
SELECT DISTINCT name, age FROM people;

DROP TABLE people;

RENAME TABLE new_people TO people;
```

**Explanation:**
- Makes a new table with no duplicates.
- Deletes the old one.
- Renames the new one.

### ✅ Method 5: Use `DISTINCT` to copy unique rows

```sql
INSERT INTO new_people (name, age)
SELECT DISTINCT name, age FROM people;
```

**Explanation:**
- Copies only unique rows into another table.

### 🛡️ Tips Before Deleting
- Always run a `SELECT` first to **see what will be deleted**.
- Make a **backup** of your table if possible.
- Choose the method that works best for your database (MySQL, PostgreSQL, SQL Server, etc.).

---

## Real World Example

1. **Create a table with duplicates**
2. **View duplicates**
3. **Delete duplicates using different methods**

### 🧪 Step 1: Create a sample table

```sql
CREATE TABLE people (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  age INT
);

INSERT INTO people (id, name, age) VALUES
(1, 'John', 25),
(2, 'John', 25),
(3, 'Alice', 30),
(4, 'Bob', 22),
(5, 'Bob', 22);
```

### 👀 Step 2: View duplicates

To see duplicates based on `name` and `age`:

```sql
SELECT name, age, COUNT(*) as count
FROM people
GROUP BY name, age
HAVING COUNT(*) > 1;
```

### 🧹 Step 3: Delete duplicates

#### ✅ Method 1: Using `ROW_NUMBER()` (works in PostgreSQL, SQL Server, Oracle)

```sql
WITH numbered AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY name, age ORDER BY id) AS rn
  FROM people
)
DELETE FROM people
WHERE id IN (
  SELECT id FROM numbered WHERE rn > 1
);
```

#### ✅ Method 2: Using `DELETE` with `JOIN` (works in MySQL)

```sql
DELETE p1 FROM people p1
JOIN people p2
ON p1.name = p2.name AND p1.age = p2.age AND p1.id > p2.id;
```

#### ✅ Method 3: Using `GROUP BY` and `MIN(id)`

```sql
DELETE FROM people
WHERE id NOT IN (
  SELECT MIN(id)
  FROM people
  GROUP BY name, age
);
```

### ✅ Method 4: Create a new table with unique rows

```sql
CREATE TABLE new_people AS
SELECT DISTINCT name, age FROM people;

DROP TABLE people;

RENAME TABLE new_people TO people;
```
