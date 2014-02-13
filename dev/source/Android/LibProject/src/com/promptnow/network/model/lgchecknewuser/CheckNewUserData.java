package com.promptnow.network.model.lgchecknewuser;

import com.google.gson.Gson;

public class CheckNewUserData {
	public String userId = "";
	public String status = "";
	public String thaiNation = "";
	public String email = "";
	
	public CheckNewUserData(){
		
	}
	
	public CheckNewUserData(String user, String st){
		this.userId = user;
		this.status = st;
	}
	
	public CheckNewUserData(String user, String st, String th, String em){
		this.userId = user;
		this.status = st;
		this.thaiNation = th;
		this.email = em;
	}
	
	 @Override
	    public String toString()
	    {
	        Gson gson = new Gson();
	        return gson.toJson(this);
	    }
}
