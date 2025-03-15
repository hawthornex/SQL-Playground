-- Running total per user by created_at
SELECT
  o.user_id,
  o.id AS order_id,
  o.created_at,
  o.total_cents,
  SUM(o.total_cents) OVER (
    PARTITION BY o.user_id
    ORDER BY o.created_at, o.id
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_total
FROM orders o
ORDER BY o.user_id, o.created_at, o.id;

-- Percent rank per user by order amount
SELECT
  o.user_id,
  o.id AS order_id,
  o.total_cents,
  PERCENT_RANK() OVER (
    PARTITION BY o.user_id ORDER BY o.total_cents
  ) AS pct_rank
FROM orders o
ORDER BY o.user_id, pct_rank, o.id;

