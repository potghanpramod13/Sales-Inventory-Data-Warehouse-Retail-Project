/****** Object:  StoredProcedure [dbo].[CreateWatermarkTableIfNotExists]    Script Date: 16-10-2024 04:29:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateWatermarkTableIfNotExists]
    @PRM_TableName NVARCHAR(255),
    @PRM_LastUpdatedValue NVARCHAR(255)
AS
BEGIN
    -- Check if the table 'watermarktable' exists
    IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'watermarktable') AND type = N'U')
    BEGIN
        -- Create the table if it does not exist
        CREATE TABLE watermarktable (
            WatermarkId INT IDENTITY(1,1) PRIMARY KEY,
            TableName NVARCHAR(255),
            LastUpdatedValue NVARCHAR(255),
            LastRunTime DATETIME
        );
    END;

    -- Insert values into the 'watermarktable' only if the TableName is 'ORDER_DETAILS' or 'ORDER_HEADER'
    IF @PRM_TableName IN ('ORDER_DETAILS', 'ORDER_HEADER')
    BEGIN
        -- Check if the TableName does not already exist
        IF NOT EXISTS (SELECT 1 FROM watermarktable WHERE TableName = @PRM_TableName)
        BEGIN
            INSERT INTO watermarktable (TableName, LastUpdatedValue)
            VALUES (@PRM_TableName, @PRM_LastUpdatedValue);
        END;
    END;
END;
GO


