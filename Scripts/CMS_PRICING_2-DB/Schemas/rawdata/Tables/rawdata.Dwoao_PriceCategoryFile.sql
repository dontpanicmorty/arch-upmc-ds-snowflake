CREATE OR REPLACE TABLE RAWDATA.Dwoao_PriceCategoryFile
(     
       LastChangedDate int
      ,LastChangedTime int
      ,LastChangedUser varchar
      ,PriceCategory varchar
      ,PriceCategoryDescription varchar
      ,LastUpdated datetime
      ,LastApplied datetime
      ,DeletedFlag datetime
      ,PriceCategoryFileSeqNbr int
      ,CHGLAST datetime
      ,CHGORIG datetime
      ,CHGUSER varchar
      ,TPACLIENT varchar
      ,TPADIVISION varchar
      ,TPAIDOFCLIENT varchar
)COMMENT='Replicated from dwOAO database';