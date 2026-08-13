CREATE OR REPLACE TABLE
	INFA.Dim_Date_Day
	(
		Dim_Date_Day_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Full_Date DATE,
		Day_Of_Month_Nbr INTEGER,
		Day_Name VARCHAR,
		Day_Short_Name VARCHAR,
		Week_Day_Ind VARCHAR,
		Week_Begin_Date DATE,
		Month_Of_Year_Nbr INTEGER,
		Month_Name VARCHAR,
		Month_Short_Name VARCHAR,
		Quarter_Of_Year_Nbr INTEGER,
		Year_Nbr INTEGER,
		Last_Day_Of_Month_Ind VARCHAR,
		Same_Day_Year_Ago_Date DATE,
		Day_Of_Week_Nbr INTEGER,
		Week_Of_Year_Nbr INTEGER,
		Year_Month_Nbr VARCHAR,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Date_Day PRIMARY KEY (Dim_Date_Day_Key),
		CONSTRAINT UK_Dim_Date_Day_Full_Date UNIQUE (Full_Date)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;