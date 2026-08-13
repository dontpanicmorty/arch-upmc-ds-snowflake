CREATE OR REPLACE VIEW CMS.MOR_RXHCC_HEADER_VW AS
SELECT
    S.FILENAME,
    S.FILE_TYPE,
    S.ROW_NUMBER,
    T.RECORD_TYPE_CODE,      
    T.RECORD_TYPE_DESC,

    -- Layout: Part D RA Model Output Header (Types 2/4/5/6/7)
    -- 1: Record Type Code (1, pos 1) -> not needed; we already have RECORD_TYPE_CODE
    SUBSTR(S.RECORD,  2, 5)  AS CONTRACT_NUMBER,        -- pos 2-6
    SUBSTR(S.RECORD,  7, 8)  AS RUN_DATE,               -- pos 7-14, CCYYMMDD
    SUBSTR(S.RECORD, 15, 6)  AS PAYMENT_YEAR_MONTH,     -- pos 15-20, CCYYMM
    -- pos 21-180 = filler (spaces) intentionally omitted

    -- File metadata (keep consistent with your other views)
    S.FILE_PREFIX,
    S.FILE_DATE,
    S.FILE_TIME,
    S.FILE_LAST_MODIFIED_DATETIME,
    S.LAST_UPDATED_DATETIME,
    S.RECORD AS RAW_RECORD_TEXT
FROM
    CMS.RESPONSE_MOR_STAGE S
    INNER JOIN CMS.RESPONSE_MOR_TYPES T
        ON T.RECORD_TYPE_CODE = S.RECORD_TYPE
       AND T.FILE_TYPE        = S.FILE_TYPE
WHERE
      T.REPORT_SEGMENT_VIEW_NAME = 'MOR_RXHCC_HEADER_VW'
  AND S.FILE_TYPE   = 'PTDMODD'   -- Part D MOR data file
  AND S.RECORD_TYPE = '1';        -- Header