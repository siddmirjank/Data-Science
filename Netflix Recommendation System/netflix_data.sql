USE [Netflix]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_NetflixData]    Script Date: 5/11/2021 6:24:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Siddhesh Mirjankar
-- Create date: 20210511
-- Description:	RAW->WRK
-- =============================================

ALTER PROC [dbo].[BLD_WRK_NetflixData]

AS
BEGIN

-- =============================================
-- Dropping if the RAW table exists
-- =============================================

IF OBJECT_ID('RAW_NetflixData_20210511') IS NOT NULL
DROP TABLE [RAW_NetflixData_20210511]

-- =============================================
-- Creating the RAW table
-- =============================================

SELECT DISTINCT

[Netflix].[dbo].[RAW_ShowData_20210511].[show_id],
[type],
[title],
[country],
[release_year],
[rating],
[duration],
[genre]

INTO [RAW_NetflixData_20210511]

FROM [Netflix].[dbo].[RAW_ShowData_20210511]
JOIN [Netflix].[dbo].[RAW_ShowDescription_20210511]
ON [Netflix].[dbo].[RAW_ShowData_20210511].[show_id] = [Netflix].[dbo].[RAW_ShowDescription_20210511].[show_id]

-- =============================================
-- Dropping if the WRK table exists
-- =============================================

IF OBJECT_ID('WRK_NetflixData_20210511') IS NOT NULL
DROP TABLE [WRK_NetflixData_20210511]

-- =============================================
-- Creating the WRK table
-- =============================================

CREATE TABLE [WRK_NetflixData_20210511]
(

[row_number] int identity(1,1),
[show_id] varchar(5000),
[type] varchar(5000),
[title] varchar(5000),
[country] varchar(5000),
[release_year] varchar(5000),
[rating] varchar(5000),
[duration] varchar(5000),
[genre] varchar(5000)

)

-- =============================================
-- Storing the data from RAW table to WRK table
-- =============================================

INSERT INTO [WRK_NetflixData_20210511]
(

[show_id],
[type],
[title],
[country],
[release_year],
[rating],
[duration],
[genre]

)
	
SELECT

[show_id],
[type],
[title],
[country],
[release_year],
[rating],
[duration],
[genre]

FROM [dbo].[RAW_NetflixData_20210511]

-- =============================================
-- Retrieving the data stored in the WRK table
-- =============================================
	
SELECT

[show_id],
[type],
[title],
[country],
[release_year],
[rating],
[duration],
[genre]

FROM [dbo].[WRK_NetflixData_20210511]

END
