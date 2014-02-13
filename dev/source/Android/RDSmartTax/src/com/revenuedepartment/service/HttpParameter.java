package com.revenuedepartment.service;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import android.text.TextUtils;

public class HttpParameter {

	private List<NameValuePair> nameValuePairs = null;

	public HttpParameter() {
		nameValuePairs = new ArrayList<NameValuePair>();
	}

	public HttpParameter setParam(String name, Object value) {
		nameValuePairs.add(new BasicNameValuePair(name, String.valueOf(value)));
		return this;
	}

	public List<NameValuePair> getParamSet() {
		return nameValuePairs;
	}

	public String getParamAsQuery() {
		String returnParam = "";
		try {
			for (NameValuePair nvc : nameValuePairs) {
				if (!TextUtils.isEmpty(returnParam))
					returnParam += "&";
				returnParam += String.format("%s=%s",
						URLEncoder.encode(nvc.getName(), "UTF-8"),
						URLEncoder.encode(nvc.getValue(), "UTF-8"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnParam;
	}

	public void clearParam() {
		nameValuePairs.clear();
		nameValuePairs = null;
	}

}