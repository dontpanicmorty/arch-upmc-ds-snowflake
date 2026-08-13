CREATE OR REPLACE TABLE
	INFA.Dim_Member_Identifier
	(
		Dim_Member_Identifier_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		TPA_Client_Id VARCHAR NOT NULL,
		TPA_Id VARCHAR NOT NULL,
		TPA_Div_Id VARCHAR NOT NULL,
		Dim_Member_Key INTEGER NOT NULL,
		Member_Identifier_Source_Name VARCHAR NOT NULL,
		Member_Identifier_Type VARCHAR NOT NULL,
		Member_Identifier VARCHAR NOT NULL,
		Is_Logical_Delete_Flag BOOLEAN NOT NULL,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Member_Identifier PRIMARY KEY (Dim_Member_Identifier_Key),
		CONSTRAINT UK_Dim_Member_Identifier UNIQUE (TPA_Client_Id, TPA_Id, TPA_Div_Id, Dim_Member_Key, Member_Identifier, Member_Identifier_Source_Name, Member_Identifier_Type)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;