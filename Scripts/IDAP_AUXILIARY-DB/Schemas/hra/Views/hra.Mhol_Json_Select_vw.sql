create or replace view HRA.MHOL_JSON_SELECT_VW
(
	MEMBER_NBR,
	COMPLETION_DATETIME,
	INSERT_DATETIME,
	MHOL_JSON_SELECT_VW_KEY,
	JSON_DATA
) COMMENT = 'This View converts the Transformed View into JSON Data' 
as ( select
MEMBERID,  COMPLETIONDATE,INSERTDATE,concat(MEMBERID,COMPLETIONDATE) as MHOL_JSON_SELECT_VW_KEY,
object_construct('envelope',object_construct('instance',object_construct('HRA',object_construct('dataSourceName', dataSourceName,
    'memberId',memberId,
	'completionDate', completionDate, 'lob', lob, 'insertDate',insertDate,'answerheader_id',answerheader_id , 'assessmentId', assessmentId, 'q01', q01,  'primaryLanguage',primaryLanguage, 'q02', q02,  'healthComparedToOthersYourAge', healthComparedToOthersYourAge, 'q03', q03,
    'healthMouthTeeth',healthMouthTeeth, 'q04', q04, 'fluShotPastYear',fluShotPastYear, 'q05',q05, 'averagePrescriptionsPerDay',averagePrescriptionsPerDay,
    'q06A',q06A,  'dontTakeAnyMeds',dontTakeAnyMeds,  'q06B', q06B,  'doTakeMedsAsPrescribed',doTakeMedsAsPrescribed,'q06C', q06C,  'dontTakeMedsAsPrescribed',dontTakeMedsAsPrescribed,  'q06D',q06D,
    'troublePayingForMeds',troublePayingForMeds,  'q06E', q06E,  'troubleGettingMeds',troubleGettingMeds, 'q06F',q06F, 'troubleRememberingMeds',troubleRememberingMeds,
    'q06G',q06G, 'understandingWhyHowPrescribed',understandingWhyHowPrescribed, 'q06H',q06H,'dontKnowIfTakingAsPrescribed',dontKnowIfTakingAsPrescribed, 'q07',q07,
    'hospitalAdmissionsPastYear',hospitalAdmissionsPastYear, 'q08',q08, 'emergencyVisitsPastYear',emergencyVisitsPastYear, 'q09A',q09A,
    'informedHighBloodPressure',informedHighBloodPressure, 'q09B',q09B, 'informedAsthma',informedAsthma, 'q09C',q09C, 'informedDiabetes',informedDiabetes,
    'q09D',q09D, 'informedSickleCell',informedSickleCell,'q09E',q09E, 
     'informedDepression',informedDepression, 'q09F',q09F, 'informedHighCholesterol',informedHighCholesterol, 'q09G',q09G, 
     'informedCopdOrEmphysema',informedCopdOrEmphysema,  'q09H',q09H, 'informedKidneyFailure',informedKidneyFailure, 'q09I',q09I,
    'informedCancer',informedCancer, 'q09J',q09J, 'informedAdhd',informedAdhd, 'q09K',q09K, 'informedAnxiety',informedAnxiety, 'q09L',q09L,
    'informedHeartDiseaseOrChf',informedHeartDiseaseOrChf, 'q09M',q09M,'informedStroke',informedStroke, 'q09N',q09N, 'informedDialysis',informedDialysis,
    'q09O',q09O, 'informedBackPain',informedBackPain, 'q09P',q09P, 'informedIntellectualDisability',informedIntellectualDisability, 'q09Q',q09Q,
    'informedSubstanceUse',informedSubstanceUse, 'q09R',q09R, 'informedOther',informedOther, 'q09S',q09S, 'informedNone',informedNone, 'q10',q10,
    'pastTwoWeeksLittleInterest',pastTwoWeeksLittleInterest,  'q11',q11, 'pastTwoWeeksDepressedHopeless',pastTwoWeeksDepressedHopeless, 'q12',q12,
    'feelLonely',feelLonely,  'q13A',q13A, 'concernedWeightTooHigh',concernedWeightTooHigh, 'q13B',q13B, 'dontEatHealthy',dontEatHealthy, 'q13C',q13C,
    'smokeOrUseTobacco',smokeOrUseTobacco,'q13D',q13D, 'drinkTooMuchAlcohol',drinkTooMuchAlcohol, 'q13E',q13E, 'nonPrescribedDrugUse',nonPrescribedDrugUse,
    'q13F',q13F, 'concernedWeightTooLow',concernedWeightTooLow, 'q13G',q13G, 'lowPhysicalActivity',lowPhysicalActivity, 'q13H',q13H, 
    'troubleHandlingStress',troubleHandlingStress, 'q13I',q13I, 'noneApply',noneApply, 'q14A',q14A, 'troubleHearing',troubleHearing, 'q14B',q14B,
    'troubleReading',troubleReading, 'q14C',q14C,'troubleSeeing',troubleSeeing, 'q14D',q14D, 'troubleSpeaking',troubleSpeaking,  'q14E',q14E,
    'communicationNone',communicationNone,  'q15A',q15A, 'forgetRecentlyLearned',forgetRecentlyLearned, 'q15B',q15B, 'multipleOrNotes',multipleOrNotes,
    'q15C',q15C, 'troubleInstructions',troubleInstructions, 'q15D',q15D, 'confusedDistractedConversations',confusedDistractedConversations, 'q15E',q15E,
    'forgetWordsDatesEvents',forgetWordsDatesEvents, 'q15F',q15F, 'misplaceThings',misplaceThings, 'q15G',q15G, 'othersSayForgetful',othersSayForgetful,
    'q15H',q15H, 'forgetNone',forgetNone, 'q16',q16, 'livingSituation',livingSituation,  'q17',q17,  'liveWith',liveWith, 'q18',q18, 
    'primaryCaregiver',primaryCaregiver, 'q19',q19, 'needAssistEverydayLiving',needAssistEverydayLiving,  'q20',q20,  
    'needAssistPersonalHygiene',needAssistPersonalHygiene,  'q21A',q21A, 'supportFromSpouseSignificant',supportFromSpouseSignificant,  'q21B',q21B,
    'supportFromAgencyCaregivers',supportFromAgencyCaregivers,  'q21C',q21C, 'supportFromOtherFamilyMembers',supportFromOtherFamilyMembers, 'q21D',q21D,
    'supportFromFacilityStaff',supportFromFacilityStaff, 'q21E',q21E, 'supportFromFriendsNonFamily',supportFromFriendsNonFamily,  'q21F',q21F,
    'dontNeedHelpSupport',dontNeedHelpSupport,  'q22',q22, 'reliableHelpSupport',reliableHelpSupport, 'q23A',q23A, 'useCane',useCane, 'q23B',q23B,
    'useProsthetic',useProsthetic, 'q23C',q23C, 'useNebulizer',useNebulizer, 'q23D',q23D, 'useWalker',useWalker  ,'q23E',q23E,'useHospitalBed',useHospitalBed
    ,'q23F',q23F,'useOxygen',useOxygen ,'q23G',q23G,'useWheelchair',useWheelchair,'q23H',q23H ,'useHoyerLift',useHoyerLift ,'q23I',q23I ,'useCpapBipap',useCpapBipap
    ,'q23J',q23J  ,'useMotorizedScooter',useMotorizedScooter ,'q23K',q23K ,'useGlucometer',useGlucometer,'q23L',q23L ,'useVentilator',useVentilator ,'q23M',q23M
    ,'useOtherDevices',useOtherDevices ,'q23N',q23N ,'useNoDevices',useNoDevices, 'q24',q24, 'fallen2OrMorePast3Months',fallen2OrMorePast3Months, 'q25A',q25A,
    'utilizeMatp',utilizeMatp, 'q25B',q25B, 'utilizeSnap',utilizeSnap, 'q25C',q25C, 'utilizeLiheap',utilizeLiheap, 'q25D',q25D, 'utilizeLtss',utilizeLtss,'q25E',q25E, 'utilizeNoResources',utilizeNoResources, 'q26',q26,'foodRunOut12Month',foodRunOut12Month, 'q27',q27,
    'foodBought12Month',foodBought12Month, 'q28',q28,'reliableTransport12Month',reliableTransport12Month,'q29',q29,
'selfSpouseMilitary',selfSpouseMilitary,  'q31',q31 ,'advanceDirective',advanceDirective, 'q32',q32 ,
    'personalRepresentative',personalRepresentative, 'q33',q33,'otherLanguage',otherLanguage,
'responses',ARRAY_CONSTRUCT_COMPACT(

case when q01 is not null then
object_construct('outputField', 'primaryLanguage', 
'outputFieldValue', primaryLanguage, 
'questionNbr', 'q01', 
'questionText', 'What is your primary language?', 
'answerNbr', q01, 
'answerText', primaryLanguage) else null end,

case when q02 is not null then
object_construct('outputField', 'healthComparedToOthersYourAge', 
'outputFieldValue', healthComparedToOthersYourAge, 
'questionNbr', 'q02', 
'questionText', 'Compared to other people your age, would you say that your health is?', 
'answerNbr', q02, 
'answerText', healthComparedToOthersYourAge) else null end,

case when q03 is not null then
object_construct('outputField', 'healthMouthTeeth', 
'outputFieldValue', healthMouthTeeth, 
'questionNbr', 'q03', 
'questionText', 'How would you describe the health of your mouth and teeth?', 
'answerNbr', q03, 
'answerText', healthMouthTeeth) else null end,

case when q04 is not null then
object_construct('outputField', 'fluShotPastYear', 
'outputFieldValue', fluShotPastYear, 
'questionNbr', 'q04', 
'questionText', 'Have you had a flu shot in the last year?', 
'answerNbr', q04, 
'answerText', fluShotPastYear) else null end,

case when q05 is not null then
object_construct('outputField', 'averagePrescriptionsPerDay', 
'outputFieldValue', averagePrescriptionsPerDay, 
'questionNbr', 'q05', 
'questionText', 'How many different prescription medications do you take on an average day?', 
'answerNbr', q05, 
'answerText', averagePrescriptionsPerDay) else null end,

case when q06A is not null then
object_construct('outputField', 'dontTakeMedsAsPrescribed', 
'outputFieldValue', dontTakeMedsAsPrescribed, 
'questionNbr', 'q06A', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q06A, 
'answerText', 'I don\'t take any medications') else null end,

case when q06B is not null then 
object_construct('outputField', 'doTakeMedsAsPrescribed', 
'outputFieldValue', doTakeMedsAsPrescribed, 
'questionNbr', 'q06B', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q06B, 
'answerText', 'I do take all my medications as prescribed') else null end,

case when q06C is not null then 
object_construct('outputField', 'dontTakeMedsAsPrescribed', 
'outputFieldValue', dontTakeMedsAsPrescribed, 
'questionNbr', 'q06C', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q06C, 
'answerText', 'I don\'t take all my medications as prescribed') else null end,

case when q06D is not null then 
object_construct('outputField', 'troublePayingForMeds', 
'outputFieldValue', troublePayingForMeds, 
'questionNbr', 'q06D', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q06D, 
'answerText', 'I have trouble paying for my medications') else null end,

case when q06E is not null then 
object_construct('outputField', 'troubleGettingMeds', 
'outputFieldValue', troubleGettingMeds, 
'questionNbr', 'q06E', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q06E, 
'answerText', 'I have trouble getting my medications') else null end,

case when q06F is not null then 
object_construct('outputField', 'troubleRememberingMeds', 
'outputFieldValue', troubleRememberingMeds, 
'questionNbr', 'q06F', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q06F, 
'answerText', 'I have trouble remembering to take my medications') else null end,

case when q06G is not null then 
object_construct('outputField', 'understandingWhyHowPrescribed', 
'outputFieldValue', understandingWhyHowPrescribed, 
'questionNbr', 'q06G', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q06G, 
'answerText', 'I have trouble understanding how and/or why to take my medications the correct way') else null end,

case when q06H is not null then 
object_construct('outputField', 'dontKnowIfTakingAsPrescribed', 
'outputFieldValue', dontKnowIfTakingAsPrescribed, 
'questionNbr', 'q06H', 
'questionText', 'Do you take all your medications as prescribed?', 
'answerNbr', q06H, 
'answerText', 'I don\'t know if I am taking my medications as prescribed') else null end,


case when q07 is not null then 
object_construct('outputField', 'hospitalAdmissionsPastYear', 
'outputFieldValue', hospitalAdmissionsPastYear, 
'questionNbr', 'q07', 
'questionText', 'In the past year, how many times were you admitted to the hospital?', 
'answerNbr', q07, 
'answerText', hospitalAdmissionsPastYear) else null end,


case when q08 is not null then 
object_construct('outputField', 'emergencyVisitsPastYear', 
'outputFieldValue', emergencyVisitsPastYear, 
'questionNbr', 'q08', 
'questionText', 'In the past year, how many times did you visit the emergency room for your own needs?', 
'answerNbr', q08, 
'answerText', emergencyVisitsPastYear) else null end,


case when q09A is not null then 
object_construct('outputField', 'informedHighBloodPressure', 
'outputFieldValue', informedHighBloodPressure, 
'questionNbr', 'q09A', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09A, 
'answerText', 'High Blood Pressure') else null end,


case when q09B is not null then 
object_construct('outputField', 'informedAsthma', 
'outputFieldValue', informedAsthma, 
'questionNbr', 'q09B', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09B, 
'answerText', 'Asthma') else null end,


case when q09C is not null then 
object_construct('outputField', 'informedDiabetes', 
'outputFieldValue', informedDiabetes, 
'questionNbr', 'q09C', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09C, 
'answerText', 'Diabetes') else null end,


case when q09D is not null then 
object_construct('outputField', 'informedSickleCell', 
'outputFieldValue', informedSickleCell, 
'questionNbr', 'q09D', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09D, 
'answerText', 'Sickle Cell') else null end,


case when q09E is not null then 
object_construct('outputField', 'informedDepression', 
'outputFieldValue', informedDepression, 
'questionNbr', 'q09E', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09E, 
'answerText', 'Depression') else null end,


case when q09F is not null then 
object_construct('outputField', 'informedHighCholesterol', 
'outputFieldValue', informedHighCholesterol, 
'questionNbr', 'q09F', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09F, 
'answerText', 'High Cholesterol') else null end,

case when q09G is not null then 
object_construct('outputField', 'informedCopdOrEmphysema', 
'outputFieldValue', informedCopdOrEmphysema, 
'questionNbr', 'q09G', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09G, 
'answerText', 'COPD or Emphysema') else null end,


case when q09H is not null then 
object_construct('outputField', 'informedKidneyFailure', 
'outputFieldValue', informedKidneyFailure, 
'questionNbr', 'q09H', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09H, 
'answerText', 'Kidney Failure') else null end,

case when q09I is not null then 
object_construct('outputField', 'informedCancer', 
'outputFieldValue', informedCancer, 
'questionNbr', 'q09I', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09I, 
'answerText', 'Cancer') else null end,

case when q09J is not null then 
object_construct('outputField', 'informedAdhd', 
'outputFieldValue', informedAdhd, 
'questionNbr', 'q09J', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09J, 
'answerText', 'ADHD') else null end,

case when q09K is not null then 
object_construct('outputField', 'informedAnxiety', 
'outputFieldValue', informedAnxiety, 
'questionNbr', 'q09K', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09K, 
'answerText', 'Anxiety') else null end,

case when q09L is not null then 
object_construct('outputField', 'informedHeartDiseaseOrChf', 
'outputFieldValue', informedHeartDiseaseOrChf, 
'questionNbr', 'q09L', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09L, 
'answerText', 'Heart Failure/Heart Disease or CHF') else null end,

case when q09M is not null then 
object_construct('outputField', 'informedStroke', 
'outputFieldValue', informedStroke, 
'questionNbr', 'q09M', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09M, 
'answerText', 'Stroke') else null end,

case when q09N is not null then 
object_construct('outputField', 'informedDialysis', 
'outputFieldValue', informedDialysis, 
'questionNbr', 'q09N', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09N, 
'answerText', 'Dialysis') else null end,

case when q09O is not null then 
object_construct('outputField', 'informedBackPain', 
'outputFieldValue', informedBackPain, 
'questionNbr', 'q09O', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09O, 
'answerText', 'Back Pain') else null end,

case when q09P is not null then 
object_construct('outputField', 'informedIntellectualDisability', 
'outputFieldValue', informedIntellectualDisability, 
'questionNbr', 'q09P', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09P, 
'answerText', 'Intellectual Disability') else null end,

case when q09Q is not null then 
object_construct('outputField', 'informedSubstanceUse', 
'outputFieldValue', informedSubstanceUse, 
'questionNbr', 'q09Q', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09Q, 
'answerText', 'Substance Abuse Disorder') else null end,

case when q09R is not null then 
object_construct('outputField', 'informedOther', 
'outputFieldValue', informedOther, 
'questionNbr', 'q09R', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09R, 
'answerText', 'Other') else null end,

case when q09S is not null then 
object_construct('outputField', 'informedNone', 
'outputFieldValue', informedNone, 
'questionNbr', 'q09S', 
'questionText', 'Have you ever been told that you have any of the following?  Please mark all that apply.', 
'answerNbr', q09S, 
'answerText', 'None of these') else null end,

case when q10 is not null then 
object_construct('outputField', 'pastTwoWeeksLittleInterest', 
'outputFieldValue', pastTwoWeeksLittleInterest, 
'questionNbr', 'q10', 
'questionText', 'Over the past two weeks, have you been bothered by little interest or pleasure in doing things several days or more?', 
'answerNbr', q10, 
'answerText', pastTwoWeeksLittleInterest) else null end,

case when q11 is not null then 
object_construct('outputField', 'pastTwoWeeksDepressedHopeless', 
'outputFieldValue', pastTwoWeeksDepressedHopeless, 
'questionNbr', 'q11', 
'questionText', 'Over the past two weeks, have you been bothered by feeling down, depressed, or hopeless several days or more?', 
'answerNbr', q11, 
'answerText', pastTwoWeeksDepressedHopeless) else null end,

case when q12 is not null then 
object_construct('outputField', 'feelLonely', 
'outputFieldValue', feelLonely, 
'questionNbr', 'q12', 
'questionText', 'How often do you feel lonely?', 
'answerNbr', q12, 
'answerText', feelLonely) else null end,

case when q13A is not null then 
object_construct('outputField', 'concernedWeightTooHigh', 
'outputFieldValue', concernedWeightTooHigh, 
'questionNbr', 'q13A', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q13A, 
'answerText', 'I feel my weight is too high') else null end,

case when q13B is not null then 
object_construct('outputField', 'dontEatHealthy', 
'outputFieldValue', dontEatHealthy, 
'questionNbr', 'q13B', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q13B, 
'answerText', 'I don\'t eat a healthy diet') else null end,

case when q13C is not null then 
object_construct('outputField', 'smokeOrUseTobacco', 
'outputFieldValue', smokeOrUseTobacco, 
'questionNbr', 'q13C', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q13C, 
'answerText', 'I smoke or use tobacco') else null end,

case when q13D is not null then 
object_construct('outputField', 'drinkTooMuchAlcohol', 
'outputFieldValue', drinkTooMuchAlcohol, 
'questionNbr', 'q13D', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q13D, 
'answerText', 'I drink too much alcohol') else null end,

case when q13E is not null then 
object_construct('outputField', 'nonPrescribedDrugUse', 
'outputFieldValue', nonPrescribedDrugUse, 
'questionNbr', 'q13E', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q13E, 
'answerText', 'I use drugs or medications not ordered for me') else null end,

case when q13F is not null then 
object_construct('outputField', 'concernedWeightTooLow', 
'outputFieldValue', concernedWeightTooLow, 
'questionNbr', 'q13F', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q13F, 
'answerText', 'I feel my weight is too low') else null end,

case when q13G is not null then 
object_construct('outputField', 'lowPhysicalActivity', 
'outputFieldValue', lowPhysicalActivity, 
'questionNbr', 'q13G', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q13G, 
'answerText', 'I don\'t get enough physical activity') else null end,

case when q13H is not null then 
object_construct('outputField', 'troubleHandlingStress', 
'outputFieldValue', troubleHandlingStress, 
'questionNbr', 'q13H', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q13H, 
'answerText', 'I have trouble handling my stress') else null end,

case when q13I is not null then 
object_construct('outputField', 'noneApply', 
'outputFieldValue', noneApply, 
'questionNbr', 'q13I', 
'questionText', 'Do any of the following apply to you?  Please mark all that apply.', 
'answerNbr', q13I, 
'answerText', 'None of these') else null end,

case when q14A is not null then 
object_construct('outputField', 'troubleHearing', 
'outputFieldValue', troubleHearing, 
'questionNbr', 'q14A', 
'questionText', 'Do any of the following make it hard to communicate?  Please mark all that apply.', 
'answerNbr', q14A, 
'answerText', 'I have trouble hearing') else null end,

case when q14B is not null then 
object_construct('outputField', 'troubleReading', 
'outputFieldValue', troubleReading, 
'questionNbr', 'q14B', 
'questionText', 'Do any of the following make it hard to communicate?  Please mark all that apply.', 
'answerNbr', q14B, 
'answerText', 'I have trouble reading') else null end,

case when q14C is not null then 
object_construct('outputField', 'troubleSeeing', 
'outputFieldValue', troubleSeeing, 
'questionNbr', 'q14C', 
'questionText', 'Do any of the following make it hard to communicate?  Please mark all that apply.', 
'answerNbr', q14C, 
'answerText', 'I have trouble seeing') else null end,

case when q14D is not null then 
object_construct('outputField', 'troubleSpeaking', 
'outputFieldValue', troubleSpeaking, 
'questionNbr', 'q14D', 
'questionText', 'Do any of the following make it hard to communicate?  Please mark all that apply.', 
'answerNbr', q14D, 
'answerText', 'I have trouble speaking') else null end,

case when q14E is not null then 
object_construct('outputField', 'communicationNone', 
'outputFieldValue', communicationNone, 
'questionNbr', 'q14E', 
'questionText', 'Do any of the following make it hard to communicate?  Please mark all that apply.', 
'answerNbr', q14E, 
'answerText', 'None of these') else null end,

case when q15A is not null then 
object_construct('outputField', 'forgetRecentlyLearned', 
'outputFieldValue', forgetRecentlyLearned, 
'questionNbr', 'q15A', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q15A, 
'answerText', 'I forget information recently learned') else null end,

case when q15B is not null then 
object_construct('outputField', 'multipleOrNotes', 
'outputFieldValue', multipleOrNotes, 
'questionNbr', 'q15B', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q15B, 
'answerText', 'I ask for the same information multiple times or need reminder notes') else null end,

case when q15C is not null then 
object_construct('outputField', 'troubleInstructions', 
'outputFieldValue', troubleInstructions, 
'questionNbr', 'q15C', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q15C, 
'answerText', 'I have trouble following instructions') else null end,

case when q15D is not null then 
object_construct('outputField', 'confusedDistractedConversations', 
'outputFieldValue', confusedDistractedConversations, 
'questionNbr', 'q15D', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q15D, 
'answerText', 'I become confused or distracted in the middle of a conversation') else null end,

case when q15E is not null then 
object_construct('outputField', 'forgetWordsDatesEvents', 
'outputFieldValue', forgetWordsDatesEvents, 
'questionNbr', 'q15E', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q15E, 
'answerText', 'I struggle to remember words, dates, or events') else null end,

case when q15F is not null then 
object_construct('outputField', 'misplaceThings', 
'outputFieldValue', misplaceThings, 
'questionNbr', 'q15F', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q15F, 
'answerText', 'I lose or misplace things') else null end,

case when q15G is not null then 
object_construct('outputField', 'othersSayForgetful', 
'outputFieldValue', othersSayForgetful, 
'questionNbr', 'q15G', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q15G, 
'answerText', 'My family/friends say I am forgetful') else null end,

case when q15H is not null then 
object_construct('outputField', 'forgetNone', 
'outputFieldValue', forgetNone, 
'questionNbr', 'q15H', 
'questionText', 'Do you experience any of the following?  Please mark all that apply.', 
'answerNbr', q15H, 
'answerText', 'None of these') else null end,

case when q16 is not null then 
object_construct('outputField', 'livingSituation', 
'outputFieldValue', livingSituation, 
'questionNbr', 'q16', 
'questionText', 'What is your living situation today?', 
'answerNbr', q16, 
'answerText', livingSituation) else null end,

case when q17 is not null then 
object_construct('outputField', 'liveWith', 
'outputFieldValue', liveWith, 
'questionNbr', 'q17', 
'questionText', 'Who do you live with?', 
'answerNbr', q17, 
'answerText', liveWith) else null end,

case when q18 is not null then 
object_construct('outputField', 'primaryCaregiver', 
'outputFieldValue', primaryCaregiver, 
'questionNbr', 'q18', 
'questionText', 'Are you the primary caregiver for someone else?', 
'answerNbr', q18, 
'answerText', primaryCaregiver) else null end,

case when q19 is not null then 
object_construct('outputField', 'needAssistEverydayLiving', 
'outputFieldValue', needAssistEverydayLiving, 
'questionNbr', 'q19', 
'questionText', 'Do you receive or need assistance from another person for tasks like taking medications, meal preparation, housekeeping, laundry, telephone, shopping, or managing finances?', 
'answerNbr', q19, 
'answerText', needAssistEverydayLiving) else null end,

case when q20 is not null then 
object_construct('outputField', 'needAssistPersonalHygiene', 
'outputFieldValue', needAssistPersonalHygiene, 
'questionNbr', 'q20', 
'questionText', 'Do you receive or do you need assistance from another person for bathing, dressing, toileting, bowel and bladder function, or eating?', 
'answerNbr', q20, 
'answerText', needAssistPersonalHygiene) else null end,

case when q21A is not null then 
object_construct('outputField', 'supportFromSpouseSignificant', 
'outputFieldValue', supportFromSpouseSignificant, 
'questionNbr', 'q21A', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q21A, 
'answerText', 'Spouse/Significant other') else null end,

case when q21B is not null then 
object_construct('outputField', 'supportFromAgencyCaregivers', 
'outputFieldValue', supportFromAgencyCaregivers, 
'questionNbr', 'q21B', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q21B, 
'answerText', 'Caregivers from an agency') else null end,

case when q21C is not null then 
object_construct('outputField', 'supportFromOtherFamilyMembers', 
'outputFieldValue', supportFromOtherFamilyMembers, 
'questionNbr', 'q21C', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q21C, 
'answerText', 'Other family member(s)') else null end,

case when q21D is not null then 
object_construct('outputField', 'supportFromFacilityStaff', 
'outputFieldValue', supportFromFacilityStaff, 
'questionNbr', 'q21D', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q21D, 
'answerText', 'Staff in facility') else null end,

case when q21E is not null then 
object_construct('outputField', 'supportFromFriendsNonFamily', 
'outputFieldValue', supportFromFriendsNonFamily, 
'questionNbr', 'q21E', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q21E, 
'answerText', 'Friends or non-relative(s)') else null end,

case when q21F is not null then 
object_construct('outputField', 'dontNeedHelpSupport', 
'outputFieldValue', dontNeedHelpSupport, 
'questionNbr', 'q21F', 
'questionText', 'Who helps and supports you with completing daily tasks?  Please mark all that apply.', 
'answerNbr', q21F, 
'answerText', 'I don\'t need help and support') else null end,

case when q22 is not null then 
object_construct('outputField', 'reliableHelpSupport', 
'outputFieldValue', reliableHelpSupport, 
'questionNbr', 'q22', 
'questionText', 'If you are receiving help from others, is the help and support reliable?', 
'answerNbr', q22, 
'answerText', reliableHelpSupport) else null end,

case when q23A is not null then 
object_construct('outputField', 'useCane', 
'outputFieldValue', useCane, 
'questionNbr', 'q23A', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23A, 
'answerText', 'Cane') else null end,

case when q23B is not null then 
object_construct('outputField', 'useProsthetic', 
'outputFieldValue', useProsthetic, 
'questionNbr', 'q23B', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23B, 
'answerText', 'Prosthetic') else null end,

case when q23C is not null then 
object_construct('outputField', 'useNebulizer', 
'outputFieldValue', useNebulizer, 
'questionNbr', 'q23C', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23C, 
'answerText', 'Nebulizer') else null end,

case when q23D is not null then 
object_construct('outputField', 'useWalker', 
'outputFieldValue', useWalker, 
'questionNbr', 'q23D', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23D, 
'answerText', 'Walker') else null end,

case when q23E is not null then 
object_construct('outputField', 'useHospitalBed', 
'outputFieldValue', useHospitalBed, 
'questionNbr', 'q23E', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23E, 
'answerText', 'Hospital bed') else null end,

case when q23F is not null then 
object_construct('outputField', 'useOxygen', 
'outputFieldValue', useOxygen, 
'questionNbr', 'q23F', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23F, 
'answerText', 'Oxygen') else null end,

case when q23G is not null then 
object_construct('outputField', 'useWheelchair', 
'outputFieldValue', useWheelchair, 
'questionNbr', 'q23G', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23G, 
'answerText', 'Wheelchair') else null end,

case when q23H is not null then 
object_construct('outputField', 'useHoyerLift', 
'outputFieldValue', useHoyerLift, 
'questionNbr', 'q23H', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23H, 
'answerText', 'Hoyer lift') else null end,

case when q23I is not null then 
object_construct('outputField', 'useCpapBipap', 
'outputFieldValue', useCpapBipap, 
'questionNbr', 'q23I', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23I, 
'answerText', 'CPAP or BiPAP') else null end,

case when q23J is not null then 
object_construct('outputField', 'useMotorizedScooter', 
'outputFieldValue', useMotorizedScooter, 
'questionNbr', 'q23J', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23J, 
'answerText', 'Motorized scooter') else null end,

case when q23K is not null then 
object_construct('outputField', 'useGlucometer', 
'outputFieldValue', useGlucometer, 
'questionNbr', 'q23K', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23K, 
'answerText', 'Glucometer') else null end,

case when q23L is not null then 
object_construct('outputField', 'useVentilator', 
'outputFieldValue', useVentilator, 
'questionNbr', 'q23L', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23L, 
'answerText', 'Ventilator') else null end,

case when q23M is not null then 
object_construct('outputField', 'useOtherDevices', 
'outputFieldValue', useOtherDevices, 
'questionNbr', 'q23M', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23M, 
'answerText', 'Other(s)') else null end,

case when q23N is not null then 
object_construct('outputField', 'useNoDevices', 
'outputFieldValue', useNoDevices, 
'questionNbr', 'q23N', 
'questionText', 'Do you have assistive devices or other equipment to manage daily living?  Please mark all that apply.', 
'answerNbr', q23N, 
'answerText', 'None of these') else null end,

case when q24 is not null then 
object_construct('outputField', 'fallen2OrMorePast3Months', 
'outputFieldValue', fallen2OrMorePast3Months, 
'questionNbr', 'q24', 
'questionText', 'Have you fallen 2 or more times in the last 3 months?', 
'answerNbr', q24, 
'answerText', fallen2OrMorePast3Months) else null end,

case when q25A is not null then 
object_construct('outputField', 'utilizeMatp', 
'outputFieldValue', utilizeMatp, 
'questionNbr', 'q25A', 
'questionText', 'Do you utilize any of these resources?  Please mark all that apply.', 
'answerNbr', q25A, 
'answerText', 'MATP - Medical Assistance Transportation Program') else null end,

case when q25B is not null then 
object_construct('outputField', 'utilizeSnap', 
'outputFieldValue', utilizeSnap, 
'questionNbr', 'q25B', 
'questionText', 'Do you utilize any of these resources?  Please mark all that apply.', 
'answerNbr', q25B, 
'answerText', 'SNAP - Supplemental Nutrition Assistance Program') else null end,

case when q25C is not null then 
object_construct('outputField', 'utilizeLiheap', 
'outputFieldValue', utilizeLiheap, 
'questionNbr', 'q25C', 
'questionText', 'Do you utilize any of these resources?  Please mark all that apply.', 
'answerNbr', q25C, 
'answerText', 'LiHEAP - Low Income Home Energy Assistance Program') else null end,

case when q25D is not null then 
object_construct('outputField', 'utilizeLtss', 
'outputFieldValue', utilizeLtss, 
'questionNbr', 'q25D', 
'questionText', 'Do you utilize any of these resources?  Please mark all that apply.', 
'answerNbr', q25D, 
'answerText', 'LTSS - Long-term Services and Supports: Personal Care at Home or Nursing Facility Care') else null end,

case when q25E is not null then 
object_construct('outputField', 'utilizeNoResources', 
'outputFieldValue', utilizeNoResources, 
'questionNbr', 'q25E', 
'questionText', 'Do you utilize any of these resources?  Please mark all that apply.', 
'answerNbr', q25E, 
'answerText', 'None of these') else null end,

case when q26 is not null then 
object_construct('outputField', 'foodRunOut12Month', 
'outputFieldValue', foodRunOut12Month, 
'questionNbr', 'q26', 
'questionText', 'Within the past 12 months, you worried that your food would run out before you got money to buy more.', 
'answerNbr', q26, 
'answerText',foodRunOut12Month) else null end,


case when q27 is not null then 
object_construct('outputField', 'foodBought12Month', 
'outputFieldValue', foodBought12Month, 
'questionNbr', 'q27', 
'questionText', 'Within the past 12 months, the food you bought just didn’t last and you didn’t have money to get more.', 
'answerNbr', q27, 
'answerText',foodBought12Month) else null end,


case when q28 is not null then 
object_construct('outputField', 'reliableTransport12Month', 
'outputFieldValue', reliableTransport12Month, 
'questionNbr', 'q28', 
'questionText', 'In the past 12 months, has lack of reliable transportation kept you from medical appointments, meetings, work or from getting things needed for daily living?', 
'answerNbr', q28, 
'answerText',reliableTransport12Month) else null end,


case when q29 is not null then 
object_construct('outputField', 'selfSpouseMilitary', 
'outputFieldValue', selfSpouseMilitary, 
'questionNbr', 'q29', 
'questionText', 'Have you or a spouse ever served in the military?', 
'answerNbr', q29, 
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
'answerText', personalRepresentative) else null end,

case when q33 is not null then 
object_construct('outputField', 'otherLanguage', 
'outputFieldValue', otherLanguage, 
'questionNbr', 'q33', 
'questionText', 'Please specify your primary Language?', 
'answerNbr', q33, 
'answerText', otherLanguage) else null end)

 )))) AS JSON_DATA
    FROM HRA.MHOL_TRANS_SELECT_VW);

