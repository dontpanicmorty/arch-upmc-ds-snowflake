CREATE OR REPLACE TABLE 
	dimdata.Dim_Provider_Identifier
	(
		Dim_Provider_Identifier_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Dim_Provider_Key INTEGER NOT NULL, 
		Identifier_Name VARCHAR NOT NULL, 
		Identifier_Nbr VARCHAR NOT NULL, 
		CONSTRAINT PK_Dim_Provider_Identifier PRIMARY KEY (Dim_Provider_Identifier_Key), 
		CONSTRAINT UK_Dim_Provider_Identifier UNIQUE (Dim_Provider_Key, Identifier_Name, Identifier_Nbr), 
		CONSTRAINT FK_DimProviderIdentifier_Dim_Provider_Key FOREIGN KEY (Dim_Provider_Key) REFERENCES dimdata.Dim_Provider(Dim_Provider_Key)
	) COMMENT='Contains a list of all provider identifier types and values used in IDAP'
	;