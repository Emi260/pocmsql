--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true
DECLARE @CodeMaintenanceTable VARCHAR(5)
DECLARE @CodeMaintenanceTableDetail VARCHAR(5)
DECLARE @LanguageEsId INT
DECLARE @LanguageEnId INT
DECLARE @CodeLanguageEs varchar(2)
DECLARE @CodeLanguageEn varchar(2)
SET @CodeMaintenanceTable = 'TDDO'
SET @CodeMaintenanceTableDetail = 'OR'
SET @CodeLanguageEs = 'ES'
SET @CodeLanguageEn = 'EN'

