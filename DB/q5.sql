SELECT	DISTINCT (P1.personInfo).name AS from_name, (P2.personInfo).name AS to_name
FROM 	Person P1, Person P2, endorsed_eachskill EES, more_skill MS 
WHERE	P1.url = EES.url	/* P1 was endorsed for each of his skills */
	AND P1.url = MS.U1
	AND P2.url = MS.U2	/* P1 is more skilled than P2 */
	ORDER BY from_name, to_name	
	