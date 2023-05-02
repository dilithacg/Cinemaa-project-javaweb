package com.abccinema;

import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static spark.Spark.post;
import static spark.Spark.port;
import static spark.Spark.staticFiles;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;

@WebServlet("/create-checkout-session")
public class StripeServer extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "jdbc:mysql://localhost:3306/abc_cinema";
		String username = "root";
		String password = "1234";
		
		String sql = "SELECT COUNT(seatId) FROM reservation WHERE scheduleId=? AND ticketId =?";	
		String scheduleId = request.getParameter("scheduleId");
		String ticketId = request.getParameter("ticketId");
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, username, password);
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, scheduleId);
			st.setString(2, ticketId);
			
			ResultSet rs = st.executeQuery();
			
			int count = 0;
			
			while(rs.next()) {
				count = rs.getInt(1);
			}
			
			
			port(4242);
//			Stripe.apiKey = "sk_test_26PHem9AhJZvU623DfE1x4sd";
			Stripe.apiKey = "sk_test_51MQNsDDGbqBStBzMCEWqaBdFRfFgKAL65OuCE0K9OqwaHtNJxFaYxfOZAsdtVQMpVOs4heXr9YQmtXeYTjGgZobE00bPWTrN3s";
		    staticFiles.externalLocation(
		            Paths.get("public").toAbsolutePath().toString());
		    
		    String YOUR_DOMAIN = "http://localhost:8080/ABCCinema";
	        SessionCreateParams params =
	          SessionCreateParams.builder()
	            .setMode(SessionCreateParams.Mode.PAYMENT)
	            .setSuccessUrl(YOUR_DOMAIN + "/success.jsp?ticketId=" + ticketId)
	            .setCancelUrl(YOUR_DOMAIN + "/index.jsp")
	            .addLineItem(
	              SessionCreateParams.LineItem.builder()
	                .setQuantity(Integer.toUnsignedLong(count))
	                // Provide the exact Price ID (for example, pr_1234) of the product you want to sell
	                .setPrice("price_1MQO8ADGbqBStBzMcZJTHwcl")
	                .build())
	            .build();
	      Session session;
		try {
			session = Session.create(params);
			response.sendRedirect(session.getUrl());
		} catch (StripeException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
			
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("DSDSSD");
			e.printStackTrace();
		}
		

     
	    
	    
	}
}