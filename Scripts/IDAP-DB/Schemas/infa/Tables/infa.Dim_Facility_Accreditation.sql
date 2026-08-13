CREATE OR REPLACE TABLE 
	INFA.Dim_Facility_Accreditation
	(
		Dim_Facility_Accreditation_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Accreditation_Agency_Name VARCHAR NOT NULL,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Facility_Accreditation PRIMARY KEY (Dim_Facility_Accreditation_Key), 
		CONSTRAINT UK_Dim_Facility_Accreditation_Agency_Name UNIQUE (Accreditation_Agency_Name)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;