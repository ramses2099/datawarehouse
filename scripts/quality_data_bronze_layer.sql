-- Check for Nulls or Duplicates in Primary key
-- Expectation: No Result

SELECT cst_id, COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
WHERE cst_id = 29466


SELECT * FROM (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
WHERE cst_id IS NOT NULL) t
WHERE flag_last = 1;


-- Check for unwanted spaces
-- Expectation : No Results
SELECT cst_firstname FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_firstname FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)


-- DATA Standardization & Consistency
SELECT DISTINCT [cst_gndr] FROM [bronze].[crm_cust_info]


INSERT INTO [silver].[crm_cust_info](
       [cst_id]
      ,[cst_key]
      ,[cst_firstname]
      ,[cst_lastname]
      ,[cst_material_status]
      ,[cst_gndr]
      ,[cst_create_date]
)
SELECT 
       [cst_id]
      ,[cst_key]
      ,TRIM([cst_firstname]) AS [cst_firstname]
      ,TRIM([cst_lastname]) AS [cst_lastname]
      ,CASE WHEN UPPER(TRIM([cst_material_status])) = 'S'  THEN 'Single'
            WHEN UPPER(TRIM([cst_material_status])) = 'M' THEN 'Married'
            ELSE 'n/a'
       END AS [cst_material_status]
      ,CASE WHEN UPPER(TRIM([cst_gndr])) = 'F'  THEN 'Female'
            WHEN UPPER(TRIM([cst_gndr])) = 'M' THEN 'Male'
            ELSE 'n/a'
       END AS [cst_gndr]
      ,[cst_create_date]
FROM (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
WHERE cst_id IS NOT NULL) t
WHERE flag_last = 1;

SELECT * FROM [silver].[crm_cust_info]