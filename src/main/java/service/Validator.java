package service;

public class Validator {
	
	public static boolean isValidString(String value) {
		if(value!=null && !value.isEmpty() && value!="null") {
			return true;
		}
		return false;
	}
	
}
