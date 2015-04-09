CREATE TYPE person_type AS (
        name varchar(30),
        skills text[]
        );

CREATE TABLE Person (
        url varchar primary key,
        personInfo  person_type
        ); 

/*create both TYPE person_type and TABLE Person
 in order to use the primary key feature per homework requirement */

CREATE TABLE Organization (
        url varchar references Person(url), /* FK constraint */
        orgName varchar(30) NOT NULL,
        startDate date NOT NULL,
        endDate date NOT NULL
        ); 

CREATE TABLE Endorsement (
        fromURL varchar references Person(url), /* FK constraint */
        toURL varchar references Person(url), /* FK constraint */
        skills text[]
        ); 
