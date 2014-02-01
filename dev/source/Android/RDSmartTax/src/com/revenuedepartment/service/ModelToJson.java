package com.revenuedepartment.service;

import com.google.gson.Gson;

public class ModelToJson {
	public static String putJson(Object object) {
		if (object != null) {
			return new Gson().toJson(object);
		} else {
			return "";
		}
	}
}
