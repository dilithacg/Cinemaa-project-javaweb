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
<title>Insert title here</title>
<link rel="stylesheet" href="css/main.css" />
</head>
<body>
	<%@include file="includes/navigation.jsp"  %> 
	
	<%
		String movie_id = request.getParameter("id"); 
	
		String api_key = application.getInitParameter("omdb_api_key");

		URL url2 = new URL("http://www.omdbapi.com/?apikey="+api_key+"&plot=full&i=" + movie_id);

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
			
		
		JSONParser parser = new JSONParser();
		try {
			JSONObject data = (JSONObject) parser.parse(String.valueOf(informationString));
	%>
	
	<div class="wrapper more-info">
		<div class="wrapper-inner">
			<div class="container">
				<h1 class="text-center"><% out.println(data.get("Title")); %></h1>
				
				<img src="<% out.println(data.get("Poster")); %>" alt="Name" 
				style="margin:25px auto 10px auto; display: block; text-align: center; width: 250px;"/>
				
				<div class="movie-info-details text-center all-center">
					<div class="all-center">
						<img src="img/icons/star.png" alt="Rating: " style="width: 35px"/> 
						<h2><% out.println(data.get("imdbRating")); %></h2>
					</div>
					
					<div class="all-center">
						<img src="img/icons/date.png" alt="Date: " style="width: 35px"/> 
						<h2><% out.println(data.get("Released")); %></h2>
					</div>
					
					<div class="all-center">
						<img src="img/icons/time.png" alt="Time: " style="width: 35px"/> 
						<h2><% out.println(data.get("Runtime")); %></h2>
					</div>
					
				</div>
				
				<div class="more-info-plot">
					<h3>Story Line</h3>
					<div class="h-line"></div>
					<p>
						<% out.println(data.get("Plot")); %>
					</p>
				</div>
				
				
				<div class="all-center" style="margin: 50px 0;">
					<a href="userDetails.jsp?id=<% out.println(data.get("imdbID")); %>" class="btn-gold">Buy Tickets</a>
				</div>
				
				
				<form style="margin: 0 auto 25px auto; width: 80%" action="changeMovie" method="POST" class="admin-login-form">
				<h2 style="margin-top: 0; color: #333;">Tell us about your experience</h2>
				
				<input type="text" placeholder="Name" class="admin-login-input" name="name" required/>
					
				<input type="email" placeholder="Email" class="admin-login-input" name="email" required/>
				<input type="text" placeholder="Comment" class="admin-login-input" name="comment" required/>
				
				<input type="submit" value="ADD" class="admin-login-btn" />
			</form>
				
			</div>
		</div>
	</div>
	<%
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			System.out.println(e);
			e.printStackTrace();
		}
		}
	%>
</body>
</html>


