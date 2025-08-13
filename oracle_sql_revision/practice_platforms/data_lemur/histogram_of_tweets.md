## 📊 Histogram of Tweets per User in 2022

### 🧾 Problem Statement
Given a table `tweets` containing Twitter data, write a SQL query to obtain a histogram of tweets posted per user in the year 2022.

The goal is to:
- Count how many tweets each user posted in 2022.
- Group users by their tweet count.
- Output the tweet count as a bucket and the number of users who fall into that bucket.

### 🗃️ Table: `tweets`

| Column Name | Type      |
|-------------|-----------|
| tweet_id    | integer   |
| user_id     | integer   |
| msg         | string    |
| tweet_date  | timestamp |

### 🧪 Example Input

| tweet_id | user_id | msg                                                             | tweet_date           |
|----------|---------|------------------------------------------------------------------|----------------------|
| 214252   | 111     | Am considering taking Tesla private at \$420. Funding secured. | 12/30/2021 00:00:00 |
| 739252   | 111     | Despite the constant negative press covfefe                    | 01/01/2022 00:00:00 |
| 846402   | 111     | Following @NickSinghTech on Twitter changed my life!           | 02/14/2022 00:00:00 |
| 241425   | 254     | If the salary is so competitive why won’t you tell me what it is? | 03/01/2022 00:00:00 |
| 231574   | 148     | I no longer have a manager. I can't be managed                 | 03/23/2022 00:00:00 |

### 📤 Expected Output

| tweet_bucket | users_num |
|--------------|-----------|
| 1            | 2         |
| 2            | 1         |

### Explanation  
- User `111` posted 2 tweets in 2022.  
- Users `254` and `148` each posted 1 tweet in 2022.  
- So, the histogram shows:
  - 2 users posted 1 tweet.
  - 1 user posted 2 tweets.

### 🧮 SQL Query

```sql
WITH tweet_totals AS (
  SELECT  
    user_id,
    COUNT(tweet_id) AS tweet_bucket
  FROM
    tweets
  WHERE
    EXTRACT(YEAR FROM tweet_date) IN ('2022')
  GROUP BY
    user_id
)
SELECT
  tweet_bucket,
  COUNT(user_id) AS users_num
FROM tweet_totals
GROUP BY tweet_bucket;
```
