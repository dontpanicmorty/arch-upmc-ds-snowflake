CREATE OR REPLACE TABLE HPANALYTICS.MILLIMAN_DRG_MAPPING_DOHE
(
SSDL_DRG_KEY                            VARCHAR,
CLAIM_CATEGORY                          VARCHAR,
DRG_TYPE                                VARCHAR,
DRG_CODE                                VARCHAR,
DRG_LOOKUP_CODE                         VARCHAR,
DRG_DESC                                VARCHAR,
DRG_DISPLAY                             VARCHAR,
DRG_CATEGORY                            VARCHAR,
DRG_CATEGORY_DESC                       VARCHAR,
MILLIMAN_DRG_SUBCATEGORY                VARCHAR,
DRG_WEIGHT                              VARCHAR,
DRG_VERSION                             VARCHAR,
DRG_SEVERITY                            VARCHAR,
DRG_GROUP_DESC                          VARCHAR,
DRG_GROUP_DISP                          VARCHAR,
MDC_CODE                                VARCHAR,
MDC_DESC                                VARCHAR,
MDC_DISP                                VARCHAR,
HCAT                                    VARCHAR,
CLINICAL_EPISODE_CATEGORY               VARCHAR,
CLINICAL_EPISODE_SERVICE_LINE_GROUP     VARCHAR,
TAVR_TRIGGER                            VARCHAR,
EFFECTIVE_START_DATE                    VARCHAR,
EFFECTIVE_END_DATE                      VARCHAR
)
COMMENT='Created for HPANALYTICS Migration'
;
