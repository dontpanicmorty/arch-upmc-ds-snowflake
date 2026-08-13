CREATE OR REPLACE TABLE
	INFA.Dim_Eligibility_Type
	(
		Dim_Eligibility_Type_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		TPA_Client_Id VARCHAR NOT NULL,
		TPA_Id VARCHAR NOT NULL,
		TPA_Div_Id VARCHAR NOT NULL,
		Eligibility_Type_Name VARCHAR NOT NULL,
		Eligibility_Type_Desc VARCHAR NOT NULL,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_DimEligibilityTypeKey PRIMARY KEY (Dim_Eligibility_Type_Key),
		CONSTRAINT UK_DimEligibilityType UNIQUE (TPA_Client_Id, TPA_Id, TPA_Div_Id, Eligibility_Type_Name)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;