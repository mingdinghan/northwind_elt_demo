SELECT
    {{ dbt_utils.generate_surrogate_key(['customers.customer_id']) }} AS customer_key,
    customers.customer_id,
    customers.company_name,
    customers.contact_name,
    customers.contact_title,
    customers.city,
    customers.region,
    us_states.state_name AS us_state,
    customers.country,
FROM {{ ref("customers") }} AS customers
LEFT JOIN {{ ref("us_states") }} AS us_states
    ON customers.region = us_states.state_abbr
