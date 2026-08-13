CREATE OR REPLACE TABLE
	INFA.Dim_GL_Distribution
	(
		Dim_GL_Distribution_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		TPA_Client_Id VARCHAR NOT NULL,
		TPA_Id VARCHAR NOT NULL,
		TPA_Div_Id VARCHAR NOT NULL,
		GL_Distribution_Code VARCHAR NOT NULL,
		GL_Distribution_Desc VARCHAR NOT NULL,
		Company_Code VARCHAR NOT NULL,
		Finance_Business_Unit_Desc VARCHAR,
		Finance_Product_Code VARCHAR,
		Finance_Product_Desc VARCHAR,
		Finance_Cost_Center_Name VARCHAR,
		Credit_GL_Nbr VARCHAR,
		Debit_GL_Nbr VARCHAR,
		Secondary_Credit_GL_Nbr VARCHAR,
		Secondary_Debit_GL_Nbr VARCHAR,
		Discount_GL_Nbr VARCHAR,
		Discount_Offset_GL_Nbr VARCHAR,
		Interest_GL_Nbr VARCHAR,
		Interest_Offset_GL_Nbr VARCHAR,
		Finance_LOB_Desc VARCHAR,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_GL_Distribution PRIMARY KEY (Dim_GL_Distribution_Key),
		CONSTRAINT UK_Dim_GL_Distribution UNIQUE (TPA_Client_Id, TPA_Id, TPA_Div_Id, GL_Distribution_Code, Company_Code, Finance_Product_Code)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;