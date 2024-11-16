{{
    config(
        materialized="table"
    )
}}

SELECT
    region_id,
    region_description
FROM {{ source('northwind_store', 'region') }}
