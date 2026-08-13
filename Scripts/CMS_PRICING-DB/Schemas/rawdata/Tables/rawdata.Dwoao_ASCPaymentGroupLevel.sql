--"exact copy of the ASCPaymentGroupLevel table from dwOAO"
CREATE OR REPLACE TABLE RAWDATA.Dwoao_ASCPaymentGroupLevel
( ASCSchedule varchar,
  ASCGroupLevel varchar,
  ASCEffectiveDate decimal(8,0),
  ASCTermDate decimal(8,0),
  Description varchar,
  ASCGroupRate decimal(8,2),
  ASCPaymentAllowance decimal(8,2),
  MedicareCarrier varchar,
  MedicareLocality varchar,
  TPACLIENT varchar,
  TPAIDOFCLIENT varchar,
  TPADIVISION varchar,
  CHGUSER varchar,
  CHGORIG datetime,
  CHGLAST datetime,
  LastUpdated datetime,
  LastApplied datetime,
  DeletedFlag datetime,
  ASCPaymentGroupLevelSetSeqNbr int
)
Comment = 'exact copy of the ASCPaymentGroupLevel table from dwOAO';