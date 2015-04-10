School Project: Use Java Servlet, PostgreSQL, Bootstrap CSS and JavaScript to develop a simplified version of LinkedIn, with basic endorsing logic implemented. 

Initially, this project was done by my teammate and me in the windows environment. At that time, I focused on the part of the table creation, writing the 7 SQL queries and parts of Java Servlet; my teammate focused on the part of Java Servlet, query for Question Number 2 , and Bootstrap CSS, as illustrated in this original [design proposal](docs/linkedoutReport.pdf).

Now, I am rewriting this project all myself using PostgreSQL 9.3 and Eclipse EE 4.4.2 in Ubuntu 14.04 LTS. And, all the version control processes are done by Git command line instead of using GitHub Client. Also, the front-end jsp file will use HTML5 format.

library used: postgresql-9.3-1100.jdbc4.jar

###Configure this project:

Step 1: Make sure you have PostgreSQL (prefer version 9.3 or above), Eclipse EE, Apache Tomcat (prefer version 7) installed on your machine; Eclipse EE is successfully configured with Apache Tomcat.

Step 2: Create a DB named "loDB" (linkedout database) under a DB user. For example, I use DB user "postgres". Then, issue command $ psql -U postgres -d loDB -h 127.0.0.1 -p 5432; after entering the password for user "postgres", you have entered the postgres command line loDB=#

Step 3: In the command line loDB=#, Run the "linkedout.sql" script in DB folder to setup the database for this project; other scripts in this DB folder are for you to check the answers to the 7 questions in the project proposal. Moreover, the Question #2 is not fully implemented by q2.sql; the program uses q2.sql and src/com/starwavelin/DB/DBQ2Help.java to resolve it. 

Step 4: Run this project in Eclipse using your local Apache Tomcat server. That's it. 
