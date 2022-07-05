--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true

DECLARE @CategoryName VARCHAR(50)
DECLARE @Name VARCHAR(50)
DECLARE @Value VARCHAR(255)
DECLARE @DataType varchar(255)
DECLARE @Comment varchar(255)

Set @CategoryName = 'AppToken'

Set @Name = 'Time'
Set @Value = '300'
Set @DataType = 'Int'
Set @Comment = 'Tiempo en segundos para determinar la vigencia del token'

