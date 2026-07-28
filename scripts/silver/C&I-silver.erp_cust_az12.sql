
PRINT 'Truncating and Inserting into table : silver.erp_cust_az12';
TRUNCATE TABLE silver.erp_cust_az12;
-- with cte

WITH clean_data AS 
(
    SELECT
    CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
    ELSE cid
    END as cleaned_cid,

    CASE WHEN bdate > GETDATE() THEN NULL
    ELSE bdate
    END cleaned_bdate,

    UPPER(TRIM(REPLACE(REPLACE(gen,CHAR(13),''),CHAR(10),''))) AS cleaned_gen 

    FROM bronze.erp_cust_az12
)

INSERT INTO silver.erp_cust_az12 (cid,bdate,gen)

SELECT
    cleaned_cid as cid,
    cleaned_bdate as bdate,
    CASE WHEN cleaned_gen IN ('F','FEMALE') THEN 'Female'
        WHEN cleaned_gen IN ('M','MALE') THEN 'Male'
        WHEN cleaned_gen = '' THEN 'n/a'
    ELSE cleaned_gen
    END gen
FROM clean_data