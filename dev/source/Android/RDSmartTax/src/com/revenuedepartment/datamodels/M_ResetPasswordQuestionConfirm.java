package com.revenuedepartment.datamodels;

import com.promptnow.network.model.CommonResponseRD;

import android.os.AsyncTask;

public class M_ResetPasswordQuestionConfirm extends CommonResponseRD {
	String responseStatus = "";
	M_ResetPasswordQuestionConfirm responseData = null;
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
	public M_ResetPasswordQuestionConfirm getResponseData() {
		return responseData;
	}
}
