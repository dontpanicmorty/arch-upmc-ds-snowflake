CREATE OR REPLACE TABLE RAWDATA.Dwoao_PerDiemPriceCategory
(     
           PerDiemCaseRateSchedule varchar,
           CaseType varchar,
           LevelNumber decimal(3,0),
           EffectiveDate decimal(8,0),
           PriceCategory varchar,
           PriceCatSequenceNumber decimal(5,0),
           PerDiemPercentage decimal(7,4),
           AllowedBilledAmtFlag varchar,
           TPACLIENT varchar,
           TPAIDOFCLIENT varchar,
           TPADIVISION varchar,
           CHGUSER varchar,
           CHGORIG DATETIME(7),
           CHGLAST DATETIME(7),
           LastUpdated datetime,
           LastApplied datetime,
           DeletedFlag datetime,
		   PerDiemPriceCategorySeqNbr int	   
)COMMENT='Replicated from dwOAO database';