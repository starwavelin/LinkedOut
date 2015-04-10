package com.starwavelin.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Help Class to the 2nd Query
 */
public class DBQ2Help {

	public static boolean checkIfBothBeenEndorsedFromSameThirdUser(
			Connection conn, String from, String to, String skill) throws SQLException{
		
		List<String> l1 = new ArrayList<String>();
		List<String> l2 = new ArrayList<String>();
		
		String sqlStmt = "SELECT SE.from_name"
				+ " FROM single_endorse SE"
				+ " WHERE SE.to_name = ?"
				+ " AND SE.skill = ?";
		PreparedStatement checkQ2SQL = conn.prepareStatement(sqlStmt);
		checkQ2SQL.setString(1, to);
		checkQ2SQL.setString(2, skill);
		
		ResultSet rs = checkQ2SQL.executeQuery();
		while (rs.next()) {
			l1.add(rs.getString("from_name"));
		}
		
		checkQ2SQL.setString(1, from);
		rs = checkQ2SQL.executeQuery();
		while (rs.next()) {
			l2.add(rs.getString("from_name"));
		}
		
		for (String s : l1) {
			if (l2.contains(s)) {
				conn.close();
				return true;
			}
		}
		
		System.out.println(l1.toString() + "    " + l2.toString() + "\n\n");
		
		conn.close();
		return false;
	}
}