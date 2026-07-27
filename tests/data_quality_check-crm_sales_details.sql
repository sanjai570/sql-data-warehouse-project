SELECT sls_order_dt FROM silver.crm_sales_details
WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) != 8

SELECT sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != (sls_quantity * sls_price) OR
sls_sales IS NULL or sls_quantity IS NULL OR sls_price IS NULL OR
sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0


SELECT * FROM silver.crm_sales_details 
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt
-- CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) 
--     THEN sls_quantity * ABS(sls_price)
--     ELSE sls_sales
-- END sls_sales

SELECT * FROM silver.crm_sales_details