WITH cleaned AS (
    SELECT
        order_id,
        customer_id,
        product,
        category,
        price,
        quantity,
        (price * quantity) AS total_amount,
        LOWER(status) AS status
    FROM {{ ref('ecommerce') }}
    WHERE status = 'completed'
),

deduped AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY order_id
        ) AS rn
    FROM cleaned
)

SELECT
    order_id,
    customer_id,
    product,
    category,
    price,
    quantity,
    total_amount,
    status
FROM deduped
WHERE rn = 1