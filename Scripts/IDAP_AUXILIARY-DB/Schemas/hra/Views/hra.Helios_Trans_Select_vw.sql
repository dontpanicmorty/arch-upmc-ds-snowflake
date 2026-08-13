create or replace view HRA.HELIOS_TRANS_SELECT_VW(
	DATASOURCENAME,
	MEMBERID,
	ORIGINALASSESSMENTID,
	HELIOSASSESSMENTID,
	SCANTIME,
	LOB,
	INSERTDATE,
	Q01,
	PRIMARYLANGUAGE,
	Q02,
	PRIMARYLANGUAGEOTHER,
	Q03,
	HEALTHCOMPAREDTOOTHERSYOURAGE,
	Q04,
	HEALTHMOUTHTEETH,
	Q05,
	FLUSHOTPASTYEAR,
	Q06,
	AVERAGEPRESCRIPTIONSPERDAY,
	Q07A,
	DONTTAKEANYMEDS,
	Q07B,
	DOTAKEMEDSASPRESCRIBED,
	Q07C,
	DONTTAKEMEDSASPRESCRIBED,
	Q07D,
	TROUBLEPAYINGFORMEDS,
	Q07E,
	TROUBLEGETTINGMEDS,
	Q07F,
	TROUBLEREMEMBERINGMEDS,
	Q07G,
	UNDERSTANDINGWHYHOWPRESCRIBED,
	Q07H,
	DONTKNOWIFTAKINGASPRESCRIBED,
	Q08,
	HOSPITALADMISSIONSPASTYEAR,
	Q09,
	EMERGENCYVISITSPASTYEAR,
	Q10A,
	INFORMEDHIGHBLOODPRESSURE,
	Q10B,
	INFORMEDASTHMA,
	Q10C,
	INFORMEDDIABETES,
	Q10D,
	INFORMEDSICKLECELL,
	Q10E,
	INFORMEDDEPRESSION,
	Q10F,
	INFORMEDHIGHCHOLESTEROL,
	Q10G,
	INFORMEDCOPDOREMPHYSEMA,
	Q10H,
	INFORMEDKIDNEYFAILURE,
	Q10I,
	INFORMEDCANCER,
	Q10J,
	INFORMEDADHD,
	Q10K,
	INFORMEDANXIETY,
	Q10L,
	INFORMEDHEARTDISEASEORCHF,
	Q10M,
	INFORMEDSTROKE,
	Q10N,
	INFORMEDDIALYSIS,
	Q10O,
	INFORMEDBACKPAIN,
	Q10P,
	INFORMEDINTELLECTUALDISABILITY,
	Q10Q,
	INFORMEDSUBSTANCEUSE,
	Q10R,
	INFORMEDOTHER,
	Q10S,
	INFORMEDNONE,
	Q11,
	PASTTWOWEEKSLITTLEINTEREST,
	Q12,
	PASTTWOWEEKSDEPRESSEDHOPELESS,
	Q13,
	FEELLONELY,
	Q14A,
	CONCERNEDWEIGHTTOOHIGH,
	Q14B,
	DONTEATHEALTHY,
	Q14C,
	SMOKEORUSETOBACCO,
	Q14D,
	DRINKTOOMUCHALCOHOL,
	Q14E,
	NONPRESCRIBEDDRUGUSE,
	Q14F,
	CONCERNEDWEIGHTTOOLOW,
	Q14G,
	LOWPHYSICALACTIVITY,
	Q14H,
	TROUBLEHANDLINGSTRESS,
	Q14I,
	NONEAPPLY,
	Q15A,
	TROUBLEHEARING,
	Q15B,
	TROUBLEREADING,
	Q15C,
	TROUBLESEEING,
	Q15D,
	TROUBLESPEAKING,
	Q15E,
	COMMUNICATIONNONE,
	Q16A,
	FORGETRECENTLYLEARNED,
	Q16B,
	MULTIPLEORNOTES,
	Q16C,
	TROUBLEINSTRUCTIONS,
	Q16D,
	CONFUSEDDISTRACTEDCONVERSATIONS,
	Q16E,
	FORGETWORDSDATESEVENTS,
	Q16F,
	MISPLACETHINGS,
	Q16G,
	OTHERSSAYFORGETFUL,
	Q16H,
	FORGETNONE,
	Q17,
	LIVINGSITUATION,
	Q18,
	LIVEWITH,
	Q19,
	PRIMARYCAREGIVER,
	Q20,
	NEEDASSISTEVERYDAYLIVING,
	Q21,
	NEEDASSISTPERSONALHYGIENE,
	Q22A,
	SUPPORTFROMSPOUSE,
	Q22B,
	SUPPORTFROMAGENCYCAREGIVERS,
	Q22C,
	SUPPORTFROMOTHERFAMILYMEMBERS,
	Q22D,
	SUPPORTFROMFACILITYSTAFF,
	Q22E,
	SUPPORTFROMFRIENDSNONFAMILY,
	Q22F,
	DONTNEEDHELPSUPPORT,
	Q23,
	RELIABLEHELPSUPPORT,
	Q24A,
	USECANE,
	Q24B,
	USEPROSTHETIC,
	Q24C,
	USENEBULIZER,
	Q24D,
	USEWALKER,
	Q24E,
	USEHOSPITALBED,
	Q24F,
	USEOXYGEN,
	Q24G,
	USEWHEELCHAIR,
	Q24H,
	USEHOYERLIFT,
	Q24I,
	USECPAPBIPAP,
	Q24J,
	USEMOTORIZEDSCOOTER,
	Q24K,
	USEGLUCOMETER,
	Q24L,
	USEVENTILATOR,
	Q24M,
	USEOTHERDEVICES,
	Q24N,
	USENODEVICES,
	Q25,
	FALLEN2ORMOREPAST3MONTHS,
	Q26A,
	UTILIZEMATP,
	Q26B,
	UTILIZESNAP,
	Q26C,
	UTILIZELIHEAP,
	Q26D,
	UTILIZELTSS,
	Q26E,
	UTILIZENORESOURCES,
	Q27,
	WORRIEDFOODWOULDRUNOUT,
	Q28,
	FOODBOUGHTDIDNTLAST,
	Q29,
	LACKOFRELIABLETRANSPORTATION,
	Q30,
	SELFSPOUSEMILITARY,
	Q31,
	ADVANCEDIRECTIVE,
	Q32,
	PERSONALREPRESENTATIVE
) COMMENT='View that transforms the data as per transformation doc'
 as (
select 
'chcHelios' as dataSourceName,
member_nbr as memberId,
TO_NUMBER(assessment_id) as originalAssessmentId,
TO_NUMBER(assessment_type_id) as heliosAssessmentId,
TO_VARCHAR(TO_TIMESTAMP(assessment_completed_date,'YYYY-MM-DD HH24:MI:SS.FF7')::Timestamp_TZ,'YYYY-MM-DDTHH24:MI:SS.FF1') as scanTime,
'CHC' as lob, 
current_timestamp() as insertDate,
q01, 
case 
when q01 = '1' then 'ENGLISH'
when q01 = '2' then 'SPANISH'
when q01 = '3' then 'RUSSIAN'
when q01 = '4' then 'NEPALI'
when q01 = '5' then 'MANDARIN'
when q01 = '6' then 'ARABIC'
when q01 = '7' then 'VIETNAMESE'
when q01 = '8' then 'OTHER'
else NULL end as primaryLanguage, 
q02,
q02 as primaryLanguageOther,
q03,
case 
when q03 = '1' then 'EXCELLENT'
when q03 = '2' then 'GOOD'
when q03 = '3' then 'FAIR'
when q03 = '4' then 'POOR'
else NULL end as healthComparedToOthersYourAge, 
q04,
case 
when q04 = '1' then 'EXCELLENT'
when q04 = '2' then 'GOOD'
when q04 = '3' then 'FAIR'
when q04 = '4' then 'POOR'
else NULL end as healthMouthTeeth, 
q05, 
case 
when q05 = '1' then 'YES'
when q05 = '2' then 'NO'
when q05 = '3' then 'DON\'T KNOW OR REMEMBER'
else NULL end as fluShotPastYear, 
q06, 
case 
when q06 = '1' then '0'
when q06 = '2' then '1-4'
when q06 = '3' then '5-8'
when q06 = '4' then '9 OR MORE'
when q06 = '5' then 'DON\'T KNOW'
else NULL end as averagePrescriptionsPerDay, 
q07a, 
case when q07a = '1' then 'YES' ELSE NULL end as dontTakeAnyMeds,
q07b,
case when q07b = '1' then 'YES' ELSE NULL end as doTakeMedsAsPrescribed,
q07c, 
case when q07c = '1' THEN 'YES' ELSE NULL END AS dontTakeMedsAsPrescribed, 
q07d, 
case when q07d = '1' THEN 'YES' ELSE NULL END AS troublePayingForMeds,
q07e,
case when q07e = '1' THEN 'YES' ELSE NULL END AS troubleGettingMeds,
q07f,
case when q07f = '1' THEN 'YES' ELSE NULL END AS troubleRememberingMeds,
q07g, 
case when q07g = '1' THEN 'YES' ELSE NULL END AS understandingWhyHowPrescribed,
q07h,   
case when q07h = '1' THEN 'YES' ELSE NULL END AS dontKnowIfTakingAsPrescribed, 
q08, 
case 
when q08 = '1' then 'NONE'
when q08 = '2' then 'ONE TIME'
when q08 = '3' then '2-3 TIMES'
when q08 = '4' then 'MORE THAN 3 TIMES'
when q08 = '5' then 'DON\'T KNOW'
else NULL end as hospitalAdmissionsPastYear, 
q09, 
case 
when q09 = '1' then 'NONE'
when q09 = '2' then 'ONE TIME'
when q09 = '3' then '2-3 TIMES'
when q09 = '4' then 'MORE THAN 3 TIMES'
when q09 = '5' then 'DON\'T KNOW'
else Null end as emergencyVisitsPastYear, 
q10A,
case when q10A = '1' THEN 'YES' ELSE NULL END AS informedHighBloodPressure, 
q10B,
case when q10B = '1' THEN 'YES' ELSE NULL END AS informedAsthma, 
q10C,
case when q10C = '1' THEN 'YES' ELSE NULL END AS informedDiabetes, 
q10D, 
case when q10D = '1' THEN 'YES' ELSE NULL END AS informedSickleCell,
q10E,
case when q10E = '1' THEN 'YES' ELSE NULL END AS informedDepression,  
q10F, 
case when q10F = '1' THEN 'YES' ELSE NULL END AS informedHighCholesterol, 
q10G, 
case when q10G = '1' THEN 'YES' ELSE NULL END AS informedCopdOrEmphysema, 
q10H,
case when q10H = '1' THEN 'YES' ELSE NULL END AS informedKidneyFailure, 
q10I, 
case when q10I = '1' THEN 'YES' ELSE NULL END AS informedCancer,
q10J, 
case when q10J = '1' THEN 'YES' ELSE NULL END AS informedAdhd,
q10K, 
case when q10K = '1' THEN 'YES' ELSE NULL END AS informedAnxiety,  
q10L,
case when q10L = '1' THEN 'YES' ELSE NULL END AS informedHeartDiseaseOrChf,
q10M, 
case when q10M = '1' THEN 'YES' ELSE NULL END AS informedStroke,
q10N, 
case when q10N = '1' THEN 'YES' ELSE NULL END AS informedDialysis,
q10O, 
case when q10O = '1' THEN 'YES' ELSE NULL END AS informedBackPain,
q10P,
case when q10P = '1' THEN 'YES' ELSE NULL END AS informedIntellectualDisability,
q10Q, 
case when q10Q = '1' THEN 'YES' ELSE NULL END AS informedSubstanceUse,
q10R, 
case when q10R = '1' THEN 'YES' ELSE NULL END AS informedOther, 
q10S,
case when q10S = '1' THEN 'YES' ELSE NULL END AS informedNone,
q11,
case 
when q11 = '1' then 'YES'
when q11 = '2' then 'NO'
else Null end as pastTwoWeeksLittleInterest,
q12,
case 
when q12 = '1' then 'YES'
when q12 = '2' then 'NO'
else Null end as pastTwoWeeksDepressedHopeless,
q13,
case 
when q13 = '1' then 'HARDLY EVER OR NEVER'
when q13 = '2' then 'SOMETIMES'
when q13 = '3' then 'OFTEN'
else Null end as feelLonely,
q14A,
case when q14A='1' THEN 'YES' ELSE NULL end as concernedWeightTooHigh,
q14B,
case when q14B='1' THEN 'YES' ELSE NULL end as dontEatHealthy,
q14C,
case when q14C='1' THEN 'YES' ELSE NULL  end as smokeOrUseTobacco,
q14D,
case when q14D='1' THEN 'YES' ELSE NULL end as drinkTooMuchAlcohol,
q14E,
case when q14E='1' THEN 'YES' ELSE NULL end as nonPrescribedDrugUse,
q14F, 
case when q14F = '1' THEN 'YES' ELSE NULL END AS concernedWeightTooLow, 
q14G, 
case when q14G = '1' THEN 'YES' ELSE NULL END AS lowPhysicalActivity, 
q14H, 
case when q14H = '1' THEN 'YES' ELSE NULL END AS troubleHandlingStress, 
q14I, 
case when q14I = '1' THEN 'YES' ELSE NULL END AS noneApply, 
q15A, 
case when q15A = '1' THEN 'YES' ELSE NULL END AS troubleHearing, 
q15B, 
case when q15B = '1' THEN 'YES' ELSE NULL END AS troubleReading, 
q15C, 
case when q15C = '1' THEN 'YES' ELSE NULL END AS troubleSeeing, 
q15D, 
case when q15D = '1' THEN 'YES' ELSE NULL END AS troubleSpeaking, 
q15E, 
case when q15E = '1' THEN 'YES' ELSE NULL END AS communicationNone, 
q16A, 
case when q16A = '1' THEN 'YES' ELSE NULL END AS forgetRecentlyLearned, 
q16B, 
case when q16B = '1' THEN 'YES' ELSE NULL END AS multipleOrNotes, 
q16C, 
case when q16C = '1' THEN 'YES' ELSE NULL END AS troubleInstructions, 
q16D, 
case when q16D = '1' THEN 'YES' ELSE NULL END AS confusedDistractedConversations, 
q16E, 
case when q16E = '1' THEN 'YES' ELSE NULL END AS forgetWordsDatesEvents, 
q16F, 
case when q16F = '1' THEN 'YES' ELSE NULL END AS misplaceThings, 
q16G, 
case when q16G = '1' THEN 'YES' ELSE NULL END AS othersSayForgetful, 
q16H, 
case when q16H = '1' THEN 'YES' ELSE NULL END AS forgetNone, 
q17, case 
when q17 = '1' then 'STABLE PLACE'
when q17 = '2' then 'PLACE BUT WORRIED ABOUT LOSS'
when q17 = '3' then 'NO STABLE PLACE'
else NULL end as livingSituation, 
q18, case 
when q18 = '1' then 'ALONE'
when q18 = '2' then 'OTHER FAMILY MEMBERS'
when q18 = '3' then 'NURSING HOME'
when q18 = '4' then 'GROUP HOME'
when q18 = '5' then 'SPOUSE'
when q18 = '6' then 'FRIENDS'
when q18 = '7' then 'ASSISTED LIVING'
when q18 = '8' then 'OTHER'
else NULL end as liveWith, 
q19, case 
when q19 = '1' then 'YES, NO CONCERNS'
when q19 = '2' then 'YES, IMPACTING MY HEALTH'
when q19 = '3' then 'NO'
else NULL end as primaryCaregiver, 
q20, case 
when q20 = '1' then 'YES, DAILY'
when q20 = '2' then 'YES, 1 OR 2 TIMES A WEEK'
when q20 = '3' then 'YES, 1 OR 2 TIMES A MONTH'
when q20 = '4' then 'NO'
else NULL end as needAssistEverydayLiving, 
q21, case 
when q21 = '1' then 'YES, DAILY'
when q21 = '2' then 'YES, 1 OR 2 TIMES A WEEK'
when q21 = '3' then 'YES, 1 OR 2 TIMES A MONTH'
when q21 = '4' then 'NO'
else NULL end as needAssistPersonalHygiene,
q22A, 
case when q22A = '1' THEN 'YES' ELSE NULL END AS supportFromSpouse, 
q22B, 
case when q22B = '1' THEN 'YES' ELSE NULL END AS supportFromAgencyCaregivers, 
q22C, 
case when q22C = '1' THEN 'YES' ELSE NULL END AS supportFromOtherFamilyMembers, 
q22D, 
case when q22D = '1' THEN 'YES' ELSE NULL END AS supportFromFacilityStaff, 
q22E, 
case when q22E = '1' THEN 'YES' ELSE NULL END AS supportFromFriendsNonFamily, 
q22F, 
case when q22F = '1' THEN 'YES' ELSE NULL END AS dontNeedHelpSupport, 
q23, case 
when q23 = '1' then 'YES, ENOUGH AND RELIABLE'
when q23 = '2' then 'YES, BUT NOT ALWAYS AVAILABLE'
when q23 = '3' then 'NO, NEED MORE HELP'
when q23 = '4' then 'N/A DON\'T RECEIVE'
else NULL end as reliableHelpSupport, 
q24A, 
case when q24A = '1' THEN 'YES' ELSE NULL END AS useCane, 
q24B, 
case when q24B = '1' THEN 'YES' ELSE NULL END AS useProsthetic, 
q24C, 
case when q24C = '1' THEN 'YES' ELSE NULL END AS useNebulizer, 
q24D, 
case when q24D = '1' THEN 'YES' ELSE NULL END AS useWalker, 
q24E, 
case when q24E = '1' THEN 'YES' ELSE NULL END AS useHospitalBed, 
q24F, 
case when q24F = '1' THEN 'YES' ELSE NULL END AS useOxygen, 
q24G, 
case when q24G = '1' THEN 'YES' ELSE NULL END AS useWheelchair, 
q24H, 
case when q24H = '1' THEN 'YES' ELSE NULL END AS useHoyerLift, 
q24I, 
case when q24I = '1' THEN 'YES' ELSE NULL END AS useCpapBipap, 
q24J, 
case when q24J = '1' THEN 'YES' ELSE NULL END AS useMotorizedScooter, 
q24K, 
case when q24K = '1' THEN 'YES' ELSE NULL END AS useGlucometer, 
q24L, 
case when q24L = '1' THEN 'YES' ELSE NULL END AS useVentilator, 
q24M, 
case when q24M = '1' THEN 'YES' ELSE NULL END AS useOtherDevices, 
q24N, 
case when q24N = '1' THEN 'YES' ELSE NULL END AS useNoDevices, 
q25, case 
when q25 = '1' then 'YES'
when q25 = '2' then 'NO'
when q25 = '3' then 'DON\'T KNOW'
else NULL end as fallen2OrMorePast3Months, 
q26A, 
case when q26A = '1' THEN 'YES' ELSE NULL END AS utilizeMatp, 
q26B, 
case when q26B = '1' THEN 'YES' ELSE NULL END AS utilizeSnap, 
q26C, 
case when q26C = '1' THEN 'YES' ELSE NULL END AS utilizeLiheap, 
q26D, 
case when q26D = '1' THEN 'YES' ELSE NULL END AS utilizeLtss, 
q26E, 
case when q26E = '1' THEN 'YES' ELSE NULL END AS utilizeNoResources, 
q27, 
case 
when q27 = '1' then 'OFTEN TRUE'
when q27 = '2' then 'SOMETIMES TRUE'
when q27 = '3' then 'NEVER TRUE'
else NULL end as worriedFoodWouldRunOut,
q28, 
case 
when q28 = '1' then 'OFTEN TRUE'
when q28 = '2' then 'SOMETIMES TRUE'
when q28 = '3' then 'NEVER TRUE'
else NULL end as foodBoughtDidntLast,
q29, 
case 
when q29 = '1' then 'YES'
when q29 = '2' then 'NO'
else NULL end as lackOfReliableTransportation,
q30, 
case 
when q30 = '1' then 'YES'
when q30 = '2' then 'NO'
when q30 = '3' then 'DON\'T KNOW'
else NULL end as selfSpouseMilitary, 
q31, 
case 
when q31 = '1' then 'YES'
when q31 = '2' then 'NO, NOT INTERESTED'
when q31 = '3' then 'NO, SEND INFO'
when q31 = '4' then 'DON\'T KNOW'
else NULL end as advanceDirective, 
q32, case 
when q32 = '1' then 'YES'
when q32 = '2' then 'NO, NOT INTERESTED'
when q32 = '3' then 'NO, SEND INFO'
when q32 = '4' then 'DON\'T KNOW'
else NULL end as personalRepresentative from HRA.HELIOS_JOIN_SELECT_VW)
;