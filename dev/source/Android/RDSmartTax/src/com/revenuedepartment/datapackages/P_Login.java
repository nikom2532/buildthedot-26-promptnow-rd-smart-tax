package com.revenuedepartment.datapackages;

import com.revenuedepartment.datamodels.M_Login;

public class P_Login {
	String responseStatus = "";
	M_Login responseData;
	String responseError = "";
	String temp_json_data = "";

	public String getTemp_json_data() {
		return temp_json_data;
	}

	public void setTemp_json_data(String temp_json_data) {
		this.temp_json_data = temp_json_data;
	}

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
