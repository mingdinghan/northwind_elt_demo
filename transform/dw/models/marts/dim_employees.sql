SELECT
    {{ dbt_utils.generate_surrogate_key(['employees.employee_id']) }} AS employee_key,
    employees.employee_id,
    CONCAT(employees.first_name, ' ', employees.last_name) as employee_name,
    employees.title,
    employees.birth_date,
    employees.hire_date,
    employees.city AS employee_city,
    employees.region AS employee_region,
    us_states.state_name AS employee_us_state,
    employees.country AS employee_country,
    territories.territory_description,
    region.region_description
FROM {{ ref('employees') }} AS employees
INNER JOIN {{ ref('employee_territories') }} AS et
    ON employees.employee_id = et.employee_id
INNER JOIN {{ ref('territories') }} AS territories
    ON et.territory_id = territories.territory_id
INNER JOIN {{ ref('region') }} AS region
    ON territories.region_id = region.region_id
LEFT JOIN {{ ref("us_states") }} AS us_states
    ON employees.region = us_states.state_abbr
