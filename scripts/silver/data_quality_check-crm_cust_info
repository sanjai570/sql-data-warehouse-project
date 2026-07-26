-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT
    cst_id,
    COUNT(*)
from silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1
--to check duplicates

SELECT
    cst_id,
    COUNT(*)
from silver.crm_cust_info
GROUP BY cst_id
HAVING cst_id IS NULL
-- to check nulls


SELECT
    cst_id,
    COUNT(*)
from silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL
-- in single query


SELECT *
FROM silver.crm_cust_info

--------------------------------------------------------------------------------------

-- Check For Unwanted Space in String Columns(varchar or nvarchar)
-- Expectation: No Result

-- first name check
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- last name check
SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

-- gender check 
SELECT cst_gndr
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

-- marital status check
SELECT cst_marital_status
FROM silver.crm_cust_info
WHERE cst_marital_status != TRIM(cst_marital_status)

-- Check For Abbrivations in the Table 
-- To Make Them in Full Form

-- for gender
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

-- for marital status
SELECT *
FROM bronze.crm_cust_info
where cst_marital_status is NULL;

SELECT * FROM silver.crm_cust_info
WHERE cst_id IN (29466,29473,29483);

SELECT cst_id
from bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

SELECT * from bronze.crm_cust_info
WHERE cst_id in (29449,
29473,
29433,
29483,
29466);
