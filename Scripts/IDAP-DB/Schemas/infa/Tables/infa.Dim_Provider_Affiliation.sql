CREATE OR REPLACE TABLE 
	INFA.Dim_Provider_Affiliation
	(
		Dim_Provider_Affiliation_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Affiliation_Type_Code INTEGER NOT NULL,
		Affiliation_Type_Desc VARCHAR NOT NULL, 	
		Affiliation_Institution_Name VARCHAR NOT NULL,
		Affiliation_Gateway_Text VARCHAR NOT NULL, 
		Affiliation_Gateway_Type_Code INTEGER NOT NULL, 
		Affiliation_Gateway_Type_Desc VARCHAR NOT NULL, 
		Affiliated_Dim_Provider_Key INTEGER NULL,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Provider_Affiliation PRIMARY KEY (Dim_Provider_Affiliation_Key), 
		CONSTRAINT UK_DimProviderAffiliation UNIQUE (Affiliation_Type_Code, Affiliation_Institution_Name, Affiliation_Gateway_Type_Code, Affiliation_Gateway_Text) 
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;

