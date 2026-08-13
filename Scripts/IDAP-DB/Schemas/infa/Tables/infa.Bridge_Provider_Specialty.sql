CREATE OR REPLACE TABLE 
	INFA.Bridge_Provider_Specialty
	(
		Bridge_Provider_Specialty_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Provider_Specialty_Grouping_Key INTEGER NOT NULL, 
		Dim_Provider_Specialty_Key INTEGER NOT NULL, 
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Bridge_Provider_Specialty PRIMARY KEY (Bridge_Provider_Specialty_Key), 
		CONSTRAINT UK_Bridge_Provider_Specialty UNIQUE (Provider_Specialty_Grouping_Key, Dim_Provider_Specialty_Key)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;