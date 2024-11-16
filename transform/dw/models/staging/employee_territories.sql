{{
    config(
        materialized="table"
    )
}}

SELECT
    employee_id,
    territory_id
FROM {{ source('northwind_store', 'employee_territories') }}
