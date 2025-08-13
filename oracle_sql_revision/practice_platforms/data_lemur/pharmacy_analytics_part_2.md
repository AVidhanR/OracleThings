CVS Health is analyzing its pharmacy sales data, and how well different products are selling in the market. Each drug is exclusively manufactured by a single manufacturer.

Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and calculate the total amount of losses incurred.

Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value. Display the results sorted in descending order with the highest losses displayed at the top.

### pharmacy_sales Table:

| Column Name   | Type     |
|---------------|----------|
| product_id    | integer  |
| units_sold    | integer  |
| total_sales   | decimal  |
| cogs          | decimal  |
| manufacturer  | varchar  |
| drug          | varchar  |

### pharmacy_sales Example Input:

| product_id | units_sold | total_sales | cogs       | manufacturer | drug                          |
|------------|------------|-------------|------------|--------------|-------------------------------|
| 156        | 89,514     | 3,130,097.00| 3,427,421.73| Biogen       | Acyclovir                     |
| 25         | 222,331    | 2,753,546.00| 2,974,975.36| AbbVie       | Lamivudine and Zidovudine     |
| 50         | 90,484     | 2,521,023.73| 2,742,445.90| Eli Lilly    | Dermasorb TA Complete Kit     |
| 98         | 110,746    |   813,188.82|   140,422.87| Biogen       | Medi-Chord                    |

### Example Output:

| Manufacturer | Drug Count | Total Loss   |
|--------------|------------|--------------|
| AbbVie       | 1          | 221,429.36   |
| Biogen       | 2          | 970,090.68   |
| Eli Lilly    | 1          | 221,422.17   |

### Explanation:
The first three rows indicate that some drugs resulted in losses. Among these, Biogen had the highest losses, followed by AbbVie and Eli Lilly. 
However, the Medi-Chord drug manufactured by Biogen reported a profit and was excluded from the result.

### 🧮 SQL Query

```sql
select 
  manufacturer,
  count(drug) as drug_count,
  abs(sum(cogs - total_sales)) as total_loss
from pharmacy_sales
where (cogs > total_sales)
group by manufacturer
order by total_loss desc;
```
