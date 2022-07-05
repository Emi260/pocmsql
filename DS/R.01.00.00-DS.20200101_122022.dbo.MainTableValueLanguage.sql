--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true
DECLARE @TableName VARCHAR(50)
DECLARE @CodeTableName VARCHAR(20)
DECLARE @MainTableValueId INT
DECLARE @LanguageEsId INT
DECLARE @LanguageEnId INT
DECLARE @CodeLanguageEs varchar(2)
DECLARE @CodeLanguageEn varchar(2)
SET @TableName = 'TransactionType'
SET @CodeLanguageEs = 'ES'
SET @CodeLanguageEn = 'EN'

SET @CodeTableName = 'ENTRY'

