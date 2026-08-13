CREATE OR REPLACE TABLE
	INFA.Dim_Sales_Channel (
		Dim_Sales_Channel_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Channel_Id VARCHAR,
		Channel_Name VARCHAR,
		Sub_Channel_Name VARCHAR,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Sales_Channel PRIMARY KEY (Dim_Sales_Channel_Key),
		CONSTRAINT UK_Dim_Sales_Channel UNIQUE (Channel_Id)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;