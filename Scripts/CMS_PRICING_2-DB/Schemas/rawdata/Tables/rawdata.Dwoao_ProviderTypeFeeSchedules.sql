CREATE OR REPLACE TABLE RAWDATA.Dwoao_ProviderTypeFeeSchedules
(     
           ProviderTypeSchedule varchar,
           ProviderType varchar,
           EffDt decimal(8,0),
           TrmDt decimal(8,0),
           ServiceReasonScheduleDescription varchar,
           TPACLIENT varchar,
           TPAIDOFCLIENT varchar,
           TPADIVISION varchar,
           CHGUSER varchar,
           CHGORIG DATETIME(7),
           CHGLAST DATETIME(7),
           LastUpdated datetime,
           LastApplied datetime,
           DeletedFlag datetime,
		   ProviderTypeFeeSchedulesRSeqNbr int
)COMMENT='Replicated from dwOAO database';