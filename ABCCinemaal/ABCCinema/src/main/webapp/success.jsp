<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@page
	import="java.io.IOException"
	import="java.net.HttpURLConnection"
	import="java.net.URL"
	import="java.util.Scanner"
	
	import="javax.servlet.ServletException"
	import="javax.servlet.annotation.WebServlet"
	import="javax.servlet.http.HttpServlet"
	import="javax.servlet.http.HttpServletRequest"
	import="javax.servlet.http.HttpServletResponse"
	
	import="org.json.simple.JSONArray"
	import="org.json.simple.JSONObject"
	import="org.json.simple.parser.JSONParser"
	import="org.json.simple.parser.ParseException"
	
	import="java.sql.Connection"
	import="java.sql.DriverManager"
	import="java.sql.PreparedStatement"
	import="java.sql.ResultSet"
 %>
 
 <%
 	String url = "jdbc:mysql://localhost:3306/abc_cinema";
	String username = "root";
	String password = "1234";
	String sql = "SELECT ticket.ticketId, ticket.name, ticket.email, movieschedule.showDate, movieschedule.showTime FROM ticket INNER JOIN movieschedule ON movieschedule.scheduleId=ticket.scheduleId WHERE ticketid=?";
	String sql1 = "UPDATE reservation SET isConfirm=true WHERE ticketId=?";
	%>
 
 <%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, username, password);
		
		PreparedStatement st = con.prepareStatement(sql);
		PreparedStatement st1 = con.prepareStatement(sql1);
		
		st1.setString(1, request.getParameter("ticketId"));
		st.setString(1, request.getParameter("ticketId"));
		
		
		st1.executeUpdate();
		ResultSet rs = st.executeQuery();
 %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Success</title>
<link rel="stylesheet" href="css/main.css" />
</head>
<body>
	<%@include file="includes/navigation.jsp"  %> 
 
	<div class="wrapper">
		<div class="wrapper-inner">
			<div class="all-center">
			<div class="admin-login-form">
				<h2 style="margin-top: 0;">PURCHASED TICKET DETAILS</h2>				
				<ul class="ticket-details">
				<%
				while(rs.next()) { 
					%>
						<li>
							<strong>Ticket Id: </strong>
							<% out.println(rs.getString(1)); %>
						</li>
						
						<li>
							<strong>Name: </strong>
							<% out.println(rs.getString(2)); %>
						</li>
						
						<li>
							<strong>Email: </strong>
							<% out.println(rs.getString(3)); %>
						</li>
						
						<li>
							<strong>Time: </strong>
							<% out.println(rs.getString(4)); %>
						</li>
						
						<li>
							<strong>Date: </strong>
							<% out.println(rs.getString(5)); %>
						</li>
					<% 
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println(e);
				e.printStackTrace();
			}
				%>
				</ul>
			</div>
		</div>
		</div>
	</div>
</body>
</html>