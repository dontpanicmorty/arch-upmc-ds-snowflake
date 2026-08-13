CREATE OR REPLACE VIEW NETWORK.SIMPLIFY_GENERAL_COST_SHARE_VW
COMMENT = 'Parses out General_Cost_Share column from JSON leaving nested arrays still as arrays so its one row per documentID/SimplifyPlanPackageKey'
AS 




(  

SELECT  C.Document_ID
    ,C.SIMPLIFY_PLAN_PACKAGE_KEY
    ,COINS_CoinsuranceAmount AS COINS_COINSURANCE_AMOUNT
    ,COINS_NetworkName AS COINS_NETWORK_NAME
    ,COINS_NetworkTier AS COINS_NETWORK_TIER
    ,DED_CoverageName AS DED_COVERAGE_NAME
    ,DED_DeductibleAmount AS DED_DEDUCTIBLE_AMOUNT
    ,DED_EmbeddedorNonEmbedded AS DED_EMBEDDED_OR_NONEMBEDDED
    ,DED_NetworkName AS DED_NETWORK_NAME
    ,DED_NetworkTier AS DED_NETWORK_TIER
    ,OOPM_CoverageName AS OOPM_COVERAGE_NAME
    ,COALESCE(H.OOPM_EmbeddedorNonEmbedded,HH.OOPM_EmbeddedorNonEmbedded) AS OOPM_EMBEDDED_OR_NONEMBEDDED
    ,OOPM_NetworkName AS OOPM_NETWORK_NAME
    ,OOPM_NetworkTier AS OOPM_NETWORK_TIER
    ,OOPM_OOPMAmount AS OOPM_OOPM_AMOUNT
    

FROM
     (SELECT DISTINCT V.Document_ID
     ,V.SIMPLIFY_PLAN_PACKAGE_KEY
     ,value:CoinsuranceAmount::String AS COINS_CoinsuranceAmount
     ,value:NetworkName::string AS COINS_NetworkName
     ,value:NetworkTier::string AS COINS_NetworkTier
      FROM IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_VW V ,lateral flatten( input => GENERALCOSTSHARE:Coinsurance:CoinsuranceList) ) C

INNER JOIN

(SELECT DISTINCT V.Document_ID
,V.SIMPLIFY_PLAN_PACKAGE_KEY
,value:CoverageName::String AS DED_CoverageName
,value:DeductibleAmount::string as DED_DeductibleAmount
,value:NetworkName::string as DED_NetworkName
,value:NetworkTier::string as DED_NetworkTier
FROM IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_VW V ,lateral flatten( input => GENERALCOSTSHARE:Deductible:DeductibleList)) D ON 
    C.SIMPLIFY_PLAN_PACKAGE_KEY = D.SIMPLIFY_PLAN_PACKAGE_KEY
    AND C.Document_ID=D.Document_ID

INNER JOIN

(SELECT DISTINCT Document_ID
,V.SIMPLIFY_PLAN_PACKAGE_KEY
,value:CoverageName::String AS OOPM_CoverageName
,value:NetworkName::string as OOPM_NetworkName
,value:NetworkTier::string as OOPM_NetworkTier
,value:OOPMAmount::string as OOPM_OOPMAmount
FROM IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_VW V ,lateral flatten( input => GENERALCOSTSHARE:OutofPocketMaximum:OutofPocketMaximumList)) O ON 
    C.SIMPLIFY_PLAN_PACKAGE_KEY = O.SIMPLIFY_PLAN_PACKAGE_KEY
    AND C.DOCUMENT_ID=O.DOCUMENT_ID

INNER JOIN


(SELECT DISTINCT Document_ID
,V.SIMPLIFY_PLAN_PACKAGE_KEY
,value:IsthedeductibleEmbeddedorNonEmbedded::string as DED_EmbeddedorNonEmbedded
FROM IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_VW V
,lateral flatten( input => GENERALCOSTSHARE) --ORDER BY 1,2
WHERE DED_EmbeddedorNonEmbedded IS NOT NULL 
--AND SIMPLIFY_PLAN_PACKAGE_KEY=796 AND DOCUMENT_ID=351386
) I
ON C.SIMPLIFY_PLAN_PACKAGE_KEY = I.SIMPLIFY_PLAN_PACKAGE_KEY
AND C.DOCUMENT_ID=I.DOCUMENT_ID

  LEFT JOIN
  

  (SELECT DISTINCT Document_ID
,V.SIMPLIFY_PLAN_PACKAGE_KEY
,value:IstheOutofPocketEmbeddedorNonEmbedded::string as OOPM_EmbeddedorNonEmbedded
FROM IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_VW V
,lateral flatten( input => GENERALCOSTSHARE:OutofPocketMaximum) 
 WHERE OOPM_EmbeddedorNonEmbedded IS NOT NULL 
 ) H
ON C.SIMPLIFY_PLAN_PACKAGE_KEY = H.SIMPLIFY_PLAN_PACKAGE_KEY
AND C.DOCUMENT_ID=H.DOCUMENT_ID

LEFT JOIN

  (SELECT DISTINCT Document_ID
,V.SIMPLIFY_PLAN_PACKAGE_KEY
,value:IstheOutofPocketEmbeddedorNonEmbedded::string as OOPM_EmbeddedorNonEmbedded
FROM IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_VW V
,lateral flatten( input => GENERALCOSTSHARE) 
 WHERE OOPM_EmbeddedorNonEmbedded IS NOT NULL 
 ) HH
ON C.SIMPLIFY_PLAN_PACKAGE_KEY = HH.SIMPLIFY_PLAN_PACKAGE_KEY
AND C.DOCUMENT_ID=HH.DOCUMENT_ID

  INNER JOIN

  
  IDAP_LAKE.NETWORK.SIMPLIFY_PLAN_PACKAGE_CURRENT_ROW_VW CR
  ON C.SIMPLIFY_PLAN_PACKAGE_KEY = CR.SIMPLIFY_PLAN_PACKAGE_KEY

)
;