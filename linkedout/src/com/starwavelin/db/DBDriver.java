package com.starwavelin.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * The main business logic (answering the 7 query questions) is here.
 */
public class DBDriver {

	private Connection conn;

	public DBDriver() {
		conn = new DBConnection().getConnection();
	}

	/* The 7 queries */
	private final String QUERY_1 = 
			"SELECT (P1.personInfo).name AS from_name, (P2.personInfo).name AS to_name "
			+ "FROM	Endorsement E, Organization O1, Organization O2, Person P1, Person P2 "
			+ "WHERE E.fromURL = O1.url  "
			+ "AND E.toURL = O2.url "
			+ "AND E.fromURL <> E.toURL "
			+ "AND O1.orgName = O2.orgName "
			+ "AND O1.startDate < '2013-09-18' "
			+ "AND O1.endDate > '2013-09-18' "
			+ "AND O2.startDate < '2013-09-18' "
			+ "AND O2.endDate > '2013-09-18' "
			+ "AND E.fromURL = P1.url "
			+ "AND E.toURL = P2.url " + "ORDER BY from_name, to_name";

	private final String QUERY_2 = 
			"SELECT SE.from_name, SE.to_name, SE.skill "
			+ "FROM single_endorse SE, single_skill SS "
			+ "WHERE SS.skill = SE.skill AND SE.from = SS.url AND SE.from <> SE.to AND "
			+ "0 < (select count(*) FROM single_endorse SEE "
			+ "WHERE SE.from <> SEE.from AND SE.to <> SEE.from AND SE.skill = SEE.skill AND SEE.to = SE.from) AND "
			+ "0 < (select count(*) FROM single_endorse SEE "
			+ "WHERE SE.from <> SEE.from AND SE.to <> SEE.from AND SE.skill = SEE.skill AND SEE.to = SE.to)";

	private final String QUERY_3 = "SELECT	DISTINCT (P.personInfo).name AS name "
			+ "FROM	Person P, single_endorse SE1 "
			+ "WHERE 	P.url = SE1.to "
			+ "AND 2 <= (SELECT count(SE2.to) "
			+ "FROM single_endorse SE2 "
			+ "WHERE 	SE1.to = SE2.to "
			+ "AND SE1.skill = SE2.skill "
			+ "AND SE2.from <> SE2.to "
			+ "AND SE1.skill NOT IN ( "
			+ "SELECT SS.skill "
			+ "FROM single_skill SS "
			+ "WHERE SE1.to = SS.url " + ")) " + "ORDER BY name ";

	private final String QUERY_4 = "SELECT	(P1.personInfo).name AS from_name, (P2.personInfo).name AS to_name "
			+ "FROM 	Person P1, Person P2 "
			+ "WHERE	P1.url <> P2.url "
			+ "AND ((P1.personInfo).skills IS NOT NULL AND (P2.personInfo).skills IS NULL) "
			+ "OR ( "
			+ "(P1.personInfo).skills @> (P2.personInfo).skills	"
			+ "AND array_length((P1.personInfo).skills, 1) > array_length((P2.personInfo).skills, 1) "
			+ ") " + "ORDER BY from_name, to_name ";

	private final String QUERY_5 = "SELECT	DISTINCT (P1.personInfo).name AS from_name, (P2.personInfo).name AS to_name "
			+ "FROM 	Person P1, Person P2, endorsed_eachskill EES, more_skill MS "
			+ "WHERE	P1.url = EES.url "
			+ "AND P1.url = MS.U1 "
			+ "AND P2.url = MS.U2 " + "ORDER BY from_name, to_name ";

	private final String QUERY_6 = "SELECT (P1.personInfo).name AS from_name, (P2.personInfo).name AS to_name "
			+ "FROM Person P1, Person P2, IndirectEndorse IE "
			+ "WHERE P1.url = IE.fromURL AND P2.url = IE.toURL "
			+ "ORDER BY from_name, to_name ";

	private final String QUERY_7 = "SELECT (P1.personInfo).name AS from_name, (P2.personInfo).name AS to_name "
			+ "FROM Person P1, Person P2, IndirectEndorse_MoreSkill IEMS "
			+ "WHERE P1.url = IEMS.fromURL AND P2.url = IEMS.toURL "
			+ "ORDER BY from_name, to_name ";
	
	
	public String getResult(int queryIndex) throws SQLException {
		StringBuilder ret = new StringBuilder();
		
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = null;
			int counter;
			
			switch(queryIndex) {
			case 1:
				rs = stmt.executeQuery(QUERY_1);
				counter = 0;
				while (rs.next()) {
					ret.append(rs.getString("from_name") + " endorses " + rs.getString("to_name") + "<br />");
					counter++;
				}
				ret.append("<br />There are " + counter + " records in the results.<br />");
				break;
			case 2:
				rs = stmt.executeQuery(QUERY_2);
				counter = 0;
				while (rs.next()) {
					String from = rs.getString("from_name");
					String to = rs.getString("to_name");
					String skill = rs.getString("skill");
					if (DBQ2Help.checkIfBothBeenEndorsedFromSameThirdUser
							(conn, from, to, skill)) {
						ret.append(from + " endorses " + to + "<br />");
						counter++;
					}
				}
				ret.append("<br />There are " + counter + " records in the results.<br />");
				break;
			case 3:
				rs = stmt.executeQuery(QUERY_3);
				counter = 0;
				while (rs.next()) {
					ret.append(rs.getString("name") + "<br />");
					counter++;
				}
				ret.append("<br />There are " + counter + " records in the results.<br />");
				break;
			case 4:
				rs = stmt.executeQuery(QUERY_4); 
				counter = 0;
				while (rs.next()) {
					ret.append(rs.getString("from_name") + " is more skilled than " + rs.getString("to_name") + "<br />");
					counter++;
				}
				ret.append("<br />There are " + counter + " records in the results.<br />");
				break;
			case 5:
				rs = stmt.executeQuery(QUERY_5);
				counter = 0;
				while (rs.next()) {
					ret.append(rs.getString("from_name") + " is more certified than " + rs.getString("to_name") + "<br />");
					counter++;
				}
				ret.append("<br />There are " + counter + " records in the results.<br />");
				break;
			case 6:
				rs = stmt.executeQuery(QUERY_6);
				counter = 0;
				while (rs.next()) {
					ret.append(rs.getString("from_name") + " indirectly endorses " + rs.getString("to_name") + "<br />");
					counter++;
				}
				ret.append("<br />There are " + counter + " records in the results.<br />");
				break;
			case 7:
				rs = stmt.executeQuery(QUERY_7); 
				counter = 0;
				while (rs.next()) {
					ret.append(rs.getString("from_name") + " skill descending "
							+ "indirectly endorses " + rs.getString("to_name") + "<br />");
					counter++;
				}
				ret.append("<br />There are " + counter + " records in the results.<br />");
				break;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			conn.close();
		}
		
		return ret.toString();
	}
}