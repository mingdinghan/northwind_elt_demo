{{
    config(
        materialized="table"
    )
}}

SELECT
    order_id,
    product_id,
    unit_price,
    quantity,
    discount
FROM {{ source('northwind_store', 'order_details') }}
