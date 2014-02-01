package com.revenuedepartment.service;

import org.apache.http.HttpResponse;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import android.text.TextUtils;

public class HttpRequestPost {
	public HttpRequestPost() {
	}

	public String httpQuery(String urlPost, HttpParameter dataValue) {

		HttpPost httppost = null;
		String responseText = null;
		try {
			if (dataValue == null){
				dataValue = new HttpParameter();
			}
			httppost = new HttpPost(urlPost);
			httppost.setEntity(new UrlEncodedFormEntity(
					dataValue.getParamSet(), "UTF-8"));

			HttpResponse response = new DefaultHttpClient().execute(httppost);
			responseText = EntityUtils.toString(response.getEntity());
			if (!isJSONformatted(responseText))
				return null;
			return responseText;
		} catch (Exception e) {
			return null;
		} finally {
			httppost = null;
		}
	}

	public String httpQuery(String urlPost, String jsonRequest) {

		HttpPost httppost = null;
		String responseText = null;
		try {

			httppost = new HttpPost(urlPost);
			httppost.setEntity(new StringEntity(jsonRequest, "UTF-8"));
			HttpResponse response = new DefaultHttpClient().execute(httppost);
			responseText = EntityUtils.toString(response.getEntity() , "UTF-8");
//			if (!isJSONformatted(responseText))
//				return null;
			return responseText;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} 
	}
	private boolean isJSONformatted(String strJSON) {
		if (TextUtils.isEmpty(strJSON))
			return false;
		return (strJSON.startsWith("{") && strJSON.endsWith("}") || strJSON
				.startsWith("[") && strJSON.endsWith("]"));
	}
}
