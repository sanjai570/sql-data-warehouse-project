SELECT 
sd.sls_ord_num,
pr.product_key,-- Use the dimension's surrogate keys instead of IDs to easily connect facts with dimensions
cu.customer_key, -- surrogate key from gold.dim_customers
sd.sls_order_dt,
sd.sls_ship_dt,
sd.sls_due_dt,
sd.sls_sales,
sd.sls_quantity,
sd.sls_price
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_products AS pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers AS cu
ON sd.sls_cust_id = cu.customer_id
