CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
BEGIN TRY
        DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
        PRINT '=====================================================================';
        PRINT 'LOADING FILES INTO TABLES - BRONZE LAYER' ;
        PRINT '=====================================================================';

        PRINT '------------------------------------';
        PRINT 'LOADING CRM FILES';
        PRINT '------------------------------------';
        
        SET @batch_start_time = GETDATE(); 

------------------------------------------------------------------------------------------------------

        SET @start_time = GETDATE();
        TRUNCATE TABLE [bronze].[crm_cust_info];
        PRINT 'bronze.crm_cust_info is TRUNCATED';

        PRINT '>> new data is loading into -- bronze.crm_cust_info';
        BULK INSERT [bronze].[crm_cust_info]
        FROM '/var/opt/mssql/datasets/source_crm/cust_info.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK  
        );
        SET @end_time = GETDATE();
        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+'sec';
        PRINT ' ';

------------------------------------------------------------------------------------------------------
        
        SET @start_time = GETDATE();
        TRUNCATE TABLE [bronze].[crm_prd_info];
        PRINT 'bronze.crm_prd_info is TRUNCATED';

        PRINT '>> new data is loading into -- bronze.crm_prd_info';
        BULK INSERT [bronze].[crm_prd_info]
        FROM '/var/opt/mssql/datasets/source_crm/prd_info.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+'sec';
        PRINT ' ';

------------------------------------------------------------------------------------------------------

        SET @start_time = GETDATE();
        TRUNCATE TABLE [bronze].[crm_sales_details];
        PRINT 'bronze.crm_sales_details is TRUNCATED';

        PRINT '>> new data is loading into -- bronze.crm_sales_details';
        BULK INSERT [bronze].[crm_sales_details]
        FROM '/var/opt/mssql/datasets/source_crm/sales_details.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+'sec';
        PRINT ' ';

------------------------------------------------------------------------------------------------------

        PRINT '------------------------------------';
        PRINT 'LOADING ERP FILES';
        PRINT '------------------------------------';

------------------------------------------------------------------------------------------------------

        SET @start_time = GETDATE();
        TRUNCATE TABLE [bronze].[erp_cust_az12];
        PRINT 'bronze.erp_cust_az12 is TRUNCATED';

        PRINT '>> new data is loading into -- bronze.erp_cust_az12';
        BULK INSERT [bronze].[erp_cust_az12]
        FROM '/var/opt/mssql/datasets/source_erp/CUST_AZ12.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+'sec';
        PRINT ' ';

------------------------------------------------------------------------------------------------------

        SET @start_time = GETDATE();
        TRUNCATE TABLE [bronze].[erp_loc_a101];
        PRINT 'bronze.erp_loc_a101 is TRUNCATED';

        PRINT '>> new data is loading into -- bronze.erp_loc_a101';
        BULK INSERT [bronze].[erp_loc_a101]
        FROM '/var/opt/mssql/datasets/source_erp/LOC_A101.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+'sec';
        PRINT ' ';

------------------------------------------------------------------------------------------------------

        SET @start_time = GETDATE();
        TRUNCATE TABLE [bronze].[erp_px_cat_g1v2];
        PRINT 'bronze.erp_px_cat_g1v2 is TRUNCATED';

        PRINT '>> new data is loading into -- bronze.erp_px_cat_g1v2';
        BULK INSERT [bronze].[erp_px_cat_g1v2]
        FROM '/var/opt/mssql/datasets/source_erp/PX_CAT_G1V2.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '-- time duration : ' + CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR)+'sec';
        PRINT ' ';

------------------------------------------------------------------------------------------------------

        PRINT '=====================================================================';
        PRINT 'SUCESSFULLY LOADED FILES INTO TABLES - BRONZE LAYER';
        PRINT '=====================================================================';
        
        SET @batch_end_time = GETDATE();
        PRINT '------------------------------------';
        PRINT 'TOTAL BATCH EXECUTION TIME : '+ CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) +'sec';
        PRINT '------------------------------------';

END TRY

BEGIN CATCH
    PRINT '>>ERROR OCCURED!<<';
    PRINT '>>ERROR MESSAGE<<' + ERROR_MESSAGE();
    PRINT '>>ERROR NUMBER<<' + CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT '>>ERROR STATE<<' + CAST(ERROR_STATE() AS NVARCHAR);


END CATCH
END



-- TO CHECK THE TOTAL NUMBER OF ROWS WHETHER THAT ALL ROWS ARE INSERTED ARE NOT.
SELECT COUNT(*) FROM bronze.crm_cust_info