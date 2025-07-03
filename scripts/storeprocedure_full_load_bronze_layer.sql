-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'bronze'
     AND SPECIFIC_NAME = N'load_bronze' 
)
BEGIN
  DROP PROCEDURE [bronze].[load_bronze];
END
GO

CREATE PROCEDURE [bronze].[load_bronze]
AS
BEGIN
  DECLARE @start_time DATETIME;
  DECLARE @end_time DATETIME;
  DECLARE @batch_start_time DATETIME;
  DECLARE @batch_end_time DATETIME;

  BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '==============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==============================================';

		PRINT '-----------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: [bronze].[crm_cust_info]';
		IF EXISTS (SELECT 1 FROM [bronze].[crm_cust_info])
		BEGIN
			TRUNCATE TABLE [bronze].[crm_cust_info];
		END

		PRINT '>> Inserting data into Table: [bronze].[crm_cust_info]';
		BULK INSERT [bronze].[crm_cust_info]
		FROM '/var/opt/mssql/data/datasets/source_crm/cust_info.csv'
		WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR =',',
			   ROWTERMINATOR = '\n',
			   TABLOCK	
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: [bronze].[crm_prd_inf]';
		IF EXISTS (SELECT 1 FROM [bronze].[crm_prd_inf])
		BEGIN
			TRUNCATE TABLE [bronze].[crm_prd_inf];
		END

		PRINT '>> Inserting data into Table: [bronze].[crm_prd_inf]';
		BULK INSERT [bronze].[crm_prd_inf]
		FROM '/var/opt/mssql/data/datasets/source_crm/prd_info.csv'
		WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR =',',
			   ROWTERMINATOR = '\n',
			   TABLOCK	
			);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: [bronze].[crm_sales_details]';
		IF EXISTS (SELECT 1 FROM [bronze].[crm_sales_details])
		BEGIN
			TRUNCATE TABLE [bronze].[crm_sales_details];
		END

		PRINT '>> Inserting data into Table: [bronze].[crm_sales_details]';
		BULK INSERT [bronze].[crm_sales_details]
		FROM '/var/opt/mssql/data/datasets/source_crm/sales_details.csv'
		WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR =',',
			   ROWTERMINATOR = '\n',
			   TABLOCK	
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------';


		PRINT '-----------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze].[erp_cust_az12]';
		IF EXISTS (SELECT 1 FROM [bronze].[erp_cust_az12])
		BEGIN
			TRUNCATE TABLE [bronze].[erp_cust_az12];
		END

		PRINT '>> Inserting data into Table: [bronze].[erp_cust_az12]';
		BULK INSERT [bronze].[erp_cust_az12]
		FROM '/var/opt/mssql/data/datasets/source_erp/CUST_AZ12.csv'
		WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR =',',
			   ROWTERMINATOR = '\n',
			   TABLOCK	
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: [bronze].[erp_loc_a101]';
		IF EXISTS (SELECT 1 FROM [bronze].[erp_loc_a101])
		BEGIN
			TRUNCATE TABLE [bronze].[erp_loc_a101];
		END

		PRINT '>> Inserting data into Table: [bronze].[erp_loc_a101]';
		BULK INSERT [bronze].[erp_loc_a101]
		FROM '/var/opt/mssql/data/datasets/source_erp/LOC_A101.csv'
		WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR =',',
			   ROWTERMINATOR = '\n',
			   TABLOCK	
			);

		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------';

		SET @start_time = GETDATE();
        PRINT '>> Truncating Table: [bronze].[erp_px_cat_g1v2]';
		IF EXISTS (SELECT 1 FROM [bronze].[erp_px_cat_g1v2])
		BEGIN
			TRUNCATE TABLE [bronze].[erp_px_cat_g1v2];
		END

		PRINT '>> Inserting data into Table: [bronze].[erp_px_cat_g1v2]';
		BULK INSERT [bronze].[erp_px_cat_g1v2]
		FROM '/var/opt/mssql/data/datasets/source_erp/PX_CAT_G1V2.csv'
		WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR =',',
			   ROWTERMINATOR = '\n',
			   TABLOCK	
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '--------';

		SET @batch_end_time = GETDATE();
		PRINT '==========================================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT ' - Total Load Duration: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '==========================================================';

	END TRY
	BEGIN CATCH
		PRINT '===============================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Message: ' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message: ' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '===============================================';
	END CATCH

	
END

-- =============================================
-- Example to execute the stored procedure
-- =============================================
 EXECUTE [bronze].[load_bronze];
