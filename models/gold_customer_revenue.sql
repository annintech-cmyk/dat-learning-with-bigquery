SELECT
  customer_id,
  COUNT(order_id) AS total_orders,
  SUM(total_amount) AS total_revenue,
  AVG(total_amount) AS avg_order_value
FROM {{ ref('stg_ecommerce') }}
GROUP BY customer_id