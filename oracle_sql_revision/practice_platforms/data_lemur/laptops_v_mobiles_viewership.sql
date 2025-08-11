/*
## 📱💻 Viewership by Device Type

### 🧾 Problem Statement
Given a table `viewership` that records user activity by device type, calculate:
- The total number of views from **laptops** (`laptop_views`)
- The total number of views from **mobile devices** (`mobile_views`), where mobile includes both **tablets** and **phones**

### 🗃️ Table: `viewership`

| Column Name | Type     |
|-------------|----------|
| user_id     | integer  |
| device_type | string   | ('laptop', 'tablet', 'phone')
| view_time   | timestamp|

### 🧪 Example Input

| user_id | device_type | view_time           |
|---------|-------------|---------------------|
| 123     | tablet      | 01/02/2022 00:00:00 |
| 125     | laptop      | 01/07/2022 00:00:00 |
| 128     | laptop      | 02/09/2022 00:00:00 |
| 129     | phone       | 02/09/2022 00:00:00 |
| 145     | tablet      | 02/24/2022 00:00:00 |

### 📤 Expected Output

| laptop_views | mobile_views |
|--------------|--------------|
| 2            | 3            |

**Explanation**:  
- Laptop views: 2 (from user_ids 125 and 128)  
- Mobile views: 3 (tablet: 2, phone: 1)
*/

select distinct (
  select count(user_id)
  from viewership 
  where device_type = 'laptop'
) as laptop_views,
(
  select count(user_id)
  from viewership 
  where device_type in ('phone', 'tablet')
) as mobile_views
from viewership;
