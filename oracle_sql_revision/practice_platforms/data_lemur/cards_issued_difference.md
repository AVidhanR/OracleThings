# JPMorgan Chase Credit Card Issuance Analysis

Your team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, you're analyzing how many credit cards were issued each month.

Write a query that outputs:
- The name of each credit card.
- The **difference** in the number of issued cards between the **month with the highest issuance** and the **month with the lowest issuance**.
- Arrange the results based on the **largest disparity**.

### `monthly_cards_issued` Table

| Column Name    | Type     | Description                          |
|----------------|----------|--------------------------------------|
| card_name      | string   | Name of the credit card              |
| issued_amount  | integer  | Number of cards issued               |
| issue_month    | integer  | Month when cards were issued         |
| issue_year     | integer  | Year when cards were issued          |

---

## 🧪 Example Input

| card_name              | issued_amount | issue_month | issue_year |
|------------------------|---------------|-------------|------------|
| Chase Freedom Flex     | 55000         | 1           | 2021       |
| Chase Freedom Flex     | 60000         | 2           | 2021       |
| Chase Freedom Flex     | 65000         | 3           | 2021       |
| Chase Freedom Flex     | 70000         | 4           | 2021       |
| Chase Sapphire Reserve | 170000        | 1           | 2021       |
| Chase Sapphire Reserve | 175000        | 2           | 2021       |
| Chase Sapphire Reserve | 180000        | 3           | 2021       |

## ✅ Example Output

| card_name              | difference |
|------------------------|------------|
| Chase Freedom Flex     | 15000      |
| Chase Sapphire Reserve | 10000      |

## 📝 Explanation

- **Chase Freedom Flex**:
  - Highest issuance: 70,000
  - Lowest issuance: 55,000
  - Difference: 15,000

- **Chase Sapphire Reserve**:
  - Highest issuance: 180,000
  - Lowest issuance: 170,000
  - Difference: 10,000

### 🧮 SQL Query

```sql
with cards_issued_difference as (
  select  
    card_name,
    (max(issued_amount) - min(issued_amount)) as difference
  from monthly_cards_issued
  group by card_name
  order by difference desc
)
select *  
from cards_issued_difference;
```
