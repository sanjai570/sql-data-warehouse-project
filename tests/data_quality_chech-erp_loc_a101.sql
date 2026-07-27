SELECT cid, COUNT(*) FROM silver.erp_loc_a101
GROUP BY cid
HAVING COUNT(*) > 1

SELECT cid FROM silver.erp_cust_az12
WHERE cid  not in (
SELECT cid FROM silver.erp_loc_a101
)

SELECT REPLACE(cid,'-','') FROM bronze.erp_loc_a101;

SELECT distinct cntry FROM silver.erp_loc_a101
-- WHERE cntry != TRIM(cntry)

SELECT distinct
REPLACE(REPLACE(cntry,CHAR(13),''),CHAR(10),'') as new 
FROM silver.erp_loc_a101

SELECT distinct
cntry as old,
CASE WHEN UPPER( TRIM(REPLACE(REPLACE(cntry,CHAR(13),''),CHAR(10),''))) IN ('US','USA') THEN 'United States'
    WHEN UPPER( TRIM(REPLACE(REPLACE(cntry,CHAR(13),''),CHAR(10),''))) = 'DE' THEN 'Germany'
    WHEN  TRIM(REPLACE(REPLACE(cntry,CHAR(13),''),CHAR(10),'')) = '' THEN 'n/a'
    ELSE  TRIM(REPLACE(REPLACE(cntry,CHAR(13),''),CHAR(10),''))
END AS cntry
FROM silver.erp_loc_a101
ORDER BY cntry

SELECT * FROM silver.erp_loc_a101