CREATE OR ALTER PROCEDURE silver.load_silver
AS
BEGIN
    BEGIN TRY
        DECLARE @start_time DATETIME , @end_time DATETIME ,@batch_start_time DATETIME,@batch_end_time DATETIME;
        PRINT '=====================================================================';
        PRINT 'LOADING FILES INTO TABLES - SILVER LAYER' ;
        PRINT '=====================================================================';

        PRINT '------------------------------------';
        PRINT 'LOADING CRM FILES';
        PRINT '------------------------------------';

        SET @batch_start_time = GETDATE();

------------------------------------------------------------------------------------------------------
        SET @start_time = GETDATE();
        PRINT 'Truncating and Inserting into table : silver.crm_cust_info';
        TRUNCATE TABLE silver.crm_cust_info;
        -- CLEANED AND INSERTED INTO silver.crm_cust_info
        INSERT INTO silver.crm_cust_info
            (
            cst_id,
            cst_key,
            cst_firstname,
            cst_lastname,
            cst_marital_status,
            cst_gndr,
            cst_create_date
            )
        SELECT
            cst_id,
            cst_key,
            TRIM(cst_firstname) AS cst_firstname, -- Data Clensing 'removing the leading and trailing space using TRIM()'
            TRIM(cst_lastname) AS cst_lastname,
            CASE 
                WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
                WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
                ELSE 'n/a'
            END cst_marital_status, -- Normalize marital status values to readable format
            CASE 
                WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
                WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
                ELSE 'n/a'
            END cst_gndr, -- Normalize gender values to readable format
            cst_create_date
        FROM(
            SELECT *,
                ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY [cst_create_date] DESC) as flag
            FROM bronze.crm_cust_info
            WHERE cst_id IS NOT NULL
            )t
        WHERE flag = 1;
        -- Select the most recent record per customer

        SET @end_time = GETDATE();
        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'sec';
        PRINT ' ';

------------------------------------------------------------------------------------------------------
        SET @start_time = GETDATE();


        PRINT 'Truncating and Inserting into table : silver.crm_prd_info';
        TRUNCATE TABLE silver.crm_prd_info;
        -- CLEANED AND INSERTED INTO silver.crm_prd_info
        INSERT INTO silver.crm_prd_info
            (
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
        FROM bronze.crm_prd_info;

        SET @end_time = GETDATE();
        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'sec';
        PRINT ' ';
------------------------------------------------------------------------------------------------------

        SET @start_time = GETDATE();


        PRINT 'Truncating and Inserting into table : silver.crm_sales_details';
        TRUNCATE TABLE silver.crm_sales_details;
        -- CLEANED AND INSERTED INTO silver.crm_sales_details
        INSERT INTO silver.crm_sales_details
            (
            sls_ord_num,
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
            THEN sls_sales/NULLIF(sls_quantity,0)
            ELSE sls_price
        END as sls_price
        FROM bronze.crm_sales_details;



        SET @end_time = GETDATE();
        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'sec';
        PRINT ' ';
------------------------------------------------------------------------------------------------------

        PRINT '------------------------------------';
        PRINT 'LOADING ERP FILES';
        PRINT '------------------------------------';

        SET @start_time = GETDATE();

        PRINT 'Truncating and Inserting into table : silver.erp_cust_az12';
        TRUNCATE TABLE silver.erp_cust_az12;

        -- with cte

        WITH
            clean_data
            AS
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
        -- CLEANED AND INSERTED INTO silver.erp_cust_az12

        INSERT INTO silver.erp_cust_az12
            (
            cid,
            bdate,
            gen
            )

        SELECT
            cleaned_cid as cid,
            cleaned_bdate as bdate,
            CASE WHEN cleaned_gen IN ('F','FEMALE') THEN 'Female'
                WHEN cleaned_gen IN ('M','MALE') THEN 'Male'
                WHEN cleaned_gen = '' THEN 'n/a'
            ELSE cleaned_gen
            END gen
        FROM clean_data


        SET @end_time = GETDATE();

        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'sec';
        PRINT ' ';

------------------------------------------------------------------------------------------------------
        SET @start_time = GETDATE();



        PRINT 'Truncating and Inserting into table : silver.erp_loc_a101';
        TRUNCATE TABLE silver.erp_loc_a101;

        WITH
            cleaned
            AS
            (
                SELECT
                    REPLACE(cid,'-','') as cleaned_cid,
                    TRIM(REPLACE(REPLACE(cntry,CHAR(13),''),CHAR(10),'')) as cleaned_cntry
                FROM bronze.erp_loc_a101
            )
        -- CLEANED AND INSERTED INTO silver.erp_loc_a101

        INSERT INTO silver.erp_loc_a101
            (
            cid,
            cntry
            )

        SELECT
            cleaned_cid as cid,
            CASE WHEN UPPER(cleaned_cntry) IN ('US','USA') THEN 'United States'
            WHEN UPPER(cleaned_cntry) = 'DE' THEN 'Germany'
            WHEN cleaned_cntry = '' THEN 'n/a'
            ELSE cleaned_cntry
        END AS cntry
        FROM cleaned;



        SET @end_time = GETDATE();


        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'sec';
        PRINT ' ';

------------------------------------------------------------------------------------------------------


        SET @start_time = GETDATE();


        PRINT 'Truncating and Inserting into table : silver.erp_px_cat_g1v2';
        TRUNCATE TABLE silver.erp_px_cat_g1v2;
        -- CLEANED AND INSERTED INTO silver.erp_px_cat_g1v2
        INSERT INTO silver.erp_px_cat_g1v2
            (
            id,
            cat,
            subcat,
            maintenance
            )
        SELECT
            id,
            cat,
            subcat,
            REPLACE(REPLACE(maintenance, CHAR(13), ''),CHAR(10), '') AS maintenance
        FROM bronze.erp_px_cat_g1v2;

        SET @end_time = GETDATE();


        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'sec';
        PRINT ' ';

------------------------------------------------------------------------------------------------------
        PRINT '=====================================================================';
        PRINT 'SUCCESSFULLY LOADED FILES INTO TABLES - SILVER LAYER';
        PRINT '=====================================================================';

        SET @batch_end_time = GETDATE();
        PRINT '------------------------------------';
        PRINT 'TOTAL BATCH EXECUTION TIME : ' + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'sec';
        PRINT '------------------------------------';
END TRY

BEGIN CATCH
    PRINT '>>ERROR OCCURED!<<';
    PRINT '>>ERROR MESSAGE<<' + ERROR_MESSAGE();
    PRINT '>>ERROR NUMBER<<' + CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT '>>ERROR STATE<<' + CAST(ERROR_STATE() AS NVARCHAR);
END CATCH

END

------------------------------------------------------------------------------------------------------