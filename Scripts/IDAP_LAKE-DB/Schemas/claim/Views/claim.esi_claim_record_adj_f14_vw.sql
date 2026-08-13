CREATE OR REPLACE VIEW CLAIM.ESI_CLAIM_RECORD_ADJ_F14_VW
AS
SELECT
TO_NUMBER(SUBSTR (RECORD,1,1),1) AS RECORD_IDENTIFIER,
TO_NUMBER(SUBSTR (RECORD,2,10),10) AS PROCESSOR_NUMBER,
TO_NUMBER(SUBSTR (RECORD,12,5),5) AS BATCH_NUMBER,
CAST(SUBSTR (RECORD,17,15) AS VARCHAR(15)) AS PHARMACY_NUMBER,
CAST(SUBSTR (RECORD,32,9) AS VARCHAR(9)) AS PRESCRIPTION_NUMBER,
TRY_TO_DATE(SUBSTR (RECORD,41,8), 'YYYYMMDD') AS DATE_FILLED,
SUBSTR (RECORD,49,11) AS NDC_NUMBER,
SUBSTR (RECORD,60,30)  AS DRUG_DESCRIPTION,
TO_NUMBER(SUBSTR (RECORD,90,2),2) AS NEW_REFILL_CODE,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 101, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                SUBSTR(RECORD, 92, 9) || DECODE(SUBSTR(RECORD, 101, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                SUBSTR(RECORD, 92, 10) 
    END
 / 1000 * 
(CASE 
    WHEN SUBSTR(RECORD, 101, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
         OR SUBSTR (RECORD,388,1) = 'R'
    THEN -1 
    ELSE 1 
END),10,2) AS METRIC_QUANTITY,
TO_NUMBER(SUBSTR (RECORD,102,3)/CASE WHEN SUBSTR(RECORD, 388, 1) = 'R' THEN -1 ELSE 1 END, 3) AS DAY_SUPPLY,
SUBSTR (RECORD,105,2) AS BASIS_OF_COST_DETERMINATION,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 115, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                SUBSTR(RECORD, 107, 8) || DECODE(SUBSTR(RECORD, 115, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                SUBSTR(RECORD, 107, 9) 
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 115, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS INGREDIENT_COST,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 124, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 116, 8) || DECODE(SUBSTR(RECORD, 124, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 116, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 124, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS DISPENSING_FEE,--Added decimals
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 133, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 125, 8) || DECODE(SUBSTR(RECORD, 133, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 125, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 133, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS CO_PAY_AMOUNT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 141, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                -- Concatenate first 7 characters with the decoded last character
                SUBSTR(RECORD, 134, 7) || DECODE(SUBSTR(RECORD, 141, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 134, 8)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 141, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),8,2) AS SALES_TAX,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 150, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 142, 8) || DECODE(SUBSTR(RECORD, 150, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 142, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 150, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS AMOUNT_BILLED,
SUBSTR (RECORD,151,12) AS PATIENT_FIRST_NAME,
SUBSTR (RECORD,163,15) AS PATIENT_LAST_NAME,
TRY_TO_DATE(SUBSTR (RECORD,178,8), 'YYYYMMDD') AS DATE_OF_BIRTH,
TO_NUMBER(SUBSTR (RECORD,186,1)) AS SEX_CODE,
SUBSTR (RECORD,187,18) AS CARDHOLDER_ID_NUMBER,
TO_NUMBER(SUBSTR (RECORD,205,1)) AS RELATIONSHIP_CODE,
SUBSTR (RECORD,206,18) AS GROUP_NUMBER,
SUBSTR (RECORD,224,3) AS HOME_PLAN,
SUBSTR (RECORD,227,3) AS HOST_PLAN,
SUBSTR (RECORD,230,15) AS PRESCRIBER_ID,
SUBSTR (RECORD,245,6) AS DIAGNOSIS_CODE,
SUBSTR (RECORD,251,12) AS CARDHOLDER_FIRST_NAME,
SUBSTR (RECORD,263,15) AS CARDHOLDER_LAST_NAME,
SUBSTR (RECORD,278,12) AS PRIOR_AUTHORIZATION_MED_CERT,
SUBSTR (RECORD,290,7) AS P_A_M_C_S_C_NUMBER,
TO_NUMBER(SUBSTR (RECORD,297,2),2) AS CUSTOMER_LOCATION,
TO_NUMBER(SUBSTR (RECORD,299,2),2) AS RESUBMISSION_CYCLE_COUNT,
TRY_TO_DATE(SUBSTR (RECORD,301,8),'YYYYMMDD') AS DATE_PRESCRIPTION_WRITTEN,
SUBSTR (RECORD,309,1) AS DISPENSE_AS_WRITTEN,
SUBSTR (RECORD,310,3) AS PERSON_CODE,
TO_NUMBER(SUBSTR (RECORD,313,2),2) AS OTHER_COVERAGE_CODE,
SUBSTR (RECORD,315,1) AS ELIGIBILITY_CLARIFICATION_CODE,
SUBSTR (RECORD,316,1) AS COMPOUND_CODE,
TO_NUMBER(SUBSTR (RECORD,317,2),2) AS NUMBER_OF_REFILLS_AUTHORIZED,
TO_NUMBER(SUBSTR (RECORD,319,2),2) AS LEVEL_OF_SERVICE,
TO_NUMBER(SUBSTR (RECORD,321,1),1) AS PRESCRIPTION_ORIGIN_CODE,
TO_NUMBER(SUBSTR (RECORD,322,2),2) AS PRESCRIPTION_DENIAL,
SUBSTR (RECORD,324,10) AS PRIMARY_PRESCRIBER,
TO_NUMBER(SUBSTR (RECORD,334,5),5) AS CLINIC_ID_NUMBER,
TO_NUMBER(SUBSTR (RECORD,339,1),1) AS DRUG_TYPE,
SUBSTR (RECORD,340,15) AS PRESCRIBER_LAST_NAME,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 358, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                SUBSTR(RECORD, 355, 3) || DECODE(SUBSTR(RECORD, 358, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                SUBSTR(RECORD, 355, 4)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 358, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),4,2) AS POSTAGE_AMOUNT_CLAIMED,
TO_NUMBER(SUBSTR (RECORD,359,1),1) AS UNIT_DOSE_INDICATOR,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 368, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                SUBSTR(RECORD, 360, 8) || DECODE(SUBSTR(RECORD, 368, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                SUBSTR(RECORD, 360, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 368, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS OTHER_PAYOR_AMOUNT,
TO_NUMBER(SUBSTR (RECORD,369,1),1) AS BASIS_OF_DAYS_SUPPLY_DET,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 378, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 370, 8) || DECODE(SUBSTR(RECORD, 378, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 370, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 378, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS FULL_AWP,
SUBSTR (RECORD,379,1) AS EXPANSION_AREA,
SUBSTR (RECORD,380,4) AS MASTER_CARRIER,
SUBSTR (RECORD,384,4) AS SUB_CARRIER,
SUBSTR (RECORD,388,1) AS CLAIM_TYPE,
SUBSTR (RECORD,389,20) AS ESI_SUB_GROUP,
SUBSTR (RECORD,409,1) AS PLAN_DESIGNATOR,
TRY_TO_DATE(SUBSTR (RECORD,410,8),'YYYYMMDD') AS ADJUDICATION_DATE,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 426, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 418, 8) || DECODE(SUBSTR(RECORD, 426, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 418, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 426, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS ADMIN_FEE,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 435, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 427, 8) || DECODE(SUBSTR(RECORD, 435, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 427, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 435, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS CAP_AMOUNT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 444, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 436, 8) || DECODE(SUBSTR(RECORD, 444, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 436, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 444, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS INGREDIENT_COST_SUB,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 453, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 445, 8) || DECODE(SUBSTR(RECORD, 453, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 445, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 453, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS MEMBER_NON_COPAY_AMOUNT,
SUBSTR (RECORD,454,2) AS MEMBER_PAY_CODE,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 463, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                -- Concatenate first 7 characters with the decoded last character
                SUBSTR(RECORD, 456, 7) || DECODE(SUBSTR(RECORD, 463, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 456, 8)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 463, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS INCENTIVE_FEE,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 469, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                -- Concatenate first 5 characters with the decoded last character
                SUBSTR(RECORD, 464, 5) || DECODE(SUBSTR(RECORD, 469, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 464, 6)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 469, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS CLAIM_ADJUSTMENT_AMOUNT,
SUBSTR (RECORD,470,2) AS CLAIM_ADJUSTMENT_CODE,
SUBSTR (RECORD,472,1) AS FORMULARY_FLAG,
SUBSTR (RECORD,473,14) AS GCN_GENERIC_CLASSIFICATION_NUM,
SUBSTR (RECORD,487,6) AS THERAPEUTIC_CLASS_AHFS,
SUBSTR (RECORD,493,1) AS PHARMACY_TYPE,
SUBSTR (RECORD,494,2) AS BILLED_BASIS_CODE,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 504, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 496, 8) || DECODE(SUBSTR(RECORD, 504, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 496, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 504, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS USUAL_CUSTOMARY_CHARGE,
TRY_TO_DATE(SUBSTR (RECORD,505,8),'yyyymmdd') AS PAID_DATE,
SUBSTR (RECORD,513,10) AS BENEFIT_CODE,
SUBSTR (RECORD,523,10) AS DRUG_STRENGTH,
SUBSTR (RECORD,533,2) AS ORIGINAL_MEMBER,
TRY_TO_DATE(SUBSTR (RECORD,535,8), 'YYYYMMDD')  AS DATE_OF_INJURY,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 551, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 543, 8) || DECODE(SUBSTR(RECORD, 551, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 543, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 551, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS FEE_AMOUNT,
SUBSTR (RECORD,552,14) AS ESI_REFERENCE_NUMBER,
SUBSTR (RECORD,566,20) AS CLIENT_CUSTOMER_ID,
SUBSTR (RECORD,586,10) AS PLAN_TYPE,
TO_NUMBER(SUBSTR (RECORD,596,9),9) AS ESI_ADJUDICATION_REF_NUMBER,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 613, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 605, 8) || DECODE(SUBSTR(RECORD, 613, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 605, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 613, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS ESI_ANCILLARY_AMT,
SUBSTR (RECORD,614,1) AS SPECIALTY_CLAIM_IND,
SUBSTR (RECORD,615,5) AS CMS_CONTRACT_ID,
SUBSTR (RECORD,620,3) AS CMS_PBP_ID,
SUBSTR (RECORD,623,1) AS TRANSITION_FILL_IND,
SUBSTR (RECORD,624,30) AS ESI_CLIENT_GENERAL_PUR_AREA,
SUBSTR (RECORD,654,1) AS PARTIAL_FILL_STATUS_CODE,
TRY_TO_DATE(SUBSTR (RECORD,655,8),'YYYYMMDD') AS ESI_BILLING_DATE,
SUBSTR (RECORD,663,2) AS FSA_VENDOR_CODE,
SUBSTR (RECORD,665,1) AS PICA_DRUG_CODE,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 674, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 666, 8) || DECODE(SUBSTR(RECORD, 674, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 666, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 674, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS AMOUNT_CLAIMED,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 683, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 675, 8) || DECODE(SUBSTR(RECORD, 683, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 675, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 683, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS AMOUNT_DISALLOWED,
SUBSTR (RECORD,684,1) AS FEDERAL_DRUG_CLASS_CODE,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 693, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 685, 8) || DECODE(SUBSTR(RECORD, 693, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 685, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 693, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS DEDUCTIBLE_AMOUNT,
SUBSTR (RECORD,694,1) AS BENEFIT_COPAY_100_PERCENT,
SUBSTR (RECORD,695,1) AS CLAIM_PROCESS_TYPE,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 699, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                -- Concatenate first 3 characters with the decoded last character
                SUBSTR(RECORD, 696, 3) || DECODE(SUBSTR(RECORD, 699, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 696, 4)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 699, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS COPAY_TIER_LEVEL_NUMBER,
SUBSTR (RECORD,700,1) AS SUBMISSION_TYPE,
SUBSTR (RECORD,701,1) AS MEDICARE_D_COVERED_DRUG,
SUBSTR (RECORD,702,1) AS RETRO_LICS_CODE,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 711, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 703, 8) || DECODE(SUBSTR(RECORD, 711, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 703, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 711, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS RETRO_LICS_AMOUNT,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 720, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                SUBSTR(RECORD, 712, 8) || DECODE(SUBSTR(RECORD, 720, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 712, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 720, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS LICS_SUBSIDY_AMOUNT,
SUBSTR (RECORD,721,1) AS MED_B_DRUG,
SUBSTR (RECORD,722,1) AS MED_B_CLAIM,
SUBSTR (RECORD,723,2) AS PRESCRIBER_QUALIFIER,
SUBSTR (RECORD,725,10) AS PRESCRIBER_IDENTIFIER,
SUBSTR (RECORD,735,2) AS PHARMACY_QUALIFIER,
SUBSTR (RECORD,737,10) AS PHARMACY_IDENTIFIER,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 757, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                SUBSTR(RECORD, 747, 10) || DECODE(SUBSTR(RECORD, 757, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                SUBSTR(RECORD, 747, 11)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 757, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),11,2) AS HRA_APPLIED_AMOUNT,
TO_NUMBER(SUBSTR (RECORD,758,6),6) AS ESI_THERAPY_CLASS,
SUBSTR (RECORD,764,12) AS HEALTH_INSURANCE_CLAIM_NUMBER,
SUBSTR (RECORD,776,1) AS HRA_FLAG,
SUBSTR (RECORD,777,4) AS DOSAGE_CODE,
SUBSTR (RECORD,781,1) AS LOW_INCOME,
SUBSTR (RECORD,782,219) AS FILLER2,
SUBSTR (RECORD,782,2) AS ADMIN_ROUTE,
SUBSTR (RECORD,784,1) AS DEA_SCHEDULE,
SUBSTR (RECORD,785,10) AS COPAY_BENEFIT_OPTION,
SUBSTR (RECORD,795,14) AS GENERIC_PRODUCT_IND,
SUBSTR (RECORD,809,10) AS PRESCRIBER_SPECIALTY,
SUBSTR (RECORD,819,18) AS VALUE_CODE,
SUBSTR (RECORD,837,18) AS PRIMARY_CARE_PHARM,
SUBSTR (RECORD,855,1) AS OFFICE_INSPECTOR_GENERAL,
SUBSTR (RECORD,856,3) AS THERAPY_SPEC_CODE,
SUBSTR (RECORD,859,1) AS PAYSUB_CLAIM_SOURCE,
SUBSTR (RECORD,860,1) AS ANDA_FLAG,
SUBSTR (RECORD,861,18) AS CDH_RESPONSE_ID,
SUBSTR (RECORD,879,4) AS CDH_ESI_REFERENCE_CODE,
SUBSTR (RECORD,883,1) AS HRA_SINGLE_BOOK_FLAG,
TO_NUMBER(
    CASE 
        WHEN DECODE(SUBSTR(RECORD, 892, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 884, 8) || DECODE(SUBSTR(RECORD, 892, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 884, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 892, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS HRA_REQUEST_AMOUNT,
SUBSTR (RECORD,893,4) AS VENDOR_ID,
SUBSTR (RECORD,897,1) AS DEDUCTIBLE_SINGLE_BOOK_FLAG,
SUBSTR (RECORD,898,1) AS MAX_OOP_SINGLE_BOOK_FLAG,
SUBSTR (RECORD,899,1) AS STOP_LOSS_SINGLE_BOOK_FLAG,
SUBSTR (RECORD,900,1) AS TDS_SINGLE_BOOK_FLAG,
SUBSTR (RECORD,901,2) AS VACCINE_PHARM_TYPE,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 911, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 903, 8) || DECODE(SUBSTR(RECORD, 911, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 903, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 911, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS VACCINE_ADMIN_AMOUNT,
SUBSTR (RECORD,912,2) AS VACCINE_ADMIN_TYPE,
SUBSTR (RECORD,914,6) AS CDH_VENDOR_VALUE,
SUBSTR (RECORD,920,1) AS ACR_ADMIN_FLAG,
SUBSTR (RECORD,921,5) AS UHC_GENERIC_CODE,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 934, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 926, 8) || DECODE(SUBSTR(RECORD, 934, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 926, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 934, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS SUPL_PAYER_PAID_AMT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 943, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 935, 8) || DECODE(SUBSTR(RECORD, 943, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 935, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 943, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS SUPL_COPAY_PAID_AMT,
SUBSTR (RECORD,944,1) AS SUPL_PAYER_COVERAGE_CODE,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 953, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 945, 8) || DECODE(SUBSTR(RECORD, 953, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 945, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 953, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS SUPL_PAYER_DEDUCTIBLE_AMT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 962, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 954, 8) || DECODE(SUBSTR(RECORD, 962, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 954, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 962, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS SUPL_PAYER_COPAY_AMT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 971, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 963, 8) || DECODE(SUBSTR(RECORD, 971, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 963, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 971, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS SUPL_PAYER_ANCILLARY_AMT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 980, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 972, 8) || DECODE(SUBSTR(RECORD, 980, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 972, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 980, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS SUPL_COPAY_ADDITIONAL_AMT,
SUBSTR (RECORD,981,12) AS PRESCRIPTION_NUMBER_12_POS,
SUBSTR (RECORD,993,2) AS PATIENT_RESIDENCE,
SUBSTR (RECORD,995,1) AS NX_EXISTS_IND,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1000, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                -- Concatenate first 4 characters with the decoded last character
                SUBSTR(RECORD, 996, 4) || DECODE(SUBSTR(RECORD, 1000, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 996, 5)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1000, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),5,2) AS MEMBER_ACR_AMOUNT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1009, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1001, 8) || DECODE(SUBSTR(RECORD, 1009, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1001, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1009, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS COB_RECOVER_AMT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1018, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1010, 8) || DECODE(SUBSTR(RECORD, 1018, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1010, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1018, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS PRE_COB_BILLED_CLAIM_AMT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1027, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1019, 8) || DECODE(SUBSTR(RECORD, 1027, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1019, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1027, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS DRUG_CALCULATED_DISCOUNT_AMT,
SUBSTR (RECORD,1028,2) AS DRUG_DISCOUNT_EXCLUSION_CODE,
SUBSTR (RECORD,1030,1) AS DRUG_DISCOUNT_APPLICABLE_CODE,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1039, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1031, 8) || DECODE(SUBSTR(RECORD, 1039, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1031, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1039, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS DRUG_DISCOUNT_ELIGIBLE_AMT,
SUBSTR (RECORD,1040,1) AS PDE_DELETE_CODE,
SUBSTR (RECORD,1041,1) AS MI_COMPOUND,
SUBSTR (RECORD,1042,1) AS MI_COMPOUND_OPTION,
SUBSTR (RECORD,1043,2) AS MI_EFFORT_LEVEL,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1050, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                -- Concatenate first 5 characters with the decoded last character
                SUBSTR(RECORD, 1045, 5) || DECODE(SUBSTR(RECORD, 1050, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1045, 6)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1050, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS MI_PROF_SERVICE_FEE,
SUBSTR (RECORD,1051,4) AS MI_INGRED_COUNT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1064, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1055, 9) || DECODE(SUBSTR(RECORD, 1064, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1055, 10)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1064, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),10,2) AS MI_COMPOUND_MED_D_ELIGIBLE,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1074, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1065, 9) || DECODE(SUBSTR(RECORD, 1074, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1065, 10)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1074, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),10,2) AS MI_COMPOUND_MED_D_INELIGIBLE,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1084, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1075, 9) || DECODE(SUBSTR(RECORD, 1084, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1075, 10)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1084, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),10,2) AS MI_COMPOUND_MED_D_COPAY,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1094, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1085, 9) || DECODE(SUBSTR(RECORD, 1094, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1085, 10)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1094, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),10,2) AS MI_COMPOUND_MED_D_COPAYPERCNT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1104, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1095, 9) || DECODE(SUBSTR(RECORD, 1104, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1095, 10)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1104, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),10,2) AS MI_COMPOUND_MED_D_MEMBERPAY,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1114, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1105, 9) || DECODE(SUBSTR(RECORD, 1114, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1105, 10)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1114, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS MI_COMPOUND_MED_D_PLANPAY,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1124, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1115, 9) || DECODE(SUBSTR(RECORD, 1124, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1115, 10)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1124, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1  
END),10,2) AS MI_COMPOUND_MED_D_COST,
SUBSTR (RECORD,1125,1) AS SHORT_CYCLE_FILL_CODE,
SUBSTR (RECORD,1126,18) AS CLAIM_ID,
SUBSTR (RECORD,1144,18) AS XREF_CLAIM_ID,
SUBSTR (RECORD,1162,2) AS TRANSACTION_TYPE_CODE,
SUBSTR (RECORD,1164,3) AS ADJUSTMENT_REASON_TYPE_CODE,
SUBSTR (RECORD,1167,54) AS FILLER3,
SUBSTR (RECORD,1167,1) AS PREFERRED_PHARMACY_IND,
SUBSTR (RECORD,1168,3) AS FILLER_2,
SUBSTR (RECORD,1171,9) AS FILLER_3,
SUBSTR (RECORD,1180,7) AS FILLER_4,
SUBSTR (RECORD,1187,7) AS FILLER_5,
SUBSTR (RECORD,1194,7) AS FILLER_6,
SUBSTR (RECORD,1201,9) AS FILLER_7,
SUBSTR (RECORD,1210,2) AS FILLER_8,
SUBSTR (RECORD,1212,9) AS FILLER_9,
SUBSTR (RECORD,1221,14) AS BATCH_ID,
SUBSTR (RECORD,1235,11) AS PAYMENT_REFERENCE_NUMBER,
SUBSTR (RECORD,1265,1) AS ADJUD_PHCY_CLASS_CDE,
SUBSTR (RECORD,1266,1) AS CLAIM_COB_CDE,
SUBSTR (RECORD,1267,8) AS FILLER_10,
SUBSTR (RECORD,1274,8) AS FILLER_11,
SUBSTR (RECORD,1282,8) AS FILLER_12,
SUBSTR (RECORD,1290,1) AS PATIENT_ASSURANCE_PROG_TYPE,
SUBSTR (RECORD,1291,8) AS PATIENT_ASSURANCE_PROG_AMT,
SUBSTR (RECORD,1299,1) AS SAVE_ON_RX_IND,
SUBSTR (RECORD,1300,2) AS PRICING_USED_IND,
SUBSTR (RECORD,1302,1) AS M3P_ORIGIN,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1311, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1303, 8) || DECODE(SUBSTR(RECORD, 1311, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1303, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1311, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS PATIENT_REDUCTION_AMOUNT,
TO_NUMBER(
    CASE 
        
        WHEN DECODE(SUBSTR(RECORD, 1320, 1),
            '{', '0', '}', '0',
            'A', '1', 'J', '1',
            'B', '2', 'K', '2',
            'C', '3', 'L', '3',
            'D', '4', 'M', '4',
            'E', '5', 'N', '5',
            'F', '6', 'O', '6',
            'G', '7', 'P', '7',
            'H', '8', 'Q', '8',
            'I', '9', 'R', '9',
            NULL) IS NOT NULL 
            THEN 
                
                SUBSTR(RECORD, 1312, 8) || DECODE(SUBSTR(RECORD, 1320, 1),
                    '{', '0', '}', '0',
                    'A', '1', 'J', '1',
                    'B', '2', 'K', '2',
                    'C', '3', 'L', '3',
                    'D', '4', 'M', '4',
                    'E', '5', 'N', '5',
                    'F', '6', 'O', '6',
                    'G', '7', 'P', '7',
                    'H', '8', 'Q', '8',
                    'I', '9', 'R', '9')
            ELSE 
                
                SUBSTR(RECORD, 1312, 9)
    END
 / 100 * 
(CASE 
    WHEN SUBSTR(RECORD, 1320, 1) IN ('}', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R') 
    THEN -1 
    ELSE 1 
END),9,2) AS SUPPLEMENTAL_COVERAGE_AMOUNT,
SUBSTR (RECORD,1321,1) AS SUPPLEMENTAL_COVERAGE_TROOP_QUALIFICATION,
SUBSTR (RECORD,1322,1) AS MANUFACTURER_DISCOUNT_TYPE,
SUBSTR (RECORD,1323,18) AS ORIGINAL_CLAIM_ID,
SUBSTR (RECORD,1341,360) AS FILLER_13,
FILENAME,
INSERT_DATETIME
FROM CLAIM.ESI_CLAIM_RECORD_ADJ_F14
WHERE RECORD_IDENTIFIER = '4';

