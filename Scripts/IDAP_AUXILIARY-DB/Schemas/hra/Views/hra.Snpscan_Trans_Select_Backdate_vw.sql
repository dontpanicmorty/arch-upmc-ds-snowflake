!set variable_substitution=true;
create or replace view HRA.SNPSCAN_TRANS_SELECT_BACKDATE_VW
COMMENT='VIEW TO VALIDATE MEMBER ELIGIBILITY i.e.,SCANDATE B/W ELIGIBILITY_START and END DATES(MC400.DWOAO.ELIGIBILITYHISTORY)'
 as
with SNPSCAN_TRANS_SELECT_TEMP as  (
    select  *, row_number() over (partition by memberid, scandate order by memberid, scandate) as rn
    from  &{IDAP_LAKE}.ASSESSMENT.SNP_SCAN_BACKDATE_VW where  scanassessmentid = 153
    ),
    SNPSCAN_TRANS_SELECT_TEMP2 as
    (select *
    from SNPSCAN_TRANS_SELECT_TEMP where rn = 1
    )
    select 
'snpScan' as dataSourceName,
org.memberid,
julianDate as julianDateTime,
scanassessmentid,
case when valid_mem.memberid is not null then true else false end as isvalidmember, 
TO_VARCHAR(TO_TIMESTAMP(SCANDATE,'mmddyy')::Timestamp_TZ,'YYYY-MM-DDTHH24:MI:SS.FF1') as scanTime,
'SNP' as lob, 
TO_VARCHAR(load_time,'yyyy-mm-ddTHH24:MI:SS.FF') insertDate, 
'n/a' as CompletionDate, 'n/a' as AnswerHeaderId, scanassessmentid as assessmentid, 
case when q01=' ' then null else q01 end as q01, 
case 
when q01 = '1' then 'ENGLISH'
when q01 = '2' then 'SPANISH'
when q01 = '3' then 'RUSSIAN'
when q01 = '4' then 'NEPALI'
when q01 = '5' then 'MANDARIN'
when q01 = '6' then 'CANTONESE'
when q01 = '7' then 'VIETNAMESE'
when q01 = '8' then 'OTHER'
when q01 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as primaryLanguage,
case when q02=' ' then null else q02 end as q02,
case 
when q02 = '1' then 'EXCELLENT'
when q02 = '2' then 'GOOD'
when q02 = '3' then 'FAIR'
when q02 = '4' then 'POOR'
when q02 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as healthComparedToOthersYourAge, 
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

case when q06a=' ' then null else q06a end as q06a,
case when q06a = '1' then 'YES' ELSE NULL end as doTakeMedsAsPrescribed,

case when q06b=' ' then null else q06b end as q06b,
case when q06b = '1' THEN 'YES' ELSE NULL END AS 	dontTakeMedsAsPrescribed, 
 
case when q06c=' ' then null else q06c end as q06c,
case when q06c = '1' THEN 'YES' ELSE NULL END AS 	troublePayingForMeds,

case when q06d=' ' then null else q06d end as q06d,
case when q06d = '1' THEN 'YES' ELSE NULL END AS 	troubleGettingMeds,

case when q06e=' ' then null else q06e end as q06e,
case when q06e = '1' THEN 'YES' ELSE NULL END AS 	troubleRememberingMeds,
 
case when q06f=' ' then null else q06f end as q06f,
case when q06f = '1' THEN 'YES' ELSE NULL END AS 	understandingWhyHowPrescribed,

case when q06g=' ' then null else q06g end as q06g,
case when q06g = '1' THEN 'YES' ELSE NULL END AS 	dontKnowIfTakingAsPrescribed, 


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

case when q09A=' ' then null else q09A end as q09A,
case when q09A = '1' THEN 'YES' ELSE NULL END AS informedHighBloodPressure, 

case when q09B=' ' then null else q09B end as q09B,
case when q09B = '1' THEN 'YES' ELSE NULL END AS informedAsthma, 

case when q09C=' ' then null else q09C end as q09C,
case when q09C = '1' THEN 'YES' ELSE NULL END AS informedDiabetes, 

case when q09D=' ' then null else q09D end as q09D,
case when q09D = '1' THEN 'YES' ELSE NULL END AS informedSickleCell,

case when q09E=' ' then null else q09E end as q09E,
case when q09E = '1' THEN 'YES' ELSE NULL END AS informedMemoryProblems,

case when q09F=' ' then null else q09F end as q09F,
case when q09F = '1' THEN 'YES' ELSE NULL END AS informedDepression,  

case when q09G=' ' then null else q09G end as q09G,
case when q09G = '1' THEN 'YES' ELSE NULL END AS informedHighCholesterol, 
 
case when q09H=' ' then null else q09H end as q09H,
case when q09H = '1' THEN 'YES' ELSE NULL END AS informedCopdOrEmphysema, 

case when q09I=' ' then null else q09I end as q09I,
case when q09I = '1' THEN 'YES' ELSE NULL END AS informedKidneyFailure, 

case when q09J=' ' then null else q09J end as q09J,
case when q09J = '1' THEN 'YES' ELSE NULL END AS informedCancer,
 
case when q09K=' ' then null else q09K end as q09K,
case when q09K = '1' THEN 'YES' ELSE NULL END AS informedAdhd,

case when q09L=' ' then null else q09L end as q09L,
case when q09L = '1' THEN 'YES' ELSE NULL END AS informedAnxiety,  

case when q09M=' ' then null else q09M end as q09M,
case when q09M = '1' THEN 'YES' ELSE NULL END AS informedHeartDiseaseOrChf,
 
case when q09N=' ' then null else q09N end as q09N,
case when q09N = '1' THEN 'YES' ELSE NULL END AS informedStroke,
 
case when q09O=' ' then null else q09O end as q09O,
case when q09O = '1' THEN 'YES' ELSE NULL END AS informedDialysis,


case when q09P=' ' then null else q09P end as q09P,
case when q09P = '1' THEN 'YES' ELSE NULL END AS informedBackPain,

case when q09Q=' ' then null else q09Q end as q09Q,
case when q09Q = '1' THEN 'YES' ELSE NULL END AS informedIntellectualDisability,


case when q09R=' ' then null else q09R end as q09R,
case when q09R = '1' THEN 'YES' ELSE NULL END AS informedSubstanceUse,

case when q09S=' ' then null else q09S end as q09S,
case when q09S = '1' THEN 'YES' ELSE NULL END AS informedOther, 

case when q09T=' ' then null else q09T end as q09T,
case when q09T = '1' THEN 'YES' ELSE NULL END AS informedNone,

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
case when q13b=' ' then null else q13b end as q13b,
case when q13b='1' THEN 'YES' ELSE NULL end as dontEatHealthy,
case when q13c=' ' then null else q13c end as q13c,
case when q13c='1' THEN 'YES' ELSE NULL  end as smokeOrUseTobacco,
case when q13d=' ' then null else q13d end as q13d,
case when q13d='1' THEN 'YES' ELSE NULL end as drinkTooMuchAlcohol,
case when q13e=' ' then null else q13e end as q13e,
case when q13e='1' THEN 'YES' ELSE NULL end as nonPrescribedDrugUse,

case when q13F=' ' then null else q13F end as q13F,
case when q13F = '1' THEN 'YES' ELSE NULL END AS concernedWeightTooLow, 

case when q13G=' ' then null else q13G end as q13G,
case when q13G = '1' THEN 'YES' ELSE NULL END AS lowPhysicalActivity, 
case when q13H=' ' then null else q13H end as q13H, 
case when q13H = '1' THEN 'YES' ELSE NULL END AS troubleHandlingStress, 

case when q13I=' ' then null else q13I end as q13I,
case when q13I = '1' THEN 'YES' ELSE NULL END AS noneApply, 

case when q14A=' ' then null else q14A end as q14A,
case when q14A = '1' THEN 'YES' ELSE NULL END AS troubleHearing, 

case when q14B=' ' then null else q14B end as q14B,
case when q14B = '1' THEN 'YES' ELSE NULL END AS troubleReading, 

case when q14C=' ' then null else q14C end as q14C,
case when q14C = '1' THEN 'YES' ELSE NULL END AS troubleSeeing, 

case when q14D=' ' then null else q14D end as q14D,
case when q14D = '1' THEN 'YES' ELSE NULL END AS troubleSpeaking, 

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
when q17 = '2' then 'OTHER FAMILY MEMBERS'
when q17 = '3' then 'NURSING HOME'
when q17 = '4' then 'GROUP HOME'
when q17 = '5' then 'SPOUSE'
when q17 = '6' then 'FRIENDS'
when q17 = '7' then 'ASSISTED LIVING'
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
case when q21B = '1' THEN 'YES' ELSE NULL END AS supportFromAgencyCaregivers, 
 
case when q21C=' ' then null else q21C end as q21C,
case when q21C = '1' THEN 'YES' ELSE NULL END AS supportFromOtherFamilyMembers, 
 
case when q21D=' ' then null else q21D end as q21D,
case when q21D = '1' THEN 'YES' ELSE NULL END AS supportFromFacilityStaff, 

case when q21E=' ' then null else q21E end as q21E,
case when q21E = '1' THEN 'YES' ELSE NULL END AS supportFromFriendsNonFamily, 

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
case when q23B = '1' THEN 'YES' ELSE NULL END AS useProsthetic, 

case when q23C=' ' then null else q23C end as q23C,
case when q23C = '1' THEN 'YES' ELSE NULL END AS useNebulizer, 

case when q23D=' ' then null else q23D end as q23D,
case when q23D = '1' THEN 'YES' ELSE NULL END AS useWalker, 

case when q23E=' ' then null else q23E end as q23E,
case when q23E = '1' THEN 'YES' ELSE NULL END AS useHospitalBed, 

case when q23F=' ' then null else q23F end as q23F,
case when q23F = '1' THEN 'YES' ELSE NULL END AS useOxygen,

case when q23G=' ' then null else q23G end as q23G,
case when q23G = '1' THEN 'YES' ELSE NULL END AS useWheelchair, 
 
case when q23H=' ' then null else q23H end as q23H,
case when q23H = '1' THEN 'YES' ELSE NULL END AS useHoyerLift, 

case when q23I=' ' then null else q23I end as q23I,
case when q23I = '1' THEN 'YES' ELSE NULL END AS useCpapBipap, 

case when q23J=' ' then null else q23J end as q23J,
case when q23J = '1' THEN 'YES' ELSE NULL END AS useMotorizedScooter, 

case when q23K=' ' then null else q23K end as q23K,
case when q23K = '1' THEN 'YES' ELSE NULL END AS useGlucometer, 
 
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

case when q26A=' ' then null else q26A end as q26A,
case when q26A = '1' THEN 'YES' ELSE NULL END AS helpTransportation, 
case when q26B=' ' then null else q26B end as q26B,
case when q26B = '1' THEN 'YES' ELSE NULL END AS helpFood, 
case when q26C=' ' then null else q26C end as q26C, 
case when q26C = '1' THEN 'YES' ELSE NULL END AS helpUtilities, 
case when q26D=' ' then null else q26D end as q26D,
case when q26D = '1' THEN 'YES' ELSE NULL END AS helpClothing, 
case when q26E=' ' then null else q26E end as q26E, 
case when q26E = '1' THEN 'YES' ELSE NULL END AS helpHouseholdSupplies, 
case when q26F=' ' then null else q26F end as q26F, 
case when q26F = '1' THEN 'YES' ELSE NULL END AS noHelpNeeded, 
case when q27=' ' then null else q27 end as q27,
case 
when q27 = '1' then 'YES'
when q27 = '2' then 'NO'
when q27 = '3' then 'DON\'T KNOW'
when q27 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as selfSpouseMilitary, 
case when q28=' ' then null else q28 end as q28, 
case 
when q28 = '1' then 'YES'
when q28 = '2' then 'NO, NOT INTERESTED'
when q28 = '3' then 'NO, SEND INFO'
when q28 = '4' then 'DON\'T KNOW'
when q28 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as advanceDirective, 
case when q29=' ' then null else q29 end as q29, 
case 
when q29 = '1' then 'YES'
when q29 = '2' then 'NO, NOT INTERESTED'
when q29 = '3' then 'NO, SEND INFO'
when q29 = '4' then 'DON\'T KNOW'
when q29 = '*' then 'MORE THAN ONE RESPONSE'
else Null end as personalRepresentative,
0 as reprocessFlag

from SNPSCAN_TRANS_SELECT_TEMP2 ORG left join ( select distinct memberid from &{IDAP_LAKE}.ASSESSMENT.SNP_SCAN_BACKDATE_VW org join &{MC400}.DWOAO.ELIGIBILITYHISTORY EH
ON ORG.MEMBERID = EH.MEMBERNBR
WHERE to_date(ORG.SCANDATE,'mmddyy') BETWEEN to_date(TO_CHAR(EH.ELIGIBILITYSTARTDATE),'yyyymmdd') AND to_date(TO_CHAR(CASE WHEN (EH.ELIGIBILITYENDDATE=0) THEN 99991231 ELSE EH.ELIGIBILITYENDDATE END ),'yyyymmdd')) valid_mem 
on 
    ORG.memberid = valid_mem.memberid;
!set variable_substitution=false;
