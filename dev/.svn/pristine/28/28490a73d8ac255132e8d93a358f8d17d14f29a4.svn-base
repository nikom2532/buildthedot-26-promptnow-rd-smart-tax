package com.revenuedepartment.service;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.revenuedepartment.datamodels.M_ResetPasswordRequest;
import com.revenuedepartment.datapackages.P_ChchkNewUser;
import com.revenuedepartment.datapackages.P_Filling;
import com.revenuedepartment.datapackages.P_Login;
import com.revenuedepartment.function.writeLog;

public class ConnectApi {

	public P_Filling requestGetPnd91() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/pnd91/getFormPnd91.json", "");

		if (responseText != null && !responseText.equals("")) {
			P_Filling rs = new GetPnd91().getPnd91(responseText);
			return rs;
		}
		return null;
	}

	public P_ChchkNewUser requestCheckNewUser(String mJsonRequestEtNid) {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/checkNewUser.json", mJsonRequestEtNid);
		
		//writeLog.LogV("P_ChchkNewUser=requestCheckNewUser=responseText", responseText.toString());
		
		if (responseText != null && !responseText.equals("")) {
			P_ChchkNewUser rs = new Gson().fromJson(responseText, P_ChchkNewUser.class);
			
			//writeLog.LogV("P_ChchkNewUser_userID", rs.getResponseData().getUserId());
			
			return rs;
		}
		return null;
	}
	
	public M_ResetPasswordRequest mResetPasswordRequest(String mJsonRequest) {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/checkNewUser.json", mJsonRequest);
		
		//writeLog.LogV("P_ChchkNewUser=requestCheckNewUser=responseText", responseText.toString());
		
		if (responseText != null && !responseText.equals("")) {
			M_ResetPasswordRequest rs = new Gson().fromJson(responseText, M_ResetPasswordRequest.class);
			
			//writeLog.LogV("P_ChchkNewUser_userID", rs.getResponseData().getUserId());
			
			return rs;
		}
		return null;
	}
	
	public P_Login requestLogin() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/authen.json", "");
		
		writeLog.LogV("P_Login=requestLogin=responseText", responseText.toString());
		
		if (responseText != null && !responseText.equals("")) {
			P_Login rs = new GetAuthen().getAuthen(responseText);
			
			//writeLog.LogV("P_Login=requestLogin=rs", rs.toString());
			
			return rs;
		}
		return null;
	}
	
	public P_Login requestUpdateProfile() {
		HttpRequestPost post = new HttpRequestPost();
		String responseText = post.httpQuery("http://kimhun55.com/llnun/TestServiceRD/mobile/register/updateProfile.json", "");

		if (responseText != null && !responseText.equals("")) {
			P_Login rs = new GetAuthen().getAuthen(responseText);
			return rs;
		}
		return null;
	}



	public static int getJsonInt(JSONObject obj, String name) {
		try {
			return obj.get(name) != null ? obj.getInt(name) : 0;
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return -1;
	}

	public static boolean hasElement(JSONObject obj, String name) {
		if (obj.has(name))
			return true;
		return false;
	}

	public static String getJsonString(JSONObject obj, String name) {
		try {
			if (hasElement(obj, name)) {
				writeLog.LogD(writeLog.TAG, (obj.get(name) != null ? obj.getString(name) : ""));
				return (obj.get(name) != null ? obj.getString(name) : "");
			} else {
				writeLog.LogD(writeLog.TAG, "");
				return "";
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return "";
	}

	public static boolean getJsonBoolean(JSONObject obj, String name) {
		try {
			return obj.get(name) != null ? obj.getBoolean(name) : false;
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return false;
	}
}
