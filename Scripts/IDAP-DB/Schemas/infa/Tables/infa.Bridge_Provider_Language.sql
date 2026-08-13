CREATE OR REPLACE TABLE 
	INFA.Bridge_Provider_Language
	(
		Bridge_Provider_Language_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Dim_Provider_Key INTEGER NOT NULL, 
		Dim_Language_Key INTEGER NOT NULL,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Bridge_Provider_Language PRIMARY KEY (Bridge_Provider_Language_Key), 
		CONSTRAINT UK_Bridge_Provider_Language UNIQUE (Dim_Provider_Key, Dim_Language_Key)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;