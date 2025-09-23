/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'CRM_DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'CRM_DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'CRM_DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'CRM_DataWarehouse')
BEGIN
    ALTER DATABASE CRM_DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CRM_DataWarehouse;
END;
GO

-- Create the 'CRM_DataWarehouse' database
CREATE DATABASE CRM_DataWarehouse;
GO

USE CRM_DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

