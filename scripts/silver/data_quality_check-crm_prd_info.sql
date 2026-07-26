-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT prd_id,count(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

------------------------------------------------------------------
-- Check For Unwanted Space in String Columns(varchar or nvarchar)
-- Expectation: No Result

-- for prd_key
SELECT prd_key FROM silver.crm_prd_info
WHERE prd_key != TRIM(prd_key)

-- for prd_nm
SELECT prd_nm FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- for prd_cost(cost should be positive and should be not null)
SELECT prd_cost
from silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

--for prd_line
SELECT DISTINCT prd_line FROM silver.crm_prd_info

-- for start date and end date 
SELECT *
--LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS end_date_test
FROM silver.crm_prd_info
WHERE prd_start_dt > prd_end_dt
--WHERE prd_key IN ('AC-HE-HL-U509-R',
-- 'AC-HE-HL-U509-R',
-- 'AC-HE-HL-U509',
-- 'AC-HE-HL-U509',
-- 'CL-SO-SO-B909-M',
-- 'CL-SO-SO-B909-L',
-- 'AC-HE-HL-U509-B')