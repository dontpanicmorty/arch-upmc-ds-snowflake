CREATE OR REPLACE TABLE
	dimdata.Bridge_Provider_Affiliation
	(
		Bridge_Provider_Affiliation_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE,
		Dim_Provider_Key INTEGER NOT NULL,
		Dim_Provider_Affiliation_Key INTEGER NOT NULL,
		Affiliation_Start_Date DATE NOT NULL,
		Affiliation_End_Date DATE NOT NULL,
		Affiliation_Active_Ind VARCHAR NOT NULL,
		Affiliation_Admit_Privileges_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Bridge_Provider_Affiliation PRIMARY KEY (Bridge_Provider_Affiliation_Key),
		CONSTRAINT UK_Bridge_Provider_Affiliation UNIQUE (Dim_Provider_Key, Dim_Provider_Affiliation_Key, Affiliation_Start_Date),
		CONSTRAINT FK_BridgeProviderAffiliation_Dim_Provider_Affiliation_Key FOREIGN KEY (Dim_Provider_Affiliation_Key) REFERENCES dimdata.Dim_Provider_Affiliation (Dim_Provider_Affiliation_Key),
		CONSTRAINT FK_BridgeProviderAffiliation_Dim_Provider_Key FOREIGN KEY (Dim_Provider_Key) REFERENCES dimdata.Dim_Provider (Dim_Provider_Key)
	) COMMENT='Bridge between DIM_PROVIDER and DIM_PROVIDER_AFFILIATION to facilitate the N:N relationship'
	;
