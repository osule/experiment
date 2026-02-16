-- Create an external JDBC catalog for SQL Server
CREATE EXTERNAL CATALOG jdbc_sqlserver
PROPERTIES (
    "type" = "jdbc",
    "user" = "sa",
    "password" = "YourPassword123!",
    "jdbc_uri" = "jdbc:sqlserver://sqlserver:1433;databaseName=raw_db;encrypt=false",
    "driver_url" = "https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/12.2.0.jre11/mssql-jdbc-12.2.0.jre11.jar",
    "driver_class" = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
);

-- Note: StarRocks all-in-one image might already have drivers, 
-- but we specify driver_url for completeness.

-- Create the destination database in StarRocks
CREATE DATABASE IF NOT EXISTS main;

-- StarRocks views or external tables can be created to map to the catalog
-- but dbt will handle the table creation based on the source definition.
