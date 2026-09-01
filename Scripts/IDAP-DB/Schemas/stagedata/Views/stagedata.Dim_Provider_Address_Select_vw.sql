--REVIEWER: This view was authored from STTM/IDAP STAGEDATA STTM.xlsx, worksheet DIM_PROVIDER_ADDRESS
--(rows 5-36); the column order below follows that sheet top to bottom. Target column names, datatypes
--and nullability are reconciled against Scripts/IDAP-DB/Schemas/dimdata/Tables/dimdata.Dim_Provider_Address.sql,
--and every source column below is reconciled against
--Scripts/IDAP-DB/Schemas/rawdata/Tables/rawdata.datahub_provider_office_base.sql, which now exists on
--this branch. Three items are deliberately NOT "fixed" in place and need a reviewer decision:
--
--  (1) NOT NULL exposure on the straight-thru columns. The STTM marks these as "straight thru" so they
--      are projected unwrapped here, but the raw DDL and the dim disagree on nullability:
--
--        source NOT NULL, target NOT NULL -> safe:  TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, OFFICE_ID
--        source NULL,     target NOT NULL -> WILL FAIL: OFFICE_NAME, PROVIDER_ADDRESS_LINE_1,
--            PROVIDER_ADDRESS_LINE_2, PROVIDER_CITY_NAME, PROVIDER_STATE_ABBREV_NAME,
--            PROVIDER_STATE_FULL_NAME, PROVIDER_COUNTY_NAME, PROVIDER_COUNTRY_NAME, PROVIDER_ZIP_CODE
--
--      This is no longer hypothetical -- all nine of those raw columns are declared nullable. As soon as
--      one NULL arrives, the MERGE into DIMDATA.DIM_PROVIDER_ADDRESS fails. The sibling Datahub feed
--      (stagedata.Dim_Provider_Upmchp_Datahub_Select_Vw) solves this with IFNULL(x,'Unknown'), and the
--      sibling pharmacy feed sidesteps it with WHERE ADDRESS_LINE_1 IS NOT NULL. Either fix contradicts
--      the STTM's stated mapping, so it is left as an explicit decision rather than a silent edit.
--      Recommendation: wrap all nine in IFNULL(x,'Unknown') and amend the STTM.
--
--  (2) LAST_UPDATED_DATETIME is mapped by the STTM to TO_TIMESTAMP_TZ('9999-12-31'). That is an SCD-2
--      row-expiration value, not a last-updated value, and is identical to the ROW_EXPIRATION_DATETIME
--      literal on the workbook's DIM_PROVIDER_UPMCHP_DATAHUB_SEL sheet -- it looks like a copy-paste.
--      Existing loaders set LAST_UPDATED_DATETIME to CURRENT_TIMESTAMP() on MERGE. The STTM literal is
--      reproduced verbatim below pending confirmation from the STTM author. The same literal appears on
--      the FACT_PROVIDER_UNIVERSE_SEL_VW sheet, so one answer settles both files.
--
--  (3) PROVIDER_ADDRESS_TYPE_CODE is VARCHAR and nullable in the raw table but INTEGER NOT NULL in the
--      dim. TRY_TO_NUMBER alone would produce NULL and break the target, so it is wrapped in IFNULL to 0.
--      See the inline note -- the 0 is a placeholder, not a known unknown-member code.
--
--All remaining gaps are tagged --TODO(STTM): and quote the sheet's own Notes column. Each block is
--intended to be deletable as a unit once answered; grep -rn "TODO(STTM)" for the full list.

CREATE OR REPLACE VIEW STAGEDATA.DIM_PROVIDER_ADDRESS_SELECT_VW
AS
SELECT DISTINCT
--TODO(STTM): DIM_PROVIDER_ADDRESS_KEY has no transformation specified in the STTM. Surrogate keys in
--this repo are assigned in the loader MERGE via the
--(SELECT IFNULL(MAX(<KEY>),100000000) FROM <target> WHERE MD5_VALUE_TEXT = '<sentinel>')
--+ ROW_NUMBER() OVER (ORDER BY 1) pattern, not in the select view. Projected as a placeholder only to
--keep this view's shape aligned with the STTM column list; drop this line once the loader is written and
--owns the key. Note the sibling Pharmacy_Dim_Provider_Address_Select_vw omits it entirely.
NULL AS DIM_PROVIDER_ADDRESS_KEY
,'N/A-UPMCHP-DATAHUB' AS MD5_VALUE_TEXT
,TO_TIMESTAMP_TZ('1900-01-01') AS INSERT_DATETIME
--REVIEWER: see item (2) in the header comment.
,TO_TIMESTAMP_TZ('9999-12-31') AS LAST_UPDATED_DATETIME
,TO_BOOLEAN('FALSE') AS IS_LOGICAL_DELETE_FLAG
,DATAHUB_PROVIDER_OFFICE_BASE.TPA_CLIENT_ID
,DATAHUB_PROVIDER_OFFICE_BASE.TPA_ID
,DATAHUB_PROVIDER_OFFICE_BASE.TPA_DIV_ID AS TPA_DIVISION_ID
--REVIEWER: see item (3) in the header comment. Source PROVIDER_ADDRESS_TYPE_CODE is VARCHAR NULL, target
--is INTEGER NOT NULL. TRY_TO_NUMBER fails soft on non-numeric text instead of failing the whole view;
--IFNULL(...,0) then satisfies the NOT NULL target. 0 is a placeholder -- if this column is meant to
--reference a coded domain, replace with the real unknown-member code, or with an explicit CASE map (see
--PROVIDER_TYPE_CODE in stagedata.Dim_Provider_Upmchp_Datahub_Select_Vw for that pattern). Note the code
--also participates in UK_Dim_Provider_Address, so collapsing everything to 0 collapses the dim grain.
,IFNULL(TRY_TO_NUMBER(DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_ADDRESS_TYPE_CODE), 0) AS PROVIDER_ADDRESS_TYPE_CODE
--TODO(STTM): unmapped. Sheet note: "Needed? ADDRESS_TYPE_CODE is itself a description." Confirmed absent
--from RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE, and the target column is NOT NULL, so defaulted. The
--pharmacy feed does source a real ADDRESS_TYPE_DESC from its own base table.
,'Unknown' AS PROVIDER_ADDRESS_TYPE_DESC
,DATAHUB_PROVIDER_OFFICE_BASE.OFFICE_ID AS PROVIDER_OFFICE_ID
,DATAHUB_PROVIDER_OFFICE_BASE.OFFICE_NAME AS PROVIDER_OFFICE_NAME
--TODO(STTM): unmapped. Sheet note: "Concatenated? If yes, ADDRESS?STANDARD ADDRESS? Line1, Line2,
--state,zip,country?" Derived below via CONCAT_WS in the sheet's stated order so the NOT NULL target is
--satisfied.
--REVIEWER: two things to decide here. First, RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE already carries
--VERIFIED_DELIVERY_LINE_1 / VERIFIED_DELIVERY_LINE_2 / VERIFIED_DELIVERY_LAST_LINE from address
--verification, which is very likely the intended source for a "formatted" address and would answer the
--sheet's own "STANDARD ADDRESS?" question -- the pharmacy feed maps a real FULL_ADDRESS_FORMATTED column
--rather than deriving one. Second, this CONCAT_WS relies on Snowflake skipping NULL arguments, so a row
--with every address part NULL yields an empty string rather than NULL; that satisfies NOT NULL but
--writes junk. Confirm the intended source, format and separator.
,CONCAT_WS(', '
    ,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_ADDRESS_LINE_1
    ,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_ADDRESS_LINE_2
    ,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_CITY_NAME
    ,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_STATE_ABBREV_NAME
    ,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_ZIP_CODE
    ,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_COUNTRY_NAME
) AS PROVIDER_FULL_ADDRESS_FORMATTED
,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_ADDRESS_LINE_1 AS PROVIDER_ADDRESS_LINE1_TEXT
,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_ADDRESS_LINE_2 AS PROVIDER_ADDRESS_LINE2_TEXT
,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_CITY_NAME
,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_STATE_ABBREV_NAME
,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_STATE_FULL_NAME
,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_COUNTY_NAME
,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_COUNTRY_NAME
--TODO(STTM): unmapped, sheet note "Needed?" on both. Confirmed absent from
--RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE -- the raw table has no country ISO columns at all, so these
--cannot be sourced without an upstream change to EXTRACTDATA.PROVIDER_OFFICE_BASE_VW. Both target
--columns are NOT NULL, so defaulted. The pharmacy feed sources its equivalents from
--ADDRESS_COUNTRY_ISO2 / ADDRESS_COUNTRY_ISO3.
,'Unknown' AS PROVIDER_COUNTRY_ISO2
,'Unknown' AS PROVIDER_COUNTRY_ISO3
,DATAHUB_PROVIDER_OFFICE_BASE.PROVIDER_ZIP_CODE AS PROVIDER_ZIP_CODE_NBR
--Source VERIFIED_LATITUDE / VERIFIED_LONGITUDE are NUMBER(10,5); target is NUMBER(9,6). The scales are
--compatible and real lat/long magnitudes fit inside NUMBER(9,6), so an explicit CAST is enough -- no
--TRY_TO_NUMBER needed. Both target columns are nullable, so raw NULLs pass through cleanly. Note the
--sibling Pharmacy_Dim_Provider_Address_Select_vw hardcodes NULL for both.
,CAST(DATAHUB_PROVIDER_OFFICE_BASE.VERIFIED_LATITUDE AS NUMBER(9,6)) AS PROVIDER_LATITUDE_NBR
,CAST(DATAHUB_PROVIDER_OFFICE_BASE.VERIFIED_LONGITUDE AS NUMBER(9,6)) AS PROVIDER_LONGITUDE_NBR
--TODO(STTM): the seven columns below are all unmapped, each carrying the sheet note "Need to be sourced
--from SAT_PROVIDER_DETAIL -> OFFICE_BASE_VW?". Confirmed absent from
--RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE as it stands on this branch, so the sheet's question is still open
--and the answer is an upstream change. PROVIDER_OFFICE_MANAGER_NAME and HANDICAP_ACCESS_IND are NOT NULL
--in dimdata.Dim_Provider_Address so they are defaulted; the remaining five are nullable and projected as
--NULL. Replace each with the real source column once the SAT_PROVIDER_DETAIL / OFFICE_BASE_VW question
--is settled. All seven exist on the pharmacy base table, so the column names are the ones to ask for.
,'Unknown' AS PROVIDER_OFFICE_MANAGER_NAME
,'U' AS HANDICAP_ACCESS_IND
,NULL AS TELE_HEALTH_IND
,NULL AS RECEIVES_MAIL_IND
,NULL AS E_PRESCRIBE_IND
,NULL AS MA_SUPER_PCP_IND
,NULL AS EMR_SYSTEM_NAME
FROM RAWDATA.DATAHUB_PROVIDER_OFFICE_BASE
--TODO(STTM): the sheet's join block (rows 38-39) and FILTERS block (rows 40-41) are both empty, so no
--joins and no WHERE clause are applied.
--REVIEWER: the sibling Pharmacy_Dim_Provider_Address_Select_vw guards with
--"WHERE ADDRESS_LINE_1 IS NOT NULL". Adding the equivalent guard here
--(WHERE PROVIDER_ADDRESS_LINE_1 IS NOT NULL) would resolve most of header item (1) at the cost of
--dropping office rows that have no street address. Confirm which behaviour is wanted.
;
