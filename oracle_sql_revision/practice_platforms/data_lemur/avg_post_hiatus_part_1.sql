/*
## 📅 Days Between First and Last Facebook Post in 2021

### 🧾 Problem Statement
Given a table of Facebook posts, for each user who posted **at least twice in 2021**, 
calculate the number of days between their **first** and **last** post of the year.

### 🗃️ Table: `posts`

| Column Name   | Type      |
|---------------|-----------|
| user_id       | integer   |
| post_id       | integer   |
| post_content  | text      |
| post_date     | timestamp |

### 🧪 Example Input
| user_id | post_id | post_content                                                                 | post_date           |
|---------|---------|------------------------------------------------------------------------------|---------------------|
| 151652  | 599415  | Need a hug                                                                   | 07/10/2021 12:00:00 |
| 661093  | 624356  | Bed. Class 8-12. Work 12-3. Gym 3-5 or 6. Then class 6-10. I miss my girlfriend | 07/29/2021 13:00:00 |
| 004239  | 784254  | Happy 4th of July!                                                           | 07/04/2021 11:00:00 |
| 661093  | 442560  | Just going to cry myself to sleep after watching Marley and Me.             | 07/08/2021 14:00:00 |
| 151652  | 111766  | I'm so done with covid - need travelling ASAP!                              | 07/12/2021 19:00:00 |

### 📤 Expected Output

| user_id | days_between |
|---------|---------------|
| 151652  | 2             |
| 661093  | 21            |

**Explanation**:  
- User `151652` posted on 07/10 and 07/12 → 2 days apart  
- User `661093` posted on 07/08 and 07/29 → 21 days apart  
- User `004239` posted only once → excluded

*/

select
  user_id,
  extract(day from (max(post_date) - min(post_date))) as days_between
from posts
where extract(year from (post_date)) = '2021'
group by user_id
having count(user_id) > 1;
