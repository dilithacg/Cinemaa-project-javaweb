package com.abccinema.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class LoginDao {
	static String url = "jdbc:mysql://localhost:3306/abc_cinema";
	static String username = "root";
	static String password = "1234";
	static String sql = "SELECT password FROM admin WHERE username=?";
	
	public static String getPassword(String uname) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, uname);
			
			ResultSet rs = st.executeQuery();
			
			while(rs.next()) {
				return rs.getString(1);
			}
				
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("DSDSSD");
			e.printStackTrace();
			return null;
		}
		
		return null;
	}
}
