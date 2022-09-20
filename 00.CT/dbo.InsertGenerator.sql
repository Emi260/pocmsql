--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true
/****** Object:  StoredProcedure [dbo].[InsertGenerator]    Script Date: 8/14/2020 8:20:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF 
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertGenerator]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[InsertGenerator] AS' 
END
GO

ALTER PROC [dbo].[InsertGenerator]
    (
      @tableName VARCHAR(100) ,
      @KeyColumn1 VARCHAR(100) = '' ,
      @KeyColumn2 VARCHAR(100) = '',
	  @IncluyeIdentity BIT = 1
    )
AS -- Generating INSERT statements in SQL Server
-- From CodeProject By Sumit Amar | 17 Jan 2005
-- Updated By Imtiaz Lorgat 19 May 2012 
-- to validate if record exists - supports 2 field Unique index

-- EXEC InsertGenerator 'Entity', 'Code', null, 0

--Declare a cursor to retrieve column specific information for the specified table
    DECLARE cursCol CURSOR FAST_FORWARD
    FOR
        SELECT  COLUMN_NAME ,
                DATA_TYPE
        FROM    INFORMATION_SCHEMA.COLUMNS
        WHERE   TABLE_NAME = @tableName;

    OPEN cursCol;

    DECLARE @string NVARCHAR(MAX); --for storing the first half of INSERT statement
    DECLARE @stringData NVARCHAR(MAX); --for storing the data (VALUES) related statement
    DECLARE @dataType NVARCHAR(1000); --data types returned for respective columns
    DECLARE @FieldVal NVARCHAR(1000); -- save value for the current field
    DECLARE @KeyVal NVARCHAR(1000); -- save value for the current field
    DECLARE @KeyTest0 NVARCHAR(1000); -- used to test if key exists
    DECLARE @KeyTest1 NVARCHAR(1000); -- used to test if key exists
    DECLARE @KeyTest2 NVARCHAR(1000); -- used to test if key exists

    DECLARE @FieldNameIdentity NVARCHAR(128);
    DECLARE @FieldNamePrimary NVARCHAR(128);

    SET @KeyTest0 = '';

    IF @KeyColumn1 <> ''
        SET @KeyTest0 = 'IF NOT EXISTS (SELECT TOP 1 '+ @KeyColumn1 +' FROM ' + @tableName;

    SET @KeyTest1 = '';
    SET @KeyTest2 = '';

    SET @string = 'INSERT ' + @tableName + '(';
    SET @stringData = '';
    SET @FieldVal = '';
    SET @KeyVal = '';

    DECLARE @colName NVARCHAR(50);

    FETCH NEXT FROM cursCol INTO @colName, @dataType;

    IF @@fetch_status <> 0
        BEGIN
            PRINT 'TABLE ' + @tableName + ' NOT FOUND, PROCESSING SKIPPED.';
            CLOSE cursCol;
            DEALLOCATE cursCol;
            RETURN;
        END;

	SET @FieldNameIdentity = ''

	select TOP 1 @FieldNameIdentity = name from sys.columns where object_name(object_id) = 'Entity' and is_identity = 1

	IF @IncluyeIdentity = 1 
	   BEGIN	
			IF RTRIM(@FieldNameIdentity) = ''
			BEGIN
				PRINT 'TABLE ' + @tableName + ' NOT IDENTITY COLUMN, PROCESSING SKIPPED.';
				CLOSE cursCol;
				DEALLOCATE cursCol;
				RETURN;
			END
			
			select TOP 1 @FieldNamePrimary = column_name from information_schema.key_column_usage where table_name like 'Entity' and constraint_name like 'PK%'

			IF RTRIM(@FieldNameIdentity) <> RTRIM(@FieldNamePrimary)
			BEGIN
				PRINT 'TABLE ' + @tableName + ' IDENTITY AND PRIMARY KEY ARE DIFFERENT, PROCESSING SKIPPED.';
				CLOSE cursCol;
				DEALLOCATE cursCol;
				RETURN;
			END	
	   END	

    WHILE @@FETCH_STATUS = 0
        BEGIN
			IF (@IncluyeIdentity = 1) OR (@FieldNameIdentity <> @colName)
			BEGIN

				IF @dataType IN ( 'varchar', 'char', 'nchar', 'nvarchar' )
					BEGIN
						SET @FieldVal = '''' + '''+isnull(''''' + '''''+'
							+ @colName + '+''''' + ''''',''NULL'')+'',''+';
						SET @KeyVal = '''+isnull(''''' + '''''+' + @colName
							+ '+''''' + ''''',''NULL'')+'',''+';
						SET @stringData = @stringData + @FieldVal;
					END;

				ELSE
					IF @dataType IN ( 'text', 'ntext', 'xml' ) --if the datatype is text or something else 
						BEGIN
							SET @FieldVal = '''''''''+isnull(cast(' + @colName
								+ ' as varchar(max)),'''')+'''''',''+';
							SET @stringData = @stringData + @FieldVal;
						END;
					ELSE
						IF @dataType = 'money' --because money doesn't get converted from varchar implicitly
							BEGIN
								SET @FieldVal = '''convert(money,''''''+isnull(cast('
									+ @colName
									+ ' as varchar(200)),''0.0000'')+''''''),''+';
								SET @stringData = @stringData + @FieldVal;
							END;
						ELSE
							IF @dataType = 'datetime'
								BEGIN
									SET @FieldVal = '''convert(datetime,'
										+ '''+isnull('''''
										+ '''''+convert(varchar(200),' + @colName
										+ ',121)+'''''
										+ ''''',''NULL'')+'',121),''+';
									SET @stringData = @stringData + @FieldVal;
								END;
							ELSE
								IF @dataType = 'image'
									BEGIN
										SET @FieldVal = '''''''''+isnull(cast(convert(varbinary,'
											+ @colName
											+ ') as varchar(6)),''0'')+'''''',''+';
										SET @stringData = @stringData + @FieldVal;
									END;
								ELSE --presuming the data type is int,bit,numeric,decimal 
									BEGIN
										SET @FieldVal = '''' + '''+isnull('''''
											+ '''''+convert(varchar(200),'
											+ @colName + ')+'''''
											+ ''''',''NULL'')+'',''+';
										SET @KeyVal = '''+isnull('''''
											+ '''''+convert(varchar(200),'
											+ @colName + ')+'''''
											+ ''''',''NULL'')+'',''+';
										SET @stringData = @stringData + @FieldVal;
									END;

	--Build key test
				IF @KeyColumn1 = @colName
					BEGIN
						SET @KeyTest1 = ' WHERE [' + @KeyColumn1 + ']=';
						SET @KeyTest1 = @KeyTest1 + @KeyVal + ']';
					END;
				IF @KeyColumn2 = @colName
					BEGIN
						SET @KeyTest2 = ' AND [' + @KeyColumn2 + ']=';
						SET @KeyTest2 = @KeyTest2 + @KeyVal + ']';
					END;

				SET @string = @string + '[' + @colName + '],';
			END;

            FETCH NEXT FROM cursCol INTO @colName, @dataType;
        END;

    DECLARE @Query NVARCHAR(MAX);

-- Build the test string to check if record exists
    IF @KeyTest0 <> ''
        BEGIN
            IF @KeyColumn1 <> ''
                SET @KeyTest0 = @KeyTest0 + SUBSTRING(@KeyTest1, 0,
                                                      LEN(@KeyTest1) - 4);
            IF @KeyColumn2 <> ''
                BEGIN
                    SET @KeyTest0 = @KeyTest0 + '''';
                    SET @KeyTest0 = @KeyTest0 + SUBSTRING(@KeyTest2, 0,
                                                          LEN(@KeyTest2) - 4);
                END;
            SET @KeyTest0 = @KeyTest0 + ''')';

            SET @Query = 'SELECT ''' + SUBSTRING(@KeyTest0, 0, LEN(@KeyTest0))
                + ') '; 
        END;
    ELSE
        SET @Query = 'SELECT ''' + SUBSTRING(@KeyTest0, 0, LEN(@KeyTest0));

    SET @Query = @Query + SUBSTRING(@string, 0, LEN(@string)) + ') '; 
    SET @Query = @Query + 'VALUES(''+ ' + SUBSTRING(@stringData, 0,
                                                    LEN(@stringData) - 2)
        + '''+'')'' FROM ' + @tableName;

    EXEC sp_executesql @Query;

    CLOSE cursCol;
    DEALLOCATE cursCol;
GO
