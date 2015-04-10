SELECT	(P1.personInfo).name AS from_name, (P2.personInfo).name AS to_name
FROM 	Person P1, Person P2
WHERE	P1.url <> P2.url		/* P1 and P2 are different persons */
	AND ((P1.personInfo).skills IS NOT NULL AND (P2.personInfo).skills IS NULL) 
					/* P1 has any skills while P2 has nothing */
	OR (
		(P1.personInfo).skills @> (P2.personInfo).skills	
							/* P1 has every skill that P2 has */
		AND array_length((P1.personInfo).skills, 1) > array_length((P2.personInfo).skills, 1)	
							/* P1 has a skill that that P2 does Not have */	
	) 
	ORDER BY from_name, to_name