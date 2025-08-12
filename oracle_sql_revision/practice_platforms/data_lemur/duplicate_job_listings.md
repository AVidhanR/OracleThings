## 🧑‍💼 Count of Companies with Duplicate Job Listings on LinkedIn

### 🧾 Problem Statement
Given a table of job postings from various companies on LinkedIn, write a query to retrieve the **count of companies** that have posted **duplicate job listings**.

### 🧠 Definition
- A **duplicate job listing** is defined as **two or more job listings** within the same company that have **identical titles and descriptions**.

### 🗃️ Table: `job_listings`

| Column Name | Type     |
|-------------|----------|
| job_id      | integer  |
| company_id  | integer  |
| title       | string   |
| description | string   |

### 🧪 Example Input

| job_id | company_id | title           | description                                                                 |
|--------|------------|------------------|------------------------------------------------------------------------------|
| 248    | 827        | Business Analyst | Business analyst evaluates past and current business data...                |
| 149    | 845        | Business Analyst | Business analyst evaluates past and current business data...                |
| 945    | 345        | Data Analyst     | Data analyst reviews data to identify key insights...                       |
| 164    | 345        | Data Analyst     | Data analyst reviews data to identify key insights...                       |
| 172    | 244        | Data Engineer    | Data engineer works in a variety of settings...                             |

### 📤 Expected Output

| duplicate_companies |
|---------------------|
| 1                   |

**Explanation**:  
- Company `345` posted two job listings with the same title and description.
- Other companies either posted unique listings or duplicates across different companies (which don't count).

### 🧮 SQL Query

```sql
with dups as (
  select
    company_id
  from job_listings
  group by company_id, title, description
  having count(job_id) > 1 
)
select count(company_id) as duplicate_companies 
from dups;
```
