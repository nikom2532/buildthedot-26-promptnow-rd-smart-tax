package com.revenuedepartment.datapackages;

import com.revenuedepartment.datamodels.M_Login;

public class P_Login {
	String responseStatus = "";
	M_Login responseData ;
	String responseError = "";
	
	public String getResponseStatus() {
		return responseStatus;
	}

	public void setResponseStatus(String responseStatus) {
		this.responseStatus = responseStatus;
	}

	public M_Login getResponseData() {
		return responseData;
	}

	public void setResponseData(M_Login responseData) {
		this.responseData = responseData;
	}

	public String getResponseError() {
		return responseError;
	}

	public void setResponseError(String responseError) {
		this.responseError = responseError;
	}
}
