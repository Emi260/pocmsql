--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true

DECLARE @EntityCode VARCHAR(5)
DECLARE @CodeMaintenanceTable VARCHAR(5)
DECLARE @CodeMaintenanceTableDetail VARCHAR(5)
DECLARE @CodeLanguageEs varchar(2)
DECLARE @CodeLanguageEn varchar(2)

SET @EntityCode = 'DTK'
SET @CodeMaintenanceTable = 'DTTK'
SET @CodeLanguageEs = 'ES'
SET @CodeLanguageEn = 'EN'

