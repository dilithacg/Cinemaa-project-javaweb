package com.abccinema;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/admin/scheduleMovie")
public class ScheduleMovie extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "jdbc:mysql://localhost:3306/abc_cinema";
		String username = "root";
		String password = "1234";
		String sql = "INSERT INTO movieschedule (movieId, showTime, showDate) VALUES (?, ?, ?)";
		
		String movieId = request.getParameter("id").trim();
		String showTime = request.getParameter("showTime");
		String showDate = request.getParameter("showDate");
	
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, movieId);
			st.setString(2, showTime);
			st.setString(3, showDate);
			
			st.executeUpdate();
			
			response.sendRedirect("dashboard.jsp");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e);
			e.printStackTrace();
		}
		
	}

}
