SELECT * FROM gold.fact_sales AS sl
LEFT JOIN gold.dim_customers AS cu
ON sl.customer_key = cu.customer_key
LEFT JOIN gold.dim_products AS pr
ON sl.product_key = pr.product_key
WHERE sl.customer_key is NULL