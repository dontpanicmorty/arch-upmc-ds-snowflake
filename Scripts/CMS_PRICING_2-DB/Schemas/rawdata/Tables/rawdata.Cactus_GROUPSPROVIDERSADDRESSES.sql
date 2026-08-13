CREATE OR REPLACE TABLE RAWDATA.Cactus_GROUPSPROVIDERSADDRESSES 
(
           GROUPSPROVIDERSADDRESS_K CHAR(10),
           GROUPADDRESS_K           CHAR(10),
           PROVIDERADDRESS_K        CHAR(10),
           WEBPUBLISHSTATUS_RTK     CHAR(10),
           LoadDate                 DATETIME
)COMMENT='Replicated from Cactus database';