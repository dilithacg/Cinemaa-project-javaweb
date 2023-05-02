package com.abccinema;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;

public class HashPassword {
	private static Argon2 argon2 = Argon2Factory.create(Argon2Factory.Argon2Types.ARGON2id, 16, 32);
	
	public static String hashPassword(char[] password) {			
	    String hash = argon2.hash(3, 64 * 1024,  1, password);
	    return hash;
	}
	
	
	@SuppressWarnings("deprecation")
	public static boolean verifyPassword(String hash, String password) {
		return argon2.verify(hash, password);
		
	}
	

}
