package com.revenuedepartment.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import com.google.gson.Gson;
import com.revenuedepartment.datamodels.P_Message;
import com.revenuedepartment.datapackages.P_ChchkNewUser;

import android.content.Context;

public class GetMessageError {
	Context context;
	String JSONmessage;
	public P_Message pMessage;
	public String lang;

	public GetMessageError(Context context) {

		try {

			JSONmessage = convertStreamToString(context.getAssets().open("message/message_error.txt"));
			pMessage = new Gson().fromJson(JSONmessage, P_Message.class);
//			JSONmessage = convertStreamToString(context.getAssets().open("message/test.txt"));
//			P_ChchkNewUser x = new Gson().fromJson(JSONmessage, P_ChchkNewUser.class);
			lang = "th";
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getFieldMessage(String field) {
		for (int i = 0; i < pMessage.getMessage_error().length; i++) {
			if (pMessage.getMessage_error()[i].getValidate_field().equals(field)) {
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
