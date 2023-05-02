package com.abccinema;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MakeReservation extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ticketId = request.getParameter("ticketId");
		String scheduleId = request.getParameter("scheduleId");
		String seatId = request.getParameter("seatId");
		
		String url = "jdbc:mysql://localhost:3306/abc_cinema";
		String username = "root";
		String password = "1234";
		String sql = "INSERT INTO reservation (ticketId, seatId, scheduleId) VALUES(?, ?, ?)";	
		String sql1 = "SELECT seatId FROM reservation WHERE scheduleId=? AND seatId=?";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);
			PreparedStatement selectSt = con.prepareStatement(sql1);
			selectSt.setString(1, scheduleId);
			selectSt.setString(2, seatId);
			
			ResultSet rs = selectSt.executeQuery();
			
			System.out.println("GGGGGGGGGGGGGGGG");
			boolean isEmpty = true;
			
			while(rs.next()) {
				isEmpty = false;
			}
			
			if(isEmpty) {
				PreparedStatement st = con.prepareStatement(sql);
				st.setString(1, ticketId);
				st.setString(2, seatId);
				st.setString(3, scheduleId);
				
				st.executeUpdate();
			} else {
				PreparedStatement st = con.prepareStatement("DELETE FROM reservation WHERE scheduleId=? AND seatId=? AND NOT isConfirm");
				st.setString(1, scheduleId);
				st.setString(2, seatId);
				st.executeUpdate();
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("DSDSSD");
			e.printStackTrace();
		}
		
	}
}
