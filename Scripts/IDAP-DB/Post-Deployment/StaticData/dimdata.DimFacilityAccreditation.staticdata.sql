/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_FACILITY_ACCREDITATION

SELECT 'Updating static data table dimdata.DIM_FACILITY_ACCREDITATION';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_DIM_FACILITY_ACCREDITATION
(
		Dim_Facility_Accreditation_Key INTEGER NOT NULL , 
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Accreditation_Agency_Name VARCHAR NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO DIMDATA.TMP_DIM_FACILITY_ACCREDITATION (DIM_FACILITY_ACCREDITATION_KEY, MD5_VALUE_TEXT, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, ACCREDITATION_AGENCY_NAME)
	VALUES(1, 'DEFAULT1', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), FALSE, 'Unknown');
INSERT INTO DIMDATA.TMP_DIM_FACILITY_ACCREDITATION (DIM_FACILITY_ACCREDITATION_KEY, MD5_VALUE_TEXT, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, ACCREDITATION_AGENCY_NAME)
	VALUES(2, 'DEFAULT2', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), FALSE, 'n/a');

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.DIM_FACILITY_ACCREDITATION (DIM_FACILITY_ACCREDITATION_KEY, MD5_VALUE_TEXT, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, ACCREDITATION_AGENCY_NAME)
SELECT tmp.Dim_Facility_Accreditation_Key,tmp.MD5_Value_Text,tmp.Insert_Datetime,tmp.Last_Updated_Datetime,tmp.Is_Logical_Delete_Flag,tmp.Accreditation_Agency_Name
FROM dimdata.tmp_DIM_FACILITY_ACCREDITATION tmp
    LEFT JOIN dimdata.DIM_FACILITY_ACCREDITATION tbl ON tbl.DIM_FACILITY_ACCREDITATION_key = tmp.DIM_FACILITY_ACCREDITATION_key
WHERE tbl.DIM_FACILITY_ACCREDITATION_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
--left out for now since this is  strictly for default records

SELECT 'Finished updating static data table DIMDATA.DIM_FACILITY_ACCREDITATION';