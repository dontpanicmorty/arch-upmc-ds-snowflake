CREATE OR REPLACE TABLE 
	dimdata.Dim_Practitioner_Education
	(
		Dim_Practitioner_Education_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Education_Type_Code INTEGER NOT NULL, 
		Education_Type_Desc VARCHAR NOT NULL, 
		Education_Institution_Source_Nbr VARCHAR NOT NULL, 
		Education_Institution_Name VARCHAR NOT NULL, 
		Education_Department_Code INTEGER NOT NULL, 
		Education_Department_Name VARCHAR NOT NULL, 
		Education_Degree_Name VARCHAR NOT NULL,
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE,		
		CONSTRAINT PK_Dim_Practitioner_Education PRIMARY KEY (Dim_Practitioner_Education_Key), 
		CONSTRAINT UK_Dim_Practitioner_Education UNIQUE (Education_Type_Code, Education_Institution_Source_Nbr, Education_Department_Code, Education_Degree_Name) 
	) COMMENT='Attributes about a practitioners education'
	;