!set variable_substitution=true;
CREATE OR REPLACE VIEW PROVIDER_ONLINE.HARD_DELETE_SYNC_VW (
    ID,
    NETWORK_ID,
    PROVIDER_KEY,
    PROVDIRJSONTXT
) COMMENT = 'Add together upserts and deletes for provideronline' AS
SELECT DISTINCT
    ID,
    NETWORK_ID,
    PROVIDER_KEY,
    OBJECT_CONSTRUCT(
        'id',
        ID,
        'providerKey',
        PROVIDER_KEY,
        'networkId',
        NETWORK_ID,
        'isLogicalDelete',
        1,
        'ttl',
        5
    ) AS PROVDIRJSONTXT
FROM
    &{IDAP_LAKE}.PROVIDER.PROVIDER_ONLINE_COSMOS_SYNC_DELETES;
!set variable_substitution=false;