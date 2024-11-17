WITH orders AS (
    SELECT
        orders.order_id,
        orders.customer_id,
        orders.employee_id,
        orders.order_date,
        orders.shipped_date,
        orders.required_date,
        shippers.company_name AS shipper_name,
        orders.freight AS freight_cost,
        orders.ship_name AS shipping_name,
        orders.ship_address AS shipping_address,
        orders.ship_city AS shipping_city,
        orders.ship_region AS shipping_region,
        us_states.state_name AS shipping_us_state,
        orders.ship_country AS shipping_country
    FROM {{ ref('orders') }} AS orders
    INNER JOIN {{ ref('shippers') }} AS shippers
        ON orders.ship_via = shippers.shipper_id
    LEFT JOIN {{ ref("us_states") }} AS us_states
        ON orders.ship_region = us_states.state_abbr
),

order_details AS (
    SELECT
        order_id,
        product_id,
        unit_price,
        quantity,
        discount
    FROM {{ ref('order_details') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['orders.order_id']) }} AS order_key,
    {{ dbt_utils.generate_surrogate_key(['order_details.product_id']) }} AS product_key,
    {{ dbt_utils.generate_surrogate_key(['orders.customer_id']) }} AS customer_key,
    {{ dbt_utils.generate_surrogate_key(['orders.employee_id']) }} AS employee_key,
    orders.order_date,
    orders.required_date,
    orders.shipped_date,
    orders.shipper_name,
    orders.freight_cost,
    order_details.unit_price,
    order_details.quantity,
    order_details.discount,
    order_details.unit_price * (1 - order_details.discount) * order_details.quantity AS revenue
FROM orders
INNER JOIN order_details
    ON orders.order_id = order_details.order_id
INNER JOIN {{ ref('dim_products') }} AS products
    ON order_details.product_id = products.product_id
