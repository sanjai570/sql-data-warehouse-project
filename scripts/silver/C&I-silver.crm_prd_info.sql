PRINT 'Truncating and Inserting into table : silver.crm_prd_info';
TRUNCATE TABLE silver.crm_prd_info;

-- silver layer bronze.crm_prd_info

INSERT INTO silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT 
    prd_id,
    REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
    SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
    prd_nm,
    ISNULL(prd_cost,0) AS prd_cost,
    CASE UPPER(TRIM(prd_line))
        WHEN 'M' THEN 'Mountain'
        WHEN 'R' THEN 'Road'
        WHEN 'S' THEN 'Other Sales'
        WHEN 'T' THEN 'Touring'
        ELSE 'n/a'
    END prd_line,
    CAST(prd_start_dt AS date) as prd_start_dt,
    CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS date)AS prd_end_dt
FROM bronze.crm_prd_info



------------------------------------------------------------------------
-- to get all the columns
-- SELECT COLUMN_NAME
-- FROM INFORMATION_SCHEMA.COLUMNS
-- WHERE TABLE_NAME = 'crm_prd_info';

