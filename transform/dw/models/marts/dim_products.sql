SELECT
    {{ dbt_utils.generate_surrogate_key(['products.product_id']) }} AS product_key,
    products.product_id,
    products.product_name,
    products.quantity_per_unit,
    products.unit_price,
    categories.category_name AS category_name,
    suppliers.company_name AS supplier_company_name
FROM {{ ref('products') }} AS products
INNER JOIN {{ ref('categories') }} AS categories
    ON products.category_id = categories.category_id
INNER JOIN {{ ref('suppliers') }} AS suppliers
    ON products.supplier_id = suppliers.supplier_id
