Title: Window Functions — Running Totals

Dataset
- orders(id, user_id, total_cents, created_at)

Tasks
- Running total per user ordered by created_at
- Percent rank of each order by total_cents per user

Hints
- Use PARTITION BY user_id

