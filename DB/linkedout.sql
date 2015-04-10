DROP VIEW IF EXISTS DirectEndorse_MoreSkill;
DROP VIEW IF EXISTS IndirectEndorse_MoreSkill;
DROP VIEW IF EXISTS IndirectEndorse; 
DROP VIEW IF EXISTS DirectEndorse; 
DROP VIEW IF EXISTS endorsed_eachskill;
DROP VIEW IF EXISTS more_skill;
DROP VIEW IF EXISTS IndirectEndorse;
DROP VIEW IF EXISTS single_endorse;
DROP VIEW IF EXISTS single_skill;
DROP TABLE IF EXISTS Endorsement;
DROP TABLE IF EXISTS Organization;
DROP TABLE IF EXISTS Person;
DROP TYPE IF EXISTS person_type;

CREATE TYPE person_type AS(	
	name	varchar(30),
	skills	text[]
);

CREATE TABLE Person		
(
	url 	varchar primary key,
	personInfo 	person_type
);
/* create both TYPE person_type and TABLE Person 
	in order to use the primary key feature */


CREATE TABLE Organization (
	url		varchar 	references Person(url),	/* foreign key constraint */
	orgName		varchar(30) NOT NULL,
	startDate	date 	NOT NULL,
	endDate		date 	NOT NULL	
);

CREATE TABLE Endorsement (
	fromURL	varchar 	references Person(url), /* foreign key constraint */
	toURL	varchar 	references Person(url), /* foreign key constraint */
	skills		text[]	
);

INSERT INTO Person VALUES ('www.linkedout.com/alice', ROW('Alice', '{"Programming", "Instructor"}'));
INSERT INTO Person VALUES ('www.linkedout.com/bob', ROW('Bob', '{"Programming"}'));
INSERT INTO Person VALUES ('www.linkedout.com/carol', ROW('Carol', NULL));
INSERT INTO Person VALUES ('www.linkedout.com/dave', ROW('Dave', '{"Programming"}'));
INSERT INTO Person VALUES ('www.linkedout.com/eve', ROW('Eve', NULL));
INSERT INTO Person VALUES ('www.linkedout.com/frank', ROW('Frank', '{"Programming"}'));
INSERT INTO Person VALUES ('www.linkedout.com/mallory', ROW('Mallory', '{"Programming", "Basketball"}'));
INSERT INTO Person VALUES ('www.linkedout.com/thor', ROW('Thor', '{"Programming", "Instructor", "Hammer Wielding"}'));
	
	
INSERT INTO Organization VALUES ('www.linkedout.com/alice', 'Stony Brook', '2013-01-01', '2013-09-30');
INSERT INTO Organization VALUES ('www.linkedout.com/bob', 'Stony Brook', '2013-08-01', '2013-12-31');
INSERT INTO Organization VALUES ('www.linkedout.com/bob', 'Microsoft', '2014-01-01', '2014-12-31');
INSERT INTO Organization VALUES ('www.linkedout.com/carol', 'IBM', '2013-06-01', '2013-12-31');
INSERT INTO Organization VALUES ('www.linkedout.com/dave', 'IBM', '2013-06-01', '2013-07-15');
INSERT INTO Organization VALUES ('www.linkedout.com/eve', 'Google', '2012-04-01', '2014-02-01');
INSERT INTO Organization VALUES ('www.linkedout.com/eve', 'Paypal', '2008-01-05', '2012-03-01');
INSERT INTO Organization VALUES ('www.linkedout.com/frank', 'Google', '2012-06-01', '2014-01-01');
INSERT INTO Organization VALUES ('www.linkedout.com/frank', 'Ebay', '2006-12-05', '2012-05-20');
INSERT INTO Organization VALUES ('www.linkedout.com/mallory', 'Oracle', '2008-08-30', '2014-03-30');
INSERT INTO Organization VALUES ('www.linkedout.com/mallory', 'Paypal', '2008-01-05', '2012-03-01');
INSERT INTO Organization VALUES ('www.linkedout.com/mallory', 'Ebay', '2006-12-05', '2007-12-20');
INSERT INTO Organization VALUES ('www.linkedout.com/thor', 'Asgard', '2000-01-01', '2013-12-31');
	
INSERT INTO Endorsement VALUES ('www.linkedout.com/bob', 'www.linkedout.com/alice', '{"Programming", "Instructor"}');
INSERT INTO Endorsement VALUES ('www.linkedout.com/bob', 'www.linkedout.com/carol', '{"Programming"}');
INSERT INTO Endorsement VALUES ('www.linkedout.com/carol', 'www.linkedout.com/alice', '{"Programming"}');
INSERT INTO Endorsement VALUES ('www.linkedout.com/carol', 'www.linkedout.com/bob', '{"Programming"}');
INSERT INTO Endorsement VALUES ('www.linkedout.com/dave', 'www.linkedout.com/carol', '{"Programming"}');
INSERT INTO Endorsement VALUES ('www.linkedout.com/frank', 'www.linkedout.com/eve', '{"Programming", "Quality Assurance"}');
INSERT INTO Endorsement VALUES ('www.linkedout.com/mallory', 'www.linkedout.com/eve', '{"Programming"}');
INSERT INTO Endorsement VALUES ('www.linkedout.com/mallory', 'www.linkedout.com/frank', '{"Programming"}');
INSERT INTO Endorsement VALUES ('www.linkedout.com/mallory', 'www.linkedout.com/mallory', '{"Programming"}');
INSERT INTO Endorsement VALUES ('www.linkedout.com/thor', 'www.linkedout.com/dave', '{"Programming"}');


CREATE VIEW single_endorse AS
	SELECT  P1.url as from, P2.url as to, (P1.personInfo).name as from_name, (P2.personInfo).name as to_name, UNNEST(E.skills) as skill
	  FROM	Endorsement E, Person P1, Person P2
	  WHERE E.fromURL = P1.url and
	        E.toURL = P2.url;

CREATE VIEW single_skill AS
	SELECT  P.url AS url, UNNEST((P.personInfo).skills) as skill
	  FROM	Person P;
	  
CREATE VIEW endorsed_eachskill AS
	SELECT DISTINCT SS.url AS url
	FROM single_skill SS, single_endorse SE
	WHERE  SS.url<>SE.from AND SS.url = SE.to AND SS.skill = SE.skill;	 

CREATE VIEW more_skill AS
SELECT	P1.url AS U1, P2.url AS U2
FROM 	Person P1, Person P2
WHERE	P1.url <> P2.url		/* P1 and P2 are different persons */
	AND ((P1.personInfo).skills IS NOT NULL AND (P2.personInfo).skills IS NULL) 
					/* P1 has any skills while P2 has nothing */
	OR (
		(P1.personInfo).skills @> (P2.personInfo).skills	
							/* P1 has every skill that P2 has */
		AND array_length((P1.personInfo).skills, 1) > array_length((P2.personInfo).skills, 1)	
							/* P1 has a skill that that P2 does Not have */	
	);	


CREATE VIEW DirectEndorse(fromURL, toURL) AS
SELECT fromURL, toURL FROM Endorsement
EXCEPT
SELECT E1.fromURL, E1.toURL FROM Endorsement E1, Endorsement E2 WHERE E1.fromURL = E2.toURL AND E2.fromURL = E1.toURL;


CREATE RECURSIVE VIEW IndirectEndorse(fromURL, toURL) AS
SELECT * FROM DirectEndorse
UNION
SELECT DE.fromURL, I.toURL
FROM DirectEndorse DE, IndirectEndorse I
WHERE DE.toURL = I.fromURL;

CREATE VIEW DirectEndorse_MoreSkill(fromURL, toURL) AS
SELECT fromURL, toURL FROM Endorsement, more_skill MS WHERE fromURL = MS.U1 AND toURL = MS.U2
EXCEPT
SELECT E1.fromURL, E1.toURL FROM Endorsement E1, Endorsement E2 WHERE E1.fromURL = E2.toURL AND E2.fromURL = E1.toURL;

CREATE RECURSIVE VIEW IndirectEndorse_MoreSkill(fromURL, toURL) AS
SELECT * FROM DirectEndorse_MoreSkill
UNION
SELECT DEMS.fromURL, IM.toURL
FROM DirectEndorse_MoreSkill DEMS, IndirectEndorse_MoreSkill IM
WHERE DEMS.toURL = IM.fromURL;