--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true
DECLARE @CodeMaintenanceTable VARCHAR(5)
DECLARE @CodeMaintenanceTableDetail VARCHAR(5)
DECLARE @CodeLanguageEs varchar(2)
DECLARE @CodeLanguageEn varchar(2)
DECLARE @CodeEntity VARCHAR (5)
SET @CodeEntity = 'IMP'
SET @CodeMaintenanceTable = 'CART'
SET @CodeLanguageEs = 'ES'
