{{
    config(
        materialized="table"
    )
}}

SELECT
    territory_id,
    territory_description,
    region_id
FROM {{ source('northwind_store', 'territories') }}
