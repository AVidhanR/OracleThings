## 🧠 Data Science Job Candidate Filter

### 🧾 Problem Statement
Given a table of candidates and their skills, identify candidates who are best suited for a Data Science job. The ideal candidate must possess **all** of the following skills:
- Python
- Tableau
- PostgreSQL

### 🗃️ Table: `candidates`

| Column Name   | Type     |
|---------------|----------|
| candidate_id  | integer  |
| skill         | varchar  |

### 🧪 Example Input

| candidate_id | skill       |
|--------------|-------------|
| 123          | Python      |
| 123          | Tableau     |
| 123          | PostgreSQL  |
| 234          | R           |
| 234          | PowerBI     |
| 234          | SQL Server  |
| 345          | Python      |
| 345          | Tableau     |

### 📤 Expected Output

| candidate_id |
|--------------|
| 123          |

**Explanation**:  
Candidate `123` is selected because they possess all three required skills: Python, Tableau, and PostgreSQL.  
Candidate `345` is not selected because they are missing PostgreSQL.

### 🧮 SQL Query

```sql
with two_req_skills as (
  select candidate_id
  from candidates
  where skill in ('Python', 'Tableau')
),
most_req_skill as (
  select candidate_id
  from candidates
  where skill in ('PostgreSQL')
)
select distinct t.candidate_id
from two_req_skills t join most_req_skill m 
on t.candidate_id = m.candidate_id;
```
