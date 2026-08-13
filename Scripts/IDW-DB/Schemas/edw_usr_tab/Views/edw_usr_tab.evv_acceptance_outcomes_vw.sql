!set variable_substitution=true;

CREATE OR REPLACE VIEW EDW_USR_TAB.EVV_ACCEPTANCE_OUTCOMES_VW
AS
SELECT
  PAYER_ID,            
  MCO,                 
  PROVIDER_ID,         
  PROVIDER_NAME,       
  PROVIDER_MPI,        
  PROVIDER_NPI,        
  PROVIDER_TAX_ID,     
  PATIENT_ID,          
  MEDICAID_ID,         
  FROM_DOS,            
  TO_DOS,              
  VISIT_START_TIME,    
  VISIT_END_TIME,     
  STAFF_OTHER_ID,      
  SERVICE_CODE,        
  MODIFIER1,           
  MODIFIER2,           
  MODIFIER3,           
  MODIFIER4,           
  VISIT_ID,            
  HHAX_BILLED_UNITS,   
  UNITS_FROM_FILE,
  CLAIM_ID,            
  DHS_ICN,        
  LINE_NUMBER,
  ESC,
  PROCESSING_DATE_TIME,
  BILL_VISIT,      
  RECORD_STATUS,       
  ERROR_MESSAGE,       
  EXPORTED_DATE,       
  TRANSACTION_ID,
  CLAIM_MPI,          
  CLAIM_NPI,
  ANALYSIS,          
  FILENAME AS FILE_NAME,          
  INSERT_DATETIME AS LOAD_DATE
FROM &{IDAP_LAKE}.CLAIM.EVV_ACCEPTANCE_OUTCOMES;

!set variable_substitution=false;     