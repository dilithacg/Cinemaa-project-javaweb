<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Change Movie</title>
<link rel="stylesheet" href="../css/main.css" />
</head>
<body>
	<nav>
		<div class="container">
			<h3 class="brand">ABC - Admin</h3>
		</div>
	</nav>
	
	<div class="wrapper">
		<div class="wrapper-inner">
				<div class="all-center">
					<form action="scheduleMovie" method="POST" class="admin-login-form">
				<h2 style="margin-top: 0;">Manage Time Slots</h2>
				<% 
					if(request.getParameter("error") != null) {
						out.println("<p class=\"msg-error\">"+ request.getParameter("error") +"</p>");
					}
				%>
				<!-- <input type="text" placeholder="Movie ID" class="admin-login-input" name="movieId" required/>  -->
				
				<% 
					if(request.getParameter("passwordError") != null) {
						out.println("<p class=\"msg-error\">"+ request.getParameter("passwordError") +"</p>");
					}
				%>
				<input type="time" placeholder="Show Time" class="admin-login-input" name="showTime"/>
				<input type="date" name="showDate" class="admin-login-input"  placeholder="Show Date">
				<input type="hidden" name="id" value="<% out.println(request.getParameter("id")); %>">
				
				<input type="submit" value="SCHEDULE" class="admin-login-btn" />
			</form>
				</div>
		</div>
	</div>
</body>
</html>