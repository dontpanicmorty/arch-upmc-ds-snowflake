CREATE OR REPLACE TABLE
	dimdata.Dim_Plan_Segment
	(
		Dim_Plan_Segment_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		TPA_Client_Id VARCHAR NOT NULL,
		TPA_Id VARCHAR NOT NULL,
		TPA_Div_Id VARCHAR NOT NULL,
        Plan_Code VARCHAR NOT NULL,
        Segment_Id VARCHAR NOT NULL,
        Segment_Description VARCHAR NULL,
        Effective_Start_Date TIMESTAMP_TZ(9) NOT NULL,
        Effective_End_Date TIMESTAMP_TZ(9) NULL,
        Active_Ind VARCHAR NULL,
		Copay      VARCHAR (100)  NULL,
        Coinsurance VARCHAR (100)  NULL,
        Mental_Health VARCHAR (100)  NULL,
        Mental_Health_Limit VARCHAR (100)  NULL,
        Other_Benefits       VARCHAR (100)  NULL,
        Out_of_Network        VARCHAR (100)  NULL,
		CONSTRAINT PK_DimPlanSegmentKey PRIMARY KEY (Dim_Plan_Segment_Key),
		CONSTRAINT UK_DimPlanSegmentKey UNIQUE (TPA_Client_Id, TPA_Id, TPA_Div_Id, Plan_Code, Segment_Id, Effective_Start_Date)
	) COMMENT='Medical, Dental, etc'
	;