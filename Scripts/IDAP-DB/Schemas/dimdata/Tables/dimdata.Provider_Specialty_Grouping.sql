CREATE OR REPLACE TABLE
	dimdata.Provider_Specialty_Grouping
	(
		Provider_Specialty_Grouping_Key INTEGER NOT NULL ,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Specialty_Grouping_List VARCHAR NOT NULL,
		SPECIALTY_CARE_TYPE_CODE VARCHAR NULL,
		CARE_TYPE_DESC VARCHAR NULL,
		CONSTRAINT PK_Provider_Specialty_Grouping PRIMARY KEY (Provider_Specialty_Grouping_Key), 
		CONSTRAINT UK_Provider_Specialty_Grouping_Specialty_Grouping_List UNIQUE (Specialty_Grouping_List) 
	)COMMENT='List of provider specialties per row'
	;