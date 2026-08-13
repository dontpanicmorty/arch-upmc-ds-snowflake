CREATE OR REPLACE TABLE RAWDATA.Dwoao_ASAConversionFactorSet
( ASAConversionSet varchar,
    ASAEffectiveDate decimal(8,0),
    ASCEffectiveDate decimal(8,0),
    ASAFromProcedureCode varchar,
    ASAToProcedureCode varchar,
    ASADescription varchar,
    ASAConversionFactor decimal(6,2),
    CHGUSER varchar,
    CHGORIG datetime,
    CHGLAST datetime,
    LastUpdated datetime,
    LastApplied datetime,
    DeletedFlag datetime,
    ASAConversionFactorSetSeqNbr int

)
Comment = 'exact copy of the ASAConversionFactorSet table from dwOAO';
