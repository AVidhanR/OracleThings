/*
## 💬 Top 2 Power Users on Microsoft Teams in August 2022

### 🧾 Problem Statement
Identify the top 2 users who sent the **highest number of messages** on Microsoft Teams in **August 2022**.  
Return their `sender_id` and the total number of messages they sent (`message_count`).  
Sort the output in **descending order** of message count.

### 🗃️ Table: `messages`

| Column Name  | Type      |
|--------------|-----------|
| message_id   | integer   |
| sender_id    | integer   |
| receiver_id  | integer   |
| content      | varchar   |
| sent_date    | datetime  |

### 🧪 Example Input

| message_id | sender_id | receiver_id | content                              | sent_date           |
|------------|-----------|-------------|--------------------------------------|---------------------|
| 901        | 3601      | 4500        | You up?                              | 08/03/2022 00:00:00 |
| 902        | 4500      | 3601        | Only if you're buying                | 08/03/2022 00:00:00 |
| 743        | 3601      | 8752        | Let's take this offline              | 06/14/2022 00:00:00 |
| 922        | 3601      | 4500        | Get on the call                      | 08/10/2022 00:00:00 |

### 📤 Expected Output

| sender_id | message_count |
|-----------|----------------|
| 3601      | 2              |
| 4500      | 1              |

**Explanation**:  
- User `3601` sent 2 messages in August 2022.  
- User `4500` sent 1 message in August 2022.  
- Only messages from August 2022 are considered.

*/

select 
  sender_id,
  count(sender_id) as message_count
from messages
where 
  extract(year from (sent_date)) = '2022' 
  and extract(month from (sent_date)) = '08'
group by sender_id
order by message_count desc
limit 2;
