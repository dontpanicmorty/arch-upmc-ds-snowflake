!set variable_substitution=true;
create or replace view HRA.MHOL_FLATTEN_SELECT_VW
(
	ANSWERHEADER_ID,
	MEMBERBEINGASSESSED,
	ASSESSMENT_ID,
	ASSESSMENT_STATUS,
	COMPLETIONDATE,
	Q01,
	Q02,
	Q03,
	Q04,
	Q05,
	Q06A,
	Q06B,
	Q06C,
	Q06D,
	Q06E,
	Q06F,
	Q06G,
	Q06H,
	Q07,
	Q08,
	Q09A,
	Q09B,
	Q09C,
	Q09D,
	Q09E,
	Q09F,
	Q09G,
	Q09H,
	Q09I,
	Q09J,
	Q09K,
	Q09L,
	Q09M,
	Q09N,
	Q09O,
	Q09P,
	Q09Q,
	Q09R,
	Q09S,
	Q10,
	Q11,
	Q12,
	Q13A,
	Q13B,
	Q13C,
	Q13D,
	Q13E,
	Q13F,
	Q13G,
	Q13H,
	Q13I,
	Q14A,
	Q14B,
	Q14C,
	Q14D,
	Q14E,
	Q15A,
	Q15B,
	Q15C,
	Q15D,
	Q15E,
	Q15F,
	Q15G,
	Q15H,
	Q16,
	Q17,
	Q18,
	Q19,
	Q20,
	Q21A,
	Q21B,
	Q21C,
	Q21D,
	Q21E,
	Q21F,
	Q22,
	Q23A,
	Q23B,
	Q23C,
	Q23D,
	Q23E,
	Q23F,
	Q23G,
	Q23H,
	Q23I,
	Q23J,
	Q23K,
	Q23L,
	Q23M,
	Q23N,
	Q24,
	Q25A,
	Q25B,
	Q25C,
	Q25D,
	Q25E,
	Q26,
	Q27,
	Q28,
	Q29,
	Q31,
	Q32,
	Q33
) COMMENT = 'This View Flattens the Source View' 
as (SELECT ANSWERHEADER_ID
		 , MEMBERBEINGASSESSED
		 , ASSESSMENT_ID
         , assessment_status
         , COMPLETIONDATE
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q01' THEN answer ELSE NULL END ))) AS q01
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q02' THEN answer ELSE NULL END))) AS q02
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q03' THEN answer ELSE NULL END))) AS q03 
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q04' THEN answer ELSE NULL END))) AS q04
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q05' THEN answer ELSE NULL END ))) AS q05
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q06A' THEN answer ELSE NULL END ))) AS q06A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q06B' THEN answer ELSE NULL END ))) AS q06B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q06C' THEN answer ELSE NULL END ))) AS q06C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q06D' THEN answer ELSE NULL END ))) AS q06D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q06E' THEN answer ELSE NULL END ))) AS q06E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q06F' THEN answer ELSE NULL END ))) AS q06F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q06G' THEN answer ELSE NULL END ))) AS q06G
         , to_varchar(round(MAX( CASE WHEN answer_id = 'q06H' THEN answer ELSE NULL END ))) AS q06H
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q07' THEN answer ELSE NULL END ))) AS q07
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q08' THEN answer ELSE NULL END ))) AS q08
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09A' THEN answer ELSE NULL END ))) AS q09A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09B' THEN answer ELSE NULL END ))) AS q09B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09C' THEN answer ELSE NULL END ))) AS q09C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09D' THEN answer ELSE NULL END ))) AS q09D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09E' THEN answer ELSE NULL END ))) AS q09E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09F' THEN answer ELSE NULL END ))) AS q09F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09G' THEN answer ELSE NULL END ))) AS q09G
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09H' THEN answer ELSE NULL END ))) AS q09H
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09I' THEN answer ELSE NULL END ))) AS q09I
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09J' THEN answer ELSE NULL END ))) AS q09J
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09K' THEN answer ELSE NULL END ))) AS q09K
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09L' THEN answer ELSE NULL END ))) AS q09L
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09M' THEN answer ELSE NULL END ))) AS q09M
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09N' THEN answer ELSE NULL END ))) AS q09N
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09O' THEN answer ELSE NULL END ))) AS q09O
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09P' THEN answer ELSE NULL END ))) AS q09P
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09Q' THEN answer ELSE NULL END ))) AS q09Q
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09R' THEN answer ELSE NULL END ))) AS q09R
	     , to_varchar(round(MAX( CASE WHEN answer_id = 'q09S' THEN answer ELSE NULL END ))) AS q09S
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10' THEN answer ELSE NULL END ))) AS q10
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q11' THEN answer ELSE NULL END ))) AS q11
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q12' THEN answer ELSE NULL END ))) AS q12
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q13A' THEN answer ELSE NULL END ))) AS q13A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q13B' THEN answer ELSE NULL END ))) AS q13B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q13C' THEN answer ELSE NULL END ))) AS q13C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q13D' THEN answer ELSE NULL END ))) AS q13D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q13E' THEN answer ELSE NULL END ))) AS q13E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q13F' THEN answer ELSE NULL END ))) AS q13F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q13G' THEN answer ELSE NULL END ))) AS q13G
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q13H' THEN answer ELSE NULL END ))) AS q13H
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q13I' THEN answer ELSE NULL END ))) AS q13I
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14A' THEN answer ELSE NULL END ))) AS q14A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14B' THEN answer ELSE NULL END ))) AS q14B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14C' THEN answer ELSE NULL END ))) AS q14C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14D' THEN answer ELSE NULL END ))) AS q14D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14E' THEN answer ELSE NULL END ))) AS q14E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15A' THEN answer ELSE NULL END ))) AS q15A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15B' THEN answer ELSE NULL END ))) AS q15B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15C' THEN answer ELSE NULL END ))) AS q15C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15D' THEN answer ELSE NULL END ))) AS q15D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15E' THEN answer ELSE NULL END ))) AS q15E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15F' THEN answer ELSE NULL END ))) AS q15F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15G' THEN answer ELSE NULL END ))) AS q15G
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15H' THEN answer ELSE NULL END ))) AS q15H
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q16' THEN answer ELSE NULL END ))) AS q16
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q17' THEN answer ELSE NULL END ))) AS q17
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q18' THEN answer ELSE NULL END ))) AS q18
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q19' THEN answer ELSE NULL END ))) AS q19
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q20' THEN answer ELSE NULL END ))) AS q20
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q21A' THEN answer ELSE NULL END ))) AS q21A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q21B' THEN answer ELSE NULL END ))) AS q21B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q21C' THEN answer ELSE NULL END ))) AS q21C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q21D' THEN answer ELSE NULL END ))) AS q21D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q21E' THEN answer ELSE NULL END ))) AS q21E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q21F' THEN answer ELSE NULL END ))) AS q21F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q22' THEN answer ELSE NULL END ))) AS q22
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23A' THEN answer ELSE NULL END ))) AS q23A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23B' THEN answer ELSE NULL END ))) AS q23B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23C' THEN answer ELSE NULL END ))) AS q23C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23D' THEN answer ELSE NULL END ))) AS q23D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23E' THEN answer ELSE NULL END ))) AS q23E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23F' THEN answer ELSE NULL END ))) AS q23F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23G' THEN answer ELSE NULL END ))) AS q23G
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23H' THEN answer ELSE NULL END ))) AS q23H
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23I' THEN answer ELSE NULL END ))) AS q23I
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23J' THEN answer ELSE NULL END ))) AS q23J
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23K' THEN answer ELSE NULL END ))) AS q23K
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23L' THEN answer ELSE NULL END ))) AS q23L
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23M' THEN answer ELSE NULL END ))) AS q23M
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23N' THEN answer ELSE NULL END ))) AS q23N
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24' THEN answer ELSE NULL END ))) AS q24
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q25A' THEN answer ELSE NULL END ))) AS q25A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q25B' THEN answer ELSE NULL END ))) AS q25B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q25C' THEN answer ELSE NULL END ))) AS q25C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q25D' THEN answer ELSE NULL END ))) AS q25D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q25E' THEN answer ELSE NULL END ))) AS q25E
         , to_varchar(round(MAX( CASE WHEN answer_id = 'q26' THEN answer ELSE NULL END ))) AS q26
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q27' THEN answer ELSE NULL END ))) AS q27
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q28' THEN answer ELSE NULL END ))) AS q28
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q29' THEN answer ELSE NULL END ))) AS q29
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q31' THEN answer ELSE NULL END ))) AS q31
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q32' THEN answer ELSE NULL END ))) AS q32
		 , to_varchar(MAX( CASE WHEN answer_id = 'q33' THEN answer ELSE NULL END )) AS q33
         
	  FROM (SELECT  a.ANSWERHEADER_ID,
      a.MEMBERBEINGASSESSED	
				 		, a.ASSESSMENT_ID
				 , 'Completed' AS ASSESSMENT_STATUS
				 , a.COMPLETIONDATE
				 , qa.QUESTION_ID
				 , qa.ANSWER_ID
				 , CASE WHEN qa.question_type = 'multi' THEN 
							CASE WHEN a.ANSWERTEXT IS NOT NULL THEN answer_code 
								 ELSE NULL 
								 END
                            WHEN qa.question_type = 'textbox' THEN a.answer
                            ELSE qa.answer_code
    						END AS answer
			  FROM (SELECT 'single' AS question_type, '1' AS question_id, 'q01' AS answer_id, 'English' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '1' AS question_id, 'q01' AS answer_id, 'Spanish' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '1' AS question_id, 'q01' AS answer_id, 'Russian' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '1' AS question_id, 'q01' AS answer_id, 'Nepali' AS answer, '4' AS answer_code UNION 
					SELECT 'single' AS question_type, '1' AS question_id, 'q01' AS answer_id, 'Mandarin' AS answer, '5' AS answer_code UNION 
					SELECT 'single' AS question_type, '1' AS question_id, 'q01' AS answer_id, 'Arabic' AS answer, '162' AS answer_code UNION
					SELECT 'single' AS question_type, '1' AS question_id, 'q01' AS answer_id, 'Vietnamese' AS answer, '7' AS answer_code UNION 
                    SELECT 'single' AS question_type, '1' AS question_id, 'q01' AS answer_id, 'Other' AS answer, '8' AS answer_code UNION 
                    SELECT 'single' AS question_type, '2' AS question_id, 'q02' AS answer_id, 'Excellent' AS answer, '9' AS answer_code UNION 
					SELECT 'single' AS question_type, '2' AS question_id, 'q02' AS answer_id, 'Good' AS answer, '10' AS answer_code UNION 
					SELECT 'single' AS question_type, '2' AS question_id, 'q02' AS answer_id, 'Fair' AS answer, '11' AS answer_code UNION 
					SELECT 'single' AS question_type, '2' AS question_id, 'q02' AS answer_id, 'Poor' AS answer, '12' AS answer_code UNION 
					SELECT 'single' AS question_type, '3' AS question_id, 'q03' AS answer_id, 'Excellent' AS answer, '13' AS answer_code UNION 
					SELECT 'single' AS question_type, '3' AS question_id, 'q03' AS answer_id, 'Good' AS answer, '14' AS answer_code UNION 
					SELECT 'single' AS question_type, '3' AS question_id, 'q03' AS answer_id, 'Fair' AS answer, '15' AS answer_code UNION 
					SELECT 'single' AS question_type, '3' AS question_id, 'q03' AS answer_id, 'Poor' AS answer, '16' AS answer_code UNION 			 
					SELECT 'single' AS question_type, '4' AS question_id, 'q04' AS answer_id, 'Yes' AS answer, '17' AS answer_code UNION 
					SELECT 'single' AS question_type, '4' AS question_id, 'q04' AS answer_id, 'No' AS answer, '18' AS answer_code UNION 
					SELECT 'single' AS question_type, '4' AS question_id, 'q04' AS answer_id, 'I don''t know or I don''t remember' AS answer, '19' AS answer_code UNION 
					SELECT 'single' AS question_type, '5' AS question_id, 'q05' AS answer_id, '0' AS answer, '20' AS answer_code UNION 
					SELECT 'single' AS question_type, '5' AS question_id, 'q05' AS answer_id, '1-4' AS answer, '21' AS answer_code UNION 
					SELECT 'single' AS question_type, '5' AS question_id, 'q05' AS answer_id, '5-8' AS answer, '22' AS answer_code UNION 
					SELECT 'single' AS question_type, '5' AS question_id, 'q05' AS answer_id, '9 or more' AS answer, '23' AS answer_code UNION 
					SELECT 'single' AS question_type, '5' AS question_id, 'q05' AS answer_id, 'I don''t know' AS answer, '24' AS answer_code UNION 
                    SELECT 'multi' AS question_type, '6' AS question_id, 'q06A' AS answer_id, 'I don’t take any medications' AS answer, '163' AS answer_code UNION
					SELECT 'multi' AS question_type, '6' AS question_id, 'q06B' AS answer_id, 'I do take all my medications as prescribed' AS answer, '25' AS answer_code UNION 
					SELECT 'multi' AS question_type, '6' AS question_id, 'q06C' AS answer_id, 'I don''t take all my medications as prescribed' AS answer, '26' AS answer_code UNION 
					SELECT 'multi' AS question_type, '6' AS question_id, 'q06D' AS answer_id, 'I have trouble paying for my medications' AS answer, '27' AS answer_code UNION 
					SELECT 'multi' AS question_type, '6' AS question_id, 'q06E' AS answer_id, 'I have trouble getting my medications' AS answer, '28' AS answer_code UNION 
					SELECT 'multi' AS question_type, '6' AS question_id, 'q06F' AS answer_id, 'I have trouble remembering to take my medications' AS answer, '29' AS answer_code UNION 
					SELECT 'multi' AS question_type, '6' AS question_id, 'q06G' AS answer_id, 'I have trouble understanding how and/or why to take my medications the correct way' AS answer, '30' AS answer_code UNION 
					SELECT 'multi' AS question_type, '6' AS question_id, 'q06H' AS answer_id, 'I don''t know if I am taking my medication as prescribed' AS answer, '31' AS answer_code UNION 
					SELECT 'single' AS question_type, '7' AS question_id, 'q07' AS answer_id, 'None' AS answer, '32' AS answer_code UNION 
					SELECT 'single' AS question_type, '7' AS question_id, 'q07' AS answer_id, 'One time' AS answer, '33' AS answer_code UNION 
					SELECT 'single' AS question_type, '7' AS question_id, 'q07' AS answer_id, '2 -3 times' AS answer, '34' AS answer_code UNION 
					SELECT 'single' AS question_type, '7' AS question_id, 'q07' AS answer_id, 'More than 3 times' AS answer, '35' AS answer_code UNION 
					SELECT 'single' AS question_type, '7' AS question_id, 'q07' AS answer_id, 'I don''t know' AS answer, '36' AS answer_code UNION 
					SELECT 'single' AS question_type, '8' AS question_id, 'q08' AS answer_id, 'None' AS answer, '37' AS answer_code UNION 
					SELECT 'single' AS question_type, '8' AS question_id, 'q08' AS answer_id, 'One time' AS answer, '38' AS answer_code UNION 
					SELECT 'single' AS question_type, '8' AS question_id, 'q08' AS answer_id, '2 -3 times' AS answer, '39' AS answer_code UNION 
					SELECT 'single' AS question_type, '8' AS question_id, 'q08' AS answer_id, 'More than 3 times' AS answer, '40' AS answer_code UNION 
					SELECT 'single' AS question_type, '8' AS question_id, 'q08' AS answer_id, 'I don''t know' AS answer, '41' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09A' AS answer_id, 'High Blood Pressure' AS answer, '42' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09B' AS answer_id, 'Asthma' AS answer, '45' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09C' AS answer_id, 'Diabetes' AS answer, '48' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09D' AS answer_id, 'Sickle Cell' AS answer, '51' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09E' AS answer_id, 'Depression' AS answer, '57' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09F' AS answer_id, 'High Cholesterol' AS answer, '43' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09G' AS answer_id, 'COPD or Emphysema' AS answer, '46' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09H' AS answer_id, 'Kidney Failure' AS answer, '49' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09I' AS answer_id, 'Cancer' AS answer, '52' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09J' AS answer_id, 'ADHD' AS answer, '55' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09K' AS answer_id, 'Anxiety' AS answer, '58' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09L' AS answer_id, 'Heart Failure/Heart Disease or CHF' AS answer, '44' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09M' AS answer_id, 'Stroke' AS answer, '47' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09N' AS answer_id, 'Dialysis' AS answer, '50' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09O' AS answer_id, 'Back Pain' AS answer, '53' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09P' AS answer_id, 'Intellectual Disability' AS answer, '56' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9' AS question_id, 'q09Q' AS answer_id, 'Substance Use Disorder' AS answer, '59' AS answer_code UNION 
                    SELECT 'multi' AS question_type, '9' AS question_id, 'q09R' AS answer_id, 'Other' AS answer, '60' AS answer_code UNION 
                    SELECT 'multi' AS question_type, '9' AS question_id, 'q09S' AS answer_id, 'None of the above' AS answer, '61' AS answer_code UNION 
					SELECT 'single' AS question_type, '10' AS question_id, 'q10' AS answer_id, 'Yes' AS answer, '62' AS answer_code UNION 
					SELECT 'single' AS question_type, '10' AS question_id, 'q10' AS answer_id, 'No' AS answer, '63' AS answer_code UNION 
					SELECT 'single' AS question_type, '11' AS question_id, 'q11' AS answer_id, 'Yes' AS answer, '64' AS answer_code UNION 
					SELECT 'single' AS question_type, '11' AS question_id, 'q11' AS answer_id, 'No' AS answer, '65' AS answer_code UNION 
					SELECT 'single' AS question_type, '12' AS question_id, 'q12' AS answer_id, 'Hardly ever or never' AS answer, '66' AS answer_code UNION 
					SELECT 'single' AS question_type, '12' AS question_id, 'q12' AS answer_id, 'Some of the time' AS answer, '67' AS answer_code UNION 
					SELECT 'single' AS question_type, '12' AS question_id, 'q12' AS answer_id, 'Often' AS answer, '68' AS answer_code UNION 
					SELECT 'multi' AS question_type, '13' AS question_id, 'q13A' AS answer_id, 'I feel my weight is too high' AS answer, '69' AS answer_code UNION 
					SELECT 'multi' AS question_type, '13' AS question_id, 'q13B' AS answer_id, 'I don''t eat a healthy diet' AS answer, '71' AS answer_code UNION 
					SELECT 'multi' AS question_type, '13' AS question_id, 'q13C' AS answer_id, 'I smoke or use tobacco' AS answer, '73' AS answer_code UNION 
					SELECT 'multi' AS question_type, '13' AS question_id, 'q13D' AS answer_id, 'I drink too much alcohol' AS answer, '75' AS answer_code UNION 
					SELECT 'multi' AS question_type, '13' AS question_id, 'q13E' AS answer_id, 'I use drugs or medications not ordered for me' AS answer, '76' AS answer_code UNION 
					SELECT 'multi' AS question_type, '13' AS question_id, 'q13F' AS answer_id, 'I feel my weight is too low' AS answer, '70' AS answer_code UNION 
					SELECT 'multi' AS question_type, '13' AS question_id, 'q13G' AS answer_id, 'I don''t get enough physical activity' AS answer, '72' AS answer_code UNION 
					SELECT 'multi' AS question_type, '13' AS question_id, 'q13H' AS answer_id, 'I have trouble handling my stress' AS answer, '74' AS answer_code UNION 
					SELECT 'multi' AS question_type, '13' AS question_id, 'q13I' AS answer_id, 'None of these' AS answer, '77' AS answer_code UNION 
					SELECT 'multi' AS question_type, '14' AS question_id, 'q14A' AS answer_id, 'I have trouble hearing' AS answer, '78' AS answer_code UNION 
					SELECT 'multi' AS question_type, '14' AS question_id, 'q14B' AS answer_id, 'I have trouble reading' AS answer, '81' AS answer_code UNION 
					SELECT 'multi' AS question_type, '14' AS question_id, 'q14C' AS answer_id, 'I have trouble seeing' AS answer, '79' AS answer_code UNION 
					SELECT 'multi' AS question_type, '14' AS question_id, 'q14D' AS answer_id, 'I have trouble speaking' AS answer, '80' AS answer_code UNION 
					SELECT 'multi' AS question_type, '14' AS question_id, 'q14E' AS answer_id, 'None of these' AS answer, '82' AS answer_code UNION 
					SELECT 'multi' AS question_type, '15' AS question_id, 'q15A' AS answer_id, 'I forget information recently learned' AS answer, '83' AS answer_code UNION 
					SELECT 'multi' AS question_type, '15' AS question_id, 'q15B' AS answer_id, 'I ask for the same information multiple times or need reminder notes' AS answer, '84' AS answer_code UNION 
					SELECT 'multi' AS question_type, '15' AS question_id, 'q15C' AS answer_id, 'I have trouble following instructions' AS answer, '85' AS answer_code UNION 
					SELECT 'multi' AS question_type, '15' AS question_id, 'q15D' AS answer_id, 'I become confused or distracted in the middle of a conversation' AS answer, '86' AS answer_code UNION 
					SELECT 'multi' AS question_type, '15' AS question_id, 'q15E' AS answer_id, 'I struggle to remember words, dates, or events' AS answer, '87' AS answer_code UNION 
					SELECT 'multi' AS question_type, '15' AS question_id, 'q15F' AS answer_id, 'I lose or misplace things' AS answer, '88' AS answer_code UNION 
					SELECT 'multi' AS question_type, '15' AS question_id, 'q15G' AS answer_id, 'My family/friends say I am forgetful' AS answer, '89' AS answer_code UNION 
					SELECT 'multi' AS question_type, '15' AS question_id, 'q15H' AS answer_id, 'None of these' AS answer, '90' AS answer_code UNION 
					SELECT 'single' AS question_type, '16' AS question_id, 'q16' AS answer_id, 'I have a steady place to live' AS answer, '91' AS answer_code UNION 
					SELECT 'single' AS question_type, '16' AS question_id, 'q16' AS answer_id, 'I have a place to live today, but I am worried about losing it in the future' AS answer, '92' AS answer_code UNION 
					SELECT 'single' AS question_type, '16' AS question_id, 'q16' AS answer_id, 'I do not have a steady place to live (I am temporarily staying with others, in a hotel, in a shelter, living outside on the street, on a beach, in a car, abandoned building, bus or train station, or in a park)' AS answer, '93' AS answer_code UNION 
					SELECT 'single' AS question_type, '17' AS question_id, 'q17' AS answer_id, 'I live alone' AS answer, '94' AS answer_code UNION 
					SELECT 'single' AS question_type, '17' AS question_id, 'q17' AS answer_id, 'I live with other family member(s)' AS answer, '96' AS answer_code UNION 
					SELECT 'single' AS question_type, '17' AS question_id, 'q17' AS answer_id, 'I live in a nursing home' AS answer, '98' AS answer_code UNION 
					SELECT 'single' AS question_type, '17' AS question_id, 'q17' AS answer_id, 'I live in a group home' AS answer, '100' AS answer_code UNION 
					SELECT 'single' AS question_type, '17' AS question_id, 'q17' AS answer_id, 'I live with my spouse/significant other' AS answer, '95' AS answer_code UNION 
					SELECT 'single' AS question_type, '17' AS question_id, 'q17' AS answer_id, 'I live with friends or non-relative(s)' AS answer, '97' AS answer_code UNION 
					SELECT 'single' AS question_type, '17' AS question_id, 'q17' AS answer_id, 'I live in personal care/assisted living' AS answer, '99' AS answer_code UNION 
                    SELECT 'single' AS question_type, '17' AS question_id, 'q17' AS answer_id, 'Other' AS answer, '101' AS answer_code UNION 
					SELECT 'single' AS question_type, '18' AS question_id, 'q18' AS answer_id, 'Yes, and I have no issues or concerns caregiving for someone else.' AS answer, '102' AS answer_code UNION 
					SELECT 'single' AS question_type, '18' AS question_id, 'q18' AS answer_id, 'Yes, and caregiving for someone else impacts my own health and wellness.' AS answer, '103' AS answer_code UNION 
					SELECT 'single' AS question_type, '18' AS question_id, 'q18' AS answer_id, 'No, I am not the primary caregiver for someone else' AS answer, '104' AS answer_code UNION 
					SELECT 'single' AS question_type, '19' AS question_id, 'q19' AS answer_id, 'Yes, every day' AS answer, '105' AS answer_code UNION 
					SELECT 'single' AS question_type, '19' AS question_id, 'q19' AS answer_id, 'Yes, 1 or 2 times per week' AS answer, '106' AS answer_code UNION 
					SELECT 'single' AS question_type, '19' AS question_id, 'q19' AS answer_id, 'Yes, 1 or 2 times per month' AS answer, '107' AS answer_code UNION 
					SELECT 'single' AS question_type, '19' AS question_id, 'q19' AS answer_id, 'No, I don''t need help' AS answer, '108' AS answer_code UNION 
					SELECT 'single' AS question_type, '20' AS question_id, 'q20' AS answer_id, 'Yes, every day' AS answer, '109' AS answer_code UNION 
					SELECT 'single' AS question_type, '20' AS question_id, 'q20' AS answer_id, 'Yes, 1 or 2 times per week' AS answer, '110' AS answer_code UNION 
					SELECT 'single' AS question_type, '20' AS question_id, 'q20' AS answer_id, 'Yes, 1 or 2 times per month' AS answer, '111' AS answer_code UNION 
					SELECT 'single' AS question_type, '20' AS question_id, 'q20' AS answer_id, 'No, I don''t need help' AS answer, '112' AS answer_code UNION 
					SELECT 'multi' AS question_type, '21' AS question_id, 'q21A' AS answer_id, 'Spouse/Significant other' AS answer, '113' AS answer_code UNION 
					SELECT 'multi' AS question_type, '21' AS question_id, 'q21B' AS answer_id, 'Caregivers from an agency' AS answer, '116' AS answer_code UNION 
					SELECT 'multi' AS question_type, '21' AS question_id, 'q21C' AS answer_id, 'Other family member(s)' AS answer, '114' AS answer_code UNION 
					SELECT 'multi' AS question_type, '21' AS question_id, 'q21D' AS answer_id, 'Staff in a facility' AS answer, '117' AS answer_code UNION 
					SELECT 'multi' AS question_type, '21' AS question_id, 'q21E' AS answer_id, 'Friend(s) or non-relative(s)' AS answer, '115' AS answer_code UNION 
					SELECT 'multi' AS question_type, '21' AS question_id, 'q21F' AS answer_id, 'I don''t need help and support' AS answer, '118' AS answer_code UNION 
					SELECT 'single' AS question_type, '22' AS question_id, 'q22' AS answer_id, 'Yes, I have enough help and it is reliable' AS answer, '119' AS answer_code UNION 
					SELECT 'single' AS question_type, '22' AS question_id, 'q22' AS answer_id, 'Yes, I have help but sometimes it is not available' AS answer, '120' AS answer_code UNION 
					SELECT 'single' AS question_type, '22' AS question_id, 'q22' AS answer_id, 'No, I need more help than I currently have' AS answer, '121' AS answer_code UNION 
					SELECT 'single' AS question_type, '22' AS question_id, 'q22' AS answer_id, 'N/A, I don''t receive help and support from others' AS answer, '122' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23A' AS answer_id, 'Cane' AS answer, '123' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23B' AS answer_id, 'Prosthetic' AS answer, '127' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23C' AS answer_id, 'Nebulizer' AS answer, '131' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23D' AS answer_id, 'Walker' AS answer, '124' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23E' AS answer_id, 'Hospital bed' AS answer, '128' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23F' AS answer_id, 'Oxygen' AS answer, '132' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23G' AS answer_id, 'Wheelchair' AS answer, '125' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23H' AS answer_id, 'Hoyer lift' AS answer, '129' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23I' AS answer_id, 'CPAP or BiPAP' AS answer, '133' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23J' AS answer_id, 'Motorized scooter' AS answer, '126' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23K' AS answer_id, 'Glucometer' AS answer, '130' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23L' AS answer_id, 'Ventilator' AS answer, '134' AS answer_code UNION 
					SELECT 'multi' AS question_type, '23' AS question_id, 'q23M' AS answer_id, 'Other(s)' AS answer, '135' AS answer_code UNION 
                    SELECT 'multi' AS question_type, '23' AS question_id, 'q23N' AS answer_id, 'None of these' AS answer, '136' AS answer_code UNION 
					SELECT 'single' AS question_type, '24' AS question_id, 'q24' AS answer_id, 'Yes' AS answer, '137' AS answer_code UNION 
					SELECT 'single' AS question_type, '24' AS question_id, 'q24' AS answer_id, 'No' AS answer, '138' AS answer_code UNION 
					SELECT 'single' AS question_type, '24' AS question_id, 'q24' AS answer_id, 'I don''t know' AS answer, '139' AS answer_code UNION 
					SELECT 'multi' AS question_type, '25' AS question_id, 'q25A' AS answer_id, 'MATP- Medical Assistance Transportation Program' AS answer, '140' AS answer_code UNION 
					SELECT 'multi' AS question_type, '25' AS question_id, 'q25B' AS answer_id, 'SNAP- Supplemental Nutrition Assistance Program' AS answer, '141' AS answer_code UNION 
					SELECT 'multi' AS question_type, '25' AS question_id, 'q25C' AS answer_id, 'LiHEAP- Low income Home Energy Assistance Program' AS answer, '142' AS answer_code UNION 
                    SELECT 'multi' AS question_type, '25' AS question_id, 'q25C' AS answer_id, 'LIHEAP- Low income Home Energy Assistance Program' AS answer, '142' AS answer_code UNION 
					SELECT 'multi' AS question_type, '25' AS question_id, 'q25D' AS answer_id, 'LTSS - Long-term Services and Supports: Personal Care at Home or Nursing Facility Care' AS answer, '143' AS answer_code UNION 
					SELECT 'multi' AS question_type, '25' AS question_id, 'q25E' AS answer_id, 'None of these' AS answer, '144' AS answer_code UNION
                    SELECT 'multi' AS question_type, '26' AS question_id, 'q26' AS answer_id, 'Often true' AS answer, '167' AS answer_code UNION
                    SELECT 'multi' AS question_type, '26' AS question_id, 'q26' AS answer_id, 'Sometimes true' AS answer, '168' AS answer_code UNION
                    SELECT 'multi' AS question_type, '26' AS question_id, 'q26' AS answer_id, 'Never true' AS answer, '169' AS answer_code UNION
                    SELECT 'single' AS question_type, '27' AS question_id, 'q27' AS answer_id, 'Often true' AS answer, '170' AS answer_code UNION 
					SELECT 'single' AS question_type, '27' AS question_id, 'q27' AS answer_id, 'Sometimes true' AS answer, '171' AS answer_code UNION 
					SELECT 'single' AS question_type, '27' AS question_id, 'q27' AS answer_id, 'Never true' AS answer, '172' AS answer_code UNION 
					SELECT 'single' AS question_type, '28' AS question_id, 'q28' AS answer_id, 'Yes' AS answer, '173' AS answer_code UNION 
					SELECT 'single' AS question_type, '28' AS question_id, 'q28' AS answer_id, 'No' AS answer, '174' AS answer_code UNION 
					SELECT 'single' AS question_type, '29' AS question_id, 'q29' AS answer_id, 'Yes' AS answer, '175' AS answer_code UNION 
					SELECT 'single' AS question_type, '29' AS question_id, 'q29' AS answer_id, 'No' AS answer, '176' AS answer_code UNION 
					SELECT 'single' AS question_type, '29' AS question_id, 'q29' AS answer_id, 'I don''t know' AS answer, '161' AS answer_code UNION 
					SELECT 'single' AS question_type, '31' AS question_id, 'q31' AS answer_id, 'Yes, I have an advance directive' AS answer, '177' AS answer_code UNION 
					SELECT 'single' AS question_type, '31' AS question_id, 'q31' AS answer_id, 'No, I don''t have an advance directive and I am not interested at this time' AS answer, '178' AS answer_code UNION 
					SELECT 'single' AS question_type, '31' AS question_id, 'q31' AS answer_id, 'I don''t know' AS answer, '180' AS answer_code UNION 
                    SELECT 'single' AS question_type, '32' AS question_id, 'q32' AS answer_id, 'Yes, I have identified my personal representative' AS answer, '181' AS answer_code UNION
                    SELECT 'single' AS question_type, '32' AS question_id, 'q32' AS answer_id, 'No, I am not interested in identifying a personal representative at this time' AS answer, '182' AS answer_code UNION
                    SELECT 'single' AS question_type, '32' AS question_id, 'q32' AS answer_id, 'I don''t know' AS answer, '184' AS answer_code UNION
                    SELECT 'textbox' AS question_type, '33' AS question_id, 'q33' AS answer_id, 'free text' AS answer, '999' AS answer_code
		
				 ) qa
		INNER JOIN (SELECT ANSWERHEADER_ID,
        MEMBERBEINGASSESSED 
						 , ASSESSMENT_ID
						 , COMPLETIONDATE 
						 , QUESTION_ID
						 , QUESTIONTEXT
						 , ANSWERTEXT
                         ,ANSWER_ID
                         ,ANSWERTEXT as answer
                    
                          FROM &{IDAP_LAKE}.ASSESSMENT.SNP_HAS_ASSESSMENTRESPONSES_ID_VW
				   ) a ON a.QUESTION_ID = qa.QUESTION_ID	
					   AND a.ANSWER_ID = qa.answer_code AND (CASE WHEN a.question_id = '33' THEN 'free text'
									ELSE a.answer 
                                    END) = qa.answer	
		   ) t
  GROUP BY 
  ANSWERHEADER_ID,
  MEMBERBEINGASSESSED
		 , assessment_id
         , assessment_status
         , COMPLETIONDATE);
!set variable_substitution=false;


