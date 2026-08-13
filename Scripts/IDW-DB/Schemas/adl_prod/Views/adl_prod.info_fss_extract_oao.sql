!set variable_substitution=true;
CREATE OR REPLACE VIEW ADL_PROD.INFO_FSS_EXTRACT_OAO
AS
SELECT
    LOB,
    CLAIM_NBR,
    CLAIM_LINE_SEQ,
    CLAIM_SEQ,
    FSS,
    ADMIT_CNT,
    CLAIM_DAY_CNT,
    DWOAO_LAST_UPDATED,
    LOAD_DATE,
    SVC_PROVIDER_ID,
    NULL AS SVC_PROVIDER_NAME
FROM
    (
        SELECT
            LOB,
            CLAIM_NBR,
            CLAIM_LINE_SEQ,
            CLAIM_SEQ,
            FSS_DWOAO AS FSS,
            ADMIT_CNT,
            CLAIM_DAY_CNT,
            ROW_NUMBER () OVER (
                PARTITION BY CLAIM_NBR,
                CLAIM_SEQ
                ORDER BY
                    DWOAO_LAST_UPDATED DESC,
                    ADMIT_CNT DESC,
                    CLAIM_DAY_CNT DESC
            ) AS LINE_ORDER,
            LOAD_DATE,
            SVC_PROVIDER_ID,
            DWOAO_LAST_UPDATED
        FROM
            &{IDW_LAKE}.ADL_PROD.INFO_EDM_DWOAO_CLAIMS_HIST
    )
WHERE
    LINE_ORDER = 1
    AND CLAIM_NBR NOT IN (
        WITH dupes AS (
            SELECT
                claim_nbr,
                claim_LINE_SEQ,
                CLAIM_SEQ
            FROM
                &{IDW_LAKE}.ADL_PROD.INFO_EDM_DWOAO_CLAIMS_HIST
            GROUP BY
                claim_nbr,
                claim_line_seq,
                claim_seq
            HAVING
                count(*) > 1
        ),
        rankDupes as (
            SELECT
                a.claim_nbr AS a_claim_nbr,
                *,
                ROW_NUMBER () OVER (
                    PARTITION BY a.CLAIM_NBR,
                    a.CLAIM_SEQ
                    ORDER BY
                        a.DWOAO_LAST_UPDATED DESC,
                        a.ADMIT_CNT DESC,
                        a.CLAIM_DAY_CNT DESC
                ) AS LINE_ORDER
            FROM
                ADL_PROD.INFO_EDM_DWOAO_CLAIMS_HIST a
                INNER JOIN dupes b ON b.claim_nbr = a.claim_nbr
                AND b.claim_LINE_seq = a.claim_LINE_seq
            ORDER BY
                a.claim_nbr,
                a.claim_line_seq
        )
        SELECT
            a_claim_nbr 
        FROM
            rankDupes
        WHERE
            line_order > 1
    );
!set variable_substitution=false;
