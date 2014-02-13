package com.revenuedepartment.datapackages;

import java.util.ArrayList;

import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.datamodels.M_Instructions;

public class P_Instructions extends CommonResponseRD {
	String responseCode;
	String responseStatus;
	String responseMessage;
	ArrayList<M_Instructions> responseData;

	public String getResponseCode() {
		return responseCode;
	}

	public void setResponseCode(String responseCode) {
		this.responseCode = responseCode;
	}

	public String getResponseStatus() {
		return responseStatus;
	}

	public void setResponseStatus(String responseStatus) {
		this.responseStatus = responseStatus;
	}

	public String getResponseMessage() {
		return responseMessage;
	}

	public void setResponseMessage(String responseMessage) {
		this.responseMessage = responseMessage;
	}

	public ArrayList<M_Instructions> getResponseData() {
		return responseData;
	}

	public void setResponseData(ArrayList<M_Instructions> responseData) {
		this.responseData = responseData;
	}

}
