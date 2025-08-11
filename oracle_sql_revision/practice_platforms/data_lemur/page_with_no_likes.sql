/*
## 📘 Facebook Pages with Zero Likes

### 🧾 Problem Statement
Given two tables — `pages` and `page_likes` — identify the Facebook pages that have **zero likes**.  
Return the `page_id`s of such pages, sorted in **ascending order**.

---

### 🗃️ Tables

#### `pages`

| Column Name | Type     |
|-------------|----------|
| page_id     | integer  |
| page_name   | varchar  |

#### `page_likes`

| Column Name | Type     |
|-------------|----------|
| user_id     | integer  |
| page_id     | integer  |
| liked_date  | datetime |

---

### 🧪 Example Input

#### `pages`

| page_id | page_name             |
|---------|------------------------|
| 20001   | SQL Solutions          |
| 20045   | Brain Exercises        |
| 20701   | Tips for Data Analysts |

#### `page_likes`

| user_id | page_id | liked_date           |
|---------|---------|----------------------|
| 111     | 20001   | 04/08/2022 00:00:00  |
| 121     | 20045   | 03/12/2022 00:00:00  |
| 156     | 20001   | 07/25/2022 00:00:00  |

---

### 📤 Expected Output

| page_id |
|---------|
| 20701   |

**Explanation**:  
Page `20701` has no entries in the `page_likes` table, indicating it has zero likes.
*/

with liked_pages_ids as (
  select page_id
  from page_likes
)
select page_id
from pages
where page_id not in (
  select * from liked_pages_ids
);
