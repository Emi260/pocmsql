--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true
DECLARE @EntityId INT
DECLARE @LangugeIdES INT
DECLARE @LangugeIdEN INT
DECLARE @Code nvarchar(4)
DECLARE @CodeStatusType nvarchar(4)
DECLARE @EntityStatusTypeId INT

SET @Code = 'VOY'
