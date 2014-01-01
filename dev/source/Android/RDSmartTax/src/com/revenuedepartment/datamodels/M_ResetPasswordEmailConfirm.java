package com.revenuedepartment.datamodels;

import android.os.AsyncTask;

public class M_ResetPasswordEmailConfirm {
	String responseStatus = "";
	M_ResetPasswordEmailConfirm responseData = null;
	String responseError = "";
	public String getResponseStatus() {
		// TODO Auto-generated method stub
		return responseStatus;
	}
	public void setResponseStatus() {
		this.responseStatus = responseStatus;
	}
	public String getResponseError() {
		return responseError;
	}
	public M_ResetPasswordEmailConfirm getResponseData() {
		return responseData;
	}
}
