--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true
DECLARE @CodeEquipmentActivityType VARCHAR(5)
DECLARE @CodeOperationType VARCHAR(5)
DECLARE @CodeLanguageEs varchar(2)
DECLARE @CodeLanguageEn varchar(2)
SET @CodeEquipmentActivityType = 'PDS'
SET @CodeOperationType = 'I'
SET @CodeLanguageEs = 'ES'
SET @CodeLanguageEn = 'EN'

