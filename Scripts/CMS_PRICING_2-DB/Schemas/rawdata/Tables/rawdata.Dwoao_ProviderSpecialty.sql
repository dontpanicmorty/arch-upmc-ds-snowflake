CREATE OR REPLACE TABLE RAWDATA.Dwoao_PROVIDERSPECIALTY
(     
           CMSType varchar,
           CMSTypeIndicator varchar,
           ProviderTypeDescrip varchar,
           Specialty varchar,
           LastUpdated datetime,
           LastApplied datetime,
           DeletedFlag datetime,
           ProviderSpecialtySeqNbr int,
           CHGLAST DATETIME(7),
           CHGORIG DATETIME(7),
           CHGUSER varchar
)COMMENT='Replicated from dwOAO database';