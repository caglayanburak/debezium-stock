use master
CREATE DATABASE DebeziumTest
USE DebeziumTest
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
[Id] [int] IDENTITY(1,1) NOT NULL,
[Name] [varchar](500) NULL,
[StockCode] [varchar](50) NULL,
[Price] [decimal](18, 2) NULL,
[StockQuantity] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED
(
[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

USE DebeziumTest
EXEC sys.sp_cdc_enable_db


USE DebeziumTest
GO
EXEC sys.sp_cdc_enable_table
@source_schema = N'dbo',
@source_name = N'Product',
@role_name = NULL,
@filegroup_name = N'',
@supports_net_changes = 0
GO
update Product set StockQuantity=32 where Id=1

select * from Product

INSERT INTO Product(Name,StockCode,Price,StockQuantity) VALUES('Test Product 2','TST-123123',104,5)