/*----------------------------------------------------------------------------------------------------------
This is the master deployment procedure for the database. Only the items in this script will be 
deployed to the target database.

Connection options for deployment via SnowSQL:
    -f FDB_Deployment.sql 
    --variable build_number="<your build number>" 
    --variable environment="<DEV, TST, PRD>" 
    -o log_level=debug 
    -o timing=false 
    -o header=false 
    -o echo=true 
    -o exit_on_error=true 
    -o output_file=FDB_Deployment.log
----------------------------------------------------------------------------------------------------------*/

--***** This sets the SnowSQL variables that are used for cross db queries
!set variable_substitution=true;
!load &{tokenFilePath}

--***************************************************************************
-- Create deployment shell database
CREATE OR REPLACE DATABASE &{sourceDB} 
DATA_RETENTION_TIME_IN_DAYS=0 
COMMENT='CLI CI/CD Deployment Compare Database for build.'
;
!set variable_substitution=false;
--***************************************************************************
--***** THE ORDER OF EXECUTION IS BASED OFF OF DATABASE DEPENDENCIES!! ******
--***************************************************************************

----------------------------------------------------------------------------------------------------------
-- Schemas
----------------------------------------------------------------------------------------------------------
!load ../Schemas/DatabaseLevelObjects/fdbdata.schema.sql;
!load ../Schemas/DatabaseLevelObjects/logdata.schema.sql;
!load ../Schemas/DatabaseLevelObjects/stagedata.schema.sql;
!load ../Schemas/DatabaseLevelObjects/util.schema.sql;

----------------------------------------------------------------------------------------------------------
-- Stages  
----------------------------------------------------------------------------------------------------------

!load ../Schemas/stagedata/Stages/stagedata.hpdsdatalake_idaplake.sql;

----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------

!load ../Schemas/stagedata/FileFormats/stagedata.fdb_file_format.sql;

----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------

--util

!load ../Schemas/util/Tables/util.load_config.sql;

--logdata

!load ../Schemas/logdata/Tables/logdata.data_validation_result.sql;
!load ../Schemas/logdata/Tables/logdata.job_log.sql;
!load ../Schemas/logdata/Tables/logdata.table_load_history.sql;

--fdbdata

!load ../Schemas/fdbdata/Tables/FDBDATA.RADIDA0_DISPLAY_ACTION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIDC0_DDI_DC_GCNSEQNO_SCREEN.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIGD1_GCNSEQNO_DOSING_THRESH.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIGE0_DDI_GCNSEQNO_EXCEPT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIMEF0_CLIN_EFFECT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIMGC4_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIMIE4_CLIN_EFFECTS_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIMM0_MONOX_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIMMA5_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIMMO5_MONO.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIMSL1_SEVER_LEVEL.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIRGE0_DDI_RTD_GEN_EXCEPT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RADIRME0_DDI_RTD_MED_EXCEPT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RAHFSD1_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RAHFSGC1_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RAPLR0_APPL_RELATION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RAPLRT0_APPL_RELATION_TYPE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RAPLT0_APPL_TYPE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RAPPLNA0_FDA_NDC_APPL.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RAPPLSL0_FDA_NDC_NDA_ANDA.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RAPPLTD0_FDA_APPL_TYPE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RATCD0_ATC_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RATCGC0_ATC_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RBLA0_BIOLOGICS_LICENSE_APPL.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RBLAHIC0_INGREDIENTS.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RBLANG0_NAME_GRP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RBLAPN0_PROPRIETARY_NAME.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RBLASG0_SUBSTANCE_GRP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RCMMD0_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RCMMGC0_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RCQDNDC0_DISP_CLNQTY_NDC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RCQMED0_CLNQTY_MEDID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RCQNDC0_CLNQTY_NDC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMAGD1_ALRGN_GRP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMAPM0_ALRGN_PICKLIST_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMCA0_CONCEPT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMCAS0_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMCD0_PICKLIST_CON_TYP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMCSD1_XSENSIT_ALLERGY_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMGHC0_HIC_ALRGN_GRP_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMGRH0_ALRGN_GRP_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMGSD0_GRP_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMGX0_ALRGN_GRP_XSENSE_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMHHA0_HIC_HICL_ALG_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMXHC0_HIC_ALRGN_XSENSE_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMXSD0_XSENSE_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDAMXSH0_ALRGN_XSENSE_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDCCD0_DRUG_CAT_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDDIMAG0_AGENT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDDIMIN0_NDC_INACTV_DDIM_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDDIMRD0_REF_CATEGORY.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDDIMRG0_ROUTED_GEN_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDDIMRM0_ROUTED_MED_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDFIMGC0_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDFIMMA0_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDFIMMO0_MONO.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDFIMRG0_ROUTED_GEN_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDFIMRM0_ROUTED_MED_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMCR0_CLIN_REVIEW_STATUS.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMDD0_DOC_LEVEL_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMDI0_DRUG_GRP_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMDR0_DRUG_ID_TYP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMGC1_GCNSEQNO_DRUG_GROUP.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMID0_INTERFERENCE_TYP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMMA1_LAB_INTERFERENCE_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMMI0_MONO_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMMO1_MONO.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMRG0_ROUTED_GEN_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMRM0_ROUTED_MED_DRUG_GROUP.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMSD0_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDLIMTD0_MONO_TXT_TYP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDOSED2_DOSE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDPTCL0_CLASS_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDPTGC0_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDPTRG0_ROUTED_GEN_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RDPTRTM0_ROUTED_MED_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCCTD0_ETC_CHANGE_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCGC0_ETC_GCNSEQNO.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCGCH0_ETC_GCNSEQNO_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCHCH0_ETC_HICSEQN_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCHCL0_ETC_HICLSEQNO.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCHIC0_ETC_HICSEQN.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCHLH0_ETC_HICLSEQNO_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCMDH0_ETC_MEDID_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCMED0_ETC_MEDID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCMNM0_ETC_MED_NAME_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCNDC0_ETC_NDC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCNDH0_ETC_NDC_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCNMH0_ETC_MED_NAME_ID_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCSCH0_ETC_SEARCH.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCTBL0_ETC_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RETCXRF0_ETC_HIC3_ETC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDCD0_RXN_CONCEPT_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDCM0_CVX_MVX_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDCPT0_EXT_CPT_CVX_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDCS0_RXN_CONCEPT_SOURCE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDCVX0_EXT_VOCAB_CVX_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDEL0_EXT_VOCAB_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDEV0_EXT_VOCAB_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDEVN0_EXT_VOCAB_NOTE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDLT0_LINK_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDMVX0_EXT_VOCAB_MVX_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDNCM0_NDC_CVX_MVX_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDRC0_RXN_CONCEPT_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDRH0_RXCUI_REP_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDRHD0_RXCUI_REP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDUR0_RXCUI_ULT_REPL.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDUSE0_EXT_VOCAB_CVX_USAGE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDVB0_CDC_VIS_LOOKUP.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDVD0_VOCAB_DATA_VERSION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDVG0_CDC_CVX_VG_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDVL0_CDC_CVX_VIS_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDVS0_SOURCE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.REVDVT0_VOCAB_TYPE_DEF.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RGCN0_GCN_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RGCNINH0_GCNSEQNO_INACTV_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RGCNINS0_STUDY_TABLE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RGCNSEQ4_GCNSEQNO_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RGCNSTR0_INGREDIENT_STRENGTH.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RGTCD0_GEN_THERAP_CLASS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHIC1D2_HIC_ORGAN_SYS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHIC2D3_HIC_RX_CLASS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHIC3D3_HIC_THERAP_CLASS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHIC3L2_HIC3_HICLSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHIC4D2_HIC_BASE_ING_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHICCAS1_HIC_CAS_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHICD5_HIC_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHICHCR0_HIC_HIC_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHICL1_HIC_HICLSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHICLSQ1_HICLSEQNO_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHICLSQ2_HICLSEQNO_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHICRH0_ING_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RHICSCD0_ING_STAT_CD_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKBF0_DXID_SCT_BEST_FIT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKBFH0_DXID_SCT_BEST_FIT_HX.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKCMD0_CLIN_MOD_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKCQM0_VSAC_MASTER.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKCS0_RXN_FDB_CS_LNK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKCSE0_RXN_FDB_CS_EXCEPT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKEAF0_EXT_ALG_FDB_VOCAB_LNK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKFAE0_FDB_ALG_EXT_VOCAB_LNK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKHFI0_SIG_FREQ_INT_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKHIE0_SIG_FREQ_INT_EVENT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKNVD0_NAVIGATION_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSC0_NLM_SCT_CONCEPT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSCD0_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSD0_NLM_SCT_CONCEPT_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSET0_VSAC_CQM_PUB_SET.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSID0_SCT_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSLG0_NLM_SCT_LANGUAGE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSR0_SCT_DXID_SRCH.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSRH0_SCT_DXID_SRCH_HX.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSRS0_NLM_SCT_RELATIONSHIP.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSSE0_SIG_FDB_TO_EXT_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSVF0_SCT_FDB_VOCAB_LNK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSX0_SCT_DXID_SRCH_EXCL.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKSXH0_SCT_DXID_SRCH_EXCL_HX.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKTD0_SCT_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKUCM0_MSTRUOM_TO_UCUM_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKUK0_USHIK_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKUKH0_USHIK_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKVHO0_VOCAB_TYP_HL7_OID_LNK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKVS0_SCT_VALUE_SET.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RIMKVSD0_SCT_VALUE_SET_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RLBLRID3_LBLR_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RLBLWD0_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RLBLWGC0_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RLBLWV0_VENDOR_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RLBLWVD0_VENDOR_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDCD0_MED_CONCEPT_TYP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDDIN0_RDFMID_INACTV_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDDIS0_ROUTED_DF_STUDY_TABLE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDIN0_MEDID_INACTV_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDIS0_MEDID_STUDY_TABLE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDMGL0_MED_GENERIC_MED_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDMHL0_MED_HICLSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDMRD0_MOVE_REASON_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDNGH0_NDC_GEN_MEDID_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDNGM0_NDC_GEN_MEDID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDNGR0_NDC_GEN_MEDID_REASON.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDNIN0_MNID_INACTV_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDNIS0_MED_NAME_STUDY_TABLE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDNMH0_NDC_MEDID_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDNMR0_NDC_MEDID_REASON.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDRIN0_RMID_INACTV_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDRIS0_ROUTED_MED_STDY_TBL.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDSPC0_SPECIFICATION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDSPD0_SPECIFICATION_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDST0_MEDID_SEARCH_TERM.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMEDSTD0_SEARCH_TERM_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIDE2D1_REF_DESI2_IND_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIDEAD1_REF_FED_DEA_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIDESD1_REF_DESI_IND_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIDFD1_DOSE_FORM.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIDFID1_ROUTED_DOSE_FORM_MED.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIDFRH1_ROUTED_DOSE_FORM_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIGC1_MEDID_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIGCND1_GCNSEQNO_ASSGN_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIGECD1_REF_GEN_THERAP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIGNCD1_REF_GEN_NAME_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIGPCD1_REF_GEN_PRC_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIGSCD1_REF_GEN_PRC_SPRD_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIID1_MED.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIINND1_REF_INNOV_IND_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMILGND1_REF_FED_LGND_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIMLTD1_REF_MULTI_SRC_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMINAMD1_NAME_SRC_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMINDC1_NDC_MEDID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMINMD1_MED_NAME_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMINMID1_MED_NAME.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMINMRH1_MED_NAME_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIRH1_MED_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIRMID1_ROUTED_MED.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIRMRH1_ROUTED_MED_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMIRTD1_ROUTE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMISCD1_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMMADMA1_ADULT_DOSE_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMMARMA0_ADULT_RANGE_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMMGDMA1_GERI_DOSE_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMMGRMA1_GERI_RANGE_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMMSRC0_DOSING_AGE_SOURCE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLAID0_ANALYTE_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLEVL0_EXT_VOCAB_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLITD0_FDB_ID_TYP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLLAB0_LAB_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLLRH0_LAB_ID_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLLSD0_LAB_ID_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLMID0_METHODOLOGY_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLPID0_PANEL_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLPLB0_PANEL_LABID_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLPRH0_PANEL_ID_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLPSD0_PANEL_ID_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLSCD0_SPEC_LAB_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLSID0_SPECIMEN_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLSLT0_SPECIFIC_LAB_ID.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLSND0_LAB_ID_SYN_NMTYP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLSRH0_SPECIFIC_LAB_ID_HIST.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLSSD0_LABID_SYN_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLSYN0_LAB_ID_SYN.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RMTLVTD0_EXT_VOCAB_TYP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RNDC14_NDC_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RNDCAT0_NDC_ATTRIBUTE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RNDCDR0_NDC_DELETION_REASON.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RNDCINH0_NDC_INACTV_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RNDCINR0_INACTV_REVIEWED.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RNDCTD0_NDC_ATTRIBUTE_TYP_DSC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RNDCVD0_NDC_ATTRIBUTE_VALU_DSC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RNP2_NDC_PRICE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RNP3_NDC_PRICE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RNPTYPD0_NDC_PRICE_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.ROBCD0_OBC_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.ROBCNDC0_OBC_NDC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPDMMA1_PEDI_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPDMUND0_PEDI_DOSE_UNIT_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPDMWT1_PEDI_WEIGHT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIAD0_ATTRIBUTE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIAL0_DF_ATTRIBUTE_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIAT0_ATTRIBUTE_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIAV0_ATTRIBUTE_VALUE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIDFA0_DOSAGE_FORM_ATTRIBUTE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIDM0_DOSAGE_FORM_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIDT0_DOSAGE_FORM_TYPE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIGA0_GCNSEQNO_ATTRIBUTE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIGD0_GCNSEQNO_DF_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIGL0_GEN_DF_MSTR_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIGR0_GCNSEQNO_RT_RELATION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIGRR0_GCNSEQNO_REP_RT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIGS0_GCNSEQNO_STR_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIHR0_HICLSEQNO_RT_RELATION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIMA0_MED_ATTRIBUTE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIMD0_MED_DF_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIML0_MED_DF_MSTR_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIMNR0_MED_NAME_RT_RELATION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIMRR0_MED_RT_RELATION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIMS0_MED_STR_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEINA0_MED_NAME_ATTRIBUTE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIND0_NDC_DF_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEINR0_NDC_RT_RELATION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEINS0_NDC_STR_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIOL0_OVW_DF_MSTR_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIPP0_PATIENT_PARAM_REQ_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIRA0_RT_DF_MED_ATTRIBUTE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIRD0_RTD_DF_MED_DF_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIRER0_RELATED_RT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIRH0_RT_HIERARCHY.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIRL0_RT_LABELED_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIRM0_RT_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIRMA0_RTD_MED_ATTRIBUTE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIRMD0_RTD_MED_DF_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIRMR0_RTD_MED_RT_RELATION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIRR0_RTD_DF_MED_RT_RELATION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIST0_STR_CONC_TYPE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIUC0_UOM_CONVERSION.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIUM0_UOM_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEIUT0_UOM_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEMGC0_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEMMA5_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEMMOE2_MONO.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEMOGC0_MONO_GCNSEQNO_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEMORG0_ROUTED_GEN_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPEMRG0_ROUTED_GEN_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRD0_PRODUCT.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDCC0_CURRENCY_CD_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDPA0_PRICE_ATTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDPAD0_PRICE_ATTR_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDPAT0_PRICE_ATTR_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDPAV0_PRICE_ATTR_VALUE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDPC0_EXT_PRODUCT_CD.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDPCD0_EXT_PRODUCT_CD_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDPKD0_PACKAGE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDPP0_PRODUCT_PRICE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDPTD0_PRICE_TYPE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDSD0_PRODUCT_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RPRDUOM0_PRICE_QTY_UOM.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RROUTED3_ROUTE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RRTGN0_ROUTED_GEN_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RRTGNGC0_RTD_GEN_GCNSEQNO_LNK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RRTGNND0_ROUTED_GEN_NDC_LINK.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RRTGNSD0_RTD_GEN_STATUS_DSC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RSTR1_STRNGTH_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RSTRSCD0_STRENGTH_STATUS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RSTRTD0_STRENGTH_TYP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RSTRUOM0_STRENGTH_UOM.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTCD0_STD_THERAP_CLASS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMDFCG0_TM_RTD_DF_CNFSN_GRP.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMDFID1_TM_ROUTED_DF_MED.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMDT0_TM_NAME_TYPE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMGRPD1_TM_GROUP_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMMICG0_TM_MED_CNFSN_GRP.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMMID1_TM_MED.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMNCG0_TM_NDC_CNFSN_GRP.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMNGN0_TM_GNN.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMNGT0_TM_GNN_TYPE.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMNID0_TM_NDC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMNMCG0_TM_MED_NAME_CNFSN_GRP.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMNMID1_TM_MED_NAME.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMRMCG0_TM_RTD_MED_CNFSN_GRP.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMRMID1_TM_ROUTED_MED.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RTMSRCD1_TM_SOURCE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RUNITSD0_UNITS_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RXRFAHX0_AGCSP_HICSEQN.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RXRFDDX0_DACN_AGCSP.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RXRGDFQ0_GCDF_SCRIPT_QQ.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RXRMDFQ0_MEDDOSFM_SCRIPT_QQ.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RXRNCQQ0_QQ_MSTR.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RXRNSRC0_SOURCE_DESC.sql;
!load ../Schemas/fdbdata/Tables/FDBDATA.RXRPDFQ0_POEMDOSFM_SCRIPT_QQ.sql;

----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------

!load ../Schemas/logdata/Functions/logdata.fxn_get_pk_columns.sql;

----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------

--logdata
!load ../Schemas/logdata/Procedures/logdata.spu_set_job_id_endtime.sql;
!load ../Schemas/logdata/Procedures/logdata.spu_set_job_id.sql;
!load ../Schemas/logdata/Procedures/spu_validate_data_primary_key_check.sql;

--util
!load ../Schemas/util/Procedures/util.get_latest_folder.sql;
!load ../Schemas/util/Procedures/util.run_pipeline.sql;

!exit
