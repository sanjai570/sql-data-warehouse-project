PRINT 'Truncating and Inserting into table : silver.crm_sales_details';
TRUNCATE TABLE silver.crm_sales_details;

INSERT INTO silver.crm_sales_details (sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt <= 0 OR LEN(sls_order_dt) != 8 THEN null
    ELSE TRY_CONVERT(DATE, CAST(sls_order_dt AS VARCHAR(8)), 112)
END AS sls_order_dt,
CASE WHEN sls_ship_dt <= 0 OR LEN(sls_ship_dt) != 8 THEN NULL
    ELSE TRY_CONVERT(DATE, CAST(sls_ship_dt AS VARCHAR(8)), 112)
END sls_ship_dt,
CASE WHEN sls_due_dt <= 0 OR LEN(sls_due_dt) != 8 THEN NULL
    ELSE TRY_CONVERT(DATE, CAST(sls_due_dt AS VARCHAR(8)), 112)
END sls_due_dt,
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) 
    THEN sls_quantity * ABS(sls_price)
    ELSE sls_sales
END sls_sales,
sls_quantity,
CASE WHEN sls_price IS NULL OR sls_price <= 0 
    THEN sls_sales/sls_quantity
    ELSE sls_price
END as sls_price
FROM bronze.crm_sales_details



-- SELECT COLUMN_NAME
-- FROM INFORMATION_SCHEMA.COLUMNS
-- WHERE TABLE_NAME = 'crm_sales_details';

