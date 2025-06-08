-- Average items per order
WITH per_order AS (
  SELECT order_id, SUM(qty) AS items
  FROM order_items
  GROUP BY order_id
)
SELECT AVG(items) AS avg_items_per_order FROM per_order;

-- Attach rate per product
WITH totals AS (
  SELECT COUNT(DISTINCT id) AS total_orders FROM orders
), prod_orders AS (
  SELECT product_id, COUNT(DISTINCT order_id) AS orders_with
  FROM order_items
  GROUP BY product_id
)
SELECT p.name, po.orders_with::float / t.total_orders AS attach_rate
FROM prod_orders po
CROSS JOIN totals t
JOIN products p ON p.id = po.product_id
ORDER BY attach_rate DESC, p.name;

-- Top 3 product pairs by co-occurrence
WITH pairs AS (
  SELECT LEAST(oi1.product_id, oi2.product_id) AS p1,
         GREATEST(oi1.product_id, oi2.product_id) AS p2,
         oi1.order_id
  FROM order_items oi1
  JOIN order_items oi2
    ON oi1.order_id = oi2.order_id AND oi1.product_id < oi2.product_id
)
SELECT p1, p2, COUNT(DISTINCT order_id) AS together
FROM pairs
GROUP BY p1, p2
ORDER BY together DESC, p1, p2
LIMIT 3;

