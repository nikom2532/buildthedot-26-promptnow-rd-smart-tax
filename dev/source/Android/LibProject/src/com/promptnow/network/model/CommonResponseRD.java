package com.promptnow.network.model;

public class CommonResponseRD {
	public static final String STATUS_SUCCESS = "SUCCESS";
	public static final String STATUS_ERROR = "ERROR";
	
	public static final String CODE_SUCCESS = "0";
	
	public String responseCode="";
	public String responseStatus="";
	public String responseMessage="";
//	public String responseData="";
    
    public CommonResponseRD(String status, String code,String msg){
    	 responseStatus = status;
         responseCode = code;
         responseMessage = msg;
    }
}
