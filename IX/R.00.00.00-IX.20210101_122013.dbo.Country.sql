--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:false


--if not exists( select 1
--                 from sys.indexes
--                where object_id = object_id( N'dbo.Country' )
--                  and name      = N'ixCountry_Code'
--             )
--create unique index ixCountry_Code
--  on dbo.Country (Code)
--
go
