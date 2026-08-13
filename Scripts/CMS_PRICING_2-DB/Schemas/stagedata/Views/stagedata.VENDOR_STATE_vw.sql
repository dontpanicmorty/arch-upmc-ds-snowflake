  --FIND ONE STATE FOR EVERY VENDOR ID
CREATE OR REPLACE VIEW STAGEDATA.VENDOR_STATE_VW
AS
(
with setup as
    (
    select distinct 
    dwoao_providers.providernbr as VENDOR_ID
    ,COALESCE(cactus_addresses.state,dwoao_providers.state) as VENDOR_STATE
    ,count(distinct cactus_groupaddress.id) as STATE_COUNT
    from rawdata.dwoao_providers 
    left join rawdata.cactus_groups 
        on INSERT(LPAD(cactus_Groups.ID, 6, 0),1,1,'V') = dwoao_providers.providernbr
    left join rawdata.cactus_groupaddress 
        on cactus_groupaddress.group_k = cactus_groups.group_k
    left join rawdata.cactus_addresses
        on cactus_addresses.address_k = cactus_groupaddress.address_k
    where (dwoao_providers.providernbr like 'V%' and length(dwoao_providers.providernbr) = 6)   
    group by dwoao_providers.providernbr,COALESCE(cactus_addresses.state,dwoao_providers.state)
    ),
--actual finished solution
    state_agg as
     (
    SELECT 
    setup.VENDOR_ID
    , setup.VENDOR_STATE
    , setup.state_count
    ,rank() OVER (PARTITION BY setup.VENDOR_ID ORDER BY vendor_state,setup.state_count desc) as rnk
    FROM setup 
    left JOIN
        (
        SELECT VENDOR_ID, MAX(state_count) AS Max_State
        FROM setup
        GROUP BY VENDOR_ID
        ) setup_grouped
    ON setup.VENDOR_ID = setup_grouped.VENDOR_ID 
    AND setup.State_Count = setup_grouped.Max_State
        )
    select distinct vendor_id, vendor_state from state_agg
    where rnk = 1
);
