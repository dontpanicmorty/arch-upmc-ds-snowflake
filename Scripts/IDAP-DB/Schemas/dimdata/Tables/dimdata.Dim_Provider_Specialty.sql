CREATE OR REPLACE TABLE
	dimdata.Dim_Provider_Specialty
	(
		Dim_Provider_Specialty_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Specialty_Name VARCHAR NOT NULL, 
		CONSTRAINT PK_Dim_Provider_Specialty PRIMARY KEY (Dim_Provider_Specialty_Key), 
		CONSTRAINT UK_Dim_Provider_Specialty UNIQUE (Specialty_Name) 
	) COMMENT='Standardized set of provider specialties'
	;