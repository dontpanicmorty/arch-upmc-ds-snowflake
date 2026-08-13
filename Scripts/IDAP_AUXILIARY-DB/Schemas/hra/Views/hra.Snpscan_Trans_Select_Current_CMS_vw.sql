!set variable_substitution=true;
create or replace view 
HRA.SNPSCAN_TRANS_SELECT_CURRENT_CMS_VW(
	DATASOURCENAME,
	MEMBERID,
	JULIANDATETIME,
	SCANASSESSMENTID,
	ISVALIDMEMBER,
	SCANTIME,
	LOB,
	INSERTDATE,
	COMPLETIONDATE,
	ANSWERHEADERID,
	ASSESSMENTID
    ,
	Q01
    ,
	PRIMARYLANGUAGE
    ,
	Q02,
  	HEALTHCOMPAREDTOOTHERSYOURAGE
    ,
	Q03,
	HEALTHMOUTHTEETH,
	Q04,
	FLUSHOTPASTYEAR,
	Q05,
	AVERAGEPRESCRIPTIONSPERDAY,
	Q06A,
    DONTTAKEANYMEDS,
    Q06B,
	DOTAKEMEDSASPRESCRIBED,
	Q06C,
	DONTTAKEMEDSASPRESCRIBED,
	Q06D,
	TROUBLEPAYINGFORMEDS,
	Q06E,
	TROUBLEGETTINGMEDS,
	Q06F,
	TROUBLEREMEMBERINGMEDS,
	Q06G,
	UNDERSTANDINGWHYHOWPRESCRIBED,
	Q06H,
	DONTKNOWIFTAKINGASPRESCRIBED,
	Q07,
	HOSPITALADMISSIONSPASTYEAR,
	Q08,
	EMERGENCYVISITSPASTYEAR,
	Q09A,
	INFORMEDHIGHBLOODPRESSURE,
	Q09B,
	INFORMEDHIGHCHOLESTEROL ,
	Q09C,
	INFORMEDHEARTDISEASEORCHF ,
	Q09D,
	INFORMEDASTHMA ,
	Q09E,
	INFORMEDCOPDOREMPHYSEMA ,
	Q09F,
	INFORMEDSTROKE,
	Q09G,
	INFORMEDDIABETES ,
	Q09H,
	INFORMEDKIDNEYFAILURE,
	Q09I,
	INFORMEDDIALYSIS ,
	Q09J,
	INFORMEDSICKLECELL ,
	Q09K,
	INFORMEDCANCER ,
	Q09L,
	INFORMEDBACKPAIN ,
	Q09M,
	INFORMEDADHD,
	Q09N,
	INFORMEDINTELLECTUALDISABILITY,
	Q09O,
	INFORMEDDEPRESSION ,
	Q09P,
	INFORMEDANXIETY ,
	Q09Q,
	INFORMEDSUBSTANCEUSE,
	Q09R,
	INFORMEDOTHER,
	Q09S,
	INFORMEDNONE,
	Q10,
	PASTTWOWEEKSLITTLEINTEREST,
	Q11,
	PASTTWOWEEKSDEPRESSEDHOPELESS,
	Q12,
	FEELLONELY,
	Q13A,
	CONCERNEDWEIGHTTOOHIGH,
	Q13B,
	CONCERNEDWEIGHTTOOLOW ,
	Q13C,
	DONTEATHEALTHY ,
	Q13D,
	LOWPHYSICALACTIVITY ,
	Q13E,
	SMOKEORUSETOBACCO ,
	Q13F,
	TROUBLEHANDLINGSTRESS ,
	Q13G,
	DRINKTOOMUCHALCOHOL ,
	Q13H,
	NONPRESCRIBEDDRUGUSE ,
	Q13I,
	NONEAPPLY,
	Q14A,
	TROUBLEHEARING,
	Q14B,
	TROUBLESEEING ,
	Q14C,
	TROUBLESPEAKING ,
	Q14D,
	TROUBLEREADING ,
	Q14E,
	COMMUNICATIONNONE,
	Q15A,
	FORGETRECENTLYLEARNED,
	Q15B,
	MULTIPLEORNOTES,
	Q15C,
	TROUBLEINSTRUCTIONS,
	Q15D,
	CONFUSEDDISTRACTEDCONVERSATIONS,
	Q15E,
	FORGETWORDSDATESEVENTS,
	Q15F,
	MISPLACETHINGS,
	Q15G,
	OTHERSSAYFORGETFUL,
	Q15H,
	FORGETNONE,
	Q16,
	LIVINGSITUATION,
	Q17,
	LIVEWITH,
	Q18,
	PRIMARYCAREGIVER,
	Q19,
	NEEDASSISTEVERYDAYLIVING,
	Q20,
	NEEDASSISTPERSONALHYGIENE,
	Q21A,
	SUPPORTFROMSPOUSE,
	Q21B,
	SUPPORTFROMOTHERFAMILYMEMBERS ,
	Q21C,
	SUPPORTFROMFRIENDSNONFAMILY ,
	Q21D,
	SUPPORTFROMAGENCYCAREGIVERS ,
	Q21E,
	SUPPORTFROMFACILITYSTAFF ,
	Q21F,
	DONTNEEDHELPSUPPORT,
	Q22,
	RELIABLEHELPSUPPORT,
	Q23A,
	USECANE,
	Q23B,
	USEWALKER ,
	Q23C,
	USEWHEELCHAIR ,
	Q23D,
	USEMOTORIZEDSCOOTER ,
	Q23E,
	USEPROSTHETIC ,
	Q23F,
	USEHOSPITALBED ,
	Q23G,
	USEHOYERLIFT ,
	Q23H,
	USEGLUCOMETER ,
	Q23I,
	USENEBULIZER ,
	Q23J,
	USEOXYGEN ,
	Q23K,
	USECPAPBIPAP ,
	Q23L,
	USEVENTILATOR,
	Q23M,
	USEOTHERDEVICES,
	Q23N,
	USENODEVICES,
	Q24,
	FALLEN2ORMOREPAST3MONTHS,
	Q25A,
	UTILIZEMATP,
	Q25B,
	UTILIZESNAP,
	Q25C,
	UTILIZELIHEAP,
	Q25D,
	UTILIZELTSS,
	Q25E,
	UTILIZENORESOURCES,
	Q26,
    FOODRUNOUT12MONTH,
    Q27,
    FOODBOUGHT12MONTH,
    Q28,
    RELIABLETRANSPORT12MONTH,
    Q29,
	SELFSPOUSEMILITARY,
	Q30,
	ADVANCEDIRECTIVE,
	Q31,
	PERSONALREPRESENTATIVE,
	REPROCESSFLAG
    
) COMMENT='VIEW TO VALIDATE MEMBER ELIGIBILITY i.e.,SCANDATE B/W ELIGIBILITY_START and END DATES(MC400.DWOAO.ELIGIBILITYHISTORY)'
 as
with SNPSCAN_TRANS_SELECT_TEMP as  (
    select  *, row_number() over (partition by memberid, scandate order by memberid, scandate) as rn
    --from  IDAP_LAKE_DEV.ASSESSMENT.SNP_SCAN_VW where  scanassessmentid = 153
   from &{IDAP_LAKE}.ASSESSMENT.SNP_SCAN_CURRENT_CMS_VW
    ),
    SNPSCAN_TRANS_SELECT_TEMP2 as
    (select *
    from SNPSCAN_TRANS_SELECT_TEMP where rn = 1
    )
    select 
'Scantron' as dataSourceName,
org.memberid,
julianDate as julianDateTime,
scanassessmentid,
case when valid_mem.memberid is not null then true else false end as isvalidmember, 
TO_VARCHAR(TO_TIMESTAMP(SCANDATE,'mmddyy')::Timestamp_TZ,'YYYY-MM-DDTHH24:MI:SS.FF1') as scanTime,
case when scanassessmentid = '160' then 'SNP'
when scanassessmentid = '161' then 'CHC'
when scanassessmentid = '162' then 'MC' 
else 'UNK' end as lob,
--'SNP' as lob, 
TO_VARCHAR(load_time,'yyyy-mm-ddTHH24:MI:SS.FF') insertDate, 
'n/a' as CompletionDate, 'n/a' as AnswerHeaderId, scanassessmentid as assessmentid
, 
case when q01=' ' then null else q01 end as q01, 
case 
when q01 = '1' then 'ENGLISH'
when q01 = '2' then 'SPANISH'
when q01 = '3' then 'RUSSIAN'
when q01 = '4' then 'NEPALI'
when q01 = '5' then 'MANDARIN'
when q01 = '6' then 'ARABIC'
when q01 = '7' then 'VIETNAMESE'
when q01 = '8' then 'OTHER'
when q01 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as primaryLanguage
,
case when q02=' ' then null else q02 end as q02,
case 
when q02 = '1' then 'EXCELLENT'
when q02 = '2' then 'GOOD'
when q02 = '3' then 'FAIR'
when q02 = '4' then 'POOR'
when q02 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as healthComparedToOthersYourAge

, 

case when q03=' ' then null else q03 end as q03,
case 
when q03 = '1' then 'EXCELLENT'
when q03 = '2' then 'GOOD'
when q03 = '3' then 'FAIR'
when q03 = '4' then 'POOR'
when q03 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as healthMouthTeeth, 

case when q04=' ' then null else q04 end as q04,
case 
when q04 = '1' then 'YES'
when q04 = '2' then 'NO'
when q04 = '3' then 'DON\'T KNOW OR REMEMBER'
when q04 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as fluShotPastYear, 

case when q05=' ' then null else q05 end as q05,
case 
when q05 = '1' then '0'
when q05 = '2' then '1-4'
when q05 = '3' then '5-8'
when q05 = '4' then '9 OR MORE'
when q05 = '5' then 'DON\'T KNOW'
when q05 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as averagePrescriptionsPerDay,

case when q06A =' ' then null else q06A end as q06A,
case when q06A = '1' then 'YES' else null end as dontTakeAnyMeds,

case when q06B =' ' then null else q06B end as q06B,
case when q06B = '1' then 'YES' ELSE NULL end as doTakeMedsAsPrescribed,

case when q06C =' ' then null else q06C end as q06C,
case when q06C = '1' THEN 'YES' ELSE NULL END AS 	dontTakeMedsAsPrescribed, 
 
case when q06D =' ' then null else q06D end as q06D,
case when q06D = '1' THEN 'YES' ELSE NULL END AS 	troublePayingForMeds,

case when q06E =' ' then null else q06E end as q06E,
case when q06E = '1' THEN 'YES' ELSE NULL END AS 	troubleGettingMeds,

case when q06F =' ' then null else q06F end as q06F,
case when q06F = '1' THEN 'YES' ELSE NULL END AS 	troubleRememberingMeds,
 
case when q06G =' ' then null else q06G end as q06G,
case when q06G = '1' THEN 'YES' ELSE NULL END AS 	understandingWhyHowPrescribed,

case when q06H =' ' then null else q06H end as q06H,
case when q06H = '1' THEN 'YES' ELSE NULL END AS 	dontKnowIfTakingAsPrescribed, 

case when q07=' ' then null else q07 end as q07,
case 
when q07 = '1' then 'NONE'
when q07 = '2' then 'ONE TIME'
when q07 = '3' then '2-3 TIMES'
when q07 = '4' then 'MORE THAN 3 TIMES'
when q07 = '5' then 'DON\'T KNOW'
when q07 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as hospitalAdmissionsPastYear, 

case when q08=' ' then null else q08 end as q08,
case 
when q08 = '1' then 'NONE'
when q08 = '2' then 'ONE TIME'
when q08 = '3' then '2-3 TIMES'
when q08 = '4' then 'MORE THAN 3 TIMES'
when q08 = '5' then 'DON\'T KNOW'
when q08 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as emergencyVisitsPastYear, 

case when q09A =' ' then null else q09A end as q09A,
case when q09A = '1' THEN 'YES' ELSE NULL END AS informedHighBloodPressure, 

case when q09B =' ' then null else q09B end as q09B,
case when q09B = '1' THEN 'YES' ELSE NULL END AS  informedHighCholesterol, 

case when q09C =' ' then null else q09C end as q09C,
case when q09C = '1' THEN 'YES' ELSE NULL END AS informedHeartDiseaseOrChf , 

case when q09D=' ' then null else q09D end as q09D,
case when q09D = '1' THEN 'YES' ELSE NULL END AS informedAsthma ,

case when q09E=' ' then null else q09E end as q09E, 
case when q09E = '1' THEN 'YES' ELSE NULL END AS informedCopdOrEmphysema ,

case when q09F=' ' then null else q09F end as q09F,
case when q09F = '1' THEN 'YES' ELSE NULL END AS informedStroke,  

case when q09G=' ' then null else q09G end as q09G,
case when q09G = '1' THEN 'YES' ELSE NULL END AS informedDiabetes, 
 
case when q09H=' ' then null else q09H end as q09H,
case when q09H = '1' THEN 'YES' ELSE NULL END AS informedKidneyFailure, 

case when q09I=' ' then null else q09I end as q09I,
case when q09I = '1' THEN 'YES' ELSE NULL END AS informedDialysis , 

case when q09J=' ' then null else q09J end as q09J,
case when q09J = '1' THEN 'YES' ELSE NULL END AS  informedSickleCell,
 
case when q09K=' ' then null else q09K end as q09K,
case when q09K = '1' THEN 'YES' ELSE NULL END AS informedCancer ,

case when q09L=' ' then null else q09L end as q09L,
case when q09L = '1' THEN 'YES' ELSE NULL END AS informedBackPain ,  

case when q09M=' ' then null else q09M end as q09M,
case when q09M = '1' THEN 'YES' ELSE NULL END AS informedAdhd ,
 
case when q09N=' ' then null else q09N end as q09N,
case when q09N = '1' THEN 'YES' ELSE NULL END AS informedIntellectualDisability ,
 
case when q09O=' ' then null else q09O end as q09O,
case when q09O = '1' THEN 'YES' ELSE NULL END AS  informedDepression ,


case when q09P=' ' then null else q09P end as q09P,
case when q09P = '1' THEN 'YES' ELSE NULL END AS nformedAnxiety,

case when q09Q=' ' then null else q09Q end as q09Q,
case when q09Q = '1' THEN 'YES' ELSE NULL END AS informedSubstanceUse,


case when q09R=' ' then null else q09R end as q09R,
case when q09R = '1' THEN 'YES' ELSE NULL END AS informedOther,

case when q09S=' ' then null else q09S end as q09S,
case when q09S = '1' THEN 'YES' ELSE NULL END AS informedNone, 

case when q10=' ' then null else q10 end as q10,
case 
when q10 = '1' then 'YES'
when q10 = '2' then 'NO'
when q10 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as pastTwoWeeksLittleInterest,

case when q11=' ' then null else q11 end as q11,
case 
when q11 = '1' then 'YES'
when q11 = '2' then 'NO'
when q11 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as pastTwoWeeksDepressedHopeless,

case when q12=' ' then null else q12 end as q12,
case 
when q12 = '1' then 'HARDLY EVER OR NEVER'
when q12 = '2' then 'SOMETIMES'
when q12 = '3' then 'OFTEN'
when q12 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as feelLonely,

case when q13A=' ' then null else q13A end as q13A,
case when q13A='1' THEN 'YES' ELSE NULL end as concernedWeightTooHigh,
case when q13B=' ' then null else q13B end as q13B,
case when q13B='1' THEN 'YES' ELSE NULL end as concernedWeightTooLow ,
case when q13C=' ' then null else q13C end as q13C,
case when q13C='1' THEN 'YES' ELSE NULL  end as dontEatHealthy ,
case when q13D=' ' then null else q13D end as q13D,
case when q13D='1' THEN 'YES' ELSE NULL end as lowPhysicalActivity ,
case when q13E=' ' then null else q13E end as q13E,
case when q13E='1' THEN 'YES' ELSE NULL end as smokeOrUseTobacco ,

case when q13F=' ' then null else q13F end as q13F,
case when q13F = '1' THEN 'YES' ELSE NULL END AS troubleHandlingStress , 

case when q13G=' ' then null else q13G end as q13G,
case when q13G = '1' THEN 'YES' ELSE NULL END AS drinkTooMuchAlcohol , 
case when q13H=' ' then null else q13H end as q13H, 
case when q13H = '1' THEN 'YES' ELSE NULL END AS nonPrescribedDrugUse , 

case when q13I=' ' then null else q13I end as q13I,
case when q13I = '1' THEN 'YES' ELSE NULL END AS noneApply, 

case when q14A=' ' then null else q14A end as q14A,
case when q14A = '1' THEN 'YES' ELSE NULL END AS troubleHearing, 

case when q14B=' ' then null else q14B end as q14B,
case when q14B = '1' THEN 'YES' ELSE NULL END AS troubleSeeing, 

case when q14C=' ' then null else q14C end as q14C,
case when q14C = '1' THEN 'YES' ELSE NULL END AS troubleSpeaking, 

case when q14D=' ' then null else q14D end as q14D,
case when q14D = '1' THEN 'YES' ELSE NULL END AS troubleReading, 

case when q14E=' ' then null else q14E end as q14E,
case when q14E = '1' THEN 'YES' ELSE NULL END AS communicationNone, 

case when q15A=' ' then null else q15A end as q15A,
case when q15A = '1' THEN 'YES' ELSE NULL END AS forgetRecentlyLearned, 

case when q15B=' ' then null else q15B end as q15B,
case when q15B = '1' THEN 'YES' ELSE NULL END AS multipleOrNotes, 
 
case when q15C=' ' then null else q15C end as q15C,
case when q15C = '1' THEN 'YES' ELSE NULL END AS troubleInstructions, 

case when q15D=' ' then null else q15D end as q15D,
case when q15D = '1' THEN 'YES' ELSE NULL END AS confusedDistractedConversations, 

case when q15E=' ' then null else q15E end as q15E,
case when q15E = '1' THEN 'YES' ELSE NULL END AS forgetWordsDatesEvents, 

case when q15F=' ' then null else q15F end as q15F,
case when q15F = '1' THEN 'YES' ELSE NULL END AS misplaceThings, 

case when q15G=' ' then null else q15G end as q15G,
case when q15G = '1' THEN 'YES' ELSE NULL END AS othersSayForgetful, 

case when q15H=' ' then null else q15H end as q15H,
case when q15H = '1' THEN 'YES' ELSE NULL END AS forgetNone, 

case when q16=' ' then null else q16 end as q16,
case 
when q16 = '1' then 'STABLE PLACE'
when q16 = '2' then 'PLACE BUT WORRIED ABOUT LOSS'
when q16 = '3' then 'NO STABLE PLACE'
when q16 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as livingSituation, 
 
case when q17=' ' then null else q17 end as q17,
case 
when q17 = '1' then 'ALONE'
when q17 = '3' then 'OTHER FAMILY MEMBERS'
when q17 = '5' then 'NURSING HOME'
when q17 = '7' then 'GROUP HOME'
when q17 = '2' then 'SPOUSE'
when q17 = '4' then 'FRIENDS'
when q17 = '6' then 'ASSISTED LIVING'
when q17 = '8' then 'OTHER'
when q17 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as liveWith, 

case when q18=' ' then null else q18 end as q18,
case 
when q18 = '1' then 'YES, NO CONCERNS'
when q18 = '2' then 'YES, IMPACTING MY HEALTH'
when q18 = '3' then 'NO'
when q18 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as primaryCaregiver, 

case when q19=' ' then null else q19 end as q19,
case 
when q19 = '1' then 'YES, DAILY'
when q19 = '2' then 'YES, 1 OR 2 TIMES A WEEK'
when q19 = '3' then 'YES, 1 OR 2 TIMES A MONTH'
when q19 = '4' then 'NO'
when q19 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as needAssistEverydayLiving, 

case when q20=' ' then null else q20 end as q20,
case 
when q20 = '1' then 'YES, DAILY'
when q20 = '2' then 'YES, 1 OR 2 TIMES A WEEK'
when q20 = '3' then 'YES, 1 OR 2 TIMES A MONTH'
when q20 = '4' then 'NO'
when q20 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as needAssistPersonalHygiene,

case when q21A=' ' then null else q21A end as q21A,
case when q21A = '1' THEN 'YES' ELSE NULL END AS supportFromSpouse, 

case when q21B=' ' then null else q21B end as q21B,
case when q21B = '1' THEN 'YES' ELSE NULL END AS supportFromOtherFamilyMembers, 
 
case when q21C=' ' then null else q21C end as q21C,
case when q21C = '1' THEN 'YES' ELSE NULL END AS supportFromFriendsNonFamily, 
 
case when q21D=' ' then null else q21D end as q21D,
case when q21D = '1' THEN 'YES' ELSE NULL END AS supportFromAgencyCaregivers, 

case when q21E=' ' then null else q21E end as q21E,
case when q21E = '1' THEN 'YES' ELSE NULL END AS supportFromFacilityStaff, 

case when q21F=' ' then null else q21F end as q21F,
case when q21F = '1' THEN 'YES' ELSE NULL END AS dontNeedHelpSupport, 

case when q22=' ' then null else q22 end as q22,
case 
when q22 = '1' then 'YES, ENOUGH AND RELIABLE'
when q22 = '2' then 'YES, BUT NOT ALWAYS AVAILABLE'
when q22 = '3' then 'NO, NEED MORE HELP'
when q22 = '4' then 'N/A DON\'T RECEIVE'
when q22 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as reliableHelpSupport, 

case when q23A=' ' then null else q23A end as q23A,
case when q23A = '1' THEN 'YES' ELSE NULL END AS useCane, 


case when q23B=' ' then null else q23B end as q23B,
case when q23B = '1' THEN 'YES' ELSE NULL END AS useWalker, 

case when q23C=' ' then null else q23C end as q23C,
case when q23C = '1' THEN 'YES' ELSE NULL END AS useWheelchair, 

case when q23D=' ' then null else q23D end as q23D,
case when q23D = '1' THEN 'YES' ELSE NULL END AS useMotorizedScooter, 

case when q23E=' ' then null else q23E end as q23E,
case when q23E = '1' THEN 'YES' ELSE NULL END AS useProsthetic, 

case when q23F=' ' then null else q23F end as q23F,
case when q23F = '1' THEN 'YES' ELSE NULL END AS useHospitalBed,

case when q23G=' ' then null else q23G end as q23G,
case when q23G = '1' THEN 'YES' ELSE NULL END AS useHoyerLift, 
 
case when q23H=' ' then null else q23H end as q23H,
case when q23H = '1' THEN 'YES' ELSE NULL END AS useGlucometer, 

case when q23I=' ' then null else q23I end as q23I,
case when q23I = '1' THEN 'YES' ELSE NULL END AS useNebulizer, 

case when q23J=' ' then null else q23J end as q23J,
case when q23J = '1' THEN 'YES' ELSE NULL END AS useOxygen, 

case when q23K=' ' then null else q23K end as q23K,
case when q23K = '1' THEN 'YES' ELSE NULL END AS useCpapBipap, 
 
case when q23L=' ' then null else q23L end as q23L,
case when q23L = '1' THEN 'YES' ELSE NULL END AS useVentilator, 

case when q23M=' ' then null else q23M end as q23M,
case when q23M = '1' THEN 'YES' ELSE NULL END AS useOtherDevices, 

case when q23N=' ' then null else q23N end as q23N,
case when q23N = '1' THEN 'YES' ELSE NULL END AS useNoDevices, 

case when q24=' ' then null else q24 end as q24,
case 
when q24 = '1' then 'YES'
when q24 = '2' then 'NO'
when q24 = '3' then 'DON\'T KNOW'
when q24 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as fallen2OrMorePast3Months, 

case when q25A=' ' then null else q25A end as q25A,
case when q25A = '1' THEN 'YES' ELSE NULL END AS utilizeMatp, 

case when q25B=' ' then null else q25B end as q25B,
case when q25B = '1' THEN 'YES' ELSE NULL END AS utilizeSnap, 

case when q25C=' ' then null else q25C end as q25C,
case when q25C = '1' THEN 'YES' ELSE NULL END AS utilizeLiheap, 

case when q25D=' ' then null else q25D end as q25D,
case when q25D = '1' THEN 'YES' ELSE NULL END AS utilizeLtss, 

case when q25E=' ' then null else q25E end as q25E,
case when q25E = '1' THEN 'YES' ELSE NULL END AS utilizeNoResources, 


case when q26=' ' then null else q26 end as q26,

case 
when q26 = '1' then 'OFTEN TRUE'
when q26 = '2' then 'SOMETIMES TRUE'
when q26 = '3' then 'NEVER TRUE'
when q26 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as foodRunOut12Month,

case when q27=' ' then null else q27 end as q27,

case 
when q27 = '1' then 'OFTEN TRUE'
when q27 = '2' then 'SOMETIMES TRUE'
when q27 = '3' then 'NEVER TRUE'
when q27 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as foodBought12Month,


case when q28=' ' then null else q28 end as q28,

case 
when q28 = '1' then 'YES'
when q28 = '2' then 'NO'
when q28 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as reliableTransport12Month,

case when q29=' ' then null else q29 end as q29,

case 
when q29 = '1' then 'YES'
when q29 = '2' then 'NO'
when q29 = '3' then 'DON\'T KNOW'
when q29 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as selfSpouseMilitary,


case when q30=' ' then null else q30 end as q30, 
case 
when q30 = '1' then 'YES'
when q30 = '2' then 'NO, NOT INTERESTED'
when q30 = '3' then 'NO, SEND INFO'
when q30 = '4' then 'DON\'T KNOW'
when q30 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as advanceDirective, 

case when q31=' ' then null else q31 end as q31, 
case 
when q31 = '1' then 'YES'
when q31 = '2' then 'NO, NOT INTERESTED'
when q31 = '3' then 'NO, SEND INFO'
when q31 = '4' then 'DON\'T KNOW'
when q31 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as personalRepresentative,
0 as reprocessFlag

from SNPSCAN_TRANS_SELECT_TEMP2 ORG left join ( select distinct memberid from  &{IDAP_LAKE}.ASSESSMENT.SNP_SCAN_CURRENT_CMS_VW org
join &{MC400}.DWOAO.ELIGIBILITYHISTORY EH
ON ORG.MEMBERID = EH.MEMBERNBR
WHERE to_date(ORG.SCANDATE,'mmddyy') BETWEEN to_date(TO_CHAR(EH.ELIGIBILITYSTARTDATE),'yyyymmdd') AND to_date(TO_CHAR(CASE WHEN (EH.ELIGIBILITYENDDATE=0) THEN 99991231 ELSE EH.ELIGIBILITYENDDATE END ),'yyyymmdd')) valid_mem 
on 
    ORG.memberid = valid_mem.memberid;