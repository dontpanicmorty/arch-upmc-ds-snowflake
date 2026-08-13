CREATE OR REPLACE TABLE
	INFA.Dim_Provider_Certification
	(
		Dim_Provider_Certification_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE,
		Dim_Provider_Key INTEGER NOT NULL, 
		Certification_Type_Desc VARCHAR NOT NULL,
		Certification_Name VARCHAR NOT NULL, 
		Certification_Nbr VARCHAR NOT NULL,
		Certification_State_Abbrev_Name VARCHAR NOT NULL, 
		Certification_State_Full_Name VARCHAR NOT NULL, 
		Certification_Start_Date DATE NOT NULL, 
		Certification_End_Date DATE NOT NULL, 
		Recertification_Date DATE NULL, 
		Certification_Verification_Date DATE NULL, 
		Certification_Status_Code INTEGER NOT NULL, 
		Certification_Status_Desc VARCHAR NOT NULL, 
		Certification_Active_Ind VARCHAR NOT NULL,
		Lifetime_Certification_Ind VARCHAR NOT NULL,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Provider_Certification PRIMARY KEY (Dim_Provider_Certification_Key), 
		CONSTRAINT UK_Dim_Provider_Certification UNIQUE (Dim_Provider_Key, Certification_Type_Desc, Certification_Name, Certification_Nbr, Certification_State_Abbrev_Name, Certification_Start_Date, Certification_Status_Code) 

	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;