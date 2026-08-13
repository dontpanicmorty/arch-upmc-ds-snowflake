CREATE OR REPLACE TABLE 
	dimdata.Bridge_Facility_Accreditation
	(
		Bridge_Facility_Accreditation_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT '0',
		Dim_Provider_Key INTEGER NOT NULL, 
		Dim_Facility_Accreditation_Key INTEGER NOT NULL,
		CONSTRAINT PK_Bridge_Facility_Accreditation PRIMARY KEY (Bridge_Facility_Accreditation_Key), 
		CONSTRAINT UK_Bridge_Facility_Accreditation UNIQUE (Dim_Provider_Key, Dim_Facility_Accreditation_Key),
		CONSTRAINT FK_BridgeFacilityAccreditation_DimProviderKey FOREIGN KEY (Dim_Provider_Key) REFERENCES dimdata.Dim_Provider(Dim_Provider_Key), 
		CONSTRAINT FK_BridgeFacilityAccreditation_DimFacilityAccreditationKey FOREIGN KEY (Dim_Facility_Accreditation_Key) REFERENCES dimdata.Dim_Facility_Accreditation(Dim_Facility_Accreditation_Key)
	) COMMENT='Bridge between DIM_PROVIDER and DIM_FACILITY_ACCREDITATION to facilitate the N:N relationship'
	;
