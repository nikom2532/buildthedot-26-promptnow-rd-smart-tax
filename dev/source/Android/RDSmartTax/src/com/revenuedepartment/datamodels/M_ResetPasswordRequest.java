package com.revenuedepartment.datamodels;

import com.promptnow.network.model.CommonResponseRD;
import android.os.AsyncTask;

public class M_ResetPasswordRequest extends CommonResponseRD {
	String responseStatus = "";
	M_ResetPasswordRequest responseData = null;
	String responseError = "";
	public String email = "";
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
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
	public M_ResetPasswordRequest getResponseData() {
		return responseData;
	}
}
