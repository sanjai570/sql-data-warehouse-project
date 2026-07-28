PRINT 'Truncating and Inserting into table : silver.erp_loc_a101';
TRUNCATE TABLE silver.erp_loc_a101;

WITH cleaned AS (
    SELECT
    REPLACE(cid,'-','') as cleaned_cid,
    TRIM(REPLACE(REPLACE(cntry,CHAR(13),''),CHAR(10),'')) as cleaned_cntry
    FROM bronze.erp_loc_a101
)

INSERT INTO silver.erp_loc_a101 (cid,cntry)

SELECT 
cleaned_cid as cid,
CASE WHEN UPPER(cleaned_cntry) IN ('US','USA') THEN 'United States'
    WHEN UPPER(cleaned_cntry) = 'DE' THEN 'Germany'
    WHEN cleaned_cntry = '' THEN 'n/a'
    ELSE cleaned_cntry
END AS cntry
FROM cleaned





