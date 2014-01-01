package com.revenuedepartment.datapackages;

import com.revenuedepartment.datamodels.M_UpdateTaxCal;

public class P_UpdateTaxCal {
	String responseStatus;
	String responseError;
	M_UpdateTaxCal responseData;

	public String getResponseStatus() {
		return responseStatus;
	}

	public void setResponseStatus(String responseStatus) {
		this.responseStatus = responseStatus;
	}

	public String getResponseError() {
		return responseError;
	}

	public void setResponseError(String responseError) {
		this.responseError = responseError;
	}

	public M_UpdateTaxCal getResponseData() {
		return responseData;
	}

	public void setResponseData(M_UpdateTaxCal responseData) {
		this.responseData = responseData;
	}

}
