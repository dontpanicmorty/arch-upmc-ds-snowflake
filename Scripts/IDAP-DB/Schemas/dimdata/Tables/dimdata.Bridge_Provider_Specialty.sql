CREATE OR REPLACE TABLE 
	dimdata.Bridge_Provider_Specialty
	(
		Bridge_Provider_Specialty_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Provider_Specialty_Grouping_Key INTEGER NOT NULL, 
		Dim_Provider_Specialty_Key INTEGER NOT NULL, 
		CONSTRAINT PK_Bridge_Provider_Specialty PRIMARY KEY (Bridge_Provider_Specialty_Key), 
		CONSTRAINT UK_Bridge_Provider_Specialty UNIQUE (Provider_Specialty_Grouping_Key, Dim_Provider_Specialty_Key), 
		CONSTRAINT FK_BridgeProviderSpecialty_Group_Provider_Specialty_Key FOREIGN KEY (Provider_Specialty_Grouping_Key) REFERENCES dimdata.Provider_Specialty_Grouping(Provider_Specialty_Grouping_Key),
		CONSTRAINT FK_BridgeProviderSpecialty_Dim_Provider_Specialty_Key FOREIGN KEY (Dim_Provider_Specialty_Key) REFERENCES dimdata.Dim_Provider_Specialty(Dim_Provider_Specialty_Key)
	) COMMENT='Bridge between DIM_PROVIDER_SPECIALTY_GROUPING and DIM_PROVIDER_SPECIALTY to facilitate the N:N relationship'
	;