CREATE OR REPLACE TABLE 
	INFA.Fact_Provider_Contract
	(
		Fact_Provider_Contract_Key INTEGER NOT NULL ,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Dim_TPA_Hierarchy_Key INTEGER NOT NULL, 
		Dim_Provider_Key INTEGER NOT NULL, 
		Dim_Provider_Contract_Key INTEGER NOT NULL, 
		Dim_Provider_Address_Key INTEGER NOT NULL, 
		Provider_Specialty_Grouping_Key INTEGER NOT NULL, 
		Dim_Provider_Contract_Attribute_Key INTEGER NOT NULL,
		Dim_Provider_Contact_Info_Key INTEGER NOT NULL, 
		Dim_Office_Hours_Key INTEGER NOT NULL, 
		Owning_Medical_Group_Key INTEGER NOT NULL, 
		Contract_Start_Date_Key INTEGER NOT NULL, 
		Contract_Termination_Date_Key INTEGER NOT NULL, 
		Address_Start_Date_Key INTEGER NOT NULL, 
		Address_Term_Date_Key INTEGER NOT NULL, 
		Contract_Level_Name VARCHAR NOT NULL,
		Contract_Active_Ind VARCHAR NOT NULL, 
		Address_Active_Ind VARCHAR NOT NULL,
		Suppressed_In_Directory_Ind VARCHAR NOT NULL,
		CARE_TYPE_DESC VARCHAR NULL,
		Convert_Ind VARCHAR NOT NULL,		
		CONSTRAINT PK_Fact_Provider_Contract PRIMARY KEY (Fact_Provider_Contract_Key), 
		CONSTRAINT UK_Fact_Provider_Contract UNIQUE (Dim_TPA_Hierarchy_Key, Dim_Provider_Key, Dim_Provider_Contract_Key, Dim_Provider_Address_Key, Provider_Specialty_Grouping_Key, Dim_Provider_Contract_Attribute_Key, Dim_Provider_Contact_Info_Key, Dim_Office_Hours_Key, Owning_Medical_Group_Key, Contract_Start_Date_Key, Contract_Termination_Date_Key, Address_Start_Date_Key, Address_Term_Date_Key)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;
