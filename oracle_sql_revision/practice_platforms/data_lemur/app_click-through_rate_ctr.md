## 📊 Click-Through Rate (CTR) Calculation for Facebook App Analytics

### 🧾 Problem Statement
Given an `events` table containing app analytics data, calculate the **Click-Through Rate (CTR)** for each app in the year **2022**.

### 🧠 Definition
CTR is calculated as:

CTR (%) = 100.0 * Number of Clicks / Number of Impressions

> ⚠️ Note: Multiply by `100.0` to avoid integer division and ensure decimal precision.

### 🗃️ Table: `events`

| Column Name | Type      |
|-------------|-----------|
| app_id      | integer   |
| event_type  | string    | ('click', 'impression')
| timestamp   | datetime  |

### 🧪 Example Input

| app_id | event_type | timestamp           |
|--------|------------|---------------------|
| 123    | impression | 07/18/2022 11:36:12 |
| 123    | impression | 07/18/2022 11:37:12 |
| 123    | click      | 07/18/2022 11:37:42 |
| 234    | impression | 07/18/2022 14:15:12 |
| 234    | click      | 07/18/2022 14:16:12 |

### 📤 Expected Output

| app_id | ctr    |
|--------|--------|
| 123    | 50.00  |
| 234    | 100.00 |

**Explanation**:  
- App `123`: 1 click / 2 impressions → CTR = 50.00%  
- App `234`: 1 click / 1 impression → CTR = 100.00%

### 🧮 SQL Query

```sql
-- First approach (easy) by copilot
select 
  app_id,
  round(
    100.0 * sum(case when event_type = 'click' then 1 else 0 end) /
           nullif(sum(case when event_type = 'impression' then 1 else 0 end), 0), 2
  ) as ctr
from events
where extract(year from timestamp) = 2022
group by app_id;

-- my approach kinda chaotic
with clicks as (
  select 
    app_id, 
    count(*) as number_of_clicks
  from events
  where 
    extract(year from timestamp) = '2022' 
    and event_type = 'click'
  group by app_id
),
impressions as (
  select 
    app_id, 
    count(*) as number_of_impressions
  from events
  where 
    extract(year from timestamp) = '2022' 
    and event_type = 'impression'
  group by app_id
)
select 
  c.app_id,
  round(100.0 * c.number_of_clicks / i.number_of_impressions, 2) as ctr
from clicks as c inner join impressions as i
on c.app_id = i.app_id;
```
