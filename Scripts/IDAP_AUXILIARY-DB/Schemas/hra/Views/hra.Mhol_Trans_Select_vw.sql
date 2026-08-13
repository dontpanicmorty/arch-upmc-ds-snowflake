create or replace view HRA.MHOL_TRANS_SELECT_VW
(
	ANSWERHEADER_ID,
	DATASOURCENAME,
	MEMBERID,
	COMPLETIONDATE,
	LOB,
	INSERTDATE,
	ASSESSMENTID,
	Q01,
	PRIMARYLANGUAGE,
	Q02,
	HEALTHCOMPAREDTOOTHERSYOURAGE,
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
	INFORMEDASTHMA,
	Q09C,
	INFORMEDDIABETES,
	Q09D,
	INFORMEDSICKLECELL,
	Q09E,
	INFORMEDDEPRESSION,
	Q09F,
	INFORMEDHIGHCHOLESTEROL,
	Q09G,
	INFORMEDCOPDOREMPHYSEMA,
	Q09H,
	INFORMEDKIDNEYFAILURE,
	Q09I,
	INFORMEDCANCER,
	Q09J,
	INFORMEDADHD,
	Q09K,
	INFORMEDANXIETY,
	Q09L,
	INFORMEDHEARTDISEASEORCHF,
	Q09M,
	INFORMEDSTROKE,
	Q09N,
	INFORMEDDIALYSIS,
	Q09O,
	INFORMEDBACKPAIN,
	Q09P,
	INFORMEDINTELLECTUALDISABILITY,
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
	DONTEATHEALTHY,
	Q13C,
	SMOKEORUSETOBACCO,
	Q13D,
	DRINKTOOMUCHALCOHOL,
	Q13E,
	NONPRESCRIBEDDRUGUSE,
	Q13F,
	CONCERNEDWEIGHTTOOLOW,
	Q13G,
	LOWPHYSICALACTIVITY,
	Q13H,
	TROUBLEHANDLINGSTRESS,
	Q13I,
	NONEAPPLY,
	Q14A,
	TROUBLEHEARING,
	Q14B,
	TROUBLEREADING,
	Q14C,
	TROUBLESEEING,
	Q14D,
	TROUBLESPEAKING,
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
	SUPPORTFROMSPOUSESIGNIFICANT,
	Q21B,
	SUPPORTFROMAGENCYCAREGIVERS,
	Q21C,
	SUPPORTFROMOTHERFAMILYMEMBERS,
	Q21D,
	SUPPORTFROMFACILITYSTAFF,
	Q21E,
	SUPPORTFROMFRIENDSNONFAMILY,
	Q21F,
	DONTNEEDHELPSUPPORT,
	Q22,
	RELIABLEHELPSUPPORT,
	Q23A,
	USECANE,
	Q23B,
	USEPROSTHETIC,
	Q23C,
	USENEBULIZER,
	Q23D,
	USEWALKER,
	Q23E,
	USEHOSPITALBED,
	Q23F,
	USEOXYGEN,
	Q23G,
	USEWHEELCHAIR,
	Q23H,
	USEHOYERLIFT,
	Q23I,
	USECPAPBIPAP,
	Q23J,
	USEMOTORIZEDSCOOTER,
	Q23K,
	USEGLUCOMETER,
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
	Q31,
	ADVANCEDIRECTIVE,
	Q32,
	PERSONALREPRESENTATIVE,
	Q33,
	OTHERLANGUAGE
) COMMENT='This View Transforms the Flatten View as per the Transformation Document'
 as (
SELECT 
ANSWERHEADER_ID,
'snpMhol' as dataSourceName,
MEMBERBEINGASSESSED as memberid,
TO_VARCHAR(TO_TIMESTAMP(COMPLETIONDATE, 'YYYY-MM-DD HH24:MI:SS.FF7')::Timestamp_TZ, 'YYYY-MM-DDTHH24:MI:SS.FF1') AS CompletionDate,
'SNP' as lob,
getdate() as insertDate, 
TO_NUMBER(ASSESSMENT_ID) AS ASSESSMENTID, 
q01, 
case 
when q01 = '1' then 'ENGLISH'
when q01 = '2' then 'SPANISH'
when q01 = '3' then 'RUSSIAN'
when q01 = '4' then 'NEPALI'
when q01 = '5' then 'MANDARIN'
when q01 = '162' then 'ARABIC'
when q01 = '7' then 'VIETNAMESE'
when q01 = '8' then 'OTHER'
else NULL end as primaryLanguage, 
--q02,
case 
when q02 = '9' then '1'
when q02 = '10' then '2'
when q02 = '11' then '3'
when q02 = '12' then '4'
else NULL end as q02,
case 
when q02 = '9' then 'EXCELLENT'
when q02 = '10' then 'GOOD'
when q02 = '11' then 'FAIR'
when q02 = '12' then 'POOR'
else NULL end as healthComparedToOthersYourAge, 
--q03,
case 
when q03 = '13' then '1'
when q03 = '14' then '2'
when q03 = '15' then '3'
when q03 = '16' then '4'
else NULL end as q03,
case 
when q03 = '13' then 'EXCELLENT'
when q03 = '14' then 'GOOD'
when q03 = '15' then 'FAIR'
when q03 = '16' then 'POOR'
else NULL end as healthMouthTeeth, 
--q04, 
case 
when q04 = '17' then '1'
when q04 = '18' then '2'
when q04 = '19' then '3'
else NULL end as q04, 
case 
when q04 = '17' then 'YES'
when q04 = '18' then 'NO'
when q04 = '19' then 'DON\'T KNOW OR REMEMBER'
else NULL end as fluShotPastYear, 
--q05, 
case 
when q05 = '20' then '1'
when q05 = '21' then '2'
when q05 = '22' then '3'
when q05 = '23' then '4'
when q05 = '24' then '5'
else NULL end as q05, 
case 
when q05 = '20' then '0'
when q05 = '21' then '1-4'
when q05 = '22' then '5-8'
when q05 = '23' then '9 OR MORE'
when q05 = '24' then 'DON\'T KNOW'
else NULL end as averagePrescriptionsPerDay, 
case when q06A = '163' then '1' ELSE NULL end as q06A,
case when q06A = '163' then 'YES' ELSE NULL end as dontTakeAnyMeds,
--q06B, 
case when q06B = '25' then '1' ELSE NULL end as q06B,
case when q06B = '25' then 'YES' ELSE NULL end as doTakeMedsAsPrescribed,
--q06b, 
case when q06C = '26' THEN '1' ELSE NULL END AS q06C,
case when q06C = '26' THEN 'YES' ELSE NULL END AS dontTakeMedsAsPrescribed, 
--q06D, 
case when q06D = '27' THEN '1' ELSE NULL END AS q06D,
case when q06D = '27' THEN 'YES' ELSE NULL END AS troublePayingForMeds,
--q06d,
case when q06E = '28' THEN '1' ELSE NULL END AS q06E,
case when q06E = '28' THEN 'YES' ELSE NULL END AS troubleGettingMeds,
--q06G,
case when q06F = '29' THEN '1' ELSE NULL END AS q06F,
case when q06F = '29' THEN 'YES' ELSE NULL END AS troubleRememberingMeds,
--q06G, 
case when q06G = '30' THEN '1' ELSE NULL END AS q06G,
case when q06G = '30' THEN 'YES' ELSE NULL END AS understandingWhyHowPrescribed,
--q06H,  
case when q06H = '31' THEN '1' ELSE NULL END AS q06H,
case when q06H = '31' THEN 'YES' ELSE NULL END AS dontKnowIfTakingAsPrescribed, 
--q07, 
case 
when q07 = '32' then '1'
when q07 = '33' then '2'
when q07 = '34' then '3'
when q07 = '35' then '4'
when q07 = '36' then '5'
else NULL end as q07, 
case 
when q07 = '32' then 'NONE'
when q07 = '33' then 'ONE TIME'
when q07 = '34' then '2-3 TIMES'
when q07 = '35' then 'MORE THAN 3 TIMES'
when q07 = '36' then 'DON\'T KNOW'
else NULL end as hospitalAdmissionsPastYear, 
--q08, 
case 
when q08 = '37' then '1'
when q08 = '38' then '2'
when q08 = '39' then '3'
when q08 = '40' then '4'
when q08 = '41' then '5'
else Null end as q08, 
case 
when q08 = '37' then 'NONE'
when q08 = '38' then 'ONE TIME'
when q08 = '39' then '2-3 TIMES'
when q08 = '40' then 'MORE THAN 3 TIMES'
when q08 = '41' then 'DON\'T KNOW'
else Null end as emergencyVisitsPastYear, 
--q09A,
case when q09A = '42' THEN '1' ELSE NULL END AS q09A,
case when q09A = '42' THEN 'YES' ELSE NULL END AS informedHighBloodPressure, 
--q09B,
case when q09B = '45' THEN '1' ELSE NULL END AS q09B,
case when q09B = '45' THEN 'YES' ELSE NULL END AS informedAsthma, 
--q09C,
case when q09C = '48' THEN '1' ELSE NULL END AS q09C, 
case when q09C = '48' THEN 'YES' ELSE NULL END AS informedDiabetes, 
--q09D, 
case when q09D = '51' THEN '1' ELSE NULL END AS q09D,
case when q09D = '51' THEN 'YES' ELSE NULL END AS informedSickleCell,
--q09E,
case when q09E = '57' THEN '1' ELSE NULL END AS q09E,
case when q09E = '57' THEN 'YES' ELSE NULL END AS informedDepression,  
--q09F, 
case when q09F = '43' THEN '1' ELSE NULL END AS q09F, 
case when q09F = '43' THEN 'YES' ELSE NULL END AS informedHighCholesterol, 
--q09G, 
case when q09G = '46' THEN '1' ELSE NULL END AS q09G, 
case when q09G = '46' THEN 'YES' ELSE NULL END AS informedCopdOrEmphysema, 
--q09H,
case when q09H = '49' THEN '1' ELSE NULL END AS q09H,
case when q09H = '49' THEN 'YES' ELSE NULL END AS informedKidneyFailure, 
--q09I,
case when q09I = '52' THEN '1' ELSE NULL END AS q09I,
case when q09I = '52' THEN 'YES' ELSE NULL END AS informedCancer,
--q09J, 
case when q09J = '55' THEN '1' ELSE NULL END AS q09J,
case when q09J = '55' THEN 'YES' ELSE NULL END AS informedAdhd,
--q09K, 
case when q09K = '58' THEN '1' ELSE NULL END AS q09K,
case when q09K = '58' THEN 'YES' ELSE NULL END AS informedAnxiety,  
--q09L,
case when q09L = '44' THEN '1' ELSE NULL END AS q09L,
case when q09L = '44' THEN 'YES' ELSE NULL END AS informedHeartDiseaseOrChf,
--q09M, 
case when q09M = '47' THEN '1' ELSE NULL END AS q09M,
case when q09M = '47' THEN 'YES' ELSE NULL END AS informedStroke,
--q09N,
case when q09N = '50' THEN '1' ELSE NULL END AS q09N,
case when q09N = '50' THEN 'YES' ELSE NULL END AS informedDialysis,
--q09O, 
case when q09O = '53' THEN '1' ELSE NULL END AS q09O,
case when q09O = '53' THEN 'YES' ELSE NULL END AS informedBackPain,
--q09Q,
case when q09P = '56' THEN '1' ELSE NULL END AS q09P,
case when q09P = '56' THEN 'YES' ELSE NULL END AS informedIntellectualDisability,
--q09R,
case when q09Q = '59' THEN '1' ELSE NULL END AS q09Q,
case when q09Q = '59' THEN 'YES' ELSE NULL END AS informedSubstanceUse,
--q09S,
case when q09R = '60' THEN '1' ELSE NULL END AS q09R, 
case when q09R = '60' THEN 'YES' ELSE NULL END AS informedOther, 
--q09S,
case when q09S = '61' THEN '1' ELSE NULL END AS q09S,
case when q09S = '61' THEN 'YES' ELSE NULL END AS informedNone,
--q10,
case 
when q10 = '62' then '1'
when q10 = '63' then '2'
else Null end as q10,
case 
when q10 = '62' then 'YES'
when q10 = '63' then 'NO'
else Null end as pastTwoWeeksLittleInterest,
--q11,
case 
when q11 = '64' then '1'
when q11 = '65' then '2'
else Null end as q11,
case 
when q11 = '64' then 'YES'
when q11 = '65' then 'NO'
else Null end as pastTwoWeeksDepressedHopeless,
--q12,
case 
when q12 = '66' then '1'
when q12 = '67' then '2'
when q12 = '68' then '3'
else Null end as q12,
case 
when q12 = '66' then 'HARDLY EVER OR NEVER'
when q12 = '67' then 'SOMETIMES'
when q12 = '68' then 'OFTEN'
else Null end as feelLonely,
--q13A,
case when q13A='69' THEN '1' ELSE NULL end as q13A,
case when q13A='69' THEN 'YES' ELSE NULL end as concernedWeightTooHigh,
--q13b,
case when q13b='71' THEN '1' ELSE NULL end as q13b,
case when q13b='71' THEN 'YES' ELSE NULL end as dontEatHealthy,
--q13c,
case when q13c='73' THEN '1' ELSE NULL  end as q13c,
case when q13c='73' THEN 'YES' ELSE NULL  end as smokeOrUseTobacco,
--q13d,
case when q13d='75' THEN '1' ELSE NULL end as q13d,
case when q13d='75' THEN 'YES' ELSE NULL end as drinkTooMuchAlcohol,
--q13e,
case when q13e='76' THEN '1' ELSE NULL end as q13e,
case when q13e='76' THEN 'YES' ELSE NULL end as nonPrescribedDrugUse,
--q13F,
case when q13F = '70' THEN '1' ELSE NULL END AS q13F, 
case when q13F = '70' THEN 'YES' ELSE NULL END AS concernedWeightTooLow, 
--q13G, 
case when q13G = '72' THEN '1' ELSE NULL END AS q13G,
case when q13G = '72' THEN 'YES' ELSE NULL END AS lowPhysicalActivity, 
--q13H, 
case when q13H = '74' THEN '1' ELSE NULL END AS q13H, 
case when q13H = '74' THEN 'YES' ELSE NULL END AS troubleHandlingStress, 
--q13I,
case when q13I = '77' THEN '1' ELSE NULL END AS q13I,
case when q13I = '77' THEN 'YES' ELSE NULL END AS noneApply, 
--q14A,
case when q14A = '78' THEN '1' ELSE NULL END AS q14a,
case when q14A = '78' THEN 'YES' ELSE NULL END AS troubleHearing, 
--q14B,
case when q14B = '81' THEN '1' ELSE NULL END AS q14B,
case when q14B = '81' THEN 'YES' ELSE NULL END AS troubleReading, 
--q14C,
case when q14C = '79' THEN '1' ELSE NULL END AS q14Cg, 
case when q14C = '79' THEN 'YES' ELSE NULL END AS troubleSeeing, 
--q14D,
case when q14D = '80' THEN '1' ELSE NULL END AS q14D,
case when q14D = '80' THEN 'YES' ELSE NULL END AS troubleSpeaking, 
--q14E, 
case when q14E = '82' THEN '1' ELSE NULL END AS q14E, 
case when q14E = '82' THEN 'YES' ELSE NULL END AS communicationNone, 
--q15A, 
case when q15A = '83' THEN '1' ELSE NULL END AS q15A,
case when q15A = '83' THEN 'YES' ELSE NULL END AS forgetRecentlyLearned, 
--q15B, 
case when q15B = '84' THEN '1' ELSE NULL END AS q15B,
case when q15B = '84' THEN 'YES' ELSE NULL END AS multipleOrNotes, 
--q15C, 
case when q15C = '85' THEN '1' ELSE NULL END AS q15C, 
case when q15C = '85' THEN 'YES' ELSE NULL END AS troubleInstructions, 
--q15D, 
case when q15D = '86' THEN '1' ELSE NULL END AS q15D, 
case when q15D = '86' THEN 'YES' ELSE NULL END AS confusedDistractedConversations, 
--q15E, 
case when q15E = '87' THEN '1' ELSE NULL END AS q15E, 
case when q15E = '87' THEN 'YES' ELSE NULL END AS forgetWordsDatesEvents, 
--q15F, 
case when q15F = '88' THEN '1' ELSE NULL END AS q15F, 
case when q15F = '88' THEN 'YES' ELSE NULL END AS misplaceThings, 
--q15G, 
case when q15G = '89' THEN '1' ELSE NULL END AS q15G, 
case when q15G = '89' THEN 'YES' ELSE NULL END AS othersSayForgetful, 
--q15H, 
case when q15H = '90' THEN '1' ELSE NULL END AS fq15H, 
case when q15H = '90' THEN 'YES' ELSE NULL END AS forgetNone, 
--q16, 
case 
when q16 = '91' then '1'
when q16 = '92' then '2'
when q16 = '93' then '3'
else NULL end as q16,
case 
when q16 = '91' then 'STABLE PLACE'
when q16 = '92' then 'PLACE BUT WORRIED ABOUT LOSS'
when q16 = '93' then 'NO STABLE PLACE'
else NULL end as livingSituation, 
--q17, 
case 
when q17 = '94' then '1'
when q17 = '96' then '2'
when q17 = '98' then '3'
when q17 = '100' then '4'
when q17 = '165' then '5'
when q17 = '97' then '6'
when q17 = '99' then '7'
when q17 = '101' then '8'
else NULL end as q17, 
case 
when q17 = '94' then 'ALONE'
when q17 = '96' then 'OTHER FAMILY MEMBERS'
when q17 = '98' then 'NURSING HOME'
when q17 = '100' then 'GROUP HOME'
when q17 = '95' then 'SPOUSE/SIGNIFICANT OTHER'
when q17 = '97' then 'FRIENDS'
when q17 = '99' then 'ASSISTED LIVING'
when q17 = '101' then 'OTHER'
else NULL end as liveWith, 
--q18, 
case 
when q18 = '102' then '1'
when q18 = '103' then '2'
when q18 = '104' then '3'
else NULL end as q18,
case 
when q18 = '102' then 'YES, NO CONCERNS'
when q18 = '103' then 'YES, IMPACTING MY HEALTH'
when q18 = '104' then 'NO'
else NULL end as primaryCaregiver, 
--q19, 
case 
when q19 = '105' then '1'
when q19 = '106' then '2'
when q19 = '107' then '3'
when q19 = '108' then '4' 
else NULL end as q19, 
case 
when q19 = '105' then 'YES, DAILY'
when q19 = '106' then 'YES, 1 OR 2 TIMES A WEEK'
when q19 = '107' then 'YES, 1 OR 2 TIMES A MONTH'
when q19 = '108' then 'NO'
else NULL end as needAssistEverydayLiving, 
--q20, 
case 
when q20 = '109' then '1'
when q20 = '110' then '2'
when q20 = '111' then '3'
when q20 = '112' then '4'
else NULL end as q20,
case 
when q20 = '109' then 'YES, DAILY'
when q20 = '110' then 'YES, 1 OR 2 TIMES A WEEK'
when q20 = '111' then 'YES, 1 OR 2 TIMES A MONTH'
when q20 = '112' then 'NO'
else NULL end as needAssistPersonalHygiene,
--q21A, 
case when q21A = '113' THEN '1' ELSE NULL END AS q21A,
case when q21A = '113' THEN 'YES' ELSE NULL END AS supportFromSpouseSignificant, 
--q21B, 
case when q21B = '116' THEN '1' ELSE NULL END AS q21B,
case when q21B = '116' THEN 'YES' ELSE NULL END AS supportFromAgencyCaregivers, 
--q21C,
case when q21C = '114' THEN '1' ELSE NULL END AS q21C, 
case when q21C = '114' THEN 'YES' ELSE NULL END AS supportFromOtherFamilyMembers, 
--q21D, 
case when q21D = '117' THEN '1' ELSE NULL END AS q21D, 
case when q21D = '117' THEN 'YES' ELSE NULL END AS supportFromFacilityStaff, 
--q21E, 
case when q21E = '115' THEN '1' ELSE NULL END AS q21E,
case when q21E = '115' THEN 'YES' ELSE NULL END AS supportFromFriendsNonFamily, 
--q21F, 
case when q21F = '118' THEN '1' ELSE NULL END AS q21F,
case when q21F = '118' THEN 'YES' ELSE NULL END AS dontNeedHelpSupport, 
--q22, 
case 
when q22 = '119' then '1'
when q22 = '120' then '2'
when q22 = '121' then '3'
when q22 = '122' then '4'
else NULL end as q22, 
case 
when q22 = '119' then 'YES, ENOUGH AND RELIABLE'
when q22 = '120' then 'YES, BUT NOT ALWAYS AVAILABLE'
when q22 = '121' then 'NO, NEED MORE HELP'
when q22 = '122' then 'N/A DON\'T RECEIVE'
else NULL end as reliableHelpSupport, 
--q23A,
case when q23A = '123' THEN '1' ELSE NULL END AS q23A,
case when q23A = '123' THEN 'YES' ELSE NULL END AS useCane, 
--q23B,
case when q23B = '127' THEN '1' ELSE NULL END AS q23B,
case when q23B = '127' THEN 'YES' ELSE NULL END AS useProsthetic, 
--q23C,
case when q23C = '131' THEN '1' ELSE NULL END AS q23C, 
case when q23C = '131' THEN 'YES' ELSE NULL END AS useNebulizer, 
--q23D,
case when q23D = '124' THEN '1' ELSE NULL END AS q23D,
case when q23D = '124' THEN 'YES' ELSE NULL END AS useWalker, 
--q23E, 
case when q23E = '128' THEN '1' ELSE NULL END AS q23E,
case when q23E = '128' THEN 'YES' ELSE NULL END AS useHospitalBed, 
--q23F,
case when q23F = '132' THEN '1' ELSE NULL END AS q23F, 
case when q23F = '132' THEN 'YES' ELSE NULL END AS useOxygen, 
--q23G, 
case when q23G = '125' THEN '1' ELSE NULL END AS q23G,
case when q23G = '125' THEN 'YES' ELSE NULL END AS useWheelchair, 
--q23H, 
case when q23H = '129' THEN '1' ELSE NULL END AS q23H, 
case when q23H = '129' THEN 'YES' ELSE NULL END AS useHoyerLift, 
--q23I, 
case when q23I = '133' THEN '1' ELSE NULL END AS q23I, 
case when q23I = '133' THEN 'YES' ELSE NULL END AS useCpapBipap, 
--q23J, 
case when q23J = '126' THEN '1' ELSE NULL END AS q23J, 
case when q23J = '126' THEN 'YES' ELSE NULL END AS useMotorizedScooter, 
--q23K, 
case when q23K = '130' THEN '1' ELSE NULL END AS q23K, 
case when q23K = '130' THEN 'YES' ELSE NULL END AS useGlucometer, 
--q23L, 
case when q23L = '134' THEN '1' ELSE NULL END AS q23L, 
case when q23L = '134' THEN 'YES' ELSE NULL END AS useVentilator, 
--q23M, 
case when q23M = '135' THEN '1' ELSE NULL END AS q23M,
case when q23M = '135' THEN 'YES' ELSE NULL END AS useOtherDevices, 
--q23N, 
case when q23N = '136' THEN '1' ELSE NULL END AS q23N, 
case when q23N = '136' THEN 'YES' ELSE NULL END AS useNoDevices, 
--q24, 
case 
when q24 = '137' then '1'
when q24 = '138' then '2'
when q24 = '139' then '3'
else NULL end as q24,
case 
when q24 = '137' then 'YES'
when q24 = '138' then 'NO'
when q24 = '139' then 'DON\'T KNOW'
else NULL end as fallen2OrMorePast3Months, 
--q25A, 
case when q25A = '140' THEN '1' ELSE NULL END AS q25A, 
case when q25A = '140' THEN 'YES' ELSE NULL END AS utilizeMatp, 
--q25B,
case when q25B = '141' THEN '1' ELSE NULL END AS q25B,
case when q25B = '141' THEN 'YES' ELSE NULL END AS utilizeSnap, 
--q25C,
case when q25C = '142' THEN '1' ELSE NULL END AS q25C,
case when q25C = '142' THEN 'YES' ELSE NULL END AS utilizeLiheap, 
--q25D,
case when q25D = '143' THEN '1' ELSE NULL END AS q25D,
case when q25D = '143' THEN 'YES' ELSE NULL END AS utilizeLtss, 
--q25E,
case when q25E = '144' THEN '1' ELSE NULL END AS q25E, 
case when q25E = '144' THEN 'YES' ELSE NULL END AS utilizeNoResources,
--q26,
case 
when q26 = '167' then '1'
when q26 = '168' then '2'
when q26 = '169' then '3'
else NULL end as q26, 
case 
when q26 = '167' then 'OFTEN TRUE'
when q26 = '168' then 'SOMETIMES TRUE'
when q26 = '169' then 'NEVER TRUE'
else NULL end as foodRunOut12Month, 
--q27, 
case 
when q27 = '170' then '1'
when q27 = '171' then '2'
when q27 = '172' then '3'
else NULL end as q27, 
case 
when q27 = '170' then 'OFTEN TRUE'
when q27 = '171' then 'SOMETIMES TRUE'
when q27 = '172' then 'NEVER TRUE'
else NULL end as foodBought12Month, 
--q28, 
case 
when q28 = '173' then '1'
when q28 = '174' then '2'
else NULL end as q28, 
case 
when q28 = '173' then 'YES'
when q28 = '174' then 'NO'
else NULL end as reliableTransport12Month, 
--q29, 
case 
when q29 = '175' then '1'
when q29 = '176' then '2'
when q29 = '161' then '3'
else NULL end as q29,
case 
when q29 = '175' then 'YES'
when q29 = '176' then 'NO'
when q29 = '161' then 'DON\'T KNOW'
else NULL end as selfSpouseMilitary, 
case 
when  q31 = '177' then '1'
when  q31  = '178' then '2'
when  q31  = '179' then '3'
when  q31  = '180' then '4'
else Null end as q31,
case 
when  q31  = '177' then 'YES'
when  q31  = '178' then 'NO, NOT INTERESTED'
when  q31  = '179' then 'NO, SEND INFO'
when  q31  = '180' then 'DON\'T KNOW'
else Null end as advanceDirective,
case 
when q32 = '181' then '1'
when q32 = '182' then '2'
when q32 = '183' then '3'
when q32 = '184' then '4'
else Null end as q32,
case 
when q32 = '181' then 'YES'
when q32 = '182' then 'NO, NOT INTERESTED'
when q32 = '183' then 'NO, SEND INFO'
when q32 = '184' then 'DON\'T KNOW'
else Null end as personalRepresentative,
case 
when q33 is not null then '999'
else null end as q33,
case
when q01 = '8' then q33
else Null end as otherLanguage

from HRA.MHOL_FLATTEN_SELECT_VW );