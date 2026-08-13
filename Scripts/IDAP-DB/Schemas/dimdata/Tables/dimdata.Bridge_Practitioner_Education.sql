CREATE OR REPLACE TABLE 
	dimdata.Bridge_Practitioner_Education 
	(
		Bridge_Practitioner_Education_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE,
		Dim_Provider_Key INTEGER NOT NULL,
		Dim_Practitioner_Education_Key INTEGER NOT NULL,
		Education_Start_Date DATE NOT NULL,
		Education_Completion_Date DATE NOT NULL,
		Education_Graduated_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Bridge_Practitioner_Education PRIMARY KEY (Bridge_Practitioner_Education_Key),
		CONSTRAINT UK_Bridge_Practitioner_Education UNIQUE (Dim_Provider_Key, Dim_Practitioner_Education_Key, Education_Start_Date, Education_Graduated_Ind),
		CONSTRAINT FK_BridgePractitionerEducation_Dim_Practitioner_Education_Key FOREIGN KEY (Dim_Practitioner_Education_Key) REFERENCES dimdata.Dim_Practitioner_Education (Dim_Practitioner_Education_Key),
		CONSTRAINT FK_BridgePractitionerEducation_Provider_Key FOREIGN KEY (Dim_Provider_Key) REFERENCES dimdata.Dim_Provider (Dim_Provider_Key)
	) COMMENT='Bridge between DIM_PROVIDER and DIM_PRACTITIONER_EDUCATION to facilitate the N:N relationship'
	;
