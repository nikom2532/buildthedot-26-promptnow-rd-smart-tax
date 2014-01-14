package com.revenuedepartment.req_datamodels;

import com.promptnow.network.model.CommonRequestRD;

public class MRequest_ChangePassword extends CommonRequestRD {
	public String userId = "";
	public String oldPassword = "";
	public String newPassword = "";
}
