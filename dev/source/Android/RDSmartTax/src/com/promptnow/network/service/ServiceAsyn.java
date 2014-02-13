package com.promptnow.network.service;

import java.util.Iterator;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.os.AsyncTask; 
import android.util.Log;
 
import com.promptnow.network.ConnectServer; 
import com.revenuedepartment.function.DialogProcess; 

public class ServiceAsyn extends AsyncTask<String, Void, Object> { 
	DialogProcess dialog;// = new DialogProcess(UpdateProfile.this);
	ConnectServer server;// = new ConnectServer(UpdateProfile.this); 
	String jsonObjSend; 
	String service; 
	private AsyncTaskCompleteListener callback;
	
	public ServiceAsyn(Activity act, String json, String sv) { 
		callback = (AsyncTaskCompleteListener)act;
		jsonObjSend = json;
		service = sv;
		dialog = new DialogProcess(act);
		server = new ConnectServer(act); 
	} 
	 
	public static boolean haveKey(JSONObject json, String keyName) throws JSONException{
	    @SuppressWarnings("unchecked")
		Iterator<String> keys = json.keys();
	    boolean havekey = false;
	    while(keys.hasNext()){
	        String key = keys.next();
	        Log.i("Joe", "key : "+key);
	        if(keyName.equals(key)){
	        	havekey = true; 
	        }
	    }
	    return havekey;
	}

	@Override
	protected void onPreExecute() {
		super.onPreExecute();
		dialog.show();
	}

	@Override
	protected String doInBackground(String... params) {  
		String datas = server.sendSecureDataServerJson(jsonObjSend.getBytes(),
				service); 
		return datas;
	}

	@Override
	protected void onPostExecute(Object rs) {
		super.onPostExecute(rs); 
		callback.onTaskComplete(rs.toString(), service);
		dialog.dismiss(); 
	} 
}
