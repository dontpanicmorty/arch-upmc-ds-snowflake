--REVIEWER: This view was authored from STTM/IDAP STAGEDATA STTM.xlsx, worksheet
--FACT_PROVIDER_UNIVERSE_SEL_VW. Column order follows that sheet rows 5-20 top to bottom; the join block
--is rows 24-31 and the FILTERS block (row 35) is empty. Source columns are reconciled against
--Scripts/IDAP-DB/Schemas/rawdata/Tables/rawdata.datahub_provider_office_base.sql and the joined
--dimensions against their DDL under Scripts/IDAP-DB/Schemas/dimdata/Tables/.
--
--Verified against real DDL: DIM_TPA_HIERARCHY (TPA_CLIENT_ID/TPA_ID/TPA_DIV_ID),
--DIM_PROVIDER (SOURCE_PROVIDER_NBR, DATA_SOURCE_NAME, IS_CURRENTROW_FLAG),
--DIM_PROVIDER_ADDRESS (PROVIDER_OFFICE_ID, IS_LOGICAL_DELETE_FLAG), DIM_DATE_DAY (FULL_DATE,
--DIM_DATE_DAY_KEY). All join predicates in the sheet resolve to columns that exist.
--
--Items deliberately NOT "fixed" in place -- each needs a reviewer decision:
--
--  (1) NO TARGET TABLE EXISTS. There is no dimdata.Fact_Provider_Universe anywhere in this repo, and no
--      loader proc. This view therefore has no authority to reconcile datatypes or nullability against,
--      unlike its sibling Dim_Provider_Address_Select_vw -- the K column of the STTM is the only
--      contract. Someone has to author dimdata.Fact_Provider_Universe before this can be loaded.
--
--  (2) INNER JOIN ON A NULLABLE MEDICAL GROUP. The sheet specifies INNER JOIN for the MG lookup
--      (row 26), but MEDICAL_GROUP_ID is nullable in RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE. An inner
--      join will silently discard every provider/office row that has no medical group. If the "universe"
--      is meant to be every provider-office relationship, this is a data-loss bug in the mapping, not in
--      this file. The STTM is honored verbatim below; the fix would be LEFT OUTER JOIN plus
--      IFNULL(MG.DIM_PROVIDER_KEY, 1) in the projection, which is the pattern
--      stagedata.Fact_Claim_Authorization_Detail_Upmchp_Datahub_Select_vw uses throughout. The same
--      concern applies to the PROV join, though PROVIDER_ID is NOT NULL in the raw table so only a
--      missing dimension row loses data there.
--
--  (3) THE ADDRESS JOIN IS UNDER-QUALIFIED AND WILL FAN OUT. The sheet's predicate (row 27) is only
--      ADDR.PROVIDER_OFFICE_ID = POB.OFFICE_ID AND ADDR.IS_LOGICAL_DELETE_FLAG = FALSE. But
--      UK_Dim_Provider_Address is
--      (PROVIDER_ADDRESS_TYPE_CODE, PROVIDER_OFFICE_ID, PROVIDER_OFFICE_NAME, ADDRESS_LINE1, ADDRESS_LINE2,
--      CITY, STATE_ABBREV, ZIP, COUNTRY) -- office id alone is not unique. Worse, DIM_PROVIDER_ADDRESS is
--      loaded by at least two independent feeds (the pharmacy feed and this Datahub feed), so one office
--      id can legitimately match several dimension rows. This join will multiply the fact grain. It needs
--      either the address-type/TPA columns added to the predicate or an explicit "current address"
--      qualifier. SELECT DISTINCT will NOT save you here -- the duplicated rows differ in
--      DIM_PROVIDER_ADDRESS_KEY, so they survive the DISTINCT.
--
--  (4) LAST_UPDATED_DATETIME is mapped to TO_TIMESTAMP_TZ('9999-12-31') (sheet row 8). That is an SCD-2
--      row-expiration value, not a last-updated value; existing loaders set it to CURRENT_TIMESTAMP() on
--      MERGE. Reproduced verbatim pending confirmation. Identical issue and identical literal on the
--      DIM_PROVIDER_ADDRESS sheet -- one answer settles both files.
--
--  (5) CARE_TYPE_NAME is mapped to the literal 'Unknown' (sheet row 16, with all source cells blank), yet
--      RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE has a real nullable CARE_TYPE_NAME column. Reading the
--      sheet's literal as a hardcode would throw away available data; reading it as a default matches the
--      IFNULL(x,'Unknown') idiom used everywhere else in stagedata. This file takes the default reading:
--      IFNULL(POB.CARE_TYPE_NAME,'Unknown'). If the intent really was a hardcoded 'Unknown', change the
--      line below to the bare literal.
--
--All remaining gaps are tagged --TODO(STTM): and quote the sheet's own Notes column. Each block is
--intended to be deletable as a unit once answered; grep -rn "TODO(STTM)" for the full list.

CREATE OR REPLACE VIEW STAGEDATA.FACT_PROVIDER_UNIVERSE_SELECT_VW
AS
SELECT DISTINCT
--TODO(STTM): FACT_PROVIDER_UNIVERSE_KEY has no transformation specified in the STTM (sheet row 5).
--Surrogate keys in this repo are assigned in the loader MERGE via the
--(SELECT IFNULL(MAX(<KEY>),100000000) FROM <target> WHERE MD5_VALUE_TEXT = '<sentinel>')
--+ ROW_NUMBER() OVER (ORDER BY 1) pattern, not in the select view. Projected as a placeholder only to
--keep this view's shape aligned with the STTM column list; drop this line once the loader is written and
--owns the key. Kept for symmetry with the sibling Dim_Provider_Address_Select_vw on this branch; note
--that Fact_Claim_Authorization_Detail_Upmchp_Datahub_Select_vw omits its own key entirely.
NULL AS FACT_PROVIDER_UNIVERSE_KEY
,'N/A-UPMCHP-DATAHUB' AS MD5_VALUE_TEXT
,TO_TIMESTAMP_TZ('1900-01-01') AS INSERT_DATETIME
--REVIEWER: see item (4) in the header comment.
,TO_TIMESTAMP_TZ('9999-12-31') AS LAST_UPDATED_DATETIME
,TO_BOOLEAN('FALSE') AS IS_LOGICAL_DELETE_FLAG
--The four dimension keys below come from INNER JOINs per the STTM, so they cannot be NULL and are not
--wrapped in IFNULL(...,1). If any of those joins is relaxed to LEFT OUTER (see header items (2) and (3)),
--the corresponding key must pick up IFNULL(...,1) to preserve the unknown-member convention used by
--stagedata.Fact_Claim_Authorization_Detail_Upmchp_Datahub_Select_vw.
,HIE.DIM_TPA_HIERARCHY_KEY
,PROV.DIM_PROVIDER_KEY
--DIM_MEDICAL_GROUP_KEY is a second role-playing reference to DIMDATA.DIM_PROVIDER, aliased MG per the
--STTM (sheet row 12) -- a medical group is itself a provider row in this model.
--REVIEWER: see item (2) in the header comment.
,MG.DIM_PROVIDER_KEY AS DIM_MEDICAL_GROUP_KEY
--REVIEWER: see item (3) in the header comment -- this is the fan-out risk.
,ADDR.DIM_PROVIDER_ADDRESS_KEY
--TODO(STTM): DIM_STANDARD_ADDRESS_KEY is sourced from DIMDATA.DIM_MASTER_ADDRESS (sheet row 14, alias
--M_ADDR), and the sheet's own Notes column says "Doesn't exist yet" for both the column (row 14) and the
--join (row 28). Confirmed: there is no DIM_MASTER_ADDRESS in this repo. Projected as the unknown-member
--key 1 so the view shape matches the STTM; replace with M_ADDR.DIM_STANDARD_ADDRESS_KEY and add the join
--once that dimension lands. Note RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE already carries
--MASTER_ADDRESS_HKEY, which is almost certainly the join column to use.
,1 AS DIM_STANDARD_ADDRESS_KEY
--TODO(STTM): DIM_PROVIDER_OWNERSHIP_KEY is sourced from DIMDATA.DIM_PROVIDER_OWNERSHIP (sheet row 15,
--alias OWNR), and the sheet's Notes say "Doesn't exist yet" for both the column (row 15) and the join
--(row 29). Confirmed: no DIM_PROVIDER_OWNERSHIP in this repo. The workbook's OWNERSHIP worksheet and
--this branch's rawdata.datahub_provider_ownership_base are the upstream pieces; the dimension itself is
--unbuilt. Projected as the unknown-member key 1; replace with OWNR.DIM_PROVIDER_OWNERSHIP_KEY and add
--the join once that dimension lands.
,1 AS DIM_PROVIDER_OWNERSHIP_KEY
--REVIEWER: see item (5) in the header comment -- literal vs. default reading of the STTM.
,IFNULL(POB.CARE_TYPE_NAME, 'Unknown') AS CARE_TYPE_NAME
--TODO(STTM): the four relationship-date columns below (sheet rows 17-20) have NO source column named --
--rows 17 and 19 carry only "Logic TBD" in the Notes, and rows 30-31 add "Dependency on Relationship
--fields". The mapping is inferred from the sheet's own DIM_DATE_DAY join SQL, which references
--POB.RELATIONSHIP_START_DATE and POB.RELATIONSHIP_END_DATE -- both of which exist on
--RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE -- so they are projected straight through here.
--REVIEWER: two things to settle. First, the target column is RELATIONSHIP_TERM_DATE but the source
--column is RELATIONSHIP_END_DATE; confirm they are the same concept and not two different dates.
--Second, the raw table also carries PROVIDER_ADDRESS_START_DATE / PROVIDER_ADDRESS_TERM_DATE and
--MEDICAL_GROUP_ADDRESS_START_DATE / MEDICAL_GROUP_ADDRESS_TERM_DATE. Given this fact joins a provider, a
--medical group AND an address, "Logic TBD" may well mean the effective relationship window is a
--GREATEST/LEAST of those three pairs rather than the bare relationship dates. That is the actual open
--question and it cannot be answered from the workbook.
,POB.RELATIONSHIP_START_DATE
--The two date keys are LEFT joins (see the FROM clause), so IFNULL to the unknown-member key 1 is
--required here -- a relationship with a NULL or out-of-range date must not drop the fact row.
,IFNULL(DDAY1.DIM_DATE_DAY_KEY, 1) AS RELATIONSHIP_START_DATE_KEY
,POB.RELATIONSHIP_END_DATE AS RELATIONSHIP_TERM_DATE
,IFNULL(DDAY2.DIM_DATE_DAY_KEY, 1) AS RELATIONSHIP_TERM_DATE_KEY
--The STTM's join block references the source table both by its full name (rows 24-27) and by the alias
--POB (rows 30-31). Aliased POB throughout here for consistency and readability, since this view carries
--six joins.
FROM RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE POB
JOIN DIMDATA.DIM_TPA_HIERARCHY HIE
    ON (POB.TPA_CLIENT_ID = HIE.TPA_CLIENT_ID
    AND POB.TPA_ID = HIE.TPA_ID
    AND POB.TPA_DIV_ID = HIE.TPA_DIV_ID
    )
JOIN DIMDATA.DIM_PROVIDER PROV
    ON (TRIM(POB.PROVIDER_ID) = TRIM(PROV.SOURCE_PROVIDER_NBR)
    AND UPPER(POB.DATA_SOURCE_NAME) = UPPER(PROV.DATA_SOURCE_NAME)
    AND PROV.IS_CURRENTROW_FLAG = TRUE
    )
--REVIEWER: see item (2) in the header comment -- INNER JOIN on the nullable MEDICAL_GROUP_ID.
JOIN DIMDATA.DIM_PROVIDER MG
    ON (TRIM(POB.MEDICAL_GROUP_ID) = TRIM(MG.SOURCE_PROVIDER_NBR)
    AND UPPER(POB.DATA_SOURCE_NAME) = UPPER(MG.DATA_SOURCE_NAME)
    AND MG.IS_CURRENTROW_FLAG = TRUE
    )
--REVIEWER: see item (3) in the header comment -- this predicate is under-qualified and will fan out.
JOIN DIMDATA.DIM_PROVIDER_ADDRESS ADDR
    ON (ADDR.PROVIDER_OFFICE_ID = POB.OFFICE_ID
    AND ADDR.IS_LOGICAL_DELETE_FLAG = FALSE
    )
--TODO(STTM): the sheet contradicts itself on these two joins -- the Join Type column (E) on rows 30-31
--says "INNER JOIN" while the SQL column (F) on the same rows says "LEFT JOIN". The SQL is followed here,
--because an inner join to DIM_DATE_DAY would drop every relationship with a NULL start or term date, and
--RELATIONSHIP_START_DATE / RELATIONSHIP_END_DATE are both nullable in the raw table. Confirm.
LEFT OUTER JOIN DIMDATA.DIM_DATE_DAY DDAY1
    ON (DDAY1.FULL_DATE = POB.RELATIONSHIP_START_DATE
    )
LEFT OUTER JOIN DIMDATA.DIM_DATE_DAY DDAY2
    ON (DDAY2.FULL_DATE = POB.RELATIONSHIP_END_DATE
    )
--TODO(STTM): the sheet's FILTERS block (row 35) is a header with nothing under it, so no WHERE clause is
--applied. Confirm that the whole provider-office table is in scope. The three INNER JOINs above are
--already acting as de facto filters.
;
