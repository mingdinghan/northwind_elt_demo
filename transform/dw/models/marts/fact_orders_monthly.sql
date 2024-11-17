SELECT
    {{ dbt_utils.
        generate_surrogate_key(["dates.month_end_date", "orders.product_key"]) }} AS orders_monthly_key,
    dates.month_end_date,
    orders.product_key,
    sum(revenue) as revenue
FROM {{ ref('fact_orders') }} AS orders
INNER JOIN {{ ref('dim_date') }} AS dates
    ON orders.order_date = dates.date_day
GROUP BY
    dates.month_end_date,
    orders.product_key
