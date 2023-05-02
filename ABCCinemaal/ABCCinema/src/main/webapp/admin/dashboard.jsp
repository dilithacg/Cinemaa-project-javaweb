<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


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
	String sql = "SELECT movieId FROM movie";
		
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="../css/main.css" />
<title>ABC Cinema</title>
</head>
<body style="height: 100vh;">
	
	<nav>
		<div class="container">
			<h3 class="brand">ABC - Admin</h3>
		</div>
	</nav>
	
	<div class="wrapper">
		<div class="wrapper-inner">
			<div class="container">
			<a href="change.jsp" class="admin-link">Add Movies</a>
			<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection(url, username, password);
				PreparedStatement st = con.prepareStatement(sql);
				
				ResultSet rs = st.executeQuery();
				
				while(rs.next()) {
					String movie_id = rs.getString(1); 
					
					String api_key = application.getInitParameter("omdb_api_key");

					URL url2 = new URL("http://www.omdbapi.com/?apikey="+api_key+"&i=" + movie_id);
					System.out.println(url2);
					HttpURLConnection conn = (HttpURLConnection) url2.openConnection();
					
					conn.setRequestMethod("GET");
					conn.connect();
					
					int responseCode = conn.getResponseCode();
					
					if(responseCode != 200) {
						System.out.println("ERROR");
					} else {
						StringBuilder informationString = new StringBuilder();
						Scanner scanner = new Scanner(url2.openStream());
						while(scanner.hasNext()) {
							informationString.append(scanner.nextLine());
						}
						
						scanner.close();
						
						// System.out.println(informationString);
							
						
						JSONParser parser = new JSONParser();
						try {
							// JSONArray dataObject = (JSONArray) parse.parse(String.valueOf(informationString));
							
							// System.out.println(dataObject.get(0));
							
							JSONObject data = (JSONObject) parser.parse(String.valueOf(informationString));
							
							%>
							
								<div class="admin-movie-item">
									<img src="<% out.println(data.get("Poster")); %>" alt="movie_poster" />
					
									<div class="admin-movie-item-buttons">
										<h3 style="margin: 0;"><% out.println(data.get("Title")); %></h3>	
										
										<a href="schedulechange.jsp?id=<% out.println(data.get("imdbID")); %>" class="admin-link">Manage Schedule</a>
									</div>
									
									
								</div>
							
							<%
							
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							System.out.println(e);
							e.printStackTrace();
						}
					}
				}
					
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("DSDSSD");
				e.printStackTrace();	
			}
			%>
			
		
			
			</div>
		</div>
	</div>
</body>
</html>