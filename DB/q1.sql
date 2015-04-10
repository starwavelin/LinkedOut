SELECT  (P1.personInfo).name AS from_name, (P2.personInfo).name AS to_name
FROM	Endorsement E, Organization O1, Organization O2, Person P1, Person P2
WHERE 	E.fromURL = O1.url 
	AND E.toURL = O2.url 
	AND E.fromURL <> E.toURL 	
	AND O1.orgName = O2.orgName
	AND O1.startDate < '2013-09-18'
	AND O1.endDate > '2013-09-18'
	AND O2.startDate < '2013-09-18'
	AND O2.endDate > '2013-09-18'
	AND E.fromURL = P1.url
	AND E.toURL = P2.url
	ORDER BY from_name, to_name