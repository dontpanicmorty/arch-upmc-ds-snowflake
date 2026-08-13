--Lots of order by statements in here but they are necessary to ensure consistent formatting of the output
CREATE OR REPLACE VIEW PROVIDER_DIRECTORY.PROVIDERS_JSON_DELETES_SELECT_VW 
COMMENT = 'Creates dummy JSON for Cosmos where records exist in FindCare but are no longer in the source and need hard deleted using ttl'
AS
SELECT OBJECT_CONSTRUCT(
    'id', DELETES.ID
    ,'networkId', DELETES.NETWORK_ID
    ,'deletedTimestamp', CURRENT_TIMESTAMP()
    ,'ttl', 10
    ) AS PROVDIR_JSON_TXT
FROM
    (
    SELECT ID, NETWORK_ID FROM PROVIDER_DIRECTORY.PROVIDERS_JSON_PREV
    MINUS
    SELECT ID, NETWORK_ID FROM PROVIDER_DIRECTORY.PROVIDERS_JSON
    ) AS DELETES;