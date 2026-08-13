CREATE OR REPLACE TABLE 
	INFA.Dim_Provider_Contract
	(
		Dim_Provider_Contract_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Data_Source_Code INTEGER NOT NULL, 
		Data_Source_Name VARCHAR NOT NULL, 
		TPA_Client_Id VARCHAR NOT NULL, 
		TPA_Id VARCHAR NOT NULL, 
		TPA_Div_Id VARCHAR NOT NULL, 
		Product_Code INTEGER NOT NULL,
		Product_Name VARCHAR NOT NULL, 
		Product_Type_Code INTEGER NOT NULL, 
		Product_Type_Name VARCHAR NOT NULL, 
		Contract_Model_Text VARCHAR NOT NULL,
		Restriction_Min_Age INTEGER NOT NULL, 
		Restriction_Max_Age INTEGER NOT NULL, 
		Restriction_Gender_Code VARCHAR NOT NULL, 
		Restriction_Gender_Name VARCHAR NOT NULL, 
		Special_Restriction_Desc VARCHAR NOT NULL, 
		Existing_Patients_Only_Ind VARCHAR NOT NULL, 
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Provider_Contract PRIMARY KEY (Dim_Provider_Contract_Key),
		CONSTRAINT UK_Dim_Provider_Contract UNIQUE (Data_Source_Code, TPA_Client_Id, TPA_Id, TPA_Div_Id, Product_Code, Product_Type_Code, Contract_Model_Text, Restriction_Min_Age, Restriction_Max_Age, Restriction_Gender_Code, Existing_Patients_Only_Ind, Special_Restriction_Desc) 
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;