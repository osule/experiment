USE master;
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'raw_db')
BEGIN
    CREATE DATABASE raw_db;
END
GO

USE raw_db;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[table_in_sqlserver]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[table_in_sqlserver] (
        [report_time] DATETIME2 NOT NULL,
        [user_id] BIGINT NOT NULL,
        [other_cols] NVARCHAR(MAX)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_table_in_sqlserver_report_time' AND object_id = OBJECT_ID('dbo.table_in_sqlserver'))
BEGIN
    CREATE INDEX IX_table_in_sqlserver_report_time ON [dbo].[table_in_sqlserver] ([report_time]);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_table_in_sqlserver_user_id' AND object_id = OBJECT_ID('dbo.table_in_sqlserver'))
BEGIN
    CREATE INDEX IX_table_in_sqlserver_user_id ON [dbo].[table_in_sqlserver] ([user_id]);
END
GO

-- Seed some test data
INSERT INTO [dbo].[table_in_sqlserver] (report_time, user_id, other_cols)
VALUES 
('2025-11-01 10:00:00', 1, 'Data 1'),
('2025-11-01 11:00:00', 2, 'Data 2'),
('2025-11-02 09:00:00', 1, 'Data 3'),
('2025-11-02 10:30:00', 3, 'Data 4'),
(GETUTCDATE(), 4, 'Real-time data');
GO
