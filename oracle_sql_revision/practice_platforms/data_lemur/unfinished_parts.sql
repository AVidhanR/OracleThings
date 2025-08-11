/*
## 🔧 Tesla Parts in Assembly but Not Finished

### 🧾 Problem Statement
Tesla is investigating production bottlenecks and needs to identify parts that have **begun the assembly process** but are **not yet finished**.

### 🧠 Assumptions
- The `parts_assembly` table contains all parts currently in production.
- A part is considered **unfinished** if its `finish_date` is `NULL`.

### 🗃️ Table: `parts_assembly`

| Column Name     | Type      |
|------------------|-----------|
| part             | string    |
| finish_date      | datetime  |
| assembly_step    | integer   |

### 🧪 Example Input

| part    | finish_date         | assembly_step |
|---------|---------------------|----------------|
| battery | 01/22/2022 00:00:00 | 1              |
| battery | 02/22/2022 00:00:00 | 2              |
| battery | 03/22/2022 00:00:00 | 3              |
| bumper  | 01/22/2022 00:00:00 | 1              |
| bumper  | 02/22/2022 00:00:00 | 2              |
| bumper  | NULL                | 3              |
| bumper  | NULL                | 4              |

### 📤 Expected Output

| part   | assembly_step |
|--------|----------------|
| bumper | 3              |
| bumper | 4              |

**Explanation**:  
Only the `bumper` part at steps 3 and 4 is unfinished, as indicated by the missing `finish_date`.
*/

select  
  part,
  assembly_step
from 
  parts_assembly
where
  finish_date is null;
