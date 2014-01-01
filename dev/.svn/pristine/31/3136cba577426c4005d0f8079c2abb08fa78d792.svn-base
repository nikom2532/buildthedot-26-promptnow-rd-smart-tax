package com.revenuedepartment.function;

import com.revenuedepartment.service.ConfigApp;
import com.revenuedepartment.service.SharedPref;

import android.content.Context;

public class CheckLang {
	public static String check(Context context, String message_th, String message_en) {
		if (new SharedPref(context).getLang().equals(ConfigApp.TH)) {
			return message_th;
		} else {
			return message_en;
		}
	}
}
