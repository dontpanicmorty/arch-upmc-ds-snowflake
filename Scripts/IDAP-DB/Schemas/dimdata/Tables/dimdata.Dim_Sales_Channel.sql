CREATE OR REPLACE TABLE
	dimdata.Dim_Sales_Channel (
		Dim_Sales_Channel_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Channel_Id VARCHAR,
		Channel_Name VARCHAR,
		Sub_Channel_Name VARCHAR,
		CONSTRAINT PK_Dim_Sales_Channel PRIMARY KEY (Dim_Sales_Channel_Key),
		CONSTRAINT UK_Dim_Sales_Channel UNIQUE (Channel_Id)
	) COMMENT='List of channels through which plans are sold'
	;