package com.starwavelin.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	private Connection conn;
	
	public static final String dbname = "loDB";		// Modify this to be your own DB name
	public static final String dbuser = "postgres"; // Modify this to be your own DB user name
	public static final String dbps = "postgres";	// Modify this to be your own DB user pwd name
		
	public Connection getConnection() {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		System.out.println("PostgreSQL JDBC Driver registered!");
		
		try {
			conn = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/" + dbname,
					dbuser, dbps);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if (conn != null) {
			System.out.println("LinkedOut DB connected!");
		} else {
			System.out.println("LinkedOut DB failed to connect, please check it...");
		}
		return conn;
	}
	
	/*public void closeConn() {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}*/
	
	/** Test Connection **/
	/*public static void main(String[] args) {
		DBConnection dbc = new DBConnection();
		dbc.getConnection();
	}*/
}