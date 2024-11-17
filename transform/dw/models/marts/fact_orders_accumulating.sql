SELECT
    {{ dbt_utils.generate_surrogate_key(['orders.order_id']) }} AS order_key,
    {{ dbt_utils.generate_surrogate_key(['orders.customer_id']) }} AS customer_key,
    orders.order_id,
    orders.order_date,
    orders.required_date,
    orders.shipped_date,
    customers.company_name AS customer_name,
    shippers.company_name AS shipper_name,
    datediff(days, orders.order_date, orders.shipped_date) AS days_shipped,
    iff(
        datediff(days, orders.required_date, orders.shipped_date) > 0,
        datediff(days, orders.required_date, orders.shipped_date),
        NULL
    ) AS days_late
FROM {{ ref('orders') }} AS orders
INNER JOIN {{ ref('dim_customers') }} AS customers
    ON orders.customer_id = customers.customer_id
INNER JOIN {{ ref('shippers') }} AS shippers
    ON orders.ship_via = shippers.shipper_id
ORDER BY orders.order_date DESC
