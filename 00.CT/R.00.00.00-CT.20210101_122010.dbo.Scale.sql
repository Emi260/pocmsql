--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:false 
set quoted_identifier on
go

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Scale]') AND type in (N'U'))


CREATE TABLE dbo."Scale"
( 
	"ScaleId"            int IDENTITY ( 1,1 ) ,
	"Code"               nvarchar(30)  NOT NULL ,
	"LocalHost"          nvarchar(50)  NOT NULL ,
	"IpLAN"              nvarchar(20)  NOT NULL ,
	"Serie"              nvarchar(30)  NOT NULL ,
	"Weight"             numeric(10,2)  NULL ,
	"BitsSecond"         int  NOT NULL ,
	"BitsData"           int  NOT NULL ,
	"Paridad"            nvarchar(30)  NOT NULL ,
	"BitsStop"           numeric(4,2)  NOT NULL ,
	"FlowControl"        nvarchar(30)  NULL ,
	"ValueIn"            nvarchar(30)  NOT NULL ,
	"COMDefault"         nvarchar(30)  NOT NULL ,
	"IsActive"           bit  NOT NULL 
	CONSTRAINT "dfScale_IsActive"
		 DEFAULT  (1),
	"RowStatus"          bit  NOT NULL ,
	"CreatedBy"          nvarchar(30)  NOT NULL ,
	"CreatedDate"        datetimeoffset  NOT NULL ,
	"ModifiedBy"         nvarchar(30)  NULL ,
	"ModifiedDate"       datetimeoffset  NULL ,
	"ScaleStatusId"      int  NOT NULL ,
	"YardId"             int  NULL ,
	CONSTRAINT "pkScale" PRIMARY KEY ("ScaleId" ASC))

go
