SELECT REPLACE(REPLACE(gen,CHAR(10),''),CHAR(13),'') FROM bronze.erp_cust_az12

-- to check duplicates
SELECT cid,
count(*) as duplicte_count
FROM bronze.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1

SELECT cst_key FROM silver.crm_cust_info
ORDER BY cst_key
SELECT cid FROM silver.erp_cust_az12
ORDER BY cid

SELECT 
CASE WHEN cid like 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
ELSE cid
END cid
FROM bronze.erp_cust_az12

SELECT bdate FROM silver.erp_cust_az12
WHERE bdate > GETDATE()

SELECT gen,
REPLACE(gen,CHAR(13),'') as newgen
FROM bronze.erp_cust_az12

SELECT distinct gen from bronze.erp_cust_az12

SELECT DISTINCT CASE WHEN UPPER(TRIM(REPLACE(REPLACE(gen,CHAR(13),''),CHAR(10),''))) IN ('M' ,'MALE') THEN 'Male'
    WHEN UPPER(TRIM(REPLACE(REPLACE(gen,CHAR(13),''),CHAR(10),''))) IN ('F','FEMALE') THEN 'Female'
    WHEN TRIM(REPLACE(REPLACE(gen,CHAR(13),''),CHAR(10),'')) = '' THEN 'n/a'
    ELSE TRIM(gen)
END gen
FROM bronze.erp_cust_az12


SELECT distinct gen FROM silver.erp_cust_az12

