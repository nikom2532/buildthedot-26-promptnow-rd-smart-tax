package com.revenuedepartment.function;

import android.content.Context;
import android.telephony.TelephonyManager;

public class GetDeviceID {

	TelephonyManager telephonyManager;

	public GetDeviceID(Context context) {
		telephonyManager = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
	}

	public String getDeviceID() {
		if (telephonyManager.getDeviceId() != null && !telephonyManager.getDeviceId().equals(""))
			return telephonyManager.getDeviceId();
		else
			return "";
	}
}
