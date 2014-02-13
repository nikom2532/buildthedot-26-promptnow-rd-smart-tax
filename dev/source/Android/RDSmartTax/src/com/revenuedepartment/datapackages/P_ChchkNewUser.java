package com.revenuedepartment.datapackages;

import com.promptnow.network.model.CommonResponseRD;
import com.revenuedepartment.datamodels.M_CheckNewUser;

public class P_ChchkNewUser extends CommonResponseRD {
	public String sessionID;
	public String serverDateTimeMS;
	public String serverDateTime;
	public M_CheckNewUser responseData = new M_CheckNewUser();
}
