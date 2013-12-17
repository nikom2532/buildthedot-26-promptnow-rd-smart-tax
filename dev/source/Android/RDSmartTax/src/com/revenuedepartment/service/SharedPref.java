package com.revenuedepartment.service;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

public class SharedPref {
	private static String PREF_PROFILE = "PREF_Profile";

	Context context;
	SharedPreferences mPref;

	public SharedPref(Context _context) {
		this.context = _context;
		mPref = _context.getSharedPreferences(PREF_PROFILE, Context.MODE_PRIVATE);
	}

	public Boolean setLang(String value) {
		SharedPreferences.Editor editor = mPref.edit();
		editor.putString(PREF_PROFILE, value);
		editor.commit();
		return true;
	}

	public String getLang() {
		String value = mPref.getString(PREF_PROFILE, "");
		return value;
	}

	public Boolean delLang() {
		if (mPref != null) {
			Editor edit = mPref.edit();
			edit.remove(PREF_PROFILE);
			edit.commit();
		}
		return true;
	}
}