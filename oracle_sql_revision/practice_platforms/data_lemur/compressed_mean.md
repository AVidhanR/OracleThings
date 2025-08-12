# Alibaba Items Per Order Analysis

You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using tables which include information on the count of items in each order (`item_count` table) and the corresponding number of orders for each item count (`order_occurrences` table).

### 📄 Table: `items_per_order`

| item_count | order_occurrences |
|------------|-------------------|
| 1          | 500               |
| 2          | 1000              |
| 3          | 800               |
| 4          | 1000              |

There are a total of:
- 500 orders with one item per order,
- 1000 orders with two items per order,
- 800 orders with three items per order,
- 1000 orders with four items per order.

### ✅ Example Output

| mean |
|------|
| 2.7  |

### 🧮 Explanation

Let's calculate the arithmetic average:

- **Total items** = (1 × 500) + (2 × 1000) + (3 × 800) + (4 × 1000) = **8,900**
- **Total orders** = 500 + 1000 + 800 + 1000 = **3,300**
- **Mean** = 8,900 ÷ 3,300 = **2.7**

### 🧮 SQL Query

```sql
with total_things as (
  select
    sum(item_count * order_occurrences) as total_items,
    sum(order_occurrences) as total_orders
  from items_per_order
)
select distinct round(
  ((select total_items from total_things)/
  (select total_orders from total_things))::NUMERIC, 1) as mean
from items_per_order;
```
