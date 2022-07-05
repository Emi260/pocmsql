﻿--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:false

--if not exists( select 1
--                 from sys.indexes
--                where object_id = object_id( N'dbo.EquipmentActivity' )
--                  and name      = N'ix_EquipmentActivity_EquipmentId_VisitId_EquipmentActivityTypeId_Filtered'
--             )
--create unique index ix_EquipmentActivity_EquipmentId_VisitId_EquipmentActivityTypeId_Filtered
--  on dbo.EquipmentActivity 
--    (EquipmentId, VisitId,   EquipmentActivityTypeId)
--      WHERE RowStatus = 1 AND EquipmentActivityTypeId IN (3,4)
--      