/****** Object:  StoredProcedure [dbo].[UpdateWatermarkTable]    Script Date: 16-10-2024 04:29:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateWatermarkTable]
    @PRM_TableName NVARCHAR(255),
    @PRM_LastUpdatedValue NVARCHAR(255),
    @PRM_LastRunTime DATETIME
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    -- Define the dynamic SQL query
    SET @sql = N'
        UPDATE WatermarkTable
        SET LastUpdatedValue = @PRM_LastUpdatedValue,
            LastRunTime = @PRM_LastRunTime
        WHERE TableName = @PRM_TableName;
    ';

    -- Execute the dynamic SQL with all parameters
    EXEC sp_executesql @sql,
        N'@PRM_TableName NVARCHAR(255), @PRM_LastUpdatedValue NVARCHAR(255), @PRM_LastRunTime DATETIME',
        @PRM_TableName, @PRM_LastUpdatedValue, @PRM_LastRunTime;
END;
GO


