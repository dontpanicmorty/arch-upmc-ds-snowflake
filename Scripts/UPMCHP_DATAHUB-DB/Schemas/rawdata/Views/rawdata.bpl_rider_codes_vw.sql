CREATE OR REPLACE VIEW RAWDATA.BPL_RIDER_CODES_VW
COMMENT = 'View all BPL Rider Codes'
AS
  SELECT
        METADATA$FILENAME,
        REGEXP_SUBSTR(METADATA$FILENAME, '\\d{4}/\\d{2}/\\d{2}') AS FILE_DATE,
        $2 AS BPL,
        $3 AS RIDER_CODE,
        $4 AS EFFECTIVE_DATE,
        $5 AS TERMINATION_DATE,
        $6 AS FORM_ID
    FROM '@RAWDATA.HPDSDATALAKE_IDAPLAKE/claim/fms/bpl_rider' (
            PATTERN => 'claim/fms/bpl_rider/\\d{4}/\\d{2}/\\d{2}/(?i)dbo.vbpl_rider_crosswalk.*.txt',
            FILE_FORMAT => RAWDATA.BPL_RIDER_CODES_FILE_FORMAT)
  QUALIFY TO_DATE(FILE_DATE, 'YYYY/MM/DD') =
        MAX(TO_DATE(FILE_DATE, 'YYYY/MM/DD')) OVER ()
    ;