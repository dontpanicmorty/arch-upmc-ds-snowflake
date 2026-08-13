CREATE OR REPLACE TABLE
	dimdata.Dim_Provider_Contract_Attribute
	(
		Dim_Provider_Contract_Attribute_Key INTEGER NOT NULL ,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Contract_Termination_Reason_Code VARCHAR NOT NULL, 
		Contract_Termination_Reason_Desc VARCHAR NOT NULL, 
		CONSTRAINT PK_Dim_Provider_Contract_Attribute PRIMARY KEY (Dim_Provider_Contract_Attribute_Key), 
		CONSTRAINT UK_Dim_Provider_Contract_Attribute UNIQUE (Contract_Termination_Reason_Code, Contract_Termination_Reason_Desc) 
	) COMMENT='Expandable list of attributes describing a provider contract'
	;
