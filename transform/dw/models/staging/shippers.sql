{{
    config(
        materialized="table"
    )
}}

SELECT
    shipper_id,
    company_name,
    phone
FROM {{ source('northwind_store', 'shippers') }}
