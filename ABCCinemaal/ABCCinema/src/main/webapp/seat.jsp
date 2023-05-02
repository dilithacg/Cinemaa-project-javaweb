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
 	import="java.sql.Statement"
 %>

<% 
	String url = "jdbc:mysql://localhost:3306/abc_cinema";
	String username = "root";
	String password = "1234";
	// String sql = "SELECT movieId FROM movie LIMIT 3";
	String sql2 = "SELECT seatId FROM reservation WHERE scheduleId=?";	
	String scheduleId = request.getParameter("scheduleId");
	String ticketId = request.getParameter("ticketId");
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, username, password);
		PreparedStatement st = con.prepareStatement(sql2);
		st.setString(1, scheduleId);

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/main.css" />
<title>ABC Cinema</title>
</head>
<body>
	<%@include file="includes/navigation.jsp"  %> 
	
	<div class="wrapper">
		<div class="wrapper-inner">
			<div class="container" style="padding-bottom: 25px">
				<div class="round-nav-wrapper">
					<div class="nav-wrapper-inner">
						<div class="nav-h-line"></div>
						
						<div class="round-nav-numbers all-center">
							<div class="nav-round round-1">1</div>
							<div class="nav-round round-1 current">2</div>
							<div class="nav-round round-1">3</div>
						</div>
					</div>
				</div>	
			</div>
			<div class="container" style="width: 50%;">
				<div class="screen">SCREEN</div>
			</div>
				<form class="container" style="margin: 25px auto; width: 50%;" method="POST" action="create-checkout-session?scheduleId=<% out.println(scheduleId); %>&ticketId=<% out.println(ticketId); %>">		
					<% 
					String[] seatLetters = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J"};
					
					for(int i = 0; i < 10; i++) { 
					%>
						<div class="seat-row">
							<% for(int d = 1; d <= 9; d++) {
								boolean isReserved = false;
								ResultSet rs = st.executeQuery();
							%>
							<% while(rs.next()) { 
								// out.println(rs.getString(1));
								String id = seatLetters[i] + Integer.toString(d);
		
								if(rs.getString(1).equals(id)) {
									isReserved = true;
								}
							}
							if(isReserved) {
								%>
							
								<input class="booked" onclick="reserveSeat(this)" type="checkbox" id="<% out.println(seatLetters[i] + Integer.toString(d)); %>" name="seat" value="<% out.println(seatLetters[i] + Integer.toString(d)); %>" disabled>
    							<label class="booked" for="<% out.println(seatLetters[i] + Integer.toString(d)); %>"><% out.println(seatLetters[i] + Integer.toString(d)); %></label>
								<%
							} else {
								%>
								<input onclick="reserveSeat(this)" type="checkbox" id="<% out.println(seatLetters[i] + Integer.toString(d)); %>" name="seat" value="<% out.println(seatLetters[i] + Integer.toString(d)); %>">
    								<label for="<% out.println(seatLetters[i] + Integer.toString(d)); %>"><% out.println(seatLetters[i] + Integer.toString(d)); %></label>
							<% } %>												
								
							
							<%} %>
						</div>
					<% } %>
					
					<%
	} catch (Exception e) {
		// TODO Auto-generated catch block
		System.out.println("DSDSSD");
		e.printStackTrace();
	}
					%>
					
					<div class="price-container">
						<div class="selected-seats all-center">
							
						</div>
						<h1 class="total">LKR <span id="amount">0</span></h1>
					</div>
					
					<div class="pay-btn-container">
						
					</div>
						
				</form>
			</div>
	</div>
	
	
	<script>
		const totalDOM = document.querySelector("#amount")
		const payButtonContainer = document.querySelector(".pay-btn-container")
		
		let total = 0;
		
		function reserveSeat(element) { 
			const selectedSeatsDOM = document.querySelector(".selected-seats")
			const url = new URL(window.location.href)
			
			const ticketId = url.searchParams.get("ticketId")
			const scheduleId = url.searchParams.get("scheduleId")
			const seatId = element.value.trim()
			
			
			fetch("http://localhost:8080/ABCCinema/makereservation?seatId=" + seatId +"&scheduleId=" + scheduleId + "&ticketId=" + ticketId)
			.then((e) => {
				if(!element.checked) {
					total -= 1000
					totalDOM.innerHTML = total
					
					const div = document.getElementById(seatId);
					console.log(div)
					selectedSeatsDOM.removeChild(div)
				} else {
					total += 1000
					totalDOM.innerHTML = total
					
					const div = document.createElement("div");
					div.innerText = seatId;
					div.classList.add("seat-box")
					div.classList.add("all-center")
					div.id = seatId
				
					selectedSeatsDOM.appendChild(div)
				}
				
				if(total >= 1000) {
					payButtonContainer.innerHTML = '<input class="admin-login-btn" style="margin-top: 25px;" type="submit" value="PAY" />'
				} else {
					payButtonContainer.innerHTML = ""
				}
			})
			.catch()
			
		}
		
	</script>
</body>
</html>