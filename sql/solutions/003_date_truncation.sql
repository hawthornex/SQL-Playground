-- Orders per week (Mon-Sun) using %W week number (ISO-like)
SELECT strftime('%Y-%W', created_at) AS year_week, COUNT(*) AS orders
FROM orders
GROUP BY year_week
ORDER BY year_week;

-- Rolling 4-week average by week bucket
WITH weeks AS (
  SELECT strftime('%Y-%W', created_at) AS yw, COUNT(*) AS cnt
  FROM orders
  GROUP BY yw
)
SELECT w1.yw,
       (
         SELECT AVG(w2.cnt)
         FROM weeks w2
         WHERE w2.yw <= w1.yw
         ORDER BY w2.yw DESC
         LIMIT 4
       ) AS avg4
FROM weeks w1
ORDER BY w1.yw;

