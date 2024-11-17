{{
    config(
        materialized="table"
    )
}}

SELECT
    state_id,
    state_name,
    state_abbr,
    state_region
FROM {{ source('northwind_store', 'us_states') }}
