--REVIEWER: Target table for STTM/IDAP STAGEDATA STTM.xlsx worksheet FACT_PROVIDER_UNIVERSE_SEL_VW.
--Column names, order and datatypes are taken from that sheet's Target Column (J) and Target Data Type (K)
--columns, rows 5-20. Loaded by dimdata.spu_Load_Fact_Provider_Universe from
--STAGEDATA.FACT_PROVIDER_UNIVERSE_SELECT_VW; exposed by dimdata.Fact_Provider_Universe_vw.
--
--Datatype note: every datatype below is the STTM's Column K spelling, verbatim. That means this file
--deviates from the surrounding repo convention in three places, deliberately and at the STTM's direction:
--
--  * NUMBER(38,0) / NUMERIC(38,0) on the keys, where every other dimdata fact and dimension declares
--    INTEGER (see dimdata.Fact_Provider_Contract). The STTM uses NUMBER(38,0) for the six dimension keys
--    and NUMERIC(38,0) for the two date keys -- that inconsistency is the sheet's, and it is reproduced
--    rather than normalised.
--  * VARCHAR(16777216) rather than bare VARCHAR.
--  * TIMESTAMP_TZ rather than TIMESTAMP_TZ(9).
--
--REVIEWER: all three are pure spelling differences -- in Snowflake, INTEGER, NUMBER(38,0) and
--NUMERIC(38,0) are the same type; bare VARCHAR is exactly VARCHAR(16777216); and bare TIMESTAMP_TZ is
--exactly TIMESTAMP_TZ(9). Nothing about storage, precision or the foreign keys below changes. So this is
--a readability trade only: the file now matches the STTM cell-for-cell, at the cost of not matching its
--neighbours in dimdata/Tables/. If house style should win instead, INTEGER / VARCHAR / TIMESTAMP_TZ(9)
--are the substitutions and they are safe to make at any time.
--
--Items needing a reviewer decision:
--
--  (1) TWO FOREIGN KEYS CANNOT BE DECLARED. Dim_Standard_Address_Key and Dim_Provider_Ownership_Key
--      reference DIMDATA.DIM_MASTER_ADDRESS and DIMDATA.DIM_PROVIDER_OWNERSHIP, which the STTM itself
--      marks "Doesn't exist yet" (sheet rows 14/15 and 28/29) and which are absent from this repo. The
--      columns are declared so the table matches the STTM shape, and the staging view supplies the
--      unknown-member value 1 for both. Their FK constraints are written out but commented at the bottom
--      of this file, ready to uncomment once those dimensions land.
--
--  (2) NOT NULL ON THE TWO UNBUILT KEYS. They are declared NOT NULL for consistency with every other key
--      on this table, which is only safe because the staging view hardcodes 1. If you would rather these
--      be NULL until the real dimensions exist, change them here and drop the hardcoded 1 in
--      stagedata.Fact_Provider_Universe_Select_vw -- the two files have to agree.
--
--  (3) GRAIN / UNIQUE KEY. The STTM does not state a grain, so UK_Fact_Provider_Universe below is the
--      full set of dimension keys plus the two date keys -- the same construction
--      UK_Fact_Provider_Contract uses. Care_Type_Name is deliberately excluded, matching how
--      Fact_Provider_Contract excludes Care_Type_Desc. That is a real assumption: if one
--      provider/medical-group/address/date combination can carry two different care types, the UK is
--      wrong and Care_Type_Name belongs inside it. Confirm with the STTM author.
--      Related and more urgent: the address join in stagedata.Fact_Provider_Universe_Select_vw is
--      under-qualified and will fan out (see item (3) in that file's header). That fan-out lands here as
--      duplicate rows differing only in Dim_Provider_Address_Key, which this UK will NOT catch because
--      the key is part of it. Fix the staging join before trusting this grain.
--
--  (4) Snowflake does not enforce PRIMARY KEY, UNIQUE or FOREIGN KEY constraints -- they are metadata for
--      the optimizer and for documentation only. Actual de-duplication is done by the MERGE in
--      dimdata.spu_Load_Fact_Provider_Universe, whose ON clause is kept in sync with UK_Fact_Provider_Universe
--      below. If you change the UK here, change the MERGE ON clause there too.
--
--  (5) Relationship_Start_Date and Relationship_Term_Date are declared NULL because
--      RELATIONSHIP_START_DATE and RELATIONSHIP_END_DATE are both nullable in
--      RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE and the staging view passes them straight through. The
--      corresponding _KEY columns are NOT NULL because the staging view resolves them through
--      IFNULL(...,1). The STTM's "Logic TBD" note on these fields (sheet rows 17/19) is still open.

CREATE OR REPLACE TABLE
	dimdata.Fact_Provider_Universe
	(
		--STTM K5
		Fact_Provider_Universe_Key NUMBER(38,0) NOT NULL,
		--STTM K6
		MD5_Value_Text VARCHAR(16777216) NOT NULL,
		--STTM K7
		Insert_Datetime TIMESTAMP_TZ NOT NULL,
		--STTM K8
		Last_Updated_Datetime TIMESTAMP_TZ NOT NULL,
		--STTM K9
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE,
		--STTM K10
		Dim_TPA_Hierarchy_Key NUMBER(38,0) NOT NULL,
		--STTM K11
		Dim_Provider_Key NUMBER(38,0) NOT NULL,
		--STTM K12
		Dim_Medical_Group_Key NUMBER(38,0) NOT NULL,
		--STTM K13
		Dim_Provider_Address_Key NUMBER(38,0) NOT NULL,
		--STTM K14. REVIEWER: see item (1) -- DIM_MASTER_ADDRESS does not exist yet.
		Dim_Standard_Address_Key NUMBER(38,0) NOT NULL,
		--STTM K15. REVIEWER: see item (1) -- DIM_PROVIDER_OWNERSHIP does not exist yet.
		Dim_Provider_Ownership_Key NUMBER(38,0) NOT NULL,
		--STTM K16
		Care_Type_Name VARCHAR(16777216) NOT NULL,
		--STTM K17
		Relationship_Start_Date DATE NULL,
		--STTM K18. Note the sheet switches from NUMBER to NUMERIC for the two date keys; reproduced as written.
		Relationship_Start_Date_Key NUMERIC(38,0) NOT NULL,
		--STTM K19
		Relationship_Term_Date DATE NULL,
		--STTM K20. See the note on K18.
		Relationship_Term_Date_Key NUMERIC(38,0) NOT NULL,
		CONSTRAINT PK_Fact_Provider_Universe PRIMARY KEY (Fact_Provider_Universe_Key),
		--REVIEWER: see item (3) -- grain assumption.
		CONSTRAINT UK_Fact_Provider_Universe UNIQUE (Dim_TPA_Hierarchy_Key, Dim_Provider_Key, Dim_Medical_Group_Key, Dim_Provider_Address_Key, Dim_Standard_Address_Key, Dim_Provider_Ownership_Key, Relationship_Start_Date_Key, Relationship_Term_Date_Key),
		CONSTRAINT FK_FactProviderUniverse_Dim_TPA_Hierarchy_Key FOREIGN KEY (Dim_TPA_Hierarchy_Key) REFERENCES dimdata.Dim_TPA_Hierarchy(Dim_TPA_Hierarchy_Key),
		CONSTRAINT FK_FactProviderUniverse_Dim_Provider_Key FOREIGN KEY (Dim_Provider_Key) REFERENCES dimdata.Dim_Provider(Dim_Provider_Key),
		--Dim_Medical_Group_Key is a second role-playing reference to Dim_Provider -- a medical group is
		--itself a provider row in this model (STTM sheet row 12). Same pattern as
		--FK_FactProviderContract_Owning_Medical_Group_Key on dimdata.Fact_Provider_Contract.
		CONSTRAINT FK_FactProviderUniverse_Dim_Medical_Group_Key FOREIGN KEY (Dim_Medical_Group_Key) REFERENCES dimdata.Dim_Provider(Dim_Provider_Key),
		CONSTRAINT FK_FactProviderUniverse_Dim_Provider_Address_Key FOREIGN KEY (Dim_Provider_Address_Key) REFERENCES dimdata.Dim_Provider_Address(Dim_Provider_Address_Key),
		CONSTRAINT FK_FactProviderUniverse_Relationship_Start_Date_Key FOREIGN KEY (Relationship_Start_Date_Key) REFERENCES dimdata.Dim_Date_Day(Dim_Date_Day_Key),
		CONSTRAINT FK_FactProviderUniverse_Relationship_Term_Date_Key FOREIGN KEY (Relationship_Term_Date_Key) REFERENCES dimdata.Dim_Date_Day(Dim_Date_Day_Key)
		--TODO(STTM): uncomment the two constraints below once DIMDATA.DIM_MASTER_ADDRESS and
		--DIMDATA.DIM_PROVIDER_OWNERSHIP exist. Both are marked "Doesn't exist yet" in the STTM itself.
		--Remember to add the comma to the FK above when you do.
		--,CONSTRAINT FK_FactProviderUniverse_Dim_Standard_Address_Key FOREIGN KEY (Dim_Standard_Address_Key) REFERENCES dimdata.Dim_Master_Address(Dim_Standard_Address_Key)
		--,CONSTRAINT FK_FactProviderUniverse_Dim_Provider_Ownership_Key FOREIGN KEY (Dim_Provider_Ownership_Key) REFERENCES dimdata.Dim_Provider_Ownership(Dim_Provider_Ownership_Key)
	) COMMENT='Factless fact of the provider universe -- every provider/medical group/office address relationship sourced from UPMCHP_DATAHUB'
	;
