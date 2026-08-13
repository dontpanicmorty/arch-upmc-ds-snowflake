--Lots of order by statements in here but they are necessary to ensure consistent formatting of the output
CREATE OR REPLACE VIEW PROVIDER_DIRECTORY.PROVIDERS_JSON_DELETES_SELECT_VW 
COMMENT = 'Creates dummy JSON for Cosmos where records exist in FindCare but are no longer in the source and need hard deleted using ttl'
AS
SELECT OBJECT_CONSTRUCT(
    'id', DELETES.ID
    ,'memberCardId', DELETES.MEMBER_CARD_ID
    ,'deletedTimestamp', CURRENT_TIMESTAMP()
    ,'ttl', 10
    ) AS MEMBER_NETWORKS_JSON_TXT
FROM
    (
    SELECT ID, MEMBER_CARD_ID FROM PROVIDER_DIRECTORY.MEMBER_NETWORKS_JSON_PREV
    MINUS
    SELECT ID, MEMBER_CARD_ID FROM PROVIDER_DIRECTORY.MEMBER_NETWORKS_JSON
    ) AS DELETES;