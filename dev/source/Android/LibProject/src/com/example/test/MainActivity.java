package com.example.test;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;

import com.google.gson.Gson;
import com.promptnow.network.ConnectServer;
import com.promptnow.network.PromptnowCommandData;
import com.promptnow.network.PromptnowDHKeyExchange;
import com.promptnow.network.model.CommonResponseRD;
import com.promptnow.network.model.keyexchange.KeyexchangeRequest;
import com.promptnow.network.model.lgchecknewuser.CheckNewUserRequest;
import com.promptnow.network.model.lgchecknewuser.CheckNewUserResponse;

import utility.UtilLog;
import android.os.Bundle;
import android.os.StrictMode;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.Dialog;
import android.util.Log;
import android.view.Menu;

public class MainActivity extends Activity {

	@TargetApi(9)
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		if(android.os.Build.VERSION.SDK_INT > 9){ 
			StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
			StrictMode.setThreadPolicy(policy);
		} 
		httpPost();
	} 

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}
	 
	public void httpPost(){
    	try{
    		ConnectServer server = new ConnectServer(this); 
    		boolean boo_getkey = server.getKeyExchange();
    		Log.d("debug","boolean_getkay : "+boo_getkey);
    		if(boo_getkey){ 
    			////
    			 CheckNewUserRequest request = new CheckNewUserRequest();
				 request.sessionID = PromptnowCommandData.JSESSIONID; 
				 request.language = "EN";	// EN, TH
				 request.longitude = "100.558611";
				 request.latitude = "13.807465";
				 request.deviceID = "231452453246536";
				 request.deviceType = "android";  
				 request.nid = "99";
				 request.clientDateTime = "2013-07-18 00:00:00"; 
				 
				 String service = "lg-check-newuser";
				 
				 Gson g = new Gson(); 
				 String jsonObjSend = g.toJson(request);
				 Log.d("debug","request : "+jsonObjSend); 
				  
				 String datas = server.sendSecureDataServerJson(jsonObjSend.getBytes(), service); 
				 Log.d("debug","response : " + datas);
				 
				 CheckNewUserResponse responseModel =  g.fromJson(datas, CheckNewUserResponse.class);
				 Log.d("debug","responseData : "+responseModel.responseData); 
				 Log.d("debug","responseCode : "+responseModel.responseCode); 
				 Log.d("debug","responseMessage : "+responseModel.responseMessage);
				 Log.d("debug","responseStatus : "+responseModel.responseStatus);  
    		}else{
    			Dialog dialog = new Dialog(this);
    			dialog.setTitle("boo_getkey : "+boo_getkey);
    			dialog.show();
    			
    		} 
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    } 
}
