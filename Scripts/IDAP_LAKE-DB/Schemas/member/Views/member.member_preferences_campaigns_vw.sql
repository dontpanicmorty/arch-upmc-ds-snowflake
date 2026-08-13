
CREATE OR REPLACE VIEW MEMBER.MEMBER_PREFERENCES_CAMPAIGNS_VW
COMMENT = 'Parses CommunicationPreferences.Campaigns array and ContactMethod array to display campaigns by contact method for each set of Member Preference Data'
AS
SELECT
    MEMBER_PREFERENCES_KEY,
    CAMPAIGNS.INDEX AS CAMPAIGN_ARRAY_INDEX,
    CONTACT_METHODS.INDEX AS CONTACT_METHODS_ARRAY_INDEX,
    CAMPAIGNS.value:Type::string as CAMPAIGN_TYPE,
    CAMPAIGNS.value:IsPaperless::string as CAMPAIGN_IS_PAPERLESS,
    CONTACT_METHODS.value:Type::string as CONTACT_METHOD_TYPE,
    CONTACT_METHODS.value:DataSource.Name::string as CONTACT_METHOD_SOURCE_NAME,
    CONTACT_METHODS.value:DataSource.UpdatedOn::string as CONTACT_METHOD_SOURCE_UPDATED_ON
FROM MEMBER.MEMBER_PREFERENCES_JSON_VW
    ,TABLE(FLATTEN(JSON_DATA:CommunicationPreferences:Campaigns)) CAMPAIGNS
    ,TABLE(FLATTEN(CAMPAIGNS.value:ContactMethods, OUTER => TRUE)) CONTACT_METHODS
    ;