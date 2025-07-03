USE [DataWarehouse];
GO

IF EXISTS (SELECT 1 FROM [bronze].[crm_cust_info])
BEGIN
    TRUNCATE TABLE [bronze].[crm_cust_info];
END

BULK INSERT [bronze].[crm_cust_info]
FROM '/var/opt/mssql/data/datasets/source_crm/cust_info.csv'
WITH (
	   FIRSTROW = 2,
	   FIELDTERMINATOR =',',
	   ROWTERMINATOR = '\n',
	   TABLOCK	
	);

GO


IF EXISTS (SELECT 1 FROM [bronze].[crm_prd_inf])
BEGIN
    TRUNCATE TABLE [bronze].[crm_prd_inf];
END

BULK INSERT [bronze].[crm_prd_inf]
FROM '/var/opt/mssql/data/datasets/source_crm/prd_info.csv'
WITH (
	   FIRSTROW = 2,
	   FIELDTERMINATOR =',',
	   ROWTERMINATOR = '\n',
	   TABLOCK	
	);

GO


IF EXISTS (SELECT 1 FROM [bronze].[crm_sales_details])
BEGIN
    TRUNCATE TABLE [bronze].[crm_sales_details];
END

BULK INSERT [bronze].[crm_sales_details]
FROM '/var/opt/mssql/data/datasets/source_crm/sales_details.csv'
WITH (
	   FIRSTROW = 2,
	   FIELDTERMINATOR =',',
	   ROWTERMINATOR = '\n',
	   TABLOCK	
	);

GO

IF EXISTS (SELECT 1 FROM [bronze].[erp_cust_az12])
BEGIN
    TRUNCATE TABLE [bronze].[erp_cust_az12];
END

BULK INSERT [bronze].[erp_cust_az12]
FROM '/var/opt/mssql/data/datasets/source_erp/CUST_AZ12.csv'
WITH (
	   FIRSTROW = 2,
	   FIELDTERMINATOR =',',
	   ROWTERMINATOR = '\n',
	   TABLOCK	
	);

GO

IF EXISTS (SELECT 1 FROM [bronze].[erp_loc_a101])
BEGIN
    TRUNCATE TABLE [bronze].[erp_loc_a101];
END

BULK INSERT [bronze].[erp_loc_a101]
FROM '/var/opt/mssql/data/datasets/source_erp/LOC_A101.csv'
WITH (
	   FIRSTROW = 2,
	   FIELDTERMINATOR =',',
	   ROWTERMINATOR = '\n',
	   TABLOCK	
	);

GO


IF EXISTS (SELECT 1 FROM [bronze].[erp_px_cat_g1v2])
BEGIN
    TRUNCATE TABLE [bronze].[erp_px_cat_g1v2];
END

BULK INSERT [bronze].[erp_px_cat_g1v2]
FROM '/var/opt/mssql/data/datasets/source_erp/PX_CAT_G1V2.csv'
WITH (
	   FIRSTROW = 2,
	   FIELDTERMINATOR =',',
	   ROWTERMINATOR = '\n',
	   TABLOCK	
	);

GO
