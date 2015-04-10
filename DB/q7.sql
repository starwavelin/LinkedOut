SELECT (P1.personInfo).name AS from_name, (P2.personInfo).name AS to_name
FROM Person P1, Person P2, IndirectEndorse_MoreSkill IEMS
WHERE P1.url = IEMS.fromURL AND P2.url = IEMS.toURL
ORDER BY from_name, to_name