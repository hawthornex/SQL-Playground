-- Total spend per user
SELECT u.id, u.name, COALESCE(SUM(o.total_cents), 0) AS total_cents
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.name
ORDER BY total_cents DESC;

-- Top 3 users by spend
WITH spend AS (
  SELECT u.id, u.name, COALESCE(SUM(o.total_cents), 0) AS total_cents
  FROM users u LEFT JOIN orders o ON o.user_id = u.id
  GROUP BY u.id, u.name
)
SELECT * FROM spend ORDER BY total_cents DESC LIMIT 3;

-- Monthly order counts
SELECT substr(created_at, 1, 7) AS ym, COUNT(*) AS cnt
FROM orders
GROUP BY ym
ORDER BY ym;

