package com.promptnow.network.service;

import android.app.Activity;
import android.view.View;

import com.revenuedepartment.service.SharedPref;

public class UtilGetStringLang {
	// get text language ( format ,. )
		public static String getTextOnLang(Activity act, View v, String txt) {
			try {
				String[] temp = txt.split(",.");
				String value = new SharedPref(act).getLang();
				if (value.equals("th")) {
					return temp[0];
				} else {
					return temp[1];
				}
			} catch (Exception e) {
				return null;
			}
		}
}
