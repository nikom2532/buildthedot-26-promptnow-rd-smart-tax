package com.revenuedepartment.service;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

import android.app.Activity;
import android.content.Context;

public class SharedPref2 {
	static Context mContext = null;
	
	public SharedPref2(Context context) {
		mContext = context;
	}
	
	public void setString(String variable,String val)
	{
		SharedPreferences settings = ((Activity)mContext).getPreferences(Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = settings.edit();
        editor.putString(variable, val);
        editor.commit();
        
        //if(Constants.slide_CaptionOn.equals(name)) log.debug("setPrivateString : "+val);
	}
	
	public String getString(String variable)
	{
		SharedPreferences settings = ((Activity)mContext).getPreferences(Context.MODE_PRIVATE);
		String access_token = settings.getString(variable, null);
		//if(Constants.slide_CaptionOn.equals(name)) log.debug("getPrivateString : "+access_token);		
		return access_token;		
	}
}