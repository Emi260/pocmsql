--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:false

--IF NOT EXISTS (SELECT * FROM sys.indexes 
--	   WHERE object_id = OBJECT_ID(N'dbo.ELMAH_Error') 
--   AND name = N'ixELMAH_Error_Sequence')
--BEGIN
--  CREATE UNIQUE INDEX ixELMAH_Error_Sequence
--    ON dbo.ELMAH_Error ([Sequence])
--END
GO
