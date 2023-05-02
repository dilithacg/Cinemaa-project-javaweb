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
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/main.css" />
<title>ABC Cinema</title>
</head>
<body>
	<%@include file="includes/navigation.jsp"  %> 
	
	<%
	String url = "jdbc:mysql://localhost:3306/abc_cinema";
	String username = "root";
	String password = "1234";
	String movieId = request.getParameter("id");
	String sql = "SELECT * FROM movieschedule WHERE movieId=?";
	
		
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, username, password);
				PreparedStatement st = con.prepareStatement(sql);
				st.setString(1, movieId);
				
				ResultSet rs = st.executeQuery();	
	%>
	
	<div class="wrapper">
		<div class="wrapper-inner">
			<div class="container">
				<div class="round-nav-wrapper">
					<div class="nav-wrapper-inner">
						<div class="nav-h-line"></div>
						
						<div class="round-nav-numbers all-center">
							<div class="nav-round round-1 current">1</div>
							<div class="nav-round round-1">2</div>
							<div class="nav-round round-1">3</div>
						</div>
					</div>
				</div>	
			</div>
			
			<div class="container all-center">
				<form method="POST" action="seat" class="admin-login-form">	
				<h2 style="margin: 0 0 15px 0">Enter your details</h2>
					
					<input type="text" name="name" placeholder="Name" class="admin-login-input" required />
					<input type="email" name="email" placeholder="Email" class="admin-login-input" required />
					
					<select name="scheduleId">
						<%
						while(rs.next()) {
						%>
						<option value="<% out.println(rs.getString(1)); %>">
							<% out.println(rs.getString(4)); %> - <% out.println(rs.getString(3)); %>
						</option>
						
						<%
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("DSDSSD");
				e.printStackTrace();
			}
				%>
					</select>
					
					<input type="submit" value="Next" class="admin-login-btn"/>
				</form>
				
				
			</div>
		</div>
	</div>
</body>
</html>

