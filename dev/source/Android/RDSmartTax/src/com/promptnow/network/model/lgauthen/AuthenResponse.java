package com.promptnow.network.model.lgauthen;

import java.util.List;

import com.promptnow.network.model.CommonResponseRD;

public class AuthenResponse extends CommonResponseRD { 
	public AuthenData responseData;  
	public List<TitleNameHash> titleNameHash;

	public String loginFirst;
	public String termsConditionDetail;
	public String displaySatisfication;
	public String lastAccessed;
	public String timeCurrent;

	public String getResponseStatus() {
		return responseStatus;
	}

	public void setResponseStatus(String responseStatus) {
		this.responseStatus = responseStatus;
	}

	public AuthenData getResponseData() {
		return responseData;
	}

	public void setResponseData(AuthenData responseData) {
		this.responseData = responseData;
	}
}
