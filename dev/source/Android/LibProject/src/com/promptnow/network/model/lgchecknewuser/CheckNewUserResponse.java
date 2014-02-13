package com.promptnow.network.model.lgchecknewuser;

import java.util.ArrayList;
 
import com.promptnow.network.model.CommonResponseRD;

public class CheckNewUserResponse extends CommonResponseRD {
 
	public  CheckNewUserData  responseData = new CheckNewUserData();
	public CheckNewUserResponse(String status, String code, String msg,
			String response) {
		super(status, code, msg); 
	} 
}
