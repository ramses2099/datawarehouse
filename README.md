# Data Warehouse

SQL Server Data Warehouse Project

## Data Warehouse
- A subject-oriented, integrated, time-variant, and non-volatile collection of data in support of management's decision-making process.

## ETL
- ETL stands for Extract, Transform, Load. It's a data integration process used to combine data from multiple sources into a single, unified repository, often a data warehouse or data lake. This process involves extracting data from various sources, transforming it into a usable format, and then loading it into the target system. 

## Tools for the project
1. SQL Server Express
1. SQL Server Management Studio (SSMS)
1. Git Repository
1. DrawIO
1. Notion

## Project Requirements
- Building the Data Warehouse (Data Engineering)
### Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

### Specifications
- **Data Sources:** Import data from two sources system (ERP and CRM) provided as CSV files.
- **Data Quality:** Cleanse and resolve data quality issues prior to analysis.
- **Integration:** Combine both sources into a single, user-friendly dta model designed for analytical queries.
- **Scope:** Focus on the latest dataset onlyl; historization of data is not required.
- **Documentation:** Provide clear documentation of the data model to support both business stakeholders and analytics team.

## BI: Analytics & Reporting (Data Analysis)
### Objective
Develop SQL-based analytics to deliver detailed insigths into:
- **Customer Behavior**
- **Product Performance**
- **Sales Trends**

These insights empower stakeholders with key business metrics, strategic decision-making.

## General Principles
- **Naming Conventions:** Use snake_case, with lowercase and underscores ( _ ) to separate words.
- **Language:** Use English for all names.
- **Avoid Reserved Words:** Do not use SQL reserved word as object names.

## Table Naming Conventions
### Bronze Rules
- All names must start with the sources system name, and tables must match their orginal names without renaming.
- sourcesystem_entity
- sourcesystem: Name of the source system (e.g., crm, erp)
- entity: Exact table name from the source system.
- Example: crm_customer_info -> Customer information from the CRM system.

### Silver Rules
- All names must start with the sources system name, and tables must match their orginal names without renaming.
- sourcesystem_entity
- sourcesystem: Name of the source system (e.g., crm, erp)
- entity: Exact table name from the source system.
- Example: crm_customer_info -> Customer information from the CRM system.

### Gold Rules
- All names must start with the sources system name, and tables must match their orginal names without renaming.
- sourcesystem_entity
- sourcesystem: Name of the source system (e.g., crm, erp)
- entity: Exact table name from the source system.
- Example: crm_customer_info -> Customer information from the CRM system.