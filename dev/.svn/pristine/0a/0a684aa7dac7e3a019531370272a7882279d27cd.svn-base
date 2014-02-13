package com.revenuedepartment.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import com.google.gson.Gson;
import com.revenuedepartment.datamodels.P_MessagePlaceHolder;

import android.content.Context;

public class GetPlaceHolders {
	Context context;
	String JSONmessage;
	public P_MessagePlaceHolder pMessage;
	public String lang;

	public GetPlaceHolders(Context context) {

		try {

			JSONmessage = convertStreamToString(context.getAssets().open("message/placeholder.txt"));
			pMessage = new Gson().fromJson(JSONmessage, P_MessagePlaceHolder.class);
			lang = "th";
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getFieldMessage(String field) {
		for (int i = 0; i < pMessage.getMessage_error().length; i++) {
			if (pMessage.getMessage_error()[i].getPlaceholder_field().equals(field)) {
				if (lang.equals("th")) {
					return pMessage.getMessage_error()[i].getMessage_th();
				} else {
					return pMessage.getMessage_error()[i].getMessage_en();
				}
			}
		}
		return "";
	}

	private String convertStreamToString(InputStream is) throws Exception {
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		StringBuilder sb = new StringBuilder();
		String line = null;
		while ((line = reader.readLine()) != null) {
			sb.append(line + "\n");
		}
		is.close();
		return sb.toString();
	}
}
