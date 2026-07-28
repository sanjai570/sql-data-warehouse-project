PRINT 'Truncating and Inserting into table : silver.erp_px_cat_g1v2';
TRUNCATE TABLE silver.erp_px_cat_g1v2;

INSERT INTO silver.erp_px_cat_g1v2 (id,cat,subcat,maintenance)
SELECT 
id,
cat,
subcat,
REPLACE(REPLACE(maintenance, CHAR(13), ''),CHAR(10), '') AS maintenance
FROM bronze.erp_px_cat_g1v2;