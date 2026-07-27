SELECT * FROM bronze.erp_px_cat_g1v2

SELECT * FROM silver.crm_prd_info

SELECT id FROM bronze.erp_px_cat_g1v2
WHERE id != TRIM(id)

SELECT cat FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat)

SELECT subcat FROM bronze.erp_px_cat_g1v2
WHERE subcat != TRIM(subcat)





SELECT * FROM silver.crm_cust_info
SELECT * FROM silver.crm_prd_info
SELECT * FROM silver.crm_sales_details
SELECT * FROM silver.erp_cust_az12
SELECT * FROM silver.erp_loc_a101
SELECT * FROM silver.erp_px_cat_g1v2