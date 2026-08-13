!set variable_substitution=true;


CREATE OR REPLACE TASK REPORTDATA.MEMBER_PREFERENCE_EXTRACT
    WAREHOUSE = DS_&{environment}_LOAD_XS_WH
    SCHEDULE = 'USING CRON 0 2 * * * America/New_York'
    COMMENT = 'Daily task to create member preference reports for export'
    QUERY_TAG = 'IDAP &{environment} REPORTDATA EXTRACT'
AS 
EXECUTE IMMEDIATE
$$
BEGIN 
-- Setup: Calculate variable names
    let Datestring string := CURRENT_DATE(); 
    let AzureDirectory string := '@REPORTDATA.SNOWFLAKEDATA_OUTBOUNDDATA/member/';
    
    -- MEMBER_PREFERENCES_COMMERCIAL_VW
    CALL REPORTDATA.SPU_WRITE_MEMBER_PREFERENCE_EXTRACT(
        'REPORTDATA.MEMBER_PREFERENCES_COMMERCIAL_VW',
        :AzureDirectory || 'Commercial_Member_Preferences_File_' || :Datestring || '.csv'
    );
        
    -- MEMBER_PREFERENCES_MEDICARE_VW
    CALL REPORTDATA.SPU_WRITE_MEMBER_PREFERENCE_EXTRACT(
        'REPORTDATA.MEMBER_PREFERENCES_MEDICARE_VW',
        :AzureDirectory || 'Medicare_Member_Preferences_File_' || :Datestring || '.csv'
    );
        
    -- MEMBER_PREFERENCES_OFF_EXCHANGE_VW
    CALL REPORTDATA.SPU_WRITE_MEMBER_PREFERENCE_EXTRACT(
        'REPORTDATA.MEMBER_PREFERENCES_OFF_EXCHANGE_VW',
        :AzureDirectory || 'Off_Exchange_Member_Preferences_File_' || :Datestring || '.csv'
    );
        
    -- MEMBER_PREFERENCES_ON_EXCHANGE_VW
    CALL REPORTDATA.SPU_WRITE_MEMBER_PREFERENCE_EXTRACT(
        'REPORTDATA.MEMBER_PREFERENCES_ON_EXCHANGE_VW',
        :AzureDirectory || 'On_Exchange_Member_Preferences_File_' || :Datestring || '.csv'
    );
        
END;
$$;

!set variable_substitution=false;
