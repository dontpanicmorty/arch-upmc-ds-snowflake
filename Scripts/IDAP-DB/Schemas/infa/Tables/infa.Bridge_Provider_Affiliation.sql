CREATE OR REPLACE TABLE
	INFA.Bridge_Provider_Affiliation
	(
		Bridge_Provider_Affiliation_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE,
		Dim_Provider_Key INTEGER NOT NULL,
		Dim_Provider_Affiliation_Key INTEGER NOT NULL,
		Affiliation_Start_Date DATE NOT NULL,
		Affiliation_End_Date DATE NOT NULL,
		Affiliation_Active_Ind VARCHAR NOT NULL,
		Affiliation_Admit_Privileges_Ind VARCHAR NOT NULL,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Bridge_Provider_Affiliation PRIMARY KEY (Bridge_Provider_Affiliation_Key),
		CONSTRAINT UK_Bridge_Provider_Affiliation UNIQUE (Dim_Provider_Key, Dim_Provider_Affiliation_Key, Affiliation_Start_Date)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;
