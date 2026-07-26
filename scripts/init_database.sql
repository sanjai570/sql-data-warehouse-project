/*
=====================================================
Creating a DataBase
=====================================================
script purpose:
    We are going to create a database called 'DataWarehouse' 
    If this database already exists we going to drop it and create a new one .
    With that we are going to create scheams in the database name 'bronze','silver'and 'gold'

WARNING :
 Run this script with caution because it will delete enitre 'DataWarehouse' if it exists.
 All data in that will be delete if it is executed  and ensure you have a proper backup!

 */


-- changing to master database
USE master;
GO

-- drop and recreate a 'Data Warehouse' database

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse
END
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
