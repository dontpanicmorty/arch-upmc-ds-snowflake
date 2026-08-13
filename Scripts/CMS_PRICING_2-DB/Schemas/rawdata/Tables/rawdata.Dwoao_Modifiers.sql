CREATE OR REPLACE TABLE RAWDATA.Dwoao_Modifiers
(  ModifierSchedule varchar,
    Modifier varchar,
    Description varchar,
    Percentage decimal(6,3),
    ModifierType varchar,
    AnesthesiaUnit decimal(2,0),
    TPACLIENT varchar,
    TPAIDOFCLIENT varchar,
    TPADIVISION varchar,
    CHGUSER varchar,
    CHGORIG datetime,
    CHGLAST datetime,
    LastUpdated datetime,
    LastApplied datetime,
    DeletedFlag datetime,
    ModifierSeqNbr int
)
Comment = 'exact copy of the Modifiers table from dwOAO';
