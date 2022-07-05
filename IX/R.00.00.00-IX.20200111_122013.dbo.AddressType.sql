--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:false

--if not exists( select 1
--                 from sys.indexes
--                where object_id = object_id( N'dbo.AddressType' )
--                  and name      = N'ix_AddressType_Code'
--             )
--create unique index ixAddressType_Code
--  on dbo.AddressType (Code)
