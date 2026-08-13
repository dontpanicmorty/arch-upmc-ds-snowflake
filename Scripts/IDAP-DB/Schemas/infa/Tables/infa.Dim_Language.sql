CREATE OR REPLACE TABLE 
	INFA.Dim_Language
	(
		Dim_Language_Key INTEGER NOT NULL ,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Language_Name VARCHAR NOT NULL, 
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Language PRIMARY KEY (Dim_Language_Key), 
		CONSTRAINT UK_Dim_Language_Name UNIQUE (Language_Name)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;