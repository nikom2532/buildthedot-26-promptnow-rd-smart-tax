package com.revenuedepartment.function;

public class Validate {
	public static Boolean checkNid(String value) {
		if (value.length() == 13) {
			return true;
		}
		return false;
	}

	public static Boolean checkNidFormat(String value) {
		if (value.length() == 17) {
			return true;
		}
		return false;
	}

	public static Boolean isValidEmail(String text) {
		if (text == null)
			return false;
		else if (text.length() < 6)
			return false;
		else if (text.equals(""))
			return false;
		else if (text.indexOf("@") < 1)
			return false;
		else if (text.indexOf(".", text.indexOf("@")) < 0)
			return false;
		// aaa@sab.
		else if (text.indexOf(".", text.indexOf("@")) == (text.length() - 1))
			return false;
		else
			return true;
	}
}
