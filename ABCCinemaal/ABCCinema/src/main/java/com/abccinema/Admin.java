package com.abccinema;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.abccinema.dao.LoginDao;

@WebServlet("/admin/adminlogin")
public class Admin extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		HttpSession session = request.getSession();
		
		String savedPassword = LoginDao.getPassword(username);
		
		if(savedPassword != null) {
			
			if(HashPassword.verifyPassword(savedPassword, password)) {
				 session.setAttribute("username", username);
				response.sendRedirect("dashboard.jsp");
			} else {
				session.removeAttribute("username");
				response.sendRedirect("admin.jsp?passwordError=Wrong password");
			}
		} else {
			response.sendRedirect("admin.jsp?error=User does't exists");
		}
		
		
		// System.out.println(HashPassword.hashPassword("12341234".toCharArray()));
		// System.out.println(HashPassword.verifyPassword("$argon2id$v=19$m=65536,t=3,p=1$4OT8dUyMZDBR3DkBuBI85w$Zvs0/2+E+T7INh3c3AWV8Noi9b8l68L3STWGE/lIhEY", "556565"));
		
		
		
	}

	public void searchMovies(String searchText) throws IOException {
			ServletContext ctx = getServletContext();
			String apiKey = ctx.getInitParameter("omdb_api_key");
			URL url = new URL("http://www.omdbapi.com/?s="+ searchText + "&apikey=" + apiKey);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("GET");
			conn.connect();
			
			int responseCode = conn.getResponseCode();
			
			if(responseCode != 200) {
				
			} else {
				StringBuilder informationString = new StringBuilder();
				Scanner scanner = new Scanner(url.openStream());
				
				while(scanner.hasNext()) {
					informationString.append(scanner.nextLine());
				}
				
				scanner.close();
				
				// System.out.println(informationString);
				
				
				
				
				JSONParser parse = new JSONParser();
				try {
					JSONArray dataObject = (JSONArray) parse.parse(String.valueOf(informationString));
					
					// System.out.println(dataObject.get(0));
					
					JSONObject data = (JSONObject) dataObject.get(1);
					
					System.out.println(data.get("body"));
					
					
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		
	}
}
