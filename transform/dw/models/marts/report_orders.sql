SELECT
    {{ dbt_utils.star(from=ref('fact_orders'), relation_alias='fact_orders', except=[
        "order_key", "product_key", "customer_key", "employee_key", "order_date"
    ]) }},
    {{ dbt_utils.star(from=ref('dim_products'), relation_alias='dim_products', except=["product_key"]) }},
    {{ dbt_utils.star(from=ref('dim_customers'), relation_alias='dim_customers', except=["customer_key"]) }},
    {{ dbt_utils.star(from=ref('dim_employees'), relation_alias='dim_employees', except=["employee_key"]) }},
    {{ dbt_utils.star(from=ref('dim_date'), relation_alias='dim_date', except=["date_day"]) }}
FROM {{ ref('fact_orders') }} AS fact_orders
LEFT JOIN
    {{ ref('dim_products') }} AS dim_products
    ON fact_orders.product_key = dim_products.product_key
LEFT JOIN
    {{ ref('dim_customers') }} AS dim_customers
    ON fact_orders.customer_key = dim_customers.customer_key
LEFT JOIN
    {{ ref('dim_employees') }} AS dim_employees
    ON fact_orders.employee_key = dim_employees.employee_key
LEFT JOIN
    {{ ref('dim_date') }} AS dim_date
    ON fact_orders.order_date = dim_date.date_day
