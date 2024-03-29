USE [Udemy]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_ChurnModeling]    Script Date: 4/19/2021 12:12:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: Siddhesh Mirjankar
-- Create date: 20210419
-- Description:	RAW->WRK
-- =============================================

ALTER PROC [dbo].[BLD_WRK_ChurnModeling]

AS
BEGIN

-- =============================================
-- Dropping if the RAW table exists
-- =============================================

IF OBJECT_ID('RAW_ChurnModeling_20210419') IS NOT NULL
DROP TABLE [RAW_ChurnModeling_20210419]

-- =============================================
-- Creating the RAW table
-- =============================================

SELECT DISTINCT

[Udemy].[dbo].[RAW_CustomerData_20210419].[CustomerId]
,[Surname]
,[Geography]
,[Gender]
,[Age]
,[CreditScore]
,[Tenure]
,[Balance]
,[NumOfProducts]
,[HasCrCard]
,[IsActiveMember]
,[EstimatedSalary]
,[Exited]

INTO [RAW_ChurnModeling_20210419]

FROM [Udemy].[dbo].[RAW_CustomerData_20210419]
LEFT JOIN [Udemy].[dbo].[RAW_CustomerHistory_20210419]
ON [Udemy].[dbo].[RAW_CustomerData_20210419].[CustomerId] = [Udemy].[dbo].[RAW_CustomerHistory_20210419].[CustomerId]

-- =============================================
-- Dropping if the WRK table exists
-- =============================================

IF OBJECT_ID('WRK_ChurnModeling_20210419') IS NOT NULL
DROP TABLE [WRK_ChurnModeling_20210419]

-- =============================================
-- Creating the WRK table
-- =============================================

CREATE TABLE [WRK_ChurnModeling_20210419]
(

[RowNumber] int identity(1,1)
,[CustomerId] varchar(5000)
,[Surname] varchar(5000)
,[Geography] varchar(5000)
,[Gender] varchar(6)
,[Age] int
,[CreditScore] varchar(3)
,[Tenure] varchar(5000)
,[Balance] float
,[NumOfProducts] varchar(5000)
,[HasCrCard] varchar(1)
,[IsActiveMember] varchar(1)
,[EstimatedSalary] float
,[Exited] varchar(1)

)

-- =============================================
-- Storing the data from RAW table to WRK table
-- =============================================

INSERT INTO [WRK_ChurnModeling_20210419]
(

[CustomerId]
,[Surname]
,[Geography]
,[Gender]
,[Age]
,[CreditScore]
,[Tenure]
,[Balance]
,[NumOfProducts]
,[HasCrCard]
,[IsActiveMember]
,[EstimatedSalary]
,[Exited]

)
	
SELECT

[CustomerId]
,[Surname]
,[Geography]
,[Gender]
,[Age]
,[CreditScore]
,[Tenure]
,[Balance]
,[NumOfProducts]
,[HasCrCard]
,[IsActiveMember]
,[EstimatedSalary]
,[Exited]

FROM [dbo].[RAW_ChurnModeling_20210419]

-- =============================================
-- Retrieving the data stored in the WRK table
-- =============================================
	
SELECT

[RowNumber]
,[CustomerId]
,[Surname]
,[Geography]
,[Gender]
,[Age]
,[CreditScore]
,[Tenure]
,[Balance]
,[NumOfProducts]
,[HasCrCard]
,[IsActiveMember]
,[EstimatedSalary]
,[Exited]

FROM [dbo].[WRK_ChurnModeling_20210419]

END
