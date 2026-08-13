CREATE OR REPLACE TABLE RAWDATA.Dwoao_ProviderTypeSchedule
(     
           ProviderTypeSchedule varchar,
           ProviderType varchar,
           EffDt decimal(8,0),
           PriceCategory varchar,
           Seq decimal(3,0),
           TPACLIENT varchar,
           TPAIDOFCLIENT varchar,
           TPADIVISION varchar,
           CHGUSER varchar,
           CHGORIG DATETIME(7),
           CHGLAST DATETIME(7),
           LastUpdated datetime,
           LastApplied datetime,
           DeletedFlag datetime,
		   ProviderTypeScheduleSeqNbr int
)COMMENT='Replicated from dwOAO database';