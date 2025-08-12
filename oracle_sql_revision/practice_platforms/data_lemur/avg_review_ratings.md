## ⭐ Average Review Ratings

### 🧾 Problem Statement
Given the `reviews` table, write a query to retrieve the **average star rating** for each product, **grouped by month**.  
The output should include:
- The month as a **numerical value**
- The **product ID**
- The **average star rating**, rounded to **two decimal places**

Sort the output by:
1. Month (ascending)
2. Product ID (ascending)

### 🗃️ Table: `reviews`

| Column Name  | Type     |
|--------------|----------|
| review_id    | integer  |
| user_id      | integer  |
| submit_date  | datetime |
| product_id   | integer  |
| stars        | integer (1-5) |

### 🧪 Example Input

| review_id | user_id | submit_date        | product_id | stars |
|-----------|---------|--------------------|------------|-------|
| 6171      | 123     | 06/08/2022 00:00:00| 50001      | 4     |
| 7802      | 265     | 06/10/2022 00:00:00| 69852      | 4     |
| 5293      | 362     | 06/18/2022 00:00:00| 50001      | 3     |
| 6352      | 192     | 07/26/2022 00:00:00| 69852      | 3     |
| 4517      | 981     | 07/05/2022 00:00:00| 69852      | 2     |

### 📤 Expected Output

| mth | product | avg_stars |
|-----|---------|-----------|
| 6   | 50001   | 3.50      |
| 6   | 69852   | 4.00      |
| 7   | 69852   | 2.50      |

**Explanation**:  
- Product `50001` received two ratings (4 and 3) in June → average = 3.5  
- Product `69852` received one rating (4) in June → average = 4.0  
- Product `69852` received two ratings (3 and 2) in July → average = 2.5

### 🧮 SQL Query

```sql
with avg_stars_rating as (
  select
    extract(month from submit_date) as mth,
    product_id as product,
    round(avg(stars), 2) as avg_stars
  from reviews
  group by product_id, mth
  order by mth, product_id asc 
)
select *
from avg_stars_rating;
```
