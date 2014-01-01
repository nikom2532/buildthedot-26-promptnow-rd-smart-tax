package com.revenuedepartment.service;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

public class SharedPref {
	private static String PREF_PROFILE = "PREF_Profile";
	private static String PREF_LANG = "PREF_LANG";
	Context context;
	SharedPreferences mPref;

	public SharedPref(Context context) {
		this.context = context;
		mPref = context.getSharedPreferences(PREF_LANG, Context.MODE_PRIVATE);
	}

	public Boolean setLang(String value) {
		SharedPreferences.Editor editor = mPref.edit();
		editor.putString(PREF_LANG, value);
		editor.commit();
		return true;
	}

	public String getLang() {
		String value = mPref.getString(PREF_LANG, "TH");
		return value;
	}

	public Boolean delLang() {
		if (mPref != null) {
			Editor edit = mPref.edit();
			edit.remove(PREF_LANG);
			edit.commit();
		}
		return true;
	}

	public void setString(String variable, String value) {
		SharedPreferences.Editor editor = mPref.edit();
		editor.putString(variable, value);
		editor.commit();
	}

	public String getString(String variable) {
		String value = mPref.getString(variable, "");
		return value;
	}
	
	public Boolean delString(String variable) {
		if (mPref != null) {
			Editor edit = mPref.edit();
			edit.remove(variable);
			edit.commit();
		}
		return true;
	}

	public Boolean setProfile(String value) {
		SharedPreferences.Editor editor = mPref.edit();
		editor.putString(PREF_PROFILE, value);
		editor.commit();
		return true;
	}

	public String getProfile() {
		String value = mPref.getString(PREF_PROFILE, "");
		return value;
	}
}