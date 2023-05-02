package com.abccinema;


import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@WebServlet("/a")
public class MovieDetails extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		URL url = new URL("https://jsonplaceholder.typicode.com/posts");
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
