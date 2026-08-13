CREATE OR REPLACE TABLE RAWDATA.Dwoao_ProviderSubPart
(     
            ProviderNumber varchar,
            ProviderSubpart varchar,
            ProviderSubpartDesign varchar,
            LastUpdated datetime,
            LastApplied datetime,
            DeletedFlag datetime,
            ProviderSubPartSeqNbr int,
            CHGLAST datetime(7),
            CHGORIG datetime(7),
            CHGUSER varchar,
            TPACLIENT varchar,
            TPADIVISION varchar,
            TPAIDOFCLIENT varchar
)COMMENT='Replicated from dwOAO database';