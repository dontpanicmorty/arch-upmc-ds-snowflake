CREATE OR REPLACE TABLE
	dimdata.Dim_TPA_Hierarchy (
		Dim_TPA_Hierarchy_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		TPA_Client_Id VARCHAR NOT NULL,
		TPA_Id VARCHAR NOT NULL,
		TPA_Div_Id VARCHAR NOT NULL,
		TPA_Client_Desc VARCHAR,
		TPA_Id_Desc VARCHAR,
		TPA_Div_Desc VARCHAR,
		CONSTRAINT PK_Dim_TPA_Hierarchy PRIMARY KEY (Dim_TPA_Hierarchy_Key),
		CONSTRAINT UK_Dim_TPA_Hierarchy UNIQUE (TPA_Client_Id, TPA_Id, TPA_Div_Id)
	) COMMENT='Third Party Administrator identifier hierarchy'
	;