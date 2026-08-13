create or replace view HRA.HELIOS_JSON_SELECT_VW(
	MEMBER_NBR,
	INSERT_DATETIME,
	COMPLETION_DATETIME,
	HELIOS_JSON_SELECT_VW_KEY,
	JSON_DATA
) COMMENT = 'View that creates JSON data for each record'
as (
select memberId, insertdate,scantime, concat(memberid,scantime),
object_construct('envelope',object_construct('instance',object_construct('HRA',object_construct('dataSourceName',dataSourceName, 
'memberId', memberid, 
'originalAssesmentId', originalAssessmentId,
'heliosAssessmentId', heliosAssessmentId, 
'scanTime',scanTime, 
'lob' ,lob, 'insertDate',insertDate, 'q01',q01, 'primaryLanguage',primaryLanguage, 'q02',q02, 'primaryLanguageOther', primaryLanguageOther, 'q03',q03,'healthComparedToOthersYourAge',healthComparedToOthersYourAge,'q04',q04,  'healthMouthTeeth',healthMouthTeeth,  'q05',q05,'fluShotPastYear',fluShotPastYear,  'q06',q06, 'averagePrescriptionsPerDay',averagePrescriptionsPerDay,  'q07A',q07A,'dontTakeAnyMeds', dontTakeAnyMeds, 'q07B',q07B,'doTakeMedsAsPrescribed',doTakeMedsAsPrescribed, 'q07C',q07C, 'dontTakeMedsAsPrescribed',dontTakeMedsAsPrescribed, 'q07D',q07D, 'troublePayingForMeds',troublePayingForMeds, 'q07E',q07E, 'troubleGettingMeds',troubleGettingMeds, 'q07F',q07F, 'troubleRememberingMeds',troubleRememberingMeds, 'q07G',q07G, 'understandingWhyHowPrescribed',understandingWhyHowPrescribed,'q07H', q07H, 'dontKnowIfTakingAsPrescribed',dontKnowIfTakingAsPrescribed, 'q08',q08, 'hospitalAdmissionsPastYear',hospitalAdmissionsPastYear, 'q09',q09, 'emergencyVisitsPastYear',emergencyVisitsPastYear, 'q10A',q10A, 'informedHighBloodPressure',informedHighBloodPressure, 'q10B',q10B, 'informedAsthma',informedAsthma, 'q10C',q10C, 'informedDiabetes',informedDiabetes, 'q10D',q10D, 'informedSickleCell',informedSickleCell,'q10E', q10E, 'informedDepression',informedDepression, 'q10F',q10F, 'informedHighCholesterol',informedHighCholesterol, 'q10G',q10G, 'informedCopdOrEmphysema',informedCopdOrEmphysema, 'q10H',q10H, 'informedKidneyFailure',informedKidneyFailure, 'q10I',q10I, 'informedCancer',informedCancer, 'q10J',q10J, 'informedAdhd',informedAdhd, 'q10K',q10K, 'informedAnxiety',informedAnxiety, 'q10L',q10L,'informedHeartDiseaseOrChf', informedHeartDiseaseOrChf, 'q10M',q10M, 'informedStroke',informedStroke, 'q10N',q10N, 'informedDialysis',informedDialysis,'q10O', q10O, 'informedBackPain',informedBackPain, 'q10P',q10P, 'informedIntellectualDisability',informedIntellectualDisability, 'q10Q',q10Q, 'informedSubstanceUse',informedSubstanceUse, 'q10R',q10R,'informedOther', informedOther, 'q10S',q10S, 'informedNone',informedNone, 'q11',q11,'pastTwoWeeksLittleInterest', pastTwoWeeksLittleInterest, 'q12',q12, 'pastTwoWeeksDepressedHopeless',pastTwoWeeksDepressedHopeless, 'q13',q13, 'feelLonely',feelLonely, 'q14A',q14A, 'concernedWeightTooHigh',concernedWeightTooHigh, 'q14B',q14B, 'dontEatHealthy',dontEatHealthy, 'q14C',q14C, 'smokeOrUseTobacco',smokeOrUseTobacco, 'q14D',q14D, 'drinkTooMuchAlcohol',drinkTooMuchAlcohol, 'q14E',q14E, 'nonPrescribedDrugUse',nonPrescribedDrugUse, 'q14F',q14F, 'concernedWeightTooLow',concernedWeightTooLow, 'q14G',q14G, 'lowPhysicalActivity',lowPhysicalActivity, 'q14H',q14H, 'troubleHandlingStress',troubleHandlingStress, 'q14I',q14I, 'noneApply',noneApply, 'q15A',q15A, 'troubleHearing',troubleHearing, 'q15B',q15B,'troubleReading', troubleReading, 'q15C',q15C, 'troubleSeeing',troubleSeeing, 'q15D',q15D, 'troubleSpeaking',troubleSpeaking, 'q15E',q15E, 'communicationNone',communicationNone, 'q16A',q16A, 'forgetRecentlyLearned',forgetRecentlyLearned, 'q16B',q16B, 'multipleOrNotes',multipleOrNotes,'q16C', q16C, 'troubleInstructions',troubleInstructions, 'q16D',q16D, 'confusedDistractedConversations',confusedDistractedConversations, 'q16E',q16E, 'forgetWordsDatesEvents',forgetWordsDatesEvents, 'q16F',q16F, 'misplaceThings',misplaceThings, 'q16G',q16G, 'othersSayForgetful',othersSayForgetful, 'q16H',q16H, 'forgetNone',forgetNone,'q17', q17, 'livingSituation',livingSituation, 'q18',q18, 'liveWith',liveWith, 'q19',q19, 'primaryCaregiver',primaryCaregiver, 'q20',q20, 'needAssistEverydayLiving',needAssistEverydayLiving, 'q21',q21, 'needAssistPersonalHygiene',needAssistPersonalHygiene, 'q22A',q22A, 'supportFromSpouse',supportFromSpouse, 'q22B',q22B, 'supportFromAgencyCaregivers',supportFromAgencyCaregivers, 'q22C',q22C,'supportFromOtherFamilyMembers', supportFromOtherFamilyMembers, 'q22D',q22D, 'supportFromFacilityStaff',supportFromFacilityStaff, 'q22E',q22E, 'supportFromFriendsNonFamily',supportFromFriendsNonFamily, 'q22F',q22F, 'dontNeedHelpSupport',dontNeedHelpSupport, 'q23',q23,'reliableHelpSupport', reliableHelpSupport, 'q24A',q24A, 'useCane',useCane,'q24B', q24B, 'useProsthetic',useProsthetic, 'q24C',q24C,'useNebulizer', useNebulizer,'q24D', q24D, 'useWalker',useWalker, 'q24E',q24E,'useHospitalBed', useHospitalBed, 'q24F',q24F, 'useOxygen',useOxygen, 'q24G',q24G, 'useWheelchair',useWheelchair,'q24H',q24H, 'useHoyerLift',useHoyerLift, 'q24I',q24I, 'useCpapBipap',useCpapBipap, 'q24J',q24J, 'useMotorizedScooter',useMotorizedScooter, 'q24K',q24K, 'useGlucometer',useGlucometer, 'q24L',q24L, 'useVentilator',useVentilator, 'q24M',q24M, 'useOtherDevices',useOtherDevices, 'q24N',q24N, 'useNoDevices',useNoDevices, 'q25',q25, 'fallen2OrMorePast3Months',fallen2OrMorePast3Months, 'q26A',q26A, 'utilizeMatp',utilizeMatp, 'q26B',q26B, 'utilizeSnap',utilizeSnap, 'q26C',q26C, 'utilizeLiheap',utilizeLiheap, 'q26D',q26D, 'utilizeLtss',utilizeLtss, 'q26E',q26E, 'utilizeNoResources',utilizeNoResources, 'q27',q27, 'worriedFoodWouldRunOut', worriedFoodWouldRunOut, 'q28', q28, 'foodBoughtDidntLast', foodBoughtDidntLast, 'q29',q29, 'lackOfReliableTransportation', lackOfReliableTransportation, 'q30',q30, 'selfSpouseMilitary',selfSpouseMilitary, 'q31',q31,'advanceDirective',advanceDirective, 'q32',q32, 'personalRepresentative',personalRepresentative,
'responses', ARRAY_CONSTRUCT_COMPACT(
case when q01 is not null then
object_construct('outputField', 'primaryLanguage', 
'outputFieldValue', primaryLanguage, 
'questionNbr', 'q01', 
'questionText', 'What is your primary language?', 
'answerNbr', q01, 
'answerText', primaryLanguage) else null end,

case when q02 is not null then
object_construct('outputField', 'primaryLanguageOther', 
'outputFieldValue', primaryLanguageOther, 
'questionNbr', 'q02', 
'questionText', 'If Other, please explain', 
'answerNbr', q02, 
'answerText', primaryLanguageOther) else null end,

case when q03 is not null then
object_construct('outputField', 'healthComparedToOthersYourAge', 
'outputFieldValue', healthComparedToOthersYourAge, 
'questionNbr', 'q03', 
'questionText', 'Compared to other people your age, would you say that your health is?', 
'answerNbr', q03, 
'answerText', healthComparedToOthersYourAge) else null end,

case when q04 is not null then
object_construct('outputField', 'healthMouthTeeth', 
'outputFieldValue', healthMouthTeeth, 
'questionNbr', 'q04', 
'questionText', 'How would you describe the health of your mouth and teeth?', 
'answerNbr', q04, 
'answerText', healthMouthTeeth) else null end,

case when q05 is not null then
object_construct('outputField', 'fluShotPastYear', 
'outputFieldValue', fluShotPastYear, 
'questionNbr', 'q05', 
'questionText', 'Have you had a flu shot in the last year?', 
'answerNbr', q05, 
'answerText', fluShotPastYear) else null end,

case when q06 is not null then
object_construct('outputField', 'averagePrescriptionsPerDay', 
'outputFieldValue', averagePrescriptionsPerDay, 
'questionNbr', 'q06', 
'questionText', 'How many different prescription medications do you take on an average day?', 
'answerNbr', q06, 
'answerText', averagePrescriptionsPerDay) else null end,

case when q07A is not null then
object_construct('outputField', 'dontTakeAnyMeds', 
'outputFieldValue', dontTakeAnyMeds, 
'questionNbr', 'q07A', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q07A, 
'answerText', 'I do take all my medications as prescribed') else null end,

case when q07B is not null then
object_construct('outputField', 'doTakeMedsAsPrescribed', 
'outputFieldValue', doTakeMedsAsPrescribed, 
'questionNbr', 'q07B', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q07B, 
'answerText', 'I do take all my medications as prescribed') else null end,

case when q07C is not null then 
object_construct('outputField', 'dontTakeMedsAsPrescribed', 
'outputFieldValue', dontTakeMedsAsPrescribed, 
'questionNbr', 'q07C', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q07C, 
'answerText', 'I don\'t take all my medications as prescribed') else null end,

case when q07D is not null then 
object_construct('outputField', 'troublePayingForMeds', 
'outputFieldValue', troublePayingForMeds, 
'questionNbr', 'q07D', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q07D, 
'answerText', 'I have trouble paying for my medications') else null end,

case when q07E is not null then 
object_construct('outputField', 'troubleGettingMeds', 
'outputFieldValue', troubleGettingMeds, 
'questionNbr', 'q07E', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q07E, 
'answerText', 'I have trouble getting my medications') else null end,

case when q07F is not null then 
object_construct('outputField', 'troubleRememberingMeds', 
'outputFieldValue', troubleRememberingMeds, 
'questionNbr', 'q07F', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q07F, 
'answerText', 'I have trouble remembering to take my medications') else null end,

case when q07G is not null then 
object_construct('outputField', 'understandingWhyHowPrescribed', 
'outputFieldValue', understandingWhyHowPrescribed, 
'questionNbr', 'q07G', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q07G, 
'answerText', 'I have trouble understanding how and/or why to take my medications the correct way') else null end,

case when q07H is not null then 
object_construct('outputField', 'dontKnowIfTakingAsPrescribed', 
'outputFieldValue', dontKnowIfTakingAsPrescribed, 
'questionNbr', 'q07H', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q07H, 
'answerText', 'I don\'t know if I am taking my medications as prescribed') else null end,


case when q08 is not null then 
object_construct('outputField', 'hospitalAdmissionsPastYear', 
'outputFieldValue', hospitalAdmissionsPastYear, 
'questionNbr', 'q08', 
'questionText', 'In the past year, how many times were you admitted to the hospital?', 
'answerNbr', q08, 
'answerText', hospitalAdmissionsPastYear) else null end,


case when q09 is not null then 
object_construct('outputField', 'emergencyVisitsPastYear', 
'outputFieldValue', emergencyVisitsPastYear, 
'questionNbr', 'q09', 
'questionText', 'In the past year, how many times did you visit the emergency room for your own needs?', 
'answerNbr', q09, 
'answerText', emergencyVisitsPastYear) else null end,


case when q10A is not null then 
object_construct('outputField', 'informedHighBloodPressure', 
'outputFieldValue', informedHighBloodPressure, 
'questionNbr', 'q10A', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10A, 
'answerText', 'High Blood Pressure') else null end,


case when q10B is not null then 
object_construct('outputField', 'informedAsthma', 
'outputFieldValue', informedAsthma, 
'questionNbr', 'q10B', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10B, 
'answerText', 'Asthma') else null end,


case when q10C is not null then 
object_construct('outputField', 'informedDiabetes', 
'outputFieldValue', informedDiabetes, 
'questionNbr', 'q10C', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10C, 
'answerText', 'Diabetes') else null end,


case when q10D is not null then 
object_construct('outputField', 'informedSickleCell', 
'outputFieldValue', informedSickleCell, 
'questionNbr', 'q10D', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10D, 
'answerText', 'Sickle Cell') else null end,

case when q10E is not null then 
object_construct('outputField', 'informedDepression', 
'outputFieldValue', informedDepression, 
'questionNbr', 'q10E', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10E, 
'answerText', 'Depression') else null end,


case when q10F is not null then 
object_construct('outputField', 'informedHighCholesterol', 
'outputFieldValue', informedHighCholesterol, 
'questionNbr', 'q10F', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10F, 
'answerText', 'High Cholesterol') else null end,

case when q10G is not null then 
object_construct('outputField', 'informedCopdOrEmphysema', 
'outputFieldValue', informedCopdOrEmphysema, 
'questionNbr', 'q10G', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10G, 
'answerText', 'COPD or Emphysema') else null end,


case when q10H is not null then 
object_construct('outputField', 'informedKidneyFailure', 
'outputFieldValue', informedKidneyFailure, 
'questionNbr', 'q10H', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10H, 
'answerText', 'Kidney Failure') else null end,

case when q10I is not null then 
object_construct('outputField', 'informedCancer', 
'outputFieldValue', informedCancer, 
'questionNbr', 'q10I', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10I, 
'answerText', 'Cancer') else null end,

case when q10J is not null then 
object_construct('outputField', 'informedAdhd', 
'outputFieldValue', informedAdhd, 
'questionNbr', 'q10J', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10J, 
'answerText', 'ADHD') else null end,

case when q10K is not null then 
object_construct('outputField', 'informedAnxiety', 
'outputFieldValue', informedAnxiety, 
'questionNbr', 'q10K', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10K, 
'answerText', 'Anxiety') else null end,

case when q10L is not null then 
object_construct('outputField', 'informedHeartDiseaseOrChf', 
'outputFieldValue', informedHeartDiseaseOrChf, 
'questionNbr', 'q10L', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10L, 
'answerText', 'Heart Failure/Heart Disease or CHF') else null end,

case when q10M is not null then 
object_construct('outputField', 'informedStroke', 
'outputFieldValue', informedStroke, 
'questionNbr', 'q10M', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10M, 
'answerText', 'Stroke') else null end,

case when q10N is not null then 
object_construct('outputField', 'informedDialysis', 
'outputFieldValue', informedDialysis, 
'questionNbr', 'q10N', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10N, 
'answerText', 'Dialysis') else null end,

case when q10O is not null then 
object_construct('outputField', 'informedBackPain', 
'outputFieldValue', informedBackPain, 
'questionNbr', 'q10O', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10O, 
'answerText', 'Back Pain') else null end,

case when q10P is not null then 
object_construct('outputField', 'informedIntellectualDisability', 
'outputFieldValue', informedIntellectualDisability, 
'questionNbr', 'q10P', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10P, 
'answerText', 'Intellectual Disability') else null end,

case when q10Q is not null then 
object_construct('outputField', 'informedSubstanceUse', 
'outputFieldValue', informedSubstanceUse, 
'questionNbr', 'q10Q', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10Q, 
'answerText', 'Substance Abuse Disorder') else null end,

case when q10R is not null then 
object_construct('outputField', 'informedOther', 
'outputFieldValue', informedOther, 
'questionNbr', 'q10R', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10R, 
'answerText', 'Other') else null end,

case when q10S is not null then 
object_construct('outputField', 'informedNone', 
'outputFieldValue', informedNone, 
'questionNbr', 'q10S', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q10S, 
'answerText', 'None of these') else null end,

case when q11 is not null then 
object_construct('outputField', 'pastTwoWeeksLittleInterest', 
'outputFieldValue', pastTwoWeeksLittleInterest, 
'questionNbr', 'q11', 
'questionText', 'Over the past two weeks, have you been bothered by little interest or pleasure in doing things several days or more?', 
'answerNbr', q11, 
'answerText', pastTwoWeeksLittleInterest) else null end,

case when q12 is not null then 
object_construct('outputField', 'pastTwoWeeksDepressedHopeless', 
'outputFieldValue', pastTwoWeeksDepressedHopeless, 
'questionNbr', 'q12', 
'questionText', 'Over the past two weeks, have you been bothered by feeling down, depressed, or hopeless several days or more?', 
'answerNbr', q12, 
'answerText', pastTwoWeeksDepressedHopeless) else null end,

case when q13 is not null then 
object_construct('outputField', 'feelLonely', 
'outputFieldValue', feelLonely, 
'questionNbr', 'q13', 
'questionText', 'How often do you feel lonely?', 
'answerNbr', q13, 
'answerText', feelLonely) else null end,

case when q14A is not null then 
object_construct('outputField', 'concernedWeightTooHigh', 
'outputFieldValue', concernedWeightTooHigh, 
'questionNbr', 'q14A', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q14A, 
'answerText', 'I feel my weight is too high') else null end,

case when q14B is not null then 
object_construct('outputField', 'dontEatHealthy', 
'outputFieldValue', dontEatHealthy, 
'questionNbr', 'q14B', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q14B, 
'answerText', 'I don\'t eat a healthy diet') else null end,

case when q14C is not null then 
object_construct('outputField', 'smokeOrUseTobacco', 
'outputFieldValue', smokeOrUseTobacco, 
'questionNbr', 'q14C', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q14C, 
'answerText', 'I smoke or use tobacco') else null end,

case when q14D is not null then 
object_construct('outputField', 'drinkTooMuchAlcohol', 
'outputFieldValue', drinkTooMuchAlcohol, 
'questionNbr', 'q14D', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q14D, 
'answerText', 'I drink too much alcohol') else null end,

case when q14E is not null then 
object_construct('outputField', 'nonPrescribedDrugUse', 
'outputFieldValue', nonPrescribedDrugUse, 
'questionNbr', 'q14E', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q14E, 
'answerText', 'I use drugs or medications not ordered for me') else null end,

case when q14F is not null then 
object_construct('outputField', 'concernedWeightTooLow', 
'outputFieldValue', concernedWeightTooLow, 
'questionNbr', 'q14F', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q14F, 
'answerText', 'I feel my weight is too low') else null end,

case when q14G is not null then 
object_construct('outputField', 'lowPhysicalActivity', 
'outputFieldValue', lowPhysicalActivity, 
'questionNbr', 'q14G', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q14G, 
'answerText', 'I don\'t get enough physical activity') else null end,

case when q14H is not null then 
object_construct('outputField', 'troubleHandlingStress', 
'outputFieldValue', troubleHandlingStress, 
'questionNbr', 'q14H', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q14H, 
'answerText', 'I have trouble handling my stress') else null end,

case when q14I is not null then 
object_construct('outputField', 'noneApply', 
'outputFieldValue', noneApply, 
'questionNbr', 'q14I', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q14I, 
'answerText', 'None of these') else null end,

case when q15A is not null then 
object_construct('outputField', 'troubleHearing', 
'outputFieldValue', troubleHearing, 
'questionNbr', 'q15A', 
'questionText', 'Do any of the following make it hard to communicate?  Please mark all that apply.', 
'answerNbr', q15A, 
'answerText', 'I have trouble hearing') else null end,

case when q15B is not null then 
object_construct('outputField', 'troubleReading', 
'outputFieldValue', troubleReading, 
'questionNbr', 'q15B', 
'questionText', 'Do any of the following make it hard to communicate?  Please mark all that apply.', 
'answerNbr', q15B, 
'answerText', 'I have trouble reading') else null end,

case when q15C is not null then 
object_construct('outputField', 'troubleSeeing', 
'outputFieldValue', troubleSeeing, 
'questionNbr', 'q15C', 
'questionText', 'Do any of the following make it hard to communicate?  Please mark all that apply.', 
'answerNbr', q15C, 
'answerText', 'I have trouble seeing') else null end,

case when q15D is not null then 
object_construct('outputField', 'troubleSpeaking', 
'outputFieldValue', troubleSpeaking, 
'questionNbr', 'q15D', 
'questionText', 'Do any of the following make it hard to communicate?  Please mark all that apply.', 
'answerNbr', q15D, 
'answerText', 'I have trouble speaking') else null end,

case when q15E is not null then 
object_construct('outputField', 'communicationNone', 
'outputFieldValue', communicationNone, 
'questionNbr', 'q15E', 
'questionText', 'Do any of the following make it hard to communicate?  Please mark all that apply.', 
'answerNbr', q15E, 
'answerText', 'None of these') else null end,

case when q16A is not null then 
object_construct('outputField', 'forgetRecentlyLearned', 
'outputFieldValue', forgetRecentlyLearned, 
'questionNbr', 'q16A', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q16A, 
'answerText', 'I forget information recently learned') else null end,

case when q16B is not null then 
object_construct('outputField', 'multipleOrNotes', 
'outputFieldValue', multipleOrNotes, 
'questionNbr', 'q16B', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q16B, 
'answerText', 'I ask for the same information multiple times or need reminder notes') else null end,

case when q16C is not null then 
object_construct('outputField', 'troubleInstructions', 
'outputFieldValue', troubleInstructions, 
'questionNbr', 'q16C', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q16C, 
'answerText', 'I have trouble following instructions') else null end,

case when q16D is not null then 
object_construct('outputField', 'confusedDistractedConversations', 
'outputFieldValue', confusedDistractedConversations, 
'questionNbr', 'q16D', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q16D, 
'answerText', 'I become confused or distracted in the middle of a conversation') else null end,

case when q16E is not null then 
object_construct('outputField', 'forgetWordsDatesEvents', 
'outputFieldValue', forgetWordsDatesEvents, 
'questionNbr', 'q16E', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q16E, 
'answerText', 'I struggle to remember words, dates, or events') else null end,

case when q16F is not null then 
object_construct('outputField', 'misplaceThings', 
'outputFieldValue', misplaceThings, 
'questionNbr', 'q16F', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q16F, 
'answerText', 'I lose or misplace things') else null end,

case when q16G is not null then 
object_construct('outputField', 'othersSayForgetful', 
'outputFieldValue', othersSayForgetful, 
'questionNbr', 'q16G', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q16G, 
'answerText', 'My family/friends say I am forgetful') else null end,

case when q16H is not null then 
object_construct('outputField', 'forgetNone', 
'outputFieldValue', forgetNone, 
'questionNbr', 'q16H', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q16H, 
'answerText', 'None of these') else null end,

case when q17 is not null then 
object_construct('outputField', 'livingSituation', 
'outputFieldValue', livingSituation, 
'questionNbr', 'q17', 
'questionText', 'What is your living situation today?', 
'answerNbr', q17, 
'answerText', livingSituation) else null end,

case when q18 is not null then 
object_construct('outputField', 'liveWith', 
'outputFieldValue', liveWith, 
'questionNbr', 'q18', 
'questionText', 'Who do you live with?', 
'answerNbr', q18, 
'answerText', liveWith) else null end,

case when q19 is not null then 
object_construct('outputField', 'primaryCaregiver', 
'outputFieldValue', primaryCaregiver, 
'questionNbr', 'q19', 
'questionText', 'Are you the primary caregiver for someone else?', 
'answerNbr', q19, 
'answerText', primaryCaregiver) else null end,

case when q20 is not null then 
object_construct('outputField', 'needAssistEverydayLiving', 
'outputFieldValue', needAssistEverydayLiving, 
'questionNbr', 'q20', 
'questionText', 'Do you receive or need assistance from another person for tasks like taking medications, meal preparation, housekeeping, laundry, telephone, shopping, or managing finances?', 
'answerNbr', q20, 
'answerText', needAssistEverydayLiving) else null end,

case when q21 is not null then 
object_construct('outputField', 'needAssistPersonalHygiene', 
'outputFieldValue', needAssistPersonalHygiene, 
'questionNbr', 'q21', 
'questionText', 'Do you receive or do you need assistance from another person for bathing, dressing, toileting, bowel and bladder function, or eating?', 
'answerNbr', q21, 
'answerText', needAssistPersonalHygiene) else null end,

case when q22A is not null then 
object_construct('outputField', 'supportFromSpouse', 
'outputFieldValue', supportFromSpouse, 
'questionNbr', 'q22A', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q22A, 
'answerText', 'Spouse') else null end,

case when q22B is not null then 
object_construct('outputField', 'supportFromAgencyCaregivers', 
'outputFieldValue', supportFromAgencyCaregivers, 
'questionNbr', 'q22B', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q22B, 
'answerText', 'Caregivers from an agency') else null end,

case when q22C is not null then 
object_construct('outputField', 'supportFromOtherFamilyMembers', 
'outputFieldValue', supportFromOtherFamilyMembers, 
'questionNbr', 'q22C', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q22C, 
'answerText', 'Other family member(s)') else null end,

case when q22D is not null then 
object_construct('outputField', 'supportFromFacilityStaff', 
'outputFieldValue', supportFromFacilityStaff, 
'questionNbr', 'q22D', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q22D, 
'answerText', 'Staff in facility') else null end,

case when q22E is not null then 
object_construct('outputField', 'supportFromFriendsNonFamily', 
'outputFieldValue', supportFromFriendsNonFamily, 
'questionNbr', 'q22E', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q22E, 
'answerText', 'Friends or non-relative(s)') else null end,

case when q22F is not null then 
object_construct('outputField', 'dontNeedHelpSupport', 
'outputFieldValue', dontNeedHelpSupport, 
'questionNbr', 'q22F', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q22F, 
'answerText', 'I don\'t need help and support') else null end,

case when q23 is not null then 
object_construct('outputField', 'reliableHelpSupport', 
'outputFieldValue', reliableHelpSupport, 
'questionNbr', 'q23', 
'questionText', 'If you are receiving help from others, is the help and support reliable?', 
'answerNbr', q23, 
'answerText', reliableHelpSupport) else null end,

case when q24A is not null then 
object_construct('outputField', 'useCane', 
'outputFieldValue', useCane, 
'questionNbr', 'q24A', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24A, 
'answerText', 'Cane') else null end,

case when q24B is not null then 
object_construct('outputField', 'useProsthetic', 
'outputFieldValue', useProsthetic, 
'questionNbr', 'q24B', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24B, 
'answerText', 'Prosthetic') else null end,

case when q24C is not null then 
object_construct('outputField', 'useNebulizer', 
'outputFieldValue', useNebulizer, 
'questionNbr', 'q24C', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24C, 
'answerText', 'Nebulizer') else null end,

case when q24D is not null then 
object_construct('outputField', 'useWalker', 
'outputFieldValue', useWalker, 
'questionNbr', 'q24D', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24D, 
'answerText', 'Walker') else null end,

case when q24E is not null then 
object_construct('outputField', 'useHospitalBed', 
'outputFieldValue', useHospitalBed, 
'questionNbr', 'q24E', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24E, 
'answerText', 'Hospital bed') else null end,

case when q24F is not null then 
object_construct('outputField', 'useOxygen', 
'outputFieldValue', useOxygen, 
'questionNbr', 'q24F', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24F, 
'answerText', 'Oxygen') else null end,

case when q24G is not null then 
object_construct('outputField', 'useWheelchair', 
'outputFieldValue', useWheelchair, 
'questionNbr', 'q24G', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24G, 
'answerText', 'Wheelchair') else null end,

case when q24H is not null then 
object_construct('outputField', 'useHoyerLift', 
'outputFieldValue', useHoyerLift, 
'questionNbr', 'q24H', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24H, 
'answerText', 'Hoyer lift') else null end,

case when q24I is not null then 
object_construct('outputField', 'useCpapBipap', 
'outputFieldValue', useCpapBipap, 
'questionNbr', 'q24I', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24I, 
'answerText', 'CPAP or BiPAP') else null end,

case when q24J is not null then 
object_construct('outputField', 'useMotorizedScooter', 
'outputFieldValue', useMotorizedScooter, 
'questionNbr', 'q24J', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24J, 
'answerText', 'Motorized scooter') else null end,

case when q24K is not null then 
object_construct('outputField', 'useGlucometer', 
'outputFieldValue', useGlucometer, 
'questionNbr', 'q24K', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24K, 
'answerText', 'Glucometer') else null end,

case when q24L is not null then 
object_construct('outputField', 'useVentilator', 
'outputFieldValue', useVentilator, 
'questionNbr', 'q24L', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24L, 
'answerText', 'Ventilator') else null end,

case when q24M is not null then 
object_construct('outputField', 'useOtherDevices', 
'outputFieldValue', useOtherDevices, 
'questionNbr', 'q24M', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24M, 
'answerText', 'Other(s)') else null end,

case when q24N is not null then 
object_construct('outputField', 'useNoDevices', 
'outputFieldValue', useNoDevices, 
'questionNbr', 'q24N', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q24N, 
'answerText', 'None of these') else null end,

case when q25 is not null then 
object_construct('outputField', 'fallen2OrMorePast3Months', 
'outputFieldValue', fallen2OrMorePast3Months, 
'questionNbr', 'q25', 
'questionText', 'Have you fallen 2 or more times in the last 3 months?', 
'answerNbr', q25, 
'answerText', fallen2OrMorePast3Months) else null end,

case when q26A is not null then 
object_construct('outputField', 'utilizeMatp', 
'outputFieldValue', utilizeMatp, 
'questionNbr', 'q26A', 
'questionText', 'Do you utilize any of these resources?  Please mark all that apply.', 
'answerNbr', q26A, 
'answerText', 'MATP - Medical Assistance Transportation Program') else null end,

case when q26B is not null then 
object_construct('outputField', 'utilizeSnap', 
'outputFieldValue', utilizeSnap, 
'questionNbr', 'q26B', 
'questionText', 'Do you utilize any of these resources?  Please mark all that apply.', 
'answerNbr', q26B, 
'answerText', 'SNAP - Supplemental Nutrition Assistance Program') else null end,

case when q26C is not null then 
object_construct('outputField', 'utilizeLiheap', 
'outputFieldValue', utilizeLiheap, 
'questionNbr', 'q26C', 
'questionText', 'Do you utilize any of these resources?  Please mark all that apply.', 
'answerNbr', q26C, 
'answerText', 'LiHEAP - Low Income Home Energy Assistance Program') else null end,

case when q26D is not null then 
object_construct('outputField', 'utilizeLtss', 
'outputFieldValue', utilizeLtss, 
'questionNbr', 'q26D', 
'questionText', 'Do you utilize any of these resources?  Please mark all that apply.', 
'answerNbr', q26D, 
'answerText', 'LTSS - Long-term Services and Supports: Personal Care at Home or Nursing Facility Care') else null end,

case when q26E is not null then 
object_construct('outputField', 'utilizeNoResources', 
'outputFieldValue', utilizeNoResources, 
'questionNbr', 'q26E', 
'questionText', 'Do you utilize any of these resources?  Please mark all that apply.', 
'answerNbr', q26E, 
'answerText', 'None of these') else null end,

case when q27 is not null then 
object_construct('outputField', 'worriedFoodWouldRunOut', 
'outputFieldValue', worriedFoodWouldRunOut, 
'questionNbr', 'q27', 
'questionText', 'Within the past 12 months, you worried that your food would run out before you got money to buy more.', 
'answerNbr', q27, 
'answerText', worriedFoodWouldRunOut) else null end,


case when q28 is not null then 
object_construct('outputField', 'foodBoughtDidntLast', 
'outputFieldValue', foodBoughtDidntLast, 
'questionNbr', 'q28', 
'questionText', 'Within the past 12 months, the food you bought just didn’t last and you didn’t have money to get more.', 
'answerNbr', q28, 
'answerText', foodBoughtDidntLast) else null end,


case when q29 is not null then 
object_construct('outputField', 'lackOfReliableTransportation', 
'outputFieldValue', lackOfReliableTransportation, 
'questionNbr', 'q29', 
'questionText', 'In the past 12 months, has lack of reliable transportation kept you from medical appointments, meetings, work or from getting things needed for daily living?', 
'answerNbr', q29, 
'answerText', lackOfReliableTransportation) else null end,

case when q30 is not null then 
object_construct('outputField', 'selfSpouseMilitary', 
'outputFieldValue', selfSpouseMilitary, 
'questionNbr', 'q30', 
'questionText', 'Have you or a spouse ever served in the military?', 
'answerNbr', q30, 
'answerText', selfSpouseMilitary) else null end,


case when q31 is not null then 
object_construct('outputField', 'advanceDirective', 
'outputFieldValue', advanceDirective, 
'questionNbr', 'q31', 
'questionText', 'An advance directive (also called a living will) tells others how you want to be cared for if you are unable to make your own choices about health care in the future.  Do you have an advance directive?', 
'answerNbr', q31, 
'answerText', advanceDirective) else null end,


case when q32 is not null then 
object_construct('outputField', 'personalRepresentative', 
'outputFieldValue', personalRepresentative, 
'questionNbr', 'q32', 
'questionText', 'A personal representative can speak on your behalf with the health plan about your private health information and benefit coverage.  Have you provided us with a personal representative?', 
'answerNbr', q32, 
'answerText', personalRepresentative) else null end)    
      )))) AS JSON_DATA
from HRA.HELIOS_TRANS_SELECT_VW);