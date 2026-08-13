CREATE OR REPLACE TABLE 
	INFA.Dim_Office_Hours
	(
		Dim_Office_Hours_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Monday_Office_Hours VARCHAR NOT NULL, 
		Tuesday_Office_Hours VARCHAR NOT NULL, 
		Wednesday_Office_Hours VARCHAR NOT NULL, 
		Thursday_Office_Hours VARCHAR NOT NULL, 
		Friday_Office_Hours VARCHAR NOT NULL, 
		Saturday_Office_Hours VARCHAR NOT NULL, 
		Sunday_Office_Hours VARCHAR NOT NULL, 
		Open_Monday_Ind VARCHAR NOT NULL,
		Open_Tuesday_Ind VARCHAR NOT NULL, 
		Open_Wednesday_Ind VARCHAR NOT NULL, 
		Open_Thursday_Ind VARCHAR NOT NULL, 
		Open_Friday_Ind VARCHAR NOT NULL, 
		Open_Saturday_Ind VARCHAR NOT NULL, 
		Open_Sunday_Ind VARCHAR NOT NULL, 
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Office_Hours PRIMARY KEY (Dim_Office_Hours_Key), 
		CONSTRAINT UK_Dim_Office_Hours UNIQUE (Monday_Office_Hours, Tuesday_Office_Hours, Wednesday_Office_Hours, Thursday_Office_Hours, Friday_Office_Hours, Saturday_Office_Hours, Sunday_Office_Hours) 
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;