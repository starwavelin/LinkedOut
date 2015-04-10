/* Users who do not have a certain skills 
	but were endorsed by at least two other users for that skill
 */
SELECT	DISTINCT (P.personInfo).name AS name
FROM	Person P, single_endorse SE1 
WHERE 	P.url = SE1.to
	AND 2 <= (SELECT count(SE2.to)
		FROM single_endorse SE2
		WHERE 	SE1.to = SE2.to
			AND SE1.skill = SE2.skill	
			AND SE2.from <> SE2.to			
					/* Users that were endorsed by at least two other users for that skill */
			AND SE1.skill NOT IN (
				SELECT SS.skill
				FROM single_skill SS
				WHERE SE1.to = SS.url
			)		/* Users do not have that certain skill */
		)			
	ORDER BY name
