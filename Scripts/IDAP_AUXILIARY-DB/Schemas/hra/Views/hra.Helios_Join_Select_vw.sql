
!set variable_substitution=true;
create or replace view HRA.HELIOS_JOIN_SELECT_VW(
	MEMBER_NBR,
	ASSESSMENT_ID,
	ASSESSMENT_STATUS,
	ASSESSMENT_COMPLETED_DATE,
	Q01,
	Q02,
	Q03,
	Q04,
	Q05,
	Q06,
	Q07A,
	Q07B,
	Q07C,
	Q07D,
	Q07E,
	Q07F,
	Q07G,
	Q07H,
	Q08,
	Q09,
	Q10A,
	Q10B,
	Q10C,
	Q10D,
	Q10E,
	Q10F,
	Q10G,
	Q10H,
	Q10I,
	Q10J,
	Q10K,
	Q10L,
	Q10M,
	Q10N,
	Q10O,
	Q10P,
	Q10Q,
	Q10R,
	Q10S,
	Q11,
	Q12,
	Q13,
	Q14A,
	Q14B,
	Q14C,
	Q14D,
	Q14E,
	Q14F,
	Q14G,
	Q14H,
	Q14I,
	Q15A,
	Q15B,
	Q15C,
	Q15D,
	Q15E,
	Q16A,
	Q16B,
	Q16C,
	Q16D,
	Q16E,
	Q16F,
	Q16G,
	Q16H,
	Q17,
	Q18,
	Q19,
	Q20,
	Q21,
	Q22A,
	Q22B,
	Q22C,
	Q22D,
	Q22E,
	Q22F,
	Q23,
	Q24A,
	Q24B,
	Q24C,
	Q24D,
	Q24E,
	Q24F,
	Q24G,
	Q24H,
	Q24I,
	Q24J,
	Q24K,
	Q24L,
	Q24M,
	Q24N,
	Q25,
	Q26A,
	Q26B,
	Q26C,
	Q26D,
	Q26E,
	Q27,
	Q28,
	Q29,
	Q30,
	Q31,
	Q32,
	ASSESSMENT_TYPE_ID
) COMMENT = 'View which joins intial 5 views- helios_assessment_data_vw, helios_assessment_form_vw, helios_client_vw,helios_eav_assessment_vw, helios_eav_assessment_ext_vw' 
	as 	(SELECT member_nbr
		 , assessment_id
         , assessment_status
         , assessment_completed_date
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q01' THEN answer ELSE NULL END ))) AS q01
         , to_varchar(MAX( CASE WHEN answer_id = 'q02' THEN answer ELSE NULL END)) AS q02
         , to_varchar(round(MAX( CASE WHEN answer_id = 'q03' THEN answer ELSE NULL END))) AS q03
         , to_varchar(round(MAX( CASE WHEN answer_id = 'q04' THEN answer ELSE NULL END))) AS q04
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q05' THEN answer ELSE NULL END ))) AS q05
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q06' THEN answer ELSE NULL END ))) AS q06
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q07A' THEN answer ELSE NULL END ))) AS q07A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q07B' THEN answer ELSE NULL END ))) AS q07B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q07C' THEN answer ELSE NULL END ))) AS q07C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q07D' THEN answer ELSE NULL END ))) AS q07D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q07E' THEN answer ELSE NULL END ))) AS q07E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q07F' THEN answer ELSE NULL END ))) AS q07F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q07G' THEN answer ELSE NULL END ))) AS q07G
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q07H' THEN answer ELSE NULL END ))) AS q07H
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q08' THEN answer ELSE NULL END ))) AS q08
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q09' THEN answer ELSE NULL END ))) AS q09
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10A' THEN answer ELSE NULL END ))) AS q10A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10B' THEN answer ELSE NULL END ))) AS q10B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10C' THEN answer ELSE NULL END ))) AS q10C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10D' THEN answer ELSE NULL END ))) AS q09D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10E' THEN answer ELSE NULL END ))) AS q10E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10F' THEN answer ELSE NULL END ))) AS q10F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10G' THEN answer ELSE NULL END ))) AS q10G
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10H' THEN answer ELSE NULL END ))) AS q10H
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10I' THEN answer ELSE NULL END ))) AS q10I
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10J' THEN answer ELSE NULL END ))) AS q10J
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10K' THEN answer ELSE NULL END ))) AS q10K
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10L' THEN answer ELSE NULL END ))) AS q10L
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10M' THEN answer ELSE NULL END ))) AS q10M
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10N' THEN answer ELSE NULL END ))) AS q10N
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10O' THEN answer ELSE NULL END ))) AS q10O
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10P' THEN answer ELSE NULL END ))) AS q10P
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10Q' THEN answer ELSE NULL END ))) AS q10Q
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10R' THEN answer ELSE NULL END ))) AS q10R
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q10S' THEN answer ELSE NULL END ))) AS q10S
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q11' THEN answer ELSE NULL END ))) AS q11
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q12' THEN answer ELSE NULL END ))) AS q12
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q13' THEN answer ELSE NULL END ))) AS q13
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14A' THEN answer ELSE NULL END ))) AS q14A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14B' THEN answer ELSE NULL END ))) AS q14B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14C' THEN answer ELSE NULL END ))) AS q14C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14D' THEN answer ELSE NULL END ))) AS q14D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14E' THEN answer ELSE NULL END ))) AS q14E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14F' THEN answer ELSE NULL END ))) AS q14F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14G' THEN answer ELSE NULL END ))) AS q14G
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14H' THEN answer ELSE NULL END ))) AS q14H
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q14I' THEN answer ELSE NULL END ))) AS q14I
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15A' THEN answer ELSE NULL END ))) AS q15A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15B' THEN answer ELSE NULL END ))) AS q15B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15C' THEN answer ELSE NULL END ))) AS q15C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15D' THEN answer ELSE NULL END ))) AS q15D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q15E' THEN answer ELSE NULL END ))) AS q15E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q16A' THEN answer ELSE NULL END ))) AS q16A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q16B' THEN answer ELSE NULL END ))) AS q16B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q16C' THEN answer ELSE NULL END ))) AS q16C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q16D' THEN answer ELSE NULL END ))) AS q16D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q16E' THEN answer ELSE NULL END ))) AS q16E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q16F' THEN answer ELSE NULL END ))) AS q16F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q16G' THEN answer ELSE NULL END ))) AS q16G
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q16H' THEN answer ELSE NULL END ))) AS q16H
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q17' THEN answer ELSE NULL END ))) AS q17
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q18' THEN answer ELSE NULL END ))) AS q18
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q19' THEN answer ELSE NULL END ))) AS q19
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q20' THEN answer ELSE NULL END ))) AS q20
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q21' THEN answer ELSE NULL END ))) AS q21
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q22A' THEN answer ELSE NULL END ))) AS q22A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q22B' THEN answer ELSE NULL END ))) AS q22B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q22C' THEN answer ELSE NULL END ))) AS q22C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q22D' THEN answer ELSE NULL END ))) AS q22D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q22E' THEN answer ELSE NULL END ))) AS q22E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q22F' THEN answer ELSE NULL END ))) AS q22F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q23' THEN answer ELSE NULL END ))) AS q23
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24A' THEN answer ELSE NULL END ))) AS q24A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24B' THEN answer ELSE NULL END ))) AS q24B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24C' THEN answer ELSE NULL END ))) AS q24C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24D' THEN answer ELSE NULL END ))) AS q24D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24E' THEN answer ELSE NULL END ))) AS q24E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24F' THEN answer ELSE NULL END ))) AS q24F
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24G' THEN answer ELSE NULL END ))) AS q24G
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24H' THEN answer ELSE NULL END ))) AS q24H
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24I' THEN answer ELSE NULL END ))) AS q24I
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24J' THEN answer ELSE NULL END ))) AS q24J
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24K' THEN answer ELSE NULL END ))) AS q24K
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24L' THEN answer ELSE NULL END ))) AS q24L
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24M' THEN answer ELSE NULL END ))) AS q24M
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q24N' THEN answer ELSE NULL END ))) AS q24N
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q25' THEN answer ELSE NULL END ))) AS q25
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q26A' THEN answer ELSE NULL END ))) AS q26A
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q26B' THEN answer ELSE NULL END ))) AS q26B
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q26C' THEN answer ELSE NULL END ))) AS q26C
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q26D' THEN answer ELSE NULL END ))) AS q26D
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q26E' THEN answer ELSE NULL END ))) AS q26E
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q27' THEN answer ELSE NULL END ))) AS q27
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q28' THEN answer ELSE NULL END ))) AS q28
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q29' THEN answer ELSE NULL END ))) AS q29
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q30' THEN answer ELSE NULL END ))) AS q30
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q31' THEN answer ELSE NULL END ))) AS q31
		 , to_varchar(round(MAX( CASE WHEN answer_id = 'q32' THEN answer ELSE NULL END ))) AS q32
         , assessment_type_id
	  FROM (SELECT a.member_nbr	
				 , a.assessment_type_id
				 , a.assessment_id
				 , 'Completed' AS assessment_status
				 , a.submitted_date AS assessment_completed_date
				 , qa.question_id
				 , qa.answer_id
				 , CASE WHEN qa.question_type = 'multi' THEN 
							CASE WHEN a.answer IS NOT NULL THEN '1'
								 ELSE NULL 
								 END
						WHEN qa.question_type = 'textbox' THEN a.answer
                        ELSE qa.answer_code
						END AS answer
			  FROM (SELECT 'single' AS question_type, 'bd6ac072-a921-4f76-a13a-26731d0d3d64' AS question_id, 'q01' AS answer_id, 'English' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, 'bd6ac072-a921-4f76-a13a-26731d0d3d64' AS question_id, 'q01' AS answer_id, 'Spanish' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, 'bd6ac072-a921-4f76-a13a-26731d0d3d64' AS question_id, 'q01' AS answer_id, 'Russian' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, 'bd6ac072-a921-4f76-a13a-26731d0d3d64' AS question_id, 'q01' AS answer_id, 'Nepali' AS answer, '4' AS answer_code UNION 
					SELECT 'single' AS question_type, 'bd6ac072-a921-4f76-a13a-26731d0d3d64' AS question_id, 'q01' AS answer_id, 'Mandarin' AS answer, '5' AS answer_code UNION 
					SELECT 'single' AS question_type, 'bd6ac072-a921-4f76-a13a-26731d0d3d64' AS question_id, 'q01' AS answer_id, 'Arabic' AS answer, '6' AS answer_code UNION 
					SELECT 'single' AS question_type, 'bd6ac072-a921-4f76-a13a-26731d0d3d64' AS question_id, 'q01' AS answer_id, 'Vietnamese' AS answer, '7' AS answer_code UNION 
                    SELECT 'single' AS question_type, 'bd6ac072-a921-4f76-a13a-26731d0d3d64' AS question_id, 'q01' AS answer_id, 'Other' AS answer, '8' AS answer_code UNION 
					SELECT 'textbox' AS question_type, '3deca42b-8293-4456-a26e-e70e54f31086' AS question_id, 'q02' AS answer_id, 'free text' AS answer, '1' AS answer_code UNION
					SELECT 'single' AS question_type, '35ee1974-07c1-4b7a-8556-07807e52b165' AS question_id, 'q03' AS answer_id, 'Excellent' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '35ee1974-07c1-4b7a-8556-07807e52b165' AS question_id, 'q03' AS answer_id, 'Good' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '35ee1974-07c1-4b7a-8556-07807e52b165' AS question_id, 'q03' AS answer_id, 'Fair' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '35ee1974-07c1-4b7a-8556-07807e52b165' AS question_id, 'q03' AS answer_id, 'Poor' AS answer, '4' AS answer_code UNION 
					SELECT 'single' AS question_type, '96a3bafb-6ac5-46ed-8272-d9d715e701cb' AS question_id, 'q04' AS answer_id, 'Excellent' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '96a3bafb-6ac5-46ed-8272-d9d715e701cb' AS question_id, 'q04' AS answer_id, 'Good' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '96a3bafb-6ac5-46ed-8272-d9d715e701cb' AS question_id, 'q04' AS answer_id, 'Fair' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '96a3bafb-6ac5-46ed-8272-d9d715e701cb' AS question_id, 'q04' AS answer_id, 'Poor' AS answer, '4' AS answer_code UNION 
					SELECT 'single' AS question_type, '3ba333fe-016d-4380-a2cc-b56646a18a53' AS question_id, 'q05' AS answer_id, 'Yes' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '3ba333fe-016d-4380-a2cc-b56646a18a53' AS question_id, 'q05' AS answer_id, 'No' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '3ba333fe-016d-4380-a2cc-b56646a18a53' AS question_id, 'q05' AS answer_id, 'I don''t know or I don''t remember' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '99bf2373-85d2-4226-bcde-34dd5a335e89' AS question_id, 'q06' AS answer_id, '0' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '99bf2373-85d2-4226-bcde-34dd5a335e89' AS question_id, 'q06' AS answer_id, '1 - 4' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '99bf2373-85d2-4226-bcde-34dd5a335e89' AS question_id, 'q06' AS answer_id, '5 - 8' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '99bf2373-85d2-4226-bcde-34dd5a335e89' AS question_id, 'q06' AS answer_id, '9 or more' AS answer, '4' AS answer_code UNION 
					SELECT 'single' AS question_type, '99bf2373-85d2-4226-bcde-34dd5a335e89' AS question_id, 'q06' AS answer_id, 'I don''t know' AS answer, '5' AS answer_code UNION 
					SELECT 'multi' AS question_type, '1016fd44-34ba-4162-94f7-17764a22e0da' AS question_id, 'q07A' AS answer_id, 'I don''t take any medications' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '1016fd44-34ba-4162-94f7-17764a22e0da' AS question_id, 'q07B' AS answer_id, 'I do take all my medications as prescribed' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '1016fd44-34ba-4162-94f7-17764a22e0da' AS question_id, 'q07C' AS answer_id, 'I don''t take all my medications as prescribed' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '1016fd44-34ba-4162-94f7-17764a22e0da' AS question_id, 'q07D' AS answer_id, 'I have trouble paying for my medications' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '1016fd44-34ba-4162-94f7-17764a22e0da' AS question_id, 'q07E' AS answer_id, 'I have trouble getting my medications' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '1016fd44-34ba-4162-94f7-17764a22e0da' AS question_id, 'q07F' AS answer_id, 'I have trouble remembering to take my medications' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '1016fd44-34ba-4162-94f7-17764a22e0da' AS question_id, 'q07G' AS answer_id, 'I have trouble understanding how and/or why to take my medications the correct way' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '1016fd44-34ba-4162-94f7-17764a22e0da' AS question_id, 'q07H' AS answer_id, 'I don''t know if I am taking my medication as prescribed' AS answer, '' AS answer_code UNION 
					SELECT 'single' AS question_type, '0ec156dc-db21-459c-945f-7546b23fc354' AS question_id, 'q08' AS answer_id, 'None' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '0ec156dc-db21-459c-945f-7546b23fc354' AS question_id, 'q08' AS answer_id, 'One time' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '0ec156dc-db21-459c-945f-7546b23fc354' AS question_id, 'q08' AS answer_id, '2 - 3 times' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '0ec156dc-db21-459c-945f-7546b23fc354' AS question_id, 'q08' AS answer_id, 'More than 3 times' AS answer, '4' AS answer_code UNION 
					SELECT 'single' AS question_type, '0ec156dc-db21-459c-945f-7546b23fc354' AS question_id, 'q08' AS answer_id, 'I don''t know' AS answer, '5' AS answer_code UNION 
					SELECT 'single' AS question_type, '9162ad46-073a-4671-ac0d-1acea83e6741' AS question_id, 'q09' AS answer_id, 'None' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '9162ad46-073a-4671-ac0d-1acea83e6741' AS question_id, 'q09' AS answer_id, 'One time' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '9162ad46-073a-4671-ac0d-1acea83e6741' AS question_id, 'q09' AS answer_id, '2 - 3 times' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '9162ad46-073a-4671-ac0d-1acea83e6741' AS question_id, 'q09' AS answer_id, 'More than 3 times' AS answer, '4' AS answer_code UNION 
					SELECT 'single' AS question_type, '9162ad46-073a-4671-ac0d-1acea83e6741' AS question_id, 'q09' AS answer_id, 'I don''t know' AS answer, '5' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10A' AS answer_id, 'High Blood Pressure' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10B' AS answer_id, 'Asthma' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10C' AS answer_id, 'Diabetes' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10D' AS answer_id, 'Sickle Cell' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10E' AS answer_id, 'Depression' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10F' AS answer_id, 'High Cholesterol' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10G' AS answer_id, 'COPD or Emphysema' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10H' AS answer_id, 'Kidney Failure' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10I' AS answer_id, 'Cancer' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10J' AS answer_id, 'ADHD' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10K' AS answer_id, 'Anxiety' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10L' AS answer_id, 'Heart Failure/Heart Disease or CHF Heart Disease' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10M' AS answer_id, 'Stroke' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10N' AS answer_id, 'Dialysis' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10O' AS answer_id, 'Back Pain' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10P' AS answer_id, 'Intellectual Disability' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10Q' AS answer_id, 'Substance Use Disorder' AS answer, '' AS answer_code UNION 
                    SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10R' AS answer_id, 'Other' AS answer, '' AS answer_code UNION 
                    SELECT 'multi' AS question_type, 'a2e628d1-2f58-4070-8151-819a324e40af' AS question_id, 'q10S' AS answer_id, 'None of the above' AS answer, '' AS answer_code UNION 
					SELECT 'single' AS question_type, '05114c35-432f-4a1b-be3a-1b45baffbbb0' AS question_id, 'q11' AS answer_id, 'Yes' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '05114c35-432f-4a1b-be3a-1b45baffbbb0' AS question_id, 'q11' AS answer_id, 'No' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, 'ab84f02c-5439-45f3-8282-3056cd2c191e' AS question_id, 'q12' AS answer_id, 'Yes' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, 'ab84f02c-5439-45f3-8282-3056cd2c191e' AS question_id, 'q12' AS answer_id, 'No' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '786290c3-8cf5-4fb2-8e57-f877ffb8d5a1' AS question_id, 'q13' AS answer_id, 'Hardly ever or never' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '786290c3-8cf5-4fb2-8e57-f877ffb8d5a1' AS question_id, 'q13' AS answer_id, 'Some of the time' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '786290c3-8cf5-4fb2-8e57-f877ffb8d5a1' AS question_id, 'q13' AS answer_id, 'Often' AS answer, '3' AS answer_code UNION 
					SELECT 'multi' AS question_type, '625f8ff2-7fb9-427e-a59e-16d2d2ad95cf' AS question_id, 'q14A' AS answer_id, 'I feel my weight is too high' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '625f8ff2-7fb9-427e-a59e-16d2d2ad95cf' AS question_id, 'q14B' AS answer_id, 'I don''t eat a healthy diet' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '625f8ff2-7fb9-427e-a59e-16d2d2ad95cf' AS question_id, 'q14C' AS answer_id, 'I smoke or use tobacco' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '625f8ff2-7fb9-427e-a59e-16d2d2ad95cf' AS question_id, 'q14D' AS answer_id, 'I drink too much alcohol' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '625f8ff2-7fb9-427e-a59e-16d2d2ad95cf' AS question_id, 'q14E' AS answer_id, 'I use drugs or medications not ordered for me' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '625f8ff2-7fb9-427e-a59e-16d2d2ad95cf' AS question_id, 'q14F' AS answer_id, 'I feel my weight is too low' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '625f8ff2-7fb9-427e-a59e-16d2d2ad95cf' AS question_id, 'q14G' AS answer_id, 'I don''t get enough physical activity' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '625f8ff2-7fb9-427e-a59e-16d2d2ad95cf' AS question_id, 'q14H' AS answer_id, 'I have trouble handling my stress' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '625f8ff2-7fb9-427e-a59e-16d2d2ad95cf' AS question_id, 'q14I' AS answer_id, 'None of these' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '02bbb7c9-25b1-4aa2-9a50-4903db093c19' AS question_id, 'q15A' AS answer_id, 'I have trouble hearing' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '02bbb7c9-25b1-4aa2-9a50-4903db093c19' AS question_id, 'q15B' AS answer_id, 'I have trouble reading' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '02bbb7c9-25b1-4aa2-9a50-4903db093c19' AS question_id, 'q15C' AS answer_id, 'I have trouble seeing' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '02bbb7c9-25b1-4aa2-9a50-4903db093c19' AS question_id, 'q15D' AS answer_id, 'I have trouble speaking' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '02bbb7c9-25b1-4aa2-9a50-4903db093c19' AS question_id, 'q15E' AS answer_id, 'None of these' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9f7bce35-8c1d-4522-923a-a1fc5c18953d' AS question_id, 'q16A' AS answer_id, 'I forget information recently learned' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9f7bce35-8c1d-4522-923a-a1fc5c18953d' AS question_id, 'q16B' AS answer_id, 'I ask for the same information multiple times or need reminder notes' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9f7bce35-8c1d-4522-923a-a1fc5c18953d' AS question_id, 'q16C' AS answer_id, 'I have trouble following instructions' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9f7bce35-8c1d-4522-923a-a1fc5c18953d' AS question_id, 'q16D' AS answer_id, 'I become confused or distracted in the middle of a conversation' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9f7bce35-8c1d-4522-923a-a1fc5c18953d' AS question_id, 'q16E' AS answer_id, 'I struggle to remember words, dates, or events' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9f7bce35-8c1d-4522-923a-a1fc5c18953d' AS question_id, 'q16F' AS answer_id, 'I lose or misplace things' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9f7bce35-8c1d-4522-923a-a1fc5c18953d' AS question_id, 'q16G' AS answer_id, 'My family/friends say I am forgetful' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '9f7bce35-8c1d-4522-923a-a1fc5c18953d' AS question_id, 'q16H' AS answer_id, 'None of these' AS answer, '' AS answer_code UNION 
					SELECT 'single' AS question_type, 'fb5fbf84-2b56-47e3-9c90-b62696c340a3' AS question_id, 'q17' AS answer_id, 'I have a steady place to live' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, 'fb5fbf84-2b56-47e3-9c90-b62696c340a3' AS question_id, 'q17' AS answer_id, 'I have a place to live today, but I am worried about losing it in the future' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, 'fb5fbf84-2b56-47e3-9c90-b62696c340a3' AS question_id, 'q17' AS answer_id, 'I do not have a steady place to live (I am temporarily staying with others, in a hotel, in a shelter, living outside on the street, on a beach, in a car, abandoned building, bus or train station, or in a park)' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '431b994e-2819-4d54-a14a-ba9762de0004' AS question_id, 'q18' AS answer_id, 'I live alone' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '431b994e-2819-4d54-a14a-ba9762de0004' AS question_id, 'q18' AS answer_id, 'I live with other family members' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '431b994e-2819-4d54-a14a-ba9762de0004' AS question_id, 'q18' AS answer_id, 'I live in a nursing home' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '431b994e-2819-4d54-a14a-ba9762de0004' AS question_id, 'q18' AS answer_id, 'I live in a group home' AS answer, '4' AS answer_code UNION 
					SELECT 'single' AS question_type, '431b994e-2819-4d54-a14a-ba9762de0004' AS question_id, 'q18' AS answer_id, 'I live with my spouse/significant other' AS answer, '5' AS answer_code UNION 
					SELECT 'single' AS question_type, '431b994e-2819-4d54-a14a-ba9762de0004' AS question_id, 'q18' AS answer_id, 'I live with friends or non-relative(s)' AS answer, '6' AS answer_code UNION 
					SELECT 'single' AS question_type, '431b994e-2819-4d54-a14a-ba9762de0004' AS question_id, 'q18' AS answer_id, 'I live in personal care/assisted living' AS answer, '7' AS answer_code UNION 
                    SELECT 'single' AS question_type, '431b994e-2819-4d54-a14a-ba9762de0004' AS question_id, 'q18' AS answer_id, 'Other' AS answer, '8' AS answer_code UNION 
					SELECT 'single' AS question_type, '26f91d64-6813-461d-94fc-d3a2ea99394b' AS question_id, 'q19' AS answer_id, 'Yes, I have no issues or concerns caregiving for someone else.' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '26f91d64-6813-461d-94fc-d3a2ea99394b' AS question_id, 'q19' AS answer_id, 'Yes, and caregiving for someone else impacts my own health and wellness.' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '26f91d64-6813-461d-94fc-d3a2ea99394b' AS question_id, 'q19' AS answer_id, 'No, I am not the primary caregiver for someone else.' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, 'c1daeb2e-9368-47ca-b8d4-1e6f1be9849f' AS question_id, 'q20' AS answer_id, 'Yes, every day' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, 'c1daeb2e-9368-47ca-b8d4-1e6f1be9849f' AS question_id, 'q20' AS answer_id, 'Yes, 1 or 2 times per week' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, 'c1daeb2e-9368-47ca-b8d4-1e6f1be9849f' AS question_id, 'q20' AS answer_id, 'Yes, 1 or 2 times per month' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, 'c1daeb2e-9368-47ca-b8d4-1e6f1be9849f' AS question_id, 'q20' AS answer_id, 'No, I don''t need help' AS answer, '4' AS answer_code UNION 
					SELECT 'single' AS question_type, '52557ee3-2421-4178-ad5a-aaed85b2198f' AS question_id, 'q21' AS answer_id, 'Yes, every day' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '52557ee3-2421-4178-ad5a-aaed85b2198f' AS question_id, 'q21' AS answer_id, 'Yes, 1 or 2 times per week' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '52557ee3-2421-4178-ad5a-aaed85b2198f' AS question_id, 'q21' AS answer_id, 'Yes, 1 or 2 times per month' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '52557ee3-2421-4178-ad5a-aaed85b2198f' AS question_id, 'q21' AS answer_id, 'No, I don''t need help' AS answer, '4' AS answer_code UNION 
					SELECT 'multi' AS question_type, '0a4859b4-70c6-4c64-b56b-6ca30f87e3a7' AS question_id, 'q22A' AS answer_id, 'Spouse/Significant other' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '0a4859b4-70c6-4c64-b56b-6ca30f87e3a7' AS question_id, 'q22B' AS answer_id, 'Caregivers from an agency' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '0a4859b4-70c6-4c64-b56b-6ca30f87e3a7' AS question_id, 'q22C' AS answer_id, 'Other family members(s)' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '0a4859b4-70c6-4c64-b56b-6ca30f87e3a7' AS question_id, 'q22D' AS answer_id, 'Staff in a facility' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '0a4859b4-70c6-4c64-b56b-6ca30f87e3a7' AS question_id, 'q22E' AS answer_id, 'Friend(s) or non-relatives(s)' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '0a4859b4-70c6-4c64-b56b-6ca30f87e3a7' AS question_id, 'q22F' AS answer_id, 'I don''t need help and support' AS answer, '' AS answer_code UNION                     
					SELECT 'single' AS question_type, 'bc88f02d-94bc-4bbf-a00f-9decffd55512' AS question_id, 'q23' AS answer_id, 'Yes, I have enough help and it is reliable' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, 'bc88f02d-94bc-4bbf-a00f-9decffd55512' AS question_id, 'q23' AS answer_id, 'Yes, I have help but sometimes it is not available' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, 'bc88f02d-94bc-4bbf-a00f-9decffd55512' AS question_id, 'q23' AS answer_id, 'No, I need more help than I currently have' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, 'bc88f02d-94bc-4bbf-a00f-9decffd55512' AS question_id, 'q23' AS answer_id, 'N/A, I don''t receive help and support from others' AS answer, '4' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24A' AS answer_id, 'Cane' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24B' AS answer_id, 'Prosthetic' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24C' AS answer_id, 'Nebulizer' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24D' AS answer_id, 'Walker' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24E' AS answer_id, 'Hospital bed' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24F' AS answer_id, 'Oxygen' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24G' AS answer_id, 'Wheelchair' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24H' AS answer_id, 'Hoyer lift' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24I' AS answer_id, 'CPAP or BiPAP' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24J' AS answer_id, 'Motorized Scooter' AS answer, '' AS answer_code UNION
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24J' AS answer_id, 'Motorized scooter' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24K' AS answer_id, 'Glucometer' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24L' AS answer_id, 'Ventilator' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24M' AS answer_id, 'Other(s)' AS answer, '' AS answer_code UNION 
                    SELECT 'multi' AS question_type, 'f3ccac0d-0243-451b-94f0-a93ccfdb6e3d' AS question_id, 'q24N' AS answer_id, 'None of these' AS answer, '' AS answer_code UNION 
					SELECT 'single' AS question_type, 'e9dae77f-f320-4c4b-8e6f-9d3cc2835aa6' AS question_id, 'q25' AS answer_id, 'Yes' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, 'e9dae77f-f320-4c4b-8e6f-9d3cc2835aa6' AS question_id, 'q25' AS answer_id, 'No' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, 'e9dae77f-f320-4c4b-8e6f-9d3cc2835aa6' AS question_id, 'q25' AS answer_id, 'I don’t know' AS answer, '3' AS answer_code UNION 
					SELECT 'multi' AS question_type, '2ba1f982-13b3-48ee-82d6-333bd7eab3e3' AS question_id, 'q26A' AS answer_id, 'MATP- Medical Assistance Transportation Program' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '2ba1f982-13b3-48ee-82d6-333bd7eab3e3' AS question_id, 'q26B' AS answer_id, 'SNAP- Supplemental Nutrition Assistance Program' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '2ba1f982-13b3-48ee-82d6-333bd7eab3e3' AS question_id, 'q26C' AS answer_id, 'LIHEAP- Low income Home Energy Assistance Program' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '2ba1f982-13b3-48ee-82d6-333bd7eab3e3' AS question_id, 'q26D' AS answer_id, 'LTSS - Long-term Services and Supports: Personal Care at Home or Nursing Facility Care' AS answer, '' AS answer_code UNION 
					SELECT 'multi' AS question_type, '2ba1f982-13b3-48ee-82d6-333bd7eab3e3' AS question_id, 'q26E' AS answer_id, 'None of these' AS answer, '' AS answer_code UNION 
					SELECT 'single' AS question_type, '2a8f9838-e104-4ce5-bb57-c89d990d7967' AS question_id, 'q27' AS answer_id, 'Often true' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '2a8f9838-e104-4ce5-bb57-c89d990d7967' AS question_id, 'q27' AS answer_id, 'Sometimes true' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '2a8f9838-e104-4ce5-bb57-c89d990d7967' AS question_id, 'q27' AS answer_id, 'Never true' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '077cf3b0-aa7b-47e1-992d-f100cf3e5607' AS question_id, 'q28' AS answer_id, 'Often true' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '077cf3b0-aa7b-47e1-992d-f100cf3e5607' AS question_id, 'q28' AS answer_id, 'Sometimes true' AS answer, '2' AS answer_code UNION
					SELECT 'single' AS question_type, '077cf3b0-aa7b-47e1-992d-f100cf3e5607' AS question_id, 'q28' AS answer_id, 'Never true' AS answer, '3' AS answer_code UNION
					SELECT 'single' AS question_type, '3dce0a99-b58a-4478-b213-d2c7557562b9' AS question_id, 'q29' AS answer_id, 'Yes' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '3dce0a99-b58a-4478-b213-d2c7557562b9' AS question_id, 'q29' AS answer_id, 'No' AS answer, '2' AS answer_code UNION
					SELECT 'single' AS question_type, 'f0bed143-2b59-4a37-91d8-76ac2ebab464' AS question_id, 'q30' AS answer_id, 'Yes' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, 'f0bed143-2b59-4a37-91d8-76ac2ebab464' AS question_id, 'q30' AS answer_id, 'No' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, 'f0bed143-2b59-4a37-91d8-76ac2ebab464' AS question_id, 'q30' AS answer_id, 'I don''t know' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '2ff82af0-1bf7-4140-af0c-200711d8db34' AS question_id, 'q31' AS answer_id, 'Yes, I have an advance directive' AS answer, '1' AS answer_code UNION
					SELECT 'single' AS question_type, '2ff82af0-1bf7-4140-af0c-200711d8db34' AS question_id, 'q31' AS answer_id, 'No, I don''t have an advance directive and I am not interested at this time' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '2ff82af0-1bf7-4140-af0c-200711d8db34' AS question_id, 'q31' AS answer_id, 'No, I don''t have an advance directive.  Please send me information by mail.' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '2ff82af0-1bf7-4140-af0c-200711d8db34' AS question_id, 'q31' AS answer_id, 'I don''t know' AS answer, '4' AS answer_code UNION 
					SELECT 'single' AS question_type, '139fdcf3-b991-4332-a858-b32d6fc05cb0' AS question_id, 'q32' AS answer_id, 'Yes, I have identified my personal representative' AS answer, '1' AS answer_code UNION 
					SELECT 'single' AS question_type, '139fdcf3-b991-4332-a858-b32d6fc05cb0' AS question_id, 'q32' AS answer_id, 'No, I am not interested in identifying a personal representative at this time' AS answer, '2' AS answer_code UNION 
					SELECT 'single' AS question_type, '139fdcf3-b991-4332-a858-b32d6fc05cb0' AS question_id, 'q32' AS answer_id, 'No, I have not identified a personal representative .  Please send me information by mail.' AS answer, '3' AS answer_code UNION 
					SELECT 'single' AS question_type, '139fdcf3-b991-4332-a858-b32d6fc05cb0' AS question_id, 'q32' AS answer_id, 'I don''t know' AS answer, '4' AS answer_code
					) qa
		INNER JOIN (SELECT mbr.id_medrec AS member_nbr
						 , asmt.id AS assessment_id
						 , asmt.submitted_date
						 , eav.question_id
						 , eav.question
						 , cast(COALESCE(eavext.answer, eav.answer) as varchar) AS answer
                         , af.id AS assessment_type_id
					  FROM &{IDAP_LAKE}.ASSESSMENT.helios_assessment_data_vw asmt
				INNER JOIN &{IDAP_LAKE}.ASSESSMENT.helios_assessment_form_vw af ON af.id = asmt.form_id
												 AND af.title = 'Health Risk Assessment'
				INNER JOIN &{IDAP_LAKE}.ASSESSMENT.helios_client_vw mbr ON mbr.user_id = asmt.client_id
				INNER JOIN &{IDAP_LAKE}.ASSESSMENT.helios_eav_assessment_vw eav ON eav.assessment_id = asmt.id
				 LEFT JOIN &{IDAP_LAKE}.ASSESSMENT.helios_eav_assessment_ext_vw eavext ON eavext.assessment_id = asmt.id AND eavext.question_id = eav.question_id
					 WHERE asmt.deleted = 0
					   AND asmt.status = 2
				   ) a ON a.question_id = qa.question_id AND (CASE WHEN a.question_id = '3deca42b-8293-4456-a26e-e70e54f31086' THEN 'free text'
									ELSE a.answer 
                                    END) = qa.answer) t
  GROUP BY member_nbr
		 , assessment_id
         , assessment_status
         , assessment_completed_date
         , assessment_type_id);

!set variable_substitution=false;
