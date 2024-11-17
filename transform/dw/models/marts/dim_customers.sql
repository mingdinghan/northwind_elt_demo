SELECT
    {{ dbt_utils.generate_surrogate_key(['customers.customer_id']) }} AS customer_key,
    customers.customer_id,
    customers.company_name,
    customers.contact_name,
    customers.contact_title,
    customers.city AS customer_city,
    customers.region AS customer_region,
    us_states.state_name AS customer_us_state,
    customers.country AS customer_country,
FROM {{ ref("customers") }} AS customers
LEFT JOIN {{ ref("us_states") }} AS us_states
    ON customers.region = us_states.state_abbr
