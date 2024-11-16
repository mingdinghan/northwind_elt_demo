{{
    config(
        materialized="table"
    )
}}

SELECT
    category_id,
    category_name,
    description,
    picture
FROM {{ source('northwind_store', 'categories') }}
