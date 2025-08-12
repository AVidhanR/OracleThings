## 📈 Cities With Completed Trades

### 🧾 Problem Statement
Given two tables — `trades` and `users` — write a query to retrieve the **top three cities** with the **highest number of completed trade orders**.  
Output the city name and the corresponding number of completed trade orders, sorted in **descending order**.

### 🗃️ Tables

#### `trades`

| Column Name | Type       |
|-------------|------------|
| order_id    | integer    |
| user_id     | integer    |
| quantity    | integer    |
| status      | string     | ('Completed', 'Cancelled')
| date        | timestamp  |
| price       | decimal(5,2)|

#### `users`

| Column Name | Type      |
|-------------|-----------|
| user_id     | integer   |
| city        | string    |
| email       | string    |
| signup_date | datetime  |

### 🧪 Example Input

#### `trades`

| order_id | user_id | quantity | status    | date               | price |
|----------|---------|----------|-----------|--------------------|--------|
| 100101   | 111     | 10       | Cancelled | 08/17/2022 12:00:00| 9.80   |
| 100102   | 111     | 10       | Completed | 08/17/2022 12:00:00| 10.00  |
| 100259   | 148     | 35       | Completed | 08/25/2022 12:00:00| 5.10   |
| 100264   | 148     | 40       | Completed | 08/26/2022 12:00:00| 4.80   |
| 100305   | 300     | 15       | Completed | 09/05/2022 12:00:00| 10.00  |
| 100400   | 178     | 32       | Completed | 09/17/2022 12:00:00| 12.00  |
| 100565   | 265     | 2        | Completed | 09/27/2022 12:00:00| 8.70   |

#### `users`

| user_id | city          | email                          | signup_date         |
|---------|---------------|----------------------------------|---------------------|
| 111     | San Francisco | rrok10@gmail.com                | 08/03/2021 12:00:00 |
| 148     | Boston        | sailor9820@gmail.com            | 08/20/2021 12:00:00 |
| 178     | San Francisco | harrypotterfan182@gmail.com     | 01/05/2022 12:00:00 |
| 265     | Denver        | shadower_@hotmail.com           | 02/26/2022 12:00:00 |
| 300     | San Francisco | houstoncowboy1122@hotmail.com   | 06/30/2022 12:00:00 |

### 📤 Expected Output

| city          | total_orders |
|---------------|--------------|
| San Francisco | 3            |
| Boston        | 2            |
| Denver        | 1            |

**Explanation**:  
- San Francisco has 3 completed orders (from users 111, 178, and 300).  
- Boston has 2 completed orders (from user 148).  
- Denver has 1 completed order (from user 265).

### 🧮 SQL Query

```sql
with total_orders_count as (
  select 
    u.city,
    count(u.city) as total_orders
  from trades t inner join users u 
  on t.user_id = u.user_id
  where t.status = 'Completed'
  group by u.city
  having count(u.city) > 1
  order by total_orders desc
)
select *
from total_orders_count;
```
