<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<link rel="stylesheet" href="../css/main.css" />
</head>
<body>
	<nav>
		<div class="container">
			<h3 class="brand">ABC - Admin</h3>
		</div>
	</nav>
 
	<div class="wrapper">
		<div class="all-center">
			<form action="adminlogin" method="POST" class="admin-login-form">
				<h2 style="margin-top: 0;">Admin Login</h2>
				<% 
					if(request.getParameter("error") != null) {
						out.println("<p class=\"msg-error\">"+ request.getParameter("error") +"</p>");
					}
				%>
				<input type="text" placeholder="Username" class="admin-login-input" name="username"/>
				
				<% 
					if(request.getParameter("passwordError") != null) {
						out.println("<p class=\"msg-error\">"+ request.getParameter("passwordError") +"</p>");
					}
				%>
				<input type="password" placeholder="Password" class="admin-login-input" name="password"/>
				<input type="submit" value="Login" class="admin-login-btn" />
			</form>
		</div>
	</div>
</body>
</html>