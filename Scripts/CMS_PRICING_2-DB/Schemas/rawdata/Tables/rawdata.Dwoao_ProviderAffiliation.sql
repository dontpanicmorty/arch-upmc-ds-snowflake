CREATE OR REPLACE TABLE RAWDATA.Dwoao_PROVIDERAFFILIATION
(     
           AffEffectiveDate int,
           AffTermDate int,
           Entity varchar,
           GroupCarrier varchar,
           MemberIPA varchar,
           PhysicianGroup varchar,
           PlanType varchar,
           RenderingProvAffiliation varchar,
           UserDefined varchar,
           LastUpdated datetime,
           LastApplied datetime,
           DeletedFlag datetime,
           ProviderAffiliationSeqNbr int,
           CHGLAST DATETIME(7),
           CHGORIG DATETIME(7),
           CHGUSER varchar,
           TPACLIENT varchar,
           TPADIVISION varchar,
           TPAIDOFCLIENT varchar
)COMMENT='Replicated from dwOAO database';