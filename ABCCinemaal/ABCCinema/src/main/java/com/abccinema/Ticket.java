package com.abccinema;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/seat")
public class Ticket extends HttpServlet {
	 String url = "jdbc:mysql://localhost:3306/abc_cinema";
	 String username = "root";
	 String password = "1234";
	 String sql = "INSERT INTO ticket (email, name, scheduleId) VALUES (?, ?, ?)";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			String email = request.getParameter("email");
			String name = request.getParameter("name");
			String scheduleId = request.getParameter("scheduleId");
			long ticketId = 0;
			
			System.out.println(scheduleId);
		
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, username, password);
				PreparedStatement st = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				st.setString(1, email);
				st.setString(2, name);
				st.setString(3, scheduleId);
				
				st.executeUpdate();
				
				
				
				 try (ResultSet generatedKeys = st.getGeneratedKeys()) {
			            if (generatedKeys.next()) {
			                ticketId = generatedKeys.getLong(1);
			            }
			            else {
			            	System.out.println("KKKKKKKKKK");
			            }
			                //throw new SQLException("Creating user failed, no ID obtained.");
			          }
		
				response.sendRedirect("seat.jsp?ticketId=" + Long.toString(ticketId) + "&scheduleId=" + scheduleId);
			
//				while(rs.next()) {
//					rs.getString(1);
//				}
					
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("DSDSSD");
				e.printStackTrace();
			}
	}

}
