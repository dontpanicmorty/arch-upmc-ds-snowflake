/*
THIS FILE SHOULD NOT BE DEPLOYED TO ANY DATABASES

This script is a work in progress intended to allow developer to run data through their own clone of IDAP
    - it can also be run by the build pipeline if we want but we should probably make that a more static thing
Note that you can't create/replace tables because we need to maintain all constaints, etc.
Lots of room for optimization here but this is a decent starting point to be able to run dimdata.spu_Load_Claim_Dimensions.sqlproc in under 20 mins total
    -- The insert into STAGEDATA.CLAIM_DETAIL takes about 9 minutes in this version
*/

--------------------------------------------------------------------------------------------------------------
------------------------------------cleanup the local DB for testing------------------------------------------
--------------------------------------------------------------------------------------------------------------
USE DATABASE IDAP_DEV_DIAMONDP;
USE WAREHOUSE DS_DEV_M_WH;


// TOP N RECORSD OF FACT
TRUNCATE TABLE DIMDATA.FACT_CLAIM_LINE;

INSERT INTO DIMDATA.FACT_CLAIM_LINE 
    SELECT TOP 10000 * FROM IDAP.DIMDATA.FACT_CLAIM_LINE
;

// GET MATCHING DIM_CLAIM_DETAIL
TRUNCATE TABLE DIMDATA.DIM_CLAIM_DETAIL;

INSERT INTO DIMDATA.DIM_CLAIM_DETAIL 
    SELECT * FROM IDAP.DIMDATA.DIM_CLAIM_DETAIL
    WHERE DIM_CLAIM_DETAIL_KEY IN (SELECT DIM_CLAIM_DETAIL_KEY FROM DIMDATA.FACT_CLAIM_LINE)
;

// GET MATCHING DIM_CLAIM_HEADER
TRUNCATE TABLE DIMDATA.DIM_CLAIM_HEADER;

INSERT INTO DIMDATA.DIM_CLAIM_HEADER
    SELECT * FROM IDAP.DIMDATA.DIM_CLAIM_HEADER
    WHERE DIM_CLAIM_HEADER_KEY IN (SELECT DIM_CLAIM_HEADER_KEY FROM DIMDATA.FACT_CLAIM_LINE)
;

//GET STAGE CLAIM DETAILS (THIS IS THE SLOWEST ONE OF THE GROUP. SHOULD LOOK AT OPTIMIZING EVENTUALLY)
TRUNCATE TABLE STAGEDATA.CLAIM_DETAIL;

INSERT INTO STAGEDATA.CLAIM_DETAIL
    SELECT CLAIM_DETAIL.* 
    FROM IDAP.STAGEDATA.CLAIM_DETAIL
        JOIN DIMDATA.DIM_CLAIM_DETAIL
            ON (DIM_CLAIM_DETAIL.DATA_HUB_UNIVERSAL_CLAIM_ID = CLAIM_DETAIL.JSON_DATA:envelope:instance:claimDetail:universalClaimId::string
            AND DIM_CLAIM_DETAIL.CLAIM_LINE_NBR = CLAIM_DETAIL.JSON_DATA:envelope:instance:claimDetail:claimLineNbr::string
            AND DIM_CLAIM_DETAIL.CLAIM_SEQUENCE_NBR = IFNULL(CLAIM_DETAIL.JSON_DATA:envelope:instance:claimDetail:claimSequenceNbr::string, 'n/a')
            AND DIM_CLAIM_DETAIL.PROCEDURE_ADJ_CODE = IFNULL(CLAIM_DETAIL.JSON_DATA:envelope:instance:claimDetail:procedureAdj::string,'n/a')
            )
;

//GET STAGE CLAIM HEADERS
TRUNCATE TABLE STAGEDATA.CLAIM_HEADER;

INSERT INTO STAGEDATA.CLAIM_HEADER
    SELECT CLAIM_HEADER.* 
    FROM IDAP.STAGEDATA.CLAIM_HEADER
        JOIN DIMDATA.DIM_CLAIM_HEADER
            ON (DIM_CLAIM_HEADER.DATA_HUB_UNIVERSAL_CLAIM_ID = CLAIM_HEADER.JSON_DATA:envelope:instance:claimHeader:universalClaimId::string)
;
