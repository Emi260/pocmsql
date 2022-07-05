--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:false 

set quoted_identifier on
go


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GateScale]') AND type in (N'U'))

CREATE TABLE dbo.GateScale
( 
	"GateScaleId"        int IDENTITY ( 1,1 ) ,
	"GateId"             int  NULL ,
	"ScaleId"            int  NULL ,
	"IsActive"           bit  NOT NULL 
	CONSTRAINT "dfGateScale_IsActive"
		 DEFAULT  (1),
	"RowStatus"          bit  NOT NULL ,
	"CreatedBy"          nvarchar(30)  NOT NULL ,
	"CreatedDate"        datetimeoffset  NOT NULL ,
	"ModifiedBy"         nvarchar(30)  NULL ,
	"ModifiedDate"       datetimeoffset  NULL ,
	CONSTRAINT "pkGateScale" PRIMARY KEY ("GateScaleId" ASC),
)
go
